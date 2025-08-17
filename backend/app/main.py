# main.py
from fastapi import FastAPI
from app.routers.jobs import router as jobs_router
from app.routers.users import router as users_router
from app.routers.auth import router as auth_router

from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import os
from fastapi.templating import Jinja2Templates

class NameRequest(BaseModel):
    name: str

app = FastAPI()

# Resolve paths
from app.core.config import STATIC_DIR

# Mount static folder
app.mount("/static", StaticFiles(directory=STATIC_DIR), name="static")

@app.get("/")
def root():
    return {"message": "ey du bist am root"}

app.include_router(jobs_router, prefix="/jobs", tags=["Jobs"])
app.include_router(users_router, prefix="/users", tags=["Users"])
app.include_router(auth_router, prefix="/auth", tags=["Auth"])
