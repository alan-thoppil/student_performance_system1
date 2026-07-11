from database import engine, Base

# Import all models so SQLAlchemy knows them
import app.users.models
import app.admin.models

print("Creating tables...")
Base.metadata.create_all(bind=engine)
print("✅ Tables created successfully")
