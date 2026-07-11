def build_student_features(student):

    studytime = student.quiz_attempts if hasattr(student, "quiz_attempts") else 2

    failures = student.failed_subjects if hasattr(student, "failed_subjects") else 0

    total_classes = getattr(student, "total_classes", 50)
    attended_classes = getattr(student, "attended_classes", 40)

    absences = total_classes - attended_classes

    g1 = getattr(student, "internal_marks", 10)

    g2 = getattr(student, "quiz_average", 12)

    return studytime, failures, absences, g1, g2