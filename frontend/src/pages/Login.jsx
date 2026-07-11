import React, { useState } from "react";
import API from "../services/api";

function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = async () => {
    try {
      const res = await API.post("/auth/login", {
        email,
        password,
      });

      // ✅ STORE AUTH DATA
      localStorage.setItem("token", res.data.access_token);
      localStorage.setItem("role", res.data.role);

      // ✅ REDIRECT BY ROLE
      if (res.data.role === "admin") {
        window.location.href = "/admin";
      } else if (res.data.role === "teacher") {
        window.location.href = "/teacher";
      } else {
        window.location.href = "/dashboard";
      }

    } catch (err) {
      alert(err.response?.data?.detail || "Login failed");
    }
  };

  return (
    <div className="container mt-5" style={{ maxWidth: 400 }}>
      <h3 className="mb-3">Login</h3>

      <input
        className="form-control mb-2"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />

      <input
        type="password"
        className="form-control mb-3"
        placeholder="Password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />

      <button className="btn btn-primary w-100" onClick={handleLogin}>
        Login
      </button>

      <p className="mt-3">
        New user? <a href="/register">Register</a>
      </p>
    </div>
  );
}

export default Login;
