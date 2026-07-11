import React from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";

import Login from "./pages/Login";
import Register from "./pages/Register";

import AdminDashboard from "./pages/AdminDashboard";
import TeacherDashboard from "./pages/teacher/TeacherDashboard";
import Students from "./pages/teacher/Students";
import CreateQuiz from "./pages/teacher/CreateQuiz";   // ✅ Added

const AdminRoute = ({ children }) => {
  const token = localStorage.getItem("token");
  const role = localStorage.getItem("role");

  if (!token || role !== "admin") {
    return <Navigate to="/" replace />;
  }
  return children;
};

const TeacherRoute = ({ children }) => {
  const token = localStorage.getItem("token");
  const role = localStorage.getItem("role");

  if (!token || role !== "teacher") {
    return <Navigate to="/" replace />;
  }
  return children;
};

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/register" element={<Register />} />

        <Route
          path="/admin"
          element={
            <AdminRoute>
              <AdminDashboard />
            </AdminRoute>
          }
        />

        <Route
          path="/teacher"
          element={
            <TeacherRoute>
              <TeacherDashboard />
            </TeacherRoute>
          }
        />

        <Route
          path="/teacher/students"
          element={
            <TeacherRoute>
              <Students />
            </TeacherRoute>
          }
        />

        {/* ✅ NEW ROUTE */}
        <Route
          path="/teacher/create-quiz"
          element={
            <TeacherRoute>
              <CreateQuiz />
            </TeacherRoute>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
