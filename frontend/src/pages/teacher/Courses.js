import React, { useEffect, useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function Courses() {

  const [courses, setCourses] = useState([]);
  const [name, setName] = useState("");
  const [deptId, setDeptId] = useState("");

  useEffect(() => {
    loadCourses();
  }, []);

  const loadCourses = async () => {
    try {

      const res = await API.get("/teacher/courses");

      setCourses(res.data);

    } catch {
      alert("Failed to load courses");
    }
  };

  const createCourse = async () => {

    if (!name || !deptId) {
      alert("Please enter course name and department ID");
      return;
    }

    try {

      await API.post("/teacher/courses", {
        name,
        department_id: Number(deptId)
      });

      alert("Course created successfully");

      setName("");
      setDeptId("");

      loadCourses();

    } catch (err) {

      alert(err.response?.data?.detail || "Course creation failed");

    }
  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h3>Create Course</h3>

        <input
          className="form-control mb-2"
          placeholder="Course Name"
          value={name}
          onChange={(e) => setName(e.target.value)}
        />

        <input
          className="form-control mb-2"
          placeholder="Department ID"
          value={deptId}
          onChange={(e) => setDeptId(e.target.value)}
        />

        <button
          className="btn btn-primary mb-4"
          onClick={createCourse}
        >
          Create Course
        </button>

        <h4>Courses</h4>

        <table className="table">

          <thead>
            <tr>
              <th>Name</th>
              <th>Department</th>
            </tr>
          </thead>

          <tbody>

            {courses.length === 0 ? (
              <tr>
                <td colSpan="2">No courses found</td>
              </tr>
            ) : (
              courses.map((c) => (
                <tr key={c.id}>
                  <td>{c.name}</td>
                  <td>{c.department}</td>
                </tr>
              ))
            )}

          </tbody>

        </table>

      </div>
    </>
  );
}