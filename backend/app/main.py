# main.py
from fastapi import FastAPI, Depends
from .routers.jobs import router as jobs_router
from .routers.users import router as users_router
from .routers.auth import router as auth_router

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

app = FastAPI(docs_url="/docs", root_path="/api")

@app.get("/")
def root():
    return {"message": "ey du bist am root"}

@app.get("/public")
def public_route():
    return {"message": "Anyone can see this!"}

from app.routers.auth import get_current_user
@app.get("/protected")
def protected_route(user: dict = Depends(get_current_user)):
    """
    Only accessible if request has a valid Keycloak-issued JWT.
    get_current_user verifies the token and injects user claims here.
    """
    return {"message": f"Hello {user['preferred_username']}", "user": user}

app.include_router(jobs_router, prefix="/jobs", tags=["Jobs"])
app.include_router(users_router, prefix="/users", tags=["Users"])
app.include_router(auth_router, prefix="/auth", tags=["Auth"])
