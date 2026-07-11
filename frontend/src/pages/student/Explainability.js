import React from "react";

export default function Explainability() {

  return (
    <div className="container mt-4">

      <h3>Explainability</h3>

      <p>SHAP and LIME explanations will appear here.</p>

      <table className="table table-bordered mt-3">

        <thead className="table-dark">
          <tr>
            <th>Feature</th>
            <th>Impact</th>
          </tr>
        </thead>

        <tbody>
          <tr>
            <td>Attendance</td>
            <td>High Impact</td>
          </tr>
          <tr>
            <td>Marks</td>
            <td>Medium Impact</td>
          </tr>
        </tbody>

      </table>

    </div>
  );
}