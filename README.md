# Student Performance Monitoring System

A comprehensive web application to monitor student performance, perform academic analysis, categorize student risk, and offer personalized chatbot recommendations.

This repository is organized as a monorepo containing:
*   [**backend/**](file:///d:/student_performance_system/backend): A Python **FastAPI** application for APIs and machine learning processes (Tensorflow, Scikit-learn).
*   [**frontend/**](file:///d:/student_performance_system/frontend): A **React** application built with React Router, Axios, and Bootstrap.

---

## 🛠️ Tech Stack
*   **Frontend**: React (v19), React Router (v6), Axios, Bootstrap 5
*   **Backend**: FastAPI, SQLAlchemy (PostgreSQL ORM), Uvicorn, Gunicorn
*   **Machine Learning**: TensorFlow, Scikit-Learn, SHAP, LIME
*   **Database**: PostgreSQL

---

## 🚀 Quick Start with Docker (Recommended)

To run the entire stack (Database, Backend, Frontend) with a single command:

1.  Make sure you have [Docker](https://www.docker.com/) and Docker Compose installed.
2.  Run the following command in the project root directory:
    ```bash
    docker-compose up --build
    ```
3.  Once the build is complete:
    *   **Frontend** will be available at: [http://localhost:3000](http://localhost:3000)
    *   **Backend API** will be available at: [http://localhost:8000](http://localhost:8000)
    *   **API Documentation** will be available at: [http://localhost:8000/docs](http://localhost:8000/docs)

---

## 💻 Local Development Setup

### 1. Database Setup
Ensure you have a PostgreSQL database instance running.
*   Default database name: `student_performance_db`
*   Create this database locally inside PostgreSQL before running the app.

### 2. Backend Setup
1.  Navigate to the backend directory:
    ```bash
    cd backend
    ```
2.  Create a virtual environment and activate it:
    ```bash
    python -m venv venv
    # On Windows:
    .\venv\Scripts\activate
    # On Linux/macOS:
    source venv/bin/activate
    ```
3.  Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```
4.  Configure your environment variables. Copy `.env.example` to `.env`:
    ```bash
    cp .env.example .env
    ```
    Open `.env` and fill in your PostgreSQL `DATABASE_URL` and `OPENAI_API_KEY`.
5.  Create database tables:
    ```bash
    python create_tables.py
    ```
6.  Start the FastAPI development server:
    ```bash
    uvicorn app.main:app --reload
    ```
    API will run on [http://127.0.0.1:8000](http://127.0.0.1:8000).

### 3. Frontend Setup
1.  Navigate to the frontend directory:
    ```bash
    cd ../frontend
    ```
2.  Install dependencies:
    ```bash
    npm install
    ```
3.  Configure environment variables (if API runs on a custom port/URL, default is `http://localhost:8000` via Axios config):
    Create a `.env` file in the `frontend` folder:
    ```env
    REACT_APP_API_URL=http://localhost:8000
    ```
4.  Start the React dev server:
    ```bash
    npm start
    ```
    Frontend will run on [http://localhost:3000](http://localhost:3000).

---

## 🌐 Hosting & Deployment Instructions

Here is how you can host the application on free/budget-friendly platforms:

### 1. Database (PostgreSQL)
*   **Platform**: **Neon.tech** or **Supabase** (both provide perpetually free PostgreSQL).
*   **Deployment**:
    1.  Create a project on Neon or Supabase.
    2.  Copy the connection string (URI) provided.
    3.  Set this connection string as the `DATABASE_URL` environment variable on your backend host.

### 2. Backend (FastAPI)
*   **Platform**: **Render** (Web Service free tier) or **Railway** (PaaS, ~$5/mo).
    *   *Note*: Vercel is not recommended due to serverless bundle size limits with Tensorflow & Scikit-learn libraries.
*   **Deployment**:
    1.  Create a new Web Service on Render or Railway connected to your Git repository.
    2.  Set the Root Directory to `backend`.
    3.  Set the start command to:
        ```bash
        gunicorn -w 2 -k uvicorn.workers.UvicornWorker app.main:app --bind 0.0.0.0:8000
        ```
    4.  Add the environment variables in the dashboard:
        *   `DATABASE_URL`: (your connection string from Neon/Supabase)
        *   `OPENAI_API_KEY`: (your OpenAI key)
        *   `ALLOWED_ORIGINS`: (URL of your hosted frontend, e.g. `https://your-app.vercel.app`)

### 3. Frontend (React)
*   **Platform**: **Vercel** (Highly recommended, free tier).
*   **Deployment**:
    1.  Import your repository into Vercel.
    2.  Select `frontend` as the Root Directory.
    3.  In the Build & Development settings, Vercel will automatically configure the React build command (`npm run build`).
    4.  Add the environment variable:
        *   `REACT_APP_API_URL`: (your hosted backend URL, e.g., `https://your-backend.onrender.com`)
    5.  Deploy.
