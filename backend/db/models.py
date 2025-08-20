from sqlmodel import SQLModel, Field

import enum
class UserRole(enum.Enum):
    seeker = "seeker"
    employer = "employer"

class User(SQLModel, table=True):
    id: int = Field(primary_key=True)
    email: str
    hashed_password: str
    name: str | None = None
    surname: str | None = None
    role: UserRole = Field(index=True)