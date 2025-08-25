from sqlmodel import SQLModel, create_engine, Session
from typing import Annotated
from fastapi import Depends

# PostgreSQL connection string format:
# postgresql+psycopg2://<username>:<password>@<host>:<port>/<database>

postgres_url = "postgresql+psycopg2://postgres:postgres@db:5432/jobtinder_db"

engine = create_engine(postgres_url, echo=True)

from .models import User, Job, Application, ChatRoom, ChatParticipant, Message, Template
def create_db_and_tables():
    SQLModel.metadata.create_all(engine)


def get_session():
    with Session(engine) as session:
        yield session


SessionDep = Annotated[Session, Depends(get_session)]