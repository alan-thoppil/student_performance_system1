from pydantic import BaseModel

class MLPredictRequest(BaseModel):
    studytime: int
    failures: int
    absences: int
    g1: float
    g2: float

class MLPredictResponse(BaseModel):
    risk_level: str
    probabilities: dict
