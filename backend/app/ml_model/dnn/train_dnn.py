import pandas as pd
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import joblib

# -----------------------------
# Config
# -----------------------------
DATA_PATH = "../dataset/processed/student_processed.csv"
MODEL_PATH = "../models/dnn_risk_model.pt"
SCALER_PATH = "../models/scaler.pkl"
EPOCHS = 50
BATCH_SIZE = 16
LR = 0.001

# -----------------------------
# Load dataset
# -----------------------------
df = pd.read_csv(DATA_PATH)

X = df[["studytime", "failures", "absences", "G1", "G2"]].values
y = df["risk_label"].values

# -----------------------------
# Train-test split (80/20)
# -----------------------------
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# -----------------------------
# Scaling
# -----------------------------
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

joblib.dump(scaler, SCALER_PATH)

# -----------------------------
# PyTorch Dataset
# -----------------------------
class StudentDataset(Dataset):
    def __init__(self, X, y):
        self.X = torch.tensor(X, dtype=torch.float32)
        self.y = torch.tensor(y, dtype=torch.long)

    def __len__(self):
        return len(self.X)

    def __getitem__(self, idx):
        return self.X[idx], self.y[idx]

train_ds = StudentDataset(X_train, y_train)
test_ds = StudentDataset(X_test, y_test)

train_loader = DataLoader(train_ds, batch_size=BATCH_SIZE, shuffle=True)
test_loader = DataLoader(test_ds, batch_size=BATCH_SIZE)

# -----------------------------
# DNN Model
# -----------------------------
class RiskDNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(5, 32),
            nn.ReLU(),
            nn.Dropout(0.3),
            nn.Linear(32, 16),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(16, 3)
        )

    def forward(self, x):
        return self.net(x)

model = RiskDNN()

# -----------------------------
# Training setup
# -----------------------------
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=LR)

# -----------------------------
# Training loop
# -----------------------------
for epoch in range(EPOCHS):
    model.train()
    total_loss = 0

    for Xb, yb in train_loader:
        optimizer.zero_grad()
        preds = model(Xb)
        loss = criterion(preds, yb)
        loss.backward()
        optimizer.step()
        total_loss += loss.item()

    if (epoch + 1) % 10 == 0:
        print(f"Epoch {epoch+1}/{EPOCHS} - Loss: {total_loss:.4f}")

# -----------------------------
# Evaluation
# -----------------------------
model.eval()
correct, total = 0, 0

with torch.no_grad():
    for Xb, yb in test_loader:
        outputs = model(Xb)
        _, predicted = torch.max(outputs, 1)
        total += yb.size(0)
        correct += (predicted == yb).sum().item()

accuracy = correct / total
print(f"✅ Test Accuracy: {accuracy:.4f}")

# -----------------------------
# Save model
# -----------------------------
torch.save(model.state_dict(), MODEL_PATH)
print("✅ DNN model saved")
