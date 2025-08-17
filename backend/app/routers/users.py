# routers/users.py
from fastapi import APIRouter
from app.models import mock_data

router = APIRouter()

@router.get("/users")
def list_users():
    return mock_data.mock_users

