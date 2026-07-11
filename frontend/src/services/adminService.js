import axios from "axios";

const API = "http://127.0.0.1:8000/admin";

export const getPendingTeachers = () =>
  axios.get(`${API}/pending-teachers`);

export const getApprovedTeachers = () =>
  axios.get(`${API}/approved-teachers`);

export const approveTeacher = (teacher_id, approved) =>
  axios.post(`${API}/approve-teacher`, { teacher_id, approved });

export const createDepartment = (name) =>
  axios.post(`${API}/departments`, { name });

export const changeAdmin = (data) =>
  axios.post(`${API}/change-admin`, data);

export const changeAdminPassword = (data) =>
  axios.post(`${API}/change-password`, data);
