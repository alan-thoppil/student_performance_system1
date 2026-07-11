from database import SessionLocal
from app.auth.utils import hash_password
from sqlalchemy import text

db = SessionLocal()

email = "admin@gmail.com"
password = "admin123"   # change later
username = "Super Admin"

# check if admin exists
existing = db.execute(
    text("SELECT id FROM users WHERE role='admin'")
).fetchone()

if existing:
    print("Admin already exists")
else:
    db.execute(
        text("""
        INSERT INTO users (username, email, password, role, status, is_active)
        VALUES (:username, :email, :password, 'admin', 'APPROVED', TRUE)
        """),
        {
            "username": username,
            "email": email,
            "password": hash_password(password)
        }
    )
    db.commit()
    print("Admin created successfully")

db.close()
