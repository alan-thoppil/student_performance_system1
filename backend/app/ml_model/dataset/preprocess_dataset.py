import pandas as pd
from pathlib import Path

# -------------------------------------------------
# Paths
# -------------------------------------------------
BASE_DIR = Path(__file__).resolve().parent

RAW_DATA_PATH = BASE_DIR / "raw" / "student-mat.csv"
PROCESSED_DIR = BASE_DIR / "processed"
PROCESSED_DATA_PATH = PROCESSED_DIR / "student_processed_balanced.csv"

PROCESSED_DIR.mkdir(exist_ok=True)

# -------------------------------------------------
# Load raw dataset
# -------------------------------------------------
if not RAW_DATA_PATH.exists():
    raise FileNotFoundError(f"❌ Raw dataset not found at {RAW_DATA_PATH}")

df = pd.read_csv(RAW_DATA_PATH, sep=";")

print("✅ Raw dataset loaded")
print(df.head())

# -------------------------------------------------
# Feature engineering
# -------------------------------------------------
df["percentage"] = (df["G3"] / 20) * 100

def assign_risk(p):
    if p < 40:
        return 0   # At Risk
    elif p < 70:
        return 1   # Average
    else:
        return 2   # Good

df["risk_label"] = df["percentage"].apply(assign_risk)

# -------------------------------------------------
# Select final features
# -------------------------------------------------
final_df = df[
    [
        "studytime",
        "failures",
        "absences",
        "G1",
        "G2",
        "percentage",
        "risk_label"
    ]
]

# -------------------------------------------------
# Class distribution BEFORE balancing
# -------------------------------------------------
print("\n📊 Class distribution BEFORE balancing:")
print(final_df["risk_label"].value_counts().sort_index())

# -------------------------------------------------
# BALANCING (SAFE METHOD)
# -------------------------------------------------
class_0 = final_df[final_df["risk_label"] == 0]
class_1 = final_df[final_df["risk_label"] == 1]
class_2 = final_df[final_df["risk_label"] == 2]

min_count = min(len(class_0), len(class_1), len(class_2))

print(f"\n🔻 Minimum class count: {min_count}")

balanced_df = pd.concat([
    class_0.sample(min_count, random_state=42),
    class_1.sample(min_count, random_state=42),
    class_2.sample(min_count, random_state=42)
])

# Shuffle
balanced_df = balanced_df.sample(frac=1, random_state=42).reset_index(drop=True)

# -------------------------------------------------
# Class distribution AFTER balancing
# -------------------------------------------------
print("\n📊 Class distribution AFTER balancing:")
print(balanced_df["risk_label"].value_counts().sort_index())

# -------------------------------------------------
# Save balanced dataset
# -------------------------------------------------
balanced_df.to_csv(PROCESSED_DATA_PATH, index=False)

print("\n✅ Preprocessing & balancing completed successfully")
print(f"📁 Saved to: {PROCESSED_DATA_PATH}")
print(balanced_df.head())
