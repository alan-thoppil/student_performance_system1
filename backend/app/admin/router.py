from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.admin.schemas import TeacherApprovalRequest, DepartmentCreate
from app.auth.utils import verify_password, hash_password

router = APIRouter(
    prefix="/admin",
    tags=["Admin"]
)

# -------------------------------------------------
# 1️⃣ Pending teachers
# -------------------------------------------------
@router.get("/pending-teachers")
def get_pending_teachers(db: Session = Depends(get_db)):
    return db.execute(
        text("""
            SELECT id, username, email, status
            FROM users
            WHERE role='teacher' AND status='PENDING'
        """)
    ).mappings().all()


# -------------------------------------------------
# 2️⃣ Approve / Reject teacher
# -------------------------------------------------
@router.post("/approve-teacher")
def approve_teacher(data: TeacherApprovalRequest, db: Session = Depends(get_db)):
    teacher = db.execute(
        text("SELECT id FROM users WHERE id=:id AND role='teacher'"),
        {"id": data.teacher_id}
    ).fetchone()

    if not teacher:
        raise HTTPException(404, "Teacher not found")

    db.execute(
        text("""
            UPDATE users
            SET status=:status, is_verified=:verified, is_active=:active
            WHERE id=:id
        """),
        {
            "id": data.teacher_id,
            "status": "APPROVED" if data.approved else "REJECTED",
            "verified": data.approved,
            "active": data.approved
        }
    )

    db.commit()
    return {"message": "Teacher updated"}


# -------------------------------------------------
# 3️⃣ Approved teachers
# -------------------------------------------------
@router.get("/approved-teachers")
def get_approved_teachers(db: Session = Depends(get_db)):
    return db.execute(
        text("""
            SELECT id, username, email
            FROM users
            WHERE role='teacher' AND status='APPROVED'
        """)
    ).mappings().all()


# -------------------------------------------------
# 4️⃣ Create department
# -------------------------------------------------
@router.post("/departments")
def create_department(data: DepartmentCreate, db: Session = Depends(get_db)):
    exists = db.execute(
        text("SELECT id FROM departments WHERE name=:name"),
        {"name": data.name}
    ).fetchone()

    if exists:
        raise HTTPException(400, "Department already exists")

    db.execute(
        text("INSERT INTO departments (name) VALUES (:name)"),
        {"name": data.name}
    )

    db.commit()
    return {"message": "Department created"}


# -------------------------------------------------
# 5️⃣ CHANGE ADMIN (ONE ADMIN ONLY)
# -------------------------------------------------
@router.post("/change-admin")
def change_admin(data: dict, db: Session = Depends(get_db)):
    new_email = data.get("new_admin_email")
    admin_password = data.get("current_admin_password")

    if not new_email or not admin_password:
        raise HTTPException(400, "Missing data")

    # Current admin
    admin = db.execute(
        text("SELECT id, password FROM users WHERE role='admin' AND is_active=TRUE")
    ).fetchone()

    if not admin or not verify_password(admin_password, admin[1]):
        raise HTTPException(401, "Invalid admin password")

    # New admin must already exist
    new_admin = db.execute(
        text("SELECT id FROM users WHERE email=:email"),
        {"email": new_email}
    ).fetchone()

    if not new_admin:
        raise HTTPException(404, "New admin user not found")

    # Deactivate old admin
    db.execute(
        text("UPDATE users SET role='teacher', is_active=FALSE WHERE id=:id"),
        {"id": admin[0]}
    )

    # Activate new admin (password unchanged)
    db.execute(
        text("""
            UPDATE users
            SET role='admin', status='APPROVED', is_active=TRUE
            WHERE id=:id
        """),
        {"id": new_admin[0]}
    )

    db.commit()
    return {"message": "Admin changed successfully"}


# -------------------------------------------------
# 6️⃣ CHANGE ADMIN PASSWORD (NEW)
# -------------------------------------------------
@router.post("/change-password")
def change_admin_password(data: dict, db: Session = Depends(get_db)):
    old_password = data.get("old_password")
    new_password = data.get("new_password")

    if not old_password or not new_password:
        raise HTTPException(400, "Missing password fields")

    admin = db.execute(
        text("SELECT id, password FROM users WHERE role='admin' AND is_active=TRUE")
    ).fetchone()

    if not admin or not verify_password(old_password, admin[1]):
        raise HTTPException(401, "Invalid current password")

    db.execute(
        text("UPDATE users SET password=:pwd WHERE id=:id"),
        {
            "pwd": hash_password(new_password),
            "id": admin[0]
        }
    )

    db.commit()
    return {"message": "Admin password changed successfully"}
