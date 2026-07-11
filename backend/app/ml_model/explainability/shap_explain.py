import torch
import torch.nn as nn
import pandas as pd
import shap
import joblib
import numpy as np
from pathlib import Path

# -------------------------------------------------
# Base directory = ml_model
# -------------------------------------------------
BASE_DIR = Path(__file__).resolve().parents[1]

MODEL_PATH = BASE_DIR / "models" / "dnn_risk_model_pso.pt"
SCALER_PATH = BASE_DIR / "models" / "scaler_pso.pkl"
DATA_PATH = BASE_DIR / "dataset" / "processed" / "student_processed_balanced.csv"

# -------------------------------------------------
# Load dataset
# -------------------------------------------------
if not DATA_PATH.exists():
    raise FileNotFoundError(f"Dataset not found at {DATA_PATH}")

df = pd.read_csv(DATA_PATH)

features = ["studytime", "failures", "absences", "G1", "G2"]
X = df[features].values

# -------------------------------------------------
# Load scaler and scale data
# -------------------------------------------------
scaler = joblib.load(SCALER_PATH)
X_scaled = scaler.transform(X)

# -------------------------------------------------
# PSO-Optimized DNN Model (MUST MATCH TRAINING)
# -------------------------------------------------
class RiskDNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(5, 26),      # PSO hidden units
            nn.ReLU(),
            nn.Dropout(0.2569),    # PSO dropout
            nn.Linear(26, 16),
            nn.ReLU(),
            nn.Linear(16, 3)       # At Risk / Average / Good
        )

    def forward(self, x):
        return self.net(x)

# -------------------------------------------------
# Load trained model
# -------------------------------------------------
model = RiskDNN()
model.load_state_dict(torch.load(MODEL_PATH, map_location="cpu"))
model.eval()

print("✅ PSO DNN model loaded successfully")

# -------------------------------------------------
# SHAP DeepExplainer
# -------------------------------------------------
# Background data (small subset)
background = torch.tensor(X_scaled[:100], dtype=torch.float32)

explainer = shap.DeepExplainer(model, background)

# Samples to explain
sample = torch.tensor(X_scaled[100:150], dtype=torch.float32)

shap_values = explainer.shap_values(sample)

# -------------------------------------------------
# SHAP Summary Plot
# -------------------------------------------------
print("📊 Generating SHAP summary plot...")

shap.summary_plot(
    shap_values,
    X[100:150],
    feature_names=features,
    class_names=["At Risk", "Average", "Good"]
)
