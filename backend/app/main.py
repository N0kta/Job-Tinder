# main.py
from fastapi import FastAPI, Depends
from .routers.jobs import router as jobs_router
from .routers.users import router as users_router
from .routers.auth import router as auth_router

from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import os
from fastapi.templating import Jinja2Templates

from db.database import create_db_and_tables
import time
from sqlalchemy.exc import OperationalError

for i in range(10):
    try:
        create_db_and_tables()
        print("DB ready")
        break
    except OperationalError:
        print("Waiting for DB...")
        time.sleep(2)


from app.routers.auth import get_current_user

class NameRequest(BaseModel):
    name: str

app = FastAPI()

# Resolve paths
from app.core.config import STATIC_DIR

# Mount static folder
app.mount("/static", StaticFiles(directory=STATIC_DIR), name="static")

@app.get("/api")
def root():
    return {"message": "ey du bist am root"}

@app.get("/api/public")
def public_route():
    return {"message": "Anyone can see this!"}

@app.get("/api/protected")
def protected_route(user: dict = Depends(get_current_user)):
    """
    Only accessible if request has a valid Keycloak-issued JWT.
    get_current_user verifies the token and injects user claims here.
    """
    return {"message": f"Hello {user['preferred_username']}", "user": user}

app.include_router(jobs_router, prefix="/api/jobs", tags=["Jobs"])
app.include_router(users_router, prefix="/api/users", tags=["Users"])
app.include_router(auth_router, prefix="/api/auth", tags=["Auth"])
