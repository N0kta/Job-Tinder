from fastapi import Depends, HTTPException, APIRouter, Request
from fastapi.security import OAuth2PasswordBearer
from jose import jwt  # pip install python-jose
from jose.exceptions import JWTError
import httpx  # pip install httpx
import os

router = APIRouter()

# ======================
# Keycloak Configuration
# ======================
KEYCLOAK_URL = "http://localhost:8080"
REALM = "FastAPI"
AUDIENCE = "jobtinder-app"

JWKS_URL = f"{KEYCLOAK_URL}/realms/{REALM}/protocol/openid-connect/certs"
ISSUER = f"{KEYCLOAK_URL}/realms/{REALM}"

# OAuth2PasswordBearer: FastAPI extracts "Authorization: Bearer <token>"
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="http://localhost:8080/realms/FastAPI/protocol/openid-connect/token")  
# Note: "tokenUrl" is not used with Keycloak, but required by FastAPI’s schema.

# Cache the JWKS keys (so we don’t fetch them on every request)
_jwks_cache = None

async def get_jwks():
    global _jwks_cache
    if _jwks_cache is None:
        async with httpx.AsyncClient() as client:
            resp = await client.get(JWKS_URL)
            resp.raise_for_status()
            _jwks_cache = resp.json()
    return _jwks_cache


# ==========================
# Dependency to get user info
# ==========================
async def get_current_user(token: str = Depends(oauth2_scheme)):
    """
    1. Extract token from Authorization header.
    2. Fetch Keycloak's public keys.
    3. Verify the token's signature and claims.
    4. Return decoded user info (claims).
    """

    jwks = await get_jwks()

    try:
        # jose.jwt will try all keys in JWKS until one works
        payload = jwt.decode(
            token,
            jwks,                        # Public keys from Keycloak
            algorithms=["RS256"],        # Keycloak uses RS256
            audience=AUDIENCE,           # Verify "aud" claim
            issuer=ISSUER,               # Verify "iss" claim
        )
        
    except JWTError as e:
        raise HTTPException(status_code=401, detail="Invalid token") from e

    # Example: payload contains sub, preferred_username, roles, etc.
    return payload

from app.core.config import templates

@router.get("/login")
def login(request: Request):
    return templates.TemplateResponse("login.html", {"request": request})

@router.get("/callback")
def callback(request: Request):
    return templates.TemplateResponse("callback.html", {"request": request})
