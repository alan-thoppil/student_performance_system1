import React, { useEffect, useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function PendingStudents() {
  const [students, setStudents] = useState([]);

  useEffect(() => {
    fetchPending();
  }, []);

  const fetchPending = async () => {
    try {
      const res = await API.get("/teacher/pending-students");
      setStudents(res.data);
    } catch (err) {
      alert("Failed to load pending students");
    }
  };

  const approveStudent = async (id) => {
    await API.post(`/teacher/approve-student/${id}`);
    fetchPending();
  };

  const rejectStudent = async (id) => {
    await API.post(`/teacher/reject-student/${id}`);
    fetchPending();
  };

  return (
    <>
      <TeacherNavbar />
      <div className="container mt-4">
        <h3>Pending Students</h3>

        {students.length === 0 ? (
          <p>No pending students</p>
        ) : (
          <table className="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              {students.map((s) => (
                <tr key={s.id}>
                  <td>{s.username}</td>
                  <td>{s.email}</td>
                  <td>
                    <button
                      className="btn btn-success btn-sm me-2"
                      onClick={() => approveStudent(s.id)}
                    >
                      Approve
                    </button>

                    <button
                      className="btn btn-danger btn-sm"
                      onClick={() => rejectStudent(s.id)}
                    >
                      Reject
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </>
  );
}