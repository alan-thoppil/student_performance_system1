import { useEffect, useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function AddMarksTable() {

  const [students, setStudents] = useState([]);
  const [subject, setSubject] = useState("");
  const [examType, setExamType] = useState("");
  const [maxMarks, setMaxMarks] = useState("");

  useEffect(() => {
    loadStudents();
  }, []);

  const loadStudents = async () => {

    const classId = localStorage.getItem("class_id");

    const res = await API.get(`/teacher/class/${classId}/students`);

    const data = res.data.map(s => ({
      ...s,
      marks: ""
    }));

    setStudents(data);
  };

  const updateMarks = (index, value) => {

    const updated = [...students];
    updated[index].marks = value;
    setStudents(updated);
  };

  const saveMarks = async () => {

    try {

      await API.post("/teacher/bulk-add-marks", {
        subject,
        exam_type: examType,
        max_marks: Number(maxMarks),
        students: students.map(s => ({
          student_id: s.id,
          marks: Number(s.marks || 0)
        }))
      });

      alert("Marks saved successfully");

    } catch (err) {
      alert("Error saving marks");
    }

  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h3>Add Marks (Table)</h3>

        <div className="row mb-3">

          <div className="col">
            <input
              className="form-control"
              placeholder="Subject"
              value={subject}
              onChange={(e)=>setSubject(e.target.value)}
            />
          </div>

          <div className="col">
            <input
              className="form-control"
              placeholder="Exam Type"
              value={examType}
              onChange={(e)=>setExamType(e.target.value)}
            />
          </div>

          <div className="col">
            <input
              className="form-control"
              placeholder="Max Marks"
              value={maxMarks}
              onChange={(e)=>setMaxMarks(e.target.value)}
            />
          </div>

        </div>

        <table className="table table-bordered">

          <thead className="table-dark">
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Marks</th>
            </tr>
          </thead>

          <tbody>

            {students.map((s,index)=>(
              <tr key={s.id}>

                <td>{s.id}</td>
                <td>{s.username}</td>
                <td>{s.email}</td>

                <td>
                  <input
                    className="form-control"
                    value={s.marks}
                    onChange={(e)=>updateMarks(index,e.target.value)}
                  />
                </td>

              </tr>
            ))}

          </tbody>

        </table>

        <button
          className="btn btn-primary"
          onClick={saveMarks}
        >
          Save Marks
        </button>

      </div>
    </>
  );
}