import React, { useEffect, useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function AIAnalytics() {

  const [data, setData] = useState([]);

  useEffect(() => {
    loadAnalytics();
  }, []);

  const loadAnalytics = async () => {

    try {

      const class_id = localStorage.getItem("class_id");

      const res = await API.get(`/teacher/analytics/${class_id}`);

      setData(res.data);

    } catch {
      alert("Failed to load analytics");
    }
  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">
        <h3>AI Student Analytics</h3>

        <table className="table table-bordered">

          <thead>
            <tr>
              <th>Student</th>
              <th>Prediction</th>
              <th>SHAP</th>
              <th>LIME</th>
            </tr>
          </thead>

          <tbody>
            {data.map((s) => (
              <tr key={s.id}>
                <td>{s.username}</td>
                <td>{s.prediction}</td>
                <td>{s.shap}</td>
                <td>{s.lime}</td>
              </tr>
            ))}
          </tbody>

        </table>
      </div>
    </>
  );
}