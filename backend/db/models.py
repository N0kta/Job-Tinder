from sqlmodel import SQLModel, Field, Relationship, JSON, Column
from pydantic import EmailStr
from typing import List, Any, Dict
from datetime import datetime, timezone

import enum
class UserRole(enum.Enum):
    seeker = "seeker"
    employer = "employer"

# ----------------- USERS -----------------
class User(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    email: EmailStr  = Field(nullable=False, unique=True)
    hashed_password: str = Field(nullable=False)
    name: str | None = None
    surname: str | None = None
    role: UserRole = Field(index=True)

    # Relationships
    jobs: List["Job"] = Relationship(back_populates="employer")  # Employer → Jobs
    applications: List["Application"] = Relationship(back_populates="seeker")  # Seeker → Applications
    sent_messages: List["Message"] = Relationship(back_populates="sender") # Message -> Sender
    chat_participations: List["ChatParticipant"] = Relationship(back_populates="user")
    templates_created: List["Template"] = Relationship(back_populates="creator")

# ----------------- JOBS -----------------
class Job(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    titel: str = Field(nullable=False)
    description: str = Field(nullable=False)
    created_at: datetime

    employer_id: int = Field(foreign_key="user.id", nullable=False)
    employer: User | None = Relationship(back_populates="jobs")

    applications: List["Application"] = Relationship(back_populates="job")

# ----------------- APPLICATIONS -----------------
class Application(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    seeker_id: int = Field(foreign_key="user.id", nullable=False)
    job_id: int = Field(foreign_key="job.id", nullable=False)
    cv_text: str | None = None
    status: str = Field(default="pending")  # pending / liked / rejected

    seeker: User | None = Relationship(back_populates="applications")
    job: Job | None = Relationship(back_populates="applications")

# ----------------- CHAT ROOMS -----------------
class ChatRoom(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    created_at: datetime = Field(default_factory=datetime.now(timezone.utc))

    participants: List["ChatParticipant"] = Relationship(back_populates="chat_room")
    messages: List["Message"] = Relationship(back_populates="chat_room")

# ----------------- CHAT PARTICIPANTS -----------------
class ChatParticipant(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id", nullable=False)
    chat_room_id: int = Field(foreign_key="chatroom.id", nullable=False)

    user: User | None = Relationship(back_populates="chat_participations")
    chat_room: ChatRoom | None = Relationship(back_populates="participants")

# ----------------- MESSAGES -----------------
class Message(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    chat_room_id: int = Field(foreign_key="chatroom.id", nullable=False)
    sender_id: int = Field(foreign_key="user.id", nullable=False)
    content: str = Field(nullable=False)
    timestamp: datetime = Field(default_factory=datetime.now(timezone.utc))

    chat_room: ChatRoom | None = Relationship(back_populates="messages")
    sender: User | None = Relationship(back_populates="sent_messages")

# ----------------- TEMPLATES -----------------
class Template(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    type: str = Field(nullable=False)  # 'cv' or 'flyer' (could also use Enum)
    name: str = Field(nullable=False)
    structure: Dict[str, Any] = Field( 
        sa_column=Column(JSON,
        nullable=False,
        default_factory=dict))  # JSONB in SQL

    created_by: int | None = Field(foreign_key="user.id")  # ON DELETE SET NULL handled manually in Python/DB
    creator: User | None = Relationship(back_populates="templates_created")
