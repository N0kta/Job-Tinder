# routers/auth.py
from fastapi import APIRouter, HTTPException
from app.models import mock_data

router = APIRouter()

@router.post("/login")
def login(username: str, password: str):
    user = next((u for u in mock_data.mock_users if u["username"] == username and u["password"] == password), None)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return {"message": f"Welcome {username}!"}

@router.post("/register")
def register(username: str, password: str):
    new_user = {"id": len(mock_data.mock_users) + 1, "username": username, "password": password}
    mock_data.mock_users.append(new_user)
    return {"message": "User registered", "user": new_user}

