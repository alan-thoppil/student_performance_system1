# =========================
# analysis/schemas.py
# =========================

from pydantic import BaseModel


class RiskAnalysisResponse(BaseModel):
    """
    Response schema for student risk prediction
    """
    student_id: int
    average_percentage: float
    risk_level: str
