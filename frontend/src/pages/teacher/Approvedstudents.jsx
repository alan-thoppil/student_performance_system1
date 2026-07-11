import React, { useEffect, useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function ApprovedStudents() {
  const [students, setStudents] = useState([]);

  useEffect(() => {
    fetchApproved();
  }, []);

  const fetchApproved = async () => {
    try {
      const res = await API.get("/teacher/approved-students");
      setStudents(res.data);
    } catch (err) {
      alert("Failed to load approved students");
    }
  };

  return (
    <>
      <TeacherNavbar />
      <div className="container mt-4">
        <h3>Approved Students</h3>

        {students.length === 0 ? (
          <p>No approved students</p>
        ) : (
          <table className="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Email</th>
              </tr>
            </thead>
            <tbody>
              {students.map((s) => (
                <tr key={s.id}>
                  <td>{s.username}</td>
                  <td>{s.email}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </>
  );
}