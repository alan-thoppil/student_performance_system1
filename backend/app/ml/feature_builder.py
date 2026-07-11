def build_student_features(student_data):

    studytime = student_data["quiz_attempts"]

    failures = student_data["failed_subjects"]

    absences = student_data["total_classes"] - student_data["attended_classes"]

    g1 = student_data["internal_marks"]

    g2 = student_data["quiz_average"]

    return studytime, failures, absences, g1, g2