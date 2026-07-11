# app/auth/schemas.py

from pydantic import BaseModel, EmailStr


# -------------------------------
# USER REGISTRATION SCHEMA
# -------------------------------
class UserRegister(BaseModel):
    username: str
    email: EmailStr
    password: str
    role: str   # STUDENT / TEACHER / ADMIN


# -------------------------------
# USER LOGIN SCHEMA
# -------------------------------
class UserLogin(BaseModel):
    username: str
    password: str
