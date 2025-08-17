# routers/jobs.py
from fastapi import APIRouter
from app.models import mock_data
from fastapi.templating import Jinja2Templates
from fastapi import Request

router = APIRouter()

# Use the templates object from main.py
# For simplicity, import it dynamically
from app.core.config import templates

from enum import Enum
class SwipeDirection(int, Enum):
    left = 0
    right = 1

from pydantic import BaseModel

class Swipe(BaseModel):
    direction: SwipeDirection

#These Paths or for Both
@router.get("/")
def get_jobs(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


#These Paths are for Employers
@router.post("/")
def create_job():
    pass

@router.get("/{job_id}/applicants")
def get_applicants(job_id: int):
    pass

@router.post("/{job_id}/applicants/swipe/{applicant_id}")
def swipe_applicant(job_id: int, applicant_id: int, swipe: Swipe):
    if swipe.direction == SwipeDirection.left:
        return {"message": f"User  swiped left on applicant {applicant_id}"}
    elif swipe.direction == SwipeDirection.right:
        return {"message": f"User  swiped right on applicant {applicant_id}"}
    else:
        return {"message": "You arent suppose to see this"}

@router.get("/{job_id}/applicants/next")
def get_next_applicant(job_id: int):
    pass


#These Paths are for Applicants
@router.get("/next")
def get_next_job():
    return mock_data.mock_jobs

#User id is passed via Authentication
@router.post("/swipe/{job_id}")
def swipe_job(job_id: int, swipe: Swipe):
    if swipe.direction == SwipeDirection.left:
        return {"message": f"User  swiped left on job {job_id}"}
    elif swipe.direction == SwipeDirection.right:
        return {"message": f"User  swiped right on job {job_id}"}
    else:
        return {"message": "You arent suppose to see this"}
