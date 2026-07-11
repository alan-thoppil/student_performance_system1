import { useEffect, useState } from "react";
import TeacherNavbar from "../../components/TeacherNavbar";
import { getStudents, removeStudent } from "../../services/teacherService";

export default function Students() {
  const [students, setStudents] = useState([]);

  useEffect(() => {
    getStudents().then(res => setStudents(res.data));
  }, []);

  const handleRemove = (id) => {
    if (!window.confirm("Remove this student?")) return;

    removeStudent(id).then(() => {
      setStudents(students.filter(s => s.id !== id));
    });
  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">
        <h3>Students</h3>

        <table className="table table-bordered table-hover">
          <thead className="table-dark">
            <tr>
              <th>Name</th>
              <th>Email</th>
              <th>Status</th>
              <th>Action</th>
            </tr>
          </thead>

          <tbody>
            {students.map(s => (
              <tr key={s.id}>
                <td>{s.username}</td>
                <td>{s.email}</td>
                <td>
                  {s.is_active ? "Active" : "Blocked"}
                </td>
                <td>
                  {s.is_active && (
                    <button
                      className="btn btn-danger btn-sm"
                      onClick={() => handleRemove(s.id)}
                    >
                      Remove
                    </button>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
}
