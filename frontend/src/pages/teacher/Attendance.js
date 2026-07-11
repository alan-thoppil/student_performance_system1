import React, { useEffect, useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function Attendance() {

  const [students, setStudents] = useState([]);
  const [selected, setSelected] = useState({});
  const [period, setPeriod] = useState(1);

  // NEW: attendance date
  const [attendanceDate, setAttendanceDate] = useState(
    new Date().toISOString().split("T")[0]
  );

  useEffect(() => {
    loadStudents();
  }, []);

  const loadStudents = async () => {

    try {

      const res = await API.get("/teacher/students-attendance");

      setStudents(res.data);

    } catch {

      alert("Failed to load students");

    }

  };

  const mark = (id, status) => {

    setSelected(prev => ({
      ...prev,
      [id]: status
    }));

  };

  const saveAttendance = async () => {

    try {

      const studentsData = Object.keys(selected).map(id => ({
        student_id: parseInt(id),
        status: selected[id]
      }));

      await API.post("/teacher/mark-attendance", {
        period: period,
        date: attendanceDate,   // NEW
        students: studentsData
      });

      alert("Attendance saved");

      setSelected({});

      loadStudents(); // refresh percentage

    } catch (err) {

      alert(err.response?.data?.detail || "Error saving attendance");

    }

  };

  const getColor = (percent) => {

    if (percent >= 75) return "green";

    if (percent >= 50) return "orange";

    return "red";

  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h3>Attendance</h3>

        {/* NEW DATE SELECTOR */}
        <div className="mb-3">

          <label>Select Date</label>

          <input
            type="date"
            className="form-control"
            value={attendanceDate}
            max={new Date().toISOString().split("T")[0]}
            onChange={(e) => setAttendanceDate(e.target.value)}
          />

        </div>

        <div className="mb-3">

          <label>Select Period</label>

          <select
            className="form-control"
            value={period}
            onChange={(e) => setPeriod(e.target.value)}
          >

            <option value={1}>Period 1</option>
            <option value={2}>Period 2</option>
            <option value={3}>Period 3</option>
            <option value={4}>Period 4</option>
            <option value={5}>Period 5</option>

          </select>

        </div>

        <table className="table table-bordered">

          <thead className="table-dark">

            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Attendance Today</th>
              <th>Overall %</th>
            </tr>

          </thead>

          <tbody>

            {students.map(s => {

              const status = selected[s.id];

              return (

                <tr key={s.id}>

                  <td>{s.username}</td>

                  <td>{s.email}</td>

                  <td>

                    <button
                      className={`btn btn-sm me-2 ${
                        status === "present"
                          ? "btn-success"
                          : "btn-outline-success"
                      }`}
                      onClick={() => mark(s.id, "present")}
                    >
                      Present
                    </button>

                    <button
                      className={`btn btn-sm ${
                        status === "absent"
                          ? "btn-danger"
                          : "btn-outline-danger"
                      }`}
                      onClick={() => mark(s.id, "absent")}
                    >
                      Absent
                    </button>

                  </td>

                  <td>

                    <span
                      style={{
                        fontWeight: "bold",
                        color: getColor(s.percentage)
                      }}
                    >
                      {s.percentage || 0}%
                    </span>

                  </td>

                </tr>

              );

            })}

          </tbody>

        </table>

        <button
          className="btn btn-primary mt-3"
          onClick={saveAttendance}
        >
          Save Attendance
        </button>

      </div>
    </>
  );

}