from sqlalchemy import text


def get_weekly_study_hours(student_id, db):

    result = db.execute(
        text("""
        SELECT
        SUM(EXTRACT(EPOCH FROM (end_time - start_time)))/3600
        FROM study_sessions
        WHERE student_id=:sid
        AND end_time IS NOT NULL
        AND start_time >= NOW() - INTERVAL '7 days'
        """),
        {"sid": student_id}
    ).fetchone()

    hours = result[0] if result and result[0] else 0

    return hours