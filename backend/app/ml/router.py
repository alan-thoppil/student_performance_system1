from fastapi import APIRouter
from app.ml.schemas import MLPredictRequest, MLPredictResponse
from app.ml.services import predict_risk

router = APIRouter(
    prefix="/ml",
    tags=["Machine Learning"]
)

@router.post("/predict", response_model=MLPredictResponse)
def predict_student_risk(data: MLPredictRequest):
    features = [
        data.studytime,
        data.failures,
        data.absences,
        data.g1,
        data.g2
    ]

    return predict_risk(features)
