# routers/auth.py
from fastapi import APIRouter, HTTPException
from sqlmodel import select
from db.models import User
from db.database import SessionDep
import hashlib

router = APIRouter()

def hash_password(password: str):
    """Hash a plain password for storing in DB."""
    return hashlib.sha256(password.encode("utf-8")).hexdigest()

@router.post("/login")
def login(username: str, password: str):
    pass

@router.post("/register")
def register(user: User, session: SessionDep):
    user.hashed_password = hash_password(user.hashed_password)
    session.add(user)
    session.commit()
    session.refresh(user)
    return user

@router.get("/register")
def list_users(session: SessionDep):
    return session.exec(select(User)).all()

