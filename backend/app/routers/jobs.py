# routers/jobs.py
from fastapi import APIRouter, Request, Depends
from sqlmodel import SQLModel, Session, select
from .auth import require_role, get_current_user
from db.database import get_session
from db.models import ChatRoom, ChatParticipant, User, Template, Job, Application, Message

router = APIRouter()


#Create Jobs
class JobCreate(SQLModel):
    titel: str
    description: str
@router.post("/library")
def create_job(job: JobCreate, session: Session =Depends(get_session), payload: dict =Depends(require_role("employer"))):
    # Check if the employer exists
    employer = session.exec(select(User).where(User.id == payload.get("sub"))).first()
    if not employer:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Employer not found")

    db_job = Job(
        **job.model_dump(),
        employer_id=payload["sub"]
    )

    # 3. Add the new job and commit to the database
    session.add(db_job)
    session.commit()
    session.refresh(db_job)

    return db_job


# Create Application
class ApplicationCreate(SQLModel):
    job_id: int
    cv_text: str | None = None

@router.post("/swipe")
def create_application(
    application: ApplicationCreate, 
    session: Session = Depends(get_session), 
    payload: dict = Depends(require_role("seeker")) # Assuming only seekers can apply
):
    # Check if the job exists before creating the application
    job = session.exec(select(Job).where(Job.id == application.job_id)).first()
    if not job:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Job not found")

    # The user ID is taken from the token payload, not the request body
    db_application = Application(
        **application.model_dump(),
        seeker_id=payload.get("sub")
    )
    
    session.add(db_application)
    session.commit()
    session.refresh(db_application)
    
    return db_application

#Create Chat Room
@router.post("/chat_rooms", response_model=ChatRoom)
def create_chat_room(
    session: Session = Depends(get_session), 
    payload: dict = Depends(require_role("employer")) # Any authenticated user can create a chat
):
    # Create the ChatRoom
    db_chat_room = ChatRoom()
    session.add(db_chat_room)
    session.commit()
    session.refresh(db_chat_room)
    
    # Create the ChatParticipant for the user who initiated the request
    # This must be done after the chat room is created so we have its ID
    db_chat_participant = ChatParticipant(
        user_id=payload.get("sub"),
        chat_room_id=db_chat_room.id
    )
    session.add(db_chat_participant)
    session.commit()
    session.refresh(db_chat_participant)
    
    return db_chat_room

#Accept Application to add both parties into a chat room
@router.post("/applications/{application_id}/accept", response_model=ChatRoom)
def accept_application(
    application_id: int,
    session: Session = Depends(get_session),
    payload: dict = Depends(require_role("employer"))
):
    """
    Accepts a job application, creates a new chat room, and adds both the employer and seeker as participants.
    """
    employer_id = payload.get("sub")

    # Fetch the application to ensure it exists and belongs to the employer's job
    application = session.exec(select(Application).where(Application.id == application_id)).one_or_none()
    if not application:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Application not found.")

    # Verify the employer owns the job associated with the application
    job = session.exec(select(Job).where(Job.id == application.job_id, Job.employer_id == employer_id)).one_or_none()
    if not job:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to accept this application.")

    # Create the new chat room
    db_chat_room = ChatRoom()
    session.add(db_chat_room)
    session.commit()
    session.refresh(db_chat_room)

    # Add the employer as a participant
    employer_participant = ChatParticipant(
        user_id=employer_id,
        chat_room_id=db_chat_room.id
    )
    session.add(employer_participant)

    # Add the seeker as a participant
    seeker_participant = ChatParticipant(
        user_id=application.seeker_id,
        chat_room_id=db_chat_room.id
    )
    session.add(seeker_participant)

    session.commit()
    session.refresh(db_chat_room)

    return db_chat_room

# Create Message
class MessageCreate(SQLModel):
    chat_room_id: int
    content: str

@router.post("/messages", response_model=Message)
def create_message(
    message: MessageCreate,
    session: Session = Depends(get_session), 
    payload: dict = Depends(get_current_user)
):
    # Check if the chat room exists
    chat_room = session.exec(select(ChatRoom).where(ChatRoom.id == message.chat_room_id)).first()
    if not chat_room:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Chat room not found")
        
    # Check if the user is a participant of the chat room
    is_participant = session.exec(
        select(ChatParticipant).where(
            ChatParticipant.user_id == payload.get("sub"),
            ChatParticipant.chat_room_id == message.chat_room_id
        )
    ).first()

    if not is_participant:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You are not a participant of this chat room")

    # Create the Message instance with the sender ID from the token
    db_message = Message(
        **message.model_dump(),
        sender_id=payload.get("sub")
    )
    
    session.add(db_message)
    session.commit()
    session.refresh(db_message)
    
    return db_message

