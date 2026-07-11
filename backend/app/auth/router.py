# app/auth/router.py

from fastapi import APIRouter, Depends, HTTPException, Body
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.auth.schemas import UserRegister, UserLogin
from app.auth.utils import hash_password, verify_password, create_access_token

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)

# -------------------------------
# USER REGISTRATION
# -------------------------------
@router.post("/register")
def register_user(
    user: UserRegister = Body(...),
    db: Session = Depends(get_db)
):
    # Check username
    existing_user = db.execute(
        text("SELECT id FROM users WHERE username = :username"),
        {"username": user.username}
    ).fetchone()

    if existing_user:
        raise HTTPException(status_code=400, detail="Username already exists")

    # Check email
    existing_email = db.execute(
        text("SELECT id FROM users WHERE email = :email"),
        {"email": user.email}
    ).fetchone()

    if existing_email:
        raise HTTPException(status_code=400, detail="Email already exists")

    hashed_pwd = hash_password(user.password)

    # Role-based defaults
    role = user.role.upper()

    if role == "STUDENT":
        status = "APPROVED"
        is_active = True
        is_verified = True
    else:  # TEACHER / ADMIN
        status = "PENDING"
        is_active = False
        is_verified = False

    db.execute(
        text("""
            INSERT INTO users (username, email, password, role, status, is_active, is_verified)
            VALUES (:username, :email, :password, :role, :status, :is_active, :is_verified)
        """),
        {
            "username": user.username,
            "email": user.email,
            "password": hashed_pwd,
            "role": role,
            "status": status,
            "is_active": is_active,
            "is_verified": is_verified
        }
    )

    db.commit()

    return {"message": "User registered successfully"}


# -------------------------------
# USER LOGIN
# -------------------------------
@router.post("/login")
def login_user(
    user: UserLogin = Body(...),
    db: Session = Depends(get_db)
):
    db_user = db.execute(
        text("""
            SELECT id, username, password, role, is_active, is_verified
            FROM users
            WHERE username = :username
        """),
        {"username": user.username}
    ).fetchone()

    if not db_user or not verify_password(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Invalid username or password")

    if not db_user.is_active:
        raise HTTPException(status_code=403, detail="Account not activated")

    if not db_user.is_verified:
        raise HTTPException(status_code=403, detail="Account not verified")

    # JWT TOKEN
    token = create_access_token({
        "user_id": db_user.id,
        "role": db_user.role
    })

    return {
        "access_token": token,
        "token_type": "bearer",
        "user_id": db_user.id,
        "username": db_user.username,
        "role": db_user.role
    }
