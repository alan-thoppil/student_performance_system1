import React, { useState } from "react";
import API from "../services/api";

function Register() {
  const [form, setForm] = useState({
    username: "",
    email: "",
    password: "",
    role: "student",
  });

  const handleRegister = async () => {
    // ✅ BASIC VALIDATION
    if (!form.username || !form.email || !form.password) {
      alert("All fields are required");
      return;
    }

    // ✅ GMAIL ONLY RULE
    if (!form.email.endsWith("@gmail.com")) {
      alert("Only Gmail (@gmail.com) addresses are allowed");
      return;
    }

    try {
      const res = await API.post("/auth/register", form);
      alert(res.data.message || "Registered successfully");
      window.location.href = "/";
    } catch (err) {
      // 🔥 SHOW REAL BACKEND ERROR
      console.error(err);
      alert(
        err.response?.data?.detail ||
        err.response?.data?.message ||
        "Registration failed (backend error)"
      );
    }
  };

  return (
    <div className="container mt-5" style={{ maxWidth: "420px" }}>
      <div className="card shadow">
        <div className="card-body">
          <h3 className="text-center mb-4">Register</h3>

          <input
            className="form-control mb-2"
            placeholder="Username"
            value={form.username}
            onChange={(e) => setForm({ ...form, username: e.target.value })}
          />

          <input
            className="form-control mb-2"
            placeholder="Email (gmail only)"
            value={form.email}
            onChange={(e) => setForm({ ...form, email: e.target.value })}
          />

          <input
            type="password"
            className="form-control mb-2"
            placeholder="Password"
            value={form.password}
            onChange={(e) => setForm({ ...form, password: e.target.value })}
          />

          <select
            className="form-select mb-3"
            value={form.role}
            onChange={(e) => setForm({ ...form, role: e.target.value })}
          >
            <option value="student">Student</option>
            <option value="teacher">Teacher</option>
          </select>

          <button className="btn btn-primary w-100" onClick={handleRegister}>
            Register
          </button>
        </div>
      </div>
    </div>
  );
}

export default Register;
