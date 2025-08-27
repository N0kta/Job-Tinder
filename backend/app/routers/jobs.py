# routers/jobs.py
from fastapi import APIRouter
from fastapi import Request
from sqlmodel import SQLModel, Session
from app.router.auth import require_role
from db.database import get_session

router = APIRouter()

# Use the templates object from main.py
# For simplicity, import it dynamically
from app.core.config import templates

from enum import Enum
class SwipeDirection(int, Enum):
    left = 0
    right = 1

from pydantic import BaseModel
class Swipe(BaseModel):
    direction: SwipeDirection
    job_id: int



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
        employer_id=current_user['id']
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

from db.models import ChatRoom, ChatParticipant

@router.post("/chat_rooms", response_model=ChatRoom)
def create_chat_room(
    session: Session = Depends(get_session), 
    payload: dict = Depends(require_role("user")) # Any authenticated user can create a chat
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

from your_app import Message, ChatRoom

# Create Message
class MessageCreate(SQLModel):
    chat_room_id: int
    content: str

@router.post("/messages", response_model=Message)
def create_message(
    message: MessageCreate,
    session: Session = Depends(get_session), 
    payload: dict = Depends(require_role("user"))
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

from your_app import Template

# Create Template
class TemplateCreate(SQLModel):
    type: str
    name: str
    structure: dict # Assuming the client sends a dictionary

@router.post("/templates", response_model=Template)
def create_template(
    template: TemplateCreate,
    session: Session = Depends(get_session),
    payload: dict = Depends(require_role("user"))
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