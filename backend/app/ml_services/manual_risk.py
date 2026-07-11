def calculate_manual_risk(attendance, marks, studytime):

    if attendance < 50 or marks < 40:
        return "HIGH"

    if attendance < 70 or marks < 60:
        return "MEDIUM"

    return "LOW"