# Create Template
class TemplateCreate(SQLModel):
    type: str
    name: str
    structure: dict # Assuming the client sends a dictionary

@router.post("/templates", response_model=Template)
def create_template(
    template: TemplateCreate,
    session: Session = Depends(get_session),
    payload: dict = Depends(get_current_user)
):
    # Check if the user exists
    user = session.exec(select(User).where(User.id == payload.get("sub"))).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")

    # Create the Template instance with the user ID from the token
    db_template = Template(
        **template.model_dump(),
        created_by=payload.get("sub")
    )
    
    session.add(db_template)
    session.commit()
    session.refresh(db_template)
    
    return db_template

# --- GET ENDPOINTS ---
@router.get("/library", response_model=list[Job])
def get_jobs(session: Session = Depends(get_session), payload: dict = Depends(require_role("employer"))):
    """
    Retrieves all jobs created by the authenticated user (employer).
    """
    jobs = session.exec(select(Job).where(Job.employer_id == payload.get("sub"))).all()
    return jobs

@router.get("/applications", response_model=list[Application])
def get_seeker_applications(session: Session = Depends(get_session), payload: dict = Depends(require_role("seeker"))):
    """
    Retrieves all applications for an authenticated seeker.
    """
    # The `require_role("seeker")` dependency ensures only seekers can access this endpoint.
    seeker_id = payload.get("sub")
    applications = session.exec(select(Application).where(Application.seeker_id == seeker_id)).all()
    return applications

@router.get("/applications/{job_id}", response_model=list[Application])
def get_job_applications_for_employer(
    job_id: int,
    session: Session = Depends(get_session),
    payload: dict = Depends(require_role("employer"))
):
    """
    Retrieves all applications for a specific job, if the authenticated employer
    is the owner of that job.
    """
    employer_id = payload.get("sub")

    # First, verify the job belongs to the employer
    job = session.exec(select(Job).where(Job.id == job_id, Job.employer_id == employer_id)).one_or_none()

    if not job:
        # If the job doesn't exist or doesn't belong to the employer, raise a 404 error.
        # This prevents an employer from seeing job applications for jobs they don't own.
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Job not found or not owned by the authenticated employer.")

    # If the job is found and belongs to the employer, retrieve all applications for that job
    applications = session.exec(select(Application).where(Application.job_id == job_id)).all()
    return applications

@router.get("/chat_rooms", response_model=list[ChatRoom])
def get_chat_rooms(session: Session = Depends(get_session), payload: dict = Depends(get_current_user)):
    """
    Retrieves all chat rooms that the authenticated user is a participant of.
    """
    chat_rooms = session.exec(
        select(ChatRoom)
        .join(ChatParticipant)
        .where(ChatParticipant.user_id == payload.get("sub"))
    ).all()
    return chat_rooms

@router.get("/chat_rooms/{chat_room_id}/messages", response_model=list[Message])
def get_messages(chat_room_id: int, session: Session = Depends(get_session), payload: dict = Depends(get_current_user)):
    """
    Retrieves all messages for a specific chat room, but only if the user is a participant.
    """
    is_participant = session.exec(
        select(ChatParticipant)
        .where(ChatParticipant.user_id == payload.get("sub"), ChatParticipant.chat_room_id == chat_room_id)
    ).first()
    if not is_participant:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="You are not a participant of this chat room.")
    
    messages = session.exec(
        select(Message).where(Message.chat_room_id == chat_room_id)
    ).all()
    return messages

@router.get("/templates", response_model=list[Template])
def get_templates(session: Session = Depends(get_session)):
    """
    Retrieves all public templates. No authentication required.
    """
    templates = session.exec(select(Template).where(Template.created_by == None)).all()
    return templates
    
@router.get("/templates/user", response_model=list[Template])
def get_user_templates(session: Session = Depends(get_session), payload: dict = Depends(get_current_user)):
    """
    Retrieves all templates created by the authenticated user.
    """
    templates = session.exec(select(Template).where(Template.created_by == payload.get("sub"))).all()
    return templates
