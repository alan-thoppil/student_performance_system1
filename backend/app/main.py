# =========================================================
# main.py
# Entry point for Student Performance Monitoring System
# =========================================================

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import os
from database import engine

# -------------------------------------------------
# Import routers
# -------------------------------------------------
from app.auth.router import router as auth_router
from app.users.router import router as users_router
from app.student.router import router as student_router
from app.teacher.router import router as teacher_router
from app.performance.router import router as performance_router
from app.analysis.router import router as analysis_router
from app.dashboards.router import router as dashboard_router
from app.ml.router import router as ml_router
from app.admin.router import router as admin_router

# -------------------------------------------------
# Create FastAPI application
# -------------------------------------------------
app = FastAPI(
    title="Student Performance Monitoring System",
    description=(
        "Backend API for monitoring student performance, "
        "academic analysis, and risk categorization"
    ),
    version="1.0.0"
)

# -------------------------------------------------
# CORS Middleware Configuration
# -------------------------------------------------
allowed_origins = os.getenv("ALLOWED_ORIGINS", "*")
origins = [origin.strip() for origin in allowed_origins.split(",") if origin.strip()]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -------------------------------------------------
# Root endpoint
# -------------------------------------------------
@app.get("/")
def root():
    return {"message": "Student Performance System backend is running"}

# -------------------------------------------------
# Database connectivity check
# -------------------------------------------------
@app.get("/db-check")
def db_check():
    try:
        connection = engine.connect()
        connection.close()
        return {"status": "Database connected successfully"}
    except Exception as e:
        return {"error": str(e)}

# -------------------------------------------------
# Include routers
# -------------------------------------------------
app.include_router(auth_router)
app.include_router(users_router)
app.include_router(student_router)
app.include_router(teacher_router)
app.include_router(performance_router)
app.include_router(analysis_router)
app.include_router(dashboard_router)
app.include_router(ml_router)
app.include_router(admin_router)
