# database.py

import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# Load environment variables from .env file
load_dotenv()

# PostgreSQL connection URL
# NOTE: If password has special characters (@, %, etc),
# it must be URL-encoded. Example: abs@123 -> abs%40123
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql://postgres:alan%4012345@localhost:5432/student_performance_db"
)

# Create the database engine
engine = create_engine(DATABASE_URL)

# Create a session factory
SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

# Base class for ORM models
Base = declarative_base()

# ✅ THIS IS WHAT WAS MISSING
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
