import torch
import torch.nn as nn
import numpy as np
import joblib
from pathlib import Path

# -------------------------------------------------
# Paths
# -------------------------------------------------
BASE_DIR = Path(__file__).resolve().parent.parent
MODEL_PATH = BASE_DIR / "ml_model" / "models" / "dnn_risk_model_pso.pt"
SCALER_PATH = BASE_DIR / "ml_model" / "models" / "scaler_pso.pkl"

# -------------------------------------------------
# DNN architecture (MUST match PSO training)
# -------------------------------------------------
class RiskDNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(5, 26),
            nn.ReLU(),
            nn.Dropout(0.25),
            nn.Linear(26, 16),
            nn.ReLU(),
            nn.Linear(16, 3)
        )

    def forward(self, x):
        return self.net(x)

# -------------------------------------------------
# Load model & scaler once
# -------------------------------------------------
model = RiskDNN()
model.load_state_dict(torch.load(MODEL_PATH, map_location="cpu"))
model.eval()

scaler = joblib.load(SCALER_PATH)

LABELS = ["At Risk", "Average", "Good"]

# -------------------------------------------------
# Prediction function
# -------------------------------------------------
def predict_risk(features: list):
    X = np.array([features])
    X_scaled = scaler.transform(X)

    with torch.no_grad():
        logits = model(torch.tensor(X_scaled, dtype=torch.float32))
        probs = torch.softmax(logits, dim=1).numpy()[0]

    predicted_index = int(np.argmax(probs))

    return {
        "risk_level": LABELS[predicted_index],
        "probabilities": {
            "At Risk": float(probs[0]),
            "Average": float(probs[1]),
            "Good": float(probs[2]),
        }
    }
