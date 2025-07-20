# main.py
from fastapi import FastAPI
from routers.jobs import router as jobs_router
from routers.users import router as users_router
from routers.auth import router as auth_router

from pydantic import BaseModel

class NameRequest(BaseModel):
    name: str

app = FastAPI()

@app.get("/")
def root():
    return {"message": "ey du bist am root"}

app.include_router(jobs_router, prefix="/jobs", tags=["Jobs"])
app.include_router(users_router, prefix="/users", tags=["Users"])
app.include_router(auth_router, prefix="/auth", tags=["Auth"])
