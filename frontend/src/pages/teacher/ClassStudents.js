import React, { useEffect, useState, useCallback } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function ClassStudents() {

  const [students, setStudents] = useState([]);

  const classId = localStorage.getItem("class_id");

  const fetchStudents = useCallback(async () => {

    try {

      const res = await API.get(`/teacher/class-students/${classId}`);

      setStudents(res.data);

    } catch (err) {

      console.error("Error loading class students", err);

    }

  }, [classId]);

  useEffect(() => {

    fetchStudents();

  }, [fetchStudents]);

  return (

    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h2>Class Students</h2>

        <h5>Class ID: {classId}</h5>

        <table className="table table-bordered mt-3">

          <thead className="table-dark">

            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Class</th>
            </tr>

          </thead>

          <tbody>

            {students.map(student => (

              <tr key={student.id}>

                <td>{student.id}</td>
                <td>{student.username}</td>
                <td>{student.email}</td>
                <td>{student.class_id}</td>

              </tr>

            ))}

          </tbody>

        </table>

      </div>

    </>

  );
}