import httpx
import pytest

BASE_URL = "http://127.0.0.1:8000"

def test_root_endpoint():
    response = httpx.get(f"{BASE_URL}/")
    assert response.status_code == 200
    assert "message" in response.json()

def test_register_user():
    payload = {"username": "testuser", "password": "testpass"}
    response = httpx.post(f"{BASE_URL}/register", json=payload)
    assert response.status_code == 200
    assert "success" in response.json()

def test_login_user():
    payload = {"username": "testuser", "password": "testpass"}
    response = httpx.post(f"{BASE_URL}/login", json=payload)
    assert response.status_code == 200
    assert "token" in response.json()

def test_fetch_job():
    response = httpx.get(f"{BASE_URL}/jobs/next")
    assert response.status_code == 200
    assert "job_title" in response.json()

