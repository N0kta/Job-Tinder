# routers/jobs.py
from fastapi import APIRouter
from models import mock_data

router = APIRouter()

@router.get("/jobs")
def get_jobs():
    return mock_data.mock_jobs

@router.post("/swipe")
def swipe_right(job_id: int, user_id: int):
    # In echt würdest du hier in DB speichern – jetzt einfach Rückmeldung
    return {"message": f"User {user_id} swiped right on job {job_id}"}

