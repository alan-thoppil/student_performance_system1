--
-- PostgreSQL database dump
--

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance (
    id integer NOT NULL,
    student_id integer,
    percentage integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    date date,
    status character varying(10),
    period integer
);


ALTER TABLE public.attendance OWNER TO postgres;

--
-- Name: attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_id_seq OWNER TO postgres;

--
-- Name: attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_id_seq OWNED BY public.attendance.id;


--
-- Name: batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batches (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    course_id integer
);


ALTER TABLE public.batches OWNER TO postgres;

--
-- Name: batches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batches_id_seq OWNER TO postgres;

--
-- Name: batches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.batches_id_seq OWNED BY public.batches.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    department_id integer
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_id_seq OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    dept_code character varying(20)
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_id_seq OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: marks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marks (
    id integer NOT NULL,
    student_id integer NOT NULL,
    subject character varying(100) NOT NULL,
    exam_type character varying(50) NOT NULL,
    marks integer NOT NULL,
    max_marks integer NOT NULL,
    uploaded_by integer,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    class_id integer
);


ALTER TABLE public.marks OWNER TO postgres;

--
-- Name: marks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marks_id_seq OWNER TO postgres;

--
-- Name: marks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marks_id_seq OWNED BY public.marks.id;


--
-- Name: otp_verifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otp_verifications (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    otp_code character varying(6) NOT NULL,
    purpose character varying(30) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    is_used boolean DEFAULT false
);


ALTER TABLE public.otp_verifications OWNER TO postgres;

--
-- Name: otp_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otp_verifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.otp_verifications_id_seq OWNER TO postgres;

--
-- Name: otp_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.otp_verifications_id_seq OWNED BY public.otp_verifications.id;


--
-- Name: performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.performance (
    id integer NOT NULL,
    student_id integer NOT NULL,
    subject character varying(100) NOT NULL,
    exam_type character varying(50) NOT NULL,
    marks double precision NOT NULL,
    max_marks double precision NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.performance OWNER TO postgres;

--
-- Name: performance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.performance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.performance_id_seq OWNER TO postgres;

--
-- Name: performance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.performance_id_seq OWNED BY public.performance.id;


--
-- Name: quiz_attempts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_attempts (
    id integer NOT NULL,
    quiz_id integer,
    student_id integer,
    score integer,
    submitted_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.quiz_attempts OWNER TO postgres;

--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_attempts_id_seq OWNER TO postgres;

--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_attempts_id_seq OWNED BY public.quiz_attempts.id;


--
-- Name: quiz_malpractice_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_malpractice_logs (
    id integer NOT NULL,
    student_id integer,
    quiz_id integer,
    issue character varying(200),
    logged_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.quiz_malpractice_logs OWNER TO postgres;

--
-- Name: quiz_malpractice_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_malpractice_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_malpractice_logs_id_seq OWNER TO postgres;

--
-- Name: quiz_malpractice_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_malpractice_logs_id_seq OWNED BY public.quiz_malpractice_logs.id;


--
-- Name: quiz_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_options (
    id integer NOT NULL,
    question_id integer NOT NULL,
    option_text text NOT NULL,
    is_correct boolean DEFAULT false
);


ALTER TABLE public.quiz_options OWNER TO postgres;

--
-- Name: quiz_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_options_id_seq OWNER TO postgres;

--
-- Name: quiz_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_options_id_seq OWNED BY public.quiz_options.id;


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quiz_questions (
    id integer NOT NULL,
    quiz_id integer,
    question_text text NOT NULL,
    option_a text NOT NULL,
    option_b text NOT NULL,
    option_c text NOT NULL,
    option_d text NOT NULL,
    correct_answer character varying(1) NOT NULL,
    hint text
);


ALTER TABLE public.quiz_questions OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quiz_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quiz_questions_id_seq OWNER TO postgres;

--
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quizzes (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    syllabus_context text,
    status character varying(20) DEFAULT 'draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    teacher_id integer,
    total_marks integer DEFAULT 0,
    duration_minutes integer DEFAULT 10,
    difficulty character varying(20),
    question_count integer DEFAULT 10,
    is_pdf boolean DEFAULT false
);


ALTER TABLE public.quizzes OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quizzes_id_seq OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- Name: risk_predictions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.risk_predictions (
    id integer NOT NULL,
    student_id integer,
    risk_level character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.risk_predictions OWNER TO postgres;

--
-- Name: risk_predictions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.risk_predictions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.risk_predictions_id_seq OWNER TO postgres;

--
-- Name: risk_predictions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.risk_predictions_id_seq OWNED BY public.risk_predictions.id;


--
-- Name: student_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_answers (
    id integer NOT NULL,
    response_id integer,
    question_id integer,
    selected_option character varying(1)
);


ALTER TABLE public.student_answers OWNER TO postgres;

--
-- Name: student_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_answers_id_seq OWNER TO postgres;

--
-- Name: student_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_answers_id_seq OWNED BY public.student_answers.id;


--
-- Name: student_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_responses (
    id integer NOT NULL,
    quiz_id integer,
    student_id integer,
    score integer,
    completed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.student_responses OWNER TO postgres;

--
-- Name: student_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_responses_id_seq OWNER TO postgres;

--
-- Name: student_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_responses_id_seq OWNED BY public.student_responses.id;


--
-- Name: student_risk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_risk (
    id integer NOT NULL,
    student_id integer,
    risk_level character varying(20),
    prob_at_risk double precision,
    prob_average double precision,
    prob_good double precision,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    manual_risk character varying(20)
);


ALTER TABLE public.student_risk OWNER TO postgres;

--
-- Name: student_risk_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_risk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_risk_id_seq OWNER TO postgres;

--
-- Name: student_risk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_risk_id_seq OWNED BY public.student_risk.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id integer NOT NULL,
    user_id integer NOT NULL,
    student_name character varying(100) NOT NULL,
    register_number character varying(50) NOT NULL,
    course character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: study_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.study_materials (
    id integer NOT NULL,
    title text,
    teacher_id integer,
    material_type text,
    file_url text,
    text_content text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    class_id character varying(20)
);


ALTER TABLE public.study_materials OWNER TO postgres;

--
-- Name: study_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.study_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.study_materials_id_seq OWNER TO postgres;

--
-- Name: study_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.study_materials_id_seq OWNED BY public.study_materials.id;


--
-- Name: study_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.study_sessions (
    id integer NOT NULL,
    student_id integer,
    material_id integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone
);


ALTER TABLE public.study_sessions OWNER TO postgres;

--
-- Name: study_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.study_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.study_sessions_id_seq OWNER TO postgres;

--
-- Name: study_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.study_sessions_id_seq OWNED BY public.study_sessions.id;


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    course_id integer
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subjects_id_seq OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subjects_id_seq OWNED BY public.subjects.id;


--
-- Name: syllabus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.syllabus (
    id integer NOT NULL,
    teacher_id integer NOT NULL,
    course_id integer,
    subject_name character varying(100),
    syllabus_text text,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    source_type character varying(20) DEFAULT 'text'::character varying,
    file_path text
);


ALTER TABLE public.syllabus OWNER TO postgres;

--
-- Name: syllabus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.syllabus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.syllabus_id_seq OWNER TO postgres;

--
-- Name: syllabus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.syllabus_id_seq OWNED BY public.syllabus.id;


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    teacher_name character varying(100) NOT NULL,
    department character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    approval_status character varying(20) DEFAULT 'PENDING'::character varying
);


ALTER TABLE public.teachers OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teachers_id_seq OWNER TO postgres;

--
-- Name: teachers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    email character varying(255),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    is_verified boolean DEFAULT false,
    is_active boolean DEFAULT false,
    is_approved boolean DEFAULT false,
    is_rejected boolean DEFAULT false,
    teacher_id integer,
    class_id character varying(20)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: attendance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance ALTER COLUMN id SET DEFAULT nextval('public.attendance_id_seq'::regclass);


--
-- Name: batches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches ALTER COLUMN id SET DEFAULT nextval('public.batches_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: marks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marks ALTER COLUMN id SET DEFAULT nextval('public.marks_id_seq'::regclass);


--
-- Name: otp_verifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp_verifications ALTER COLUMN id SET DEFAULT nextval('public.otp_verifications_id_seq'::regclass);


--
-- Name: performance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance ALTER COLUMN id SET DEFAULT nextval('public.performance_id_seq'::regclass);


--
-- Name: quiz_attempts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts ALTER COLUMN id SET DEFAULT nextval('public.quiz_attempts_id_seq'::regclass);


--
-- Name: quiz_malpractice_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_malpractice_logs ALTER COLUMN id SET DEFAULT nextval('public.quiz_malpractice_logs_id_seq'::regclass);


--
-- Name: quiz_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options ALTER COLUMN id SET DEFAULT nextval('public.quiz_options_id_seq'::regclass);


--
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: risk_predictions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.risk_predictions ALTER COLUMN id SET DEFAULT nextval('public.risk_predictions_id_seq'::regclass);


--
-- Name: student_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_answers ALTER COLUMN id SET DEFAULT nextval('public.student_answers_id_seq'::regclass);


--
-- Name: student_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_responses ALTER COLUMN id SET DEFAULT nextval('public.student_responses_id_seq'::regclass);


--
-- Name: student_risk id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_risk ALTER COLUMN id SET DEFAULT nextval('public.student_risk_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: study_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.study_materials ALTER COLUMN id SET DEFAULT nextval('public.study_materials_id_seq'::regclass);


--
-- Name: study_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.study_sessions ALTER COLUMN id SET DEFAULT nextval('public.study_sessions_id_seq'::regclass);


--
-- Name: subjects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects ALTER COLUMN id SET DEFAULT nextval('public.subjects_id_seq'::regclass);


--
-- Name: syllabus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus ALTER COLUMN id SET DEFAULT nextval('public.syllabus_id_seq'::regclass);


--
-- Name: teachers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.attendance VALUES (9, 2, NULL, '2026-03-06 13:20:23.304716', '2026-03-06', 'present', 1);
INSERT INTO public.attendance VALUES (10, 13, NULL, '2026-03-06 13:20:34.530175', '2026-03-06', 'present', 1);
INSERT INTO public.attendance VALUES (11, 13, NULL, '2026-03-06 13:29:44.551035', '2026-03-06', 'present', 1);
INSERT INTO public.attendance VALUES (12, 2, NULL, '2026-03-06 13:42:36.888083', '2026-03-06', 'present', 2);
INSERT INTO public.attendance VALUES (13, 3, NULL, '2026-03-06 13:42:36.888083', '2026-03-06', 'absent', 2);
INSERT INTO public.attendance VALUES (14, 13, NULL, '2026-03-06 13:42:36.888083', '2026-03-06', 'present', 2);
INSERT INTO public.attendance VALUES (15, 16, NULL, '2026-03-06 13:42:36.888083', '2026-03-06', 'present', 2);
INSERT INTO public.attendance VALUES (16, 1, NULL, '2026-03-06 23:44:31.931657', '2026-03-06', 'absent', 5);
INSERT INTO public.attendance VALUES (17, 3, NULL, '2026-03-06 23:44:31.931657', '2026-03-06', 'present', 5);
INSERT INTO public.attendance VALUES (18, 12, NULL, '2026-03-06 23:44:31.931657', '2026-03-06', 'absent', 5);
INSERT INTO public.attendance VALUES (19, 13, NULL, '2026-03-06 23:44:31.931657', '2026-03-06', 'present', 5);
INSERT INTO public.attendance VALUES (20, 16, NULL, '2026-03-06 23:44:31.931657', '2026-03-06', 'present', 5);
INSERT INTO public.attendance VALUES (21, 12, NULL, '2026-03-07 00:19:36.04965', '2026-03-07', 'absent', 1);
INSERT INTO public.attendance VALUES (22, 13, NULL, '2026-03-07 00:19:36.04965', '2026-03-07', 'present', 1);
INSERT INTO public.attendance VALUES (23, 14, NULL, '2026-03-07 00:19:36.04965', '2026-03-07', 'absent', 1);
INSERT INTO public.attendance VALUES (24, 20, NULL, '2026-03-07 00:19:36.04965', '2026-03-07', 'absent', 1);
INSERT INTO public.attendance VALUES (25, 12, NULL, '2026-03-07 11:32:25.872163', '2026-03-05', 'present', 2);
INSERT INTO public.attendance VALUES (26, 13, NULL, '2026-03-07 11:32:25.872163', '2026-03-05', 'absent', 2);
INSERT INTO public.attendance VALUES (27, 14, NULL, '2026-03-07 11:32:25.872163', '2026-03-05', 'present', 2);
INSERT INTO public.attendance VALUES (28, 20, NULL, '2026-03-07 11:32:25.872163', '2026-03-05', 'present', 2);
INSERT INTO public.attendance VALUES (29, 12, NULL, '2026-03-07 14:45:06.423948', '2026-03-03', 'present', 1);
INSERT INTO public.attendance VALUES (30, 13, NULL, '2026-03-07 14:45:06.423948', '2026-03-03', 'present', 1);
INSERT INTO public.attendance VALUES (31, 14, NULL, '2026-03-07 14:45:06.423948', '2026-03-03', 'present', 1);
INSERT INTO public.attendance VALUES (32, 20, NULL, '2026-03-07 14:45:06.423948', '2026-03-03', 'present', 1);
INSERT INTO public.attendance VALUES (33, 13, NULL, '2026-03-07 21:07:28.468223', '2026-03-04', 'present', 1);
INSERT INTO public.attendance VALUES (34, 12, NULL, '2026-03-07 21:07:38.381713', '2026-03-04', 'absent', 2);
INSERT INTO public.attendance VALUES (35, 13, NULL, '2026-03-07 21:07:38.381713', '2026-03-04', 'present', 2);
INSERT INTO public.attendance VALUES (36, 14, NULL, '2026-03-07 21:07:38.381713', '2026-03-04', 'present', 2);
INSERT INTO public.attendance VALUES (37, 20, NULL, '2026-03-07 21:07:38.381713', '2026-03-04', 'present', 2);
INSERT INTO public.attendance VALUES (38, 12, NULL, '2026-03-08 10:30:32.192925', '2026-03-08', 'present', 2);
INSERT INTO public.attendance VALUES (39, 13, NULL, '2026-03-08 10:30:32.192925', '2026-03-08', 'present', 2);
INSERT INTO public.attendance VALUES (40, 14, NULL, '2026-03-08 10:30:32.192925', '2026-03-08', 'present', 2);
INSERT INTO public.attendance VALUES (41, 20, NULL, '2026-03-08 10:30:32.192925', '2026-03-08', 'present', 2);
INSERT INTO public.attendance VALUES (42, 12, NULL, '2026-03-08 11:29:13.248785', '2026-03-08', 'present', 3);
INSERT INTO public.attendance VALUES (43, 13, NULL, '2026-03-08 11:29:13.248785', '2026-03-08', 'present', 3);
INSERT INTO public.attendance VALUES (44, 14, NULL, '2026-03-08 11:29:13.248785', '2026-03-08', 'present', 3);
INSERT INTO public.attendance VALUES (45, 20, NULL, '2026-03-08 11:29:13.248785', '2026-03-08', 'present', 3);
INSERT INTO public.attendance VALUES (46, 12, NULL, '2026-03-08 11:54:07.527764', '2026-03-08', 'present', 4);
INSERT INTO public.attendance VALUES (47, 13, NULL, '2026-03-08 11:54:07.527764', '2026-03-08', 'present', 4);
INSERT INTO public.attendance VALUES (48, 14, NULL, '2026-03-08 11:54:07.527764', '2026-03-08', 'present', 4);
INSERT INTO public.attendance VALUES (49, 20, NULL, '2026-03-08 11:54:07.527764', '2026-03-08', 'present', 4);
INSERT INTO public.attendance VALUES (50, 12, NULL, '2026-03-08 12:04:59.236248', '2026-03-08', 'present', 1);
INSERT INTO public.attendance VALUES (51, 13, NULL, '2026-03-08 12:04:59.236248', '2026-03-08', 'present', 1);
INSERT INTO public.attendance VALUES (52, 14, NULL, '2026-03-08 12:04:59.236248', '2026-03-08', 'present', 1);
INSERT INTO public.attendance VALUES (53, 20, NULL, '2026-03-08 12:04:59.236248', '2026-03-08', 'present', 1);
INSERT INTO public.attendance VALUES (54, 12, NULL, '2026-03-09 09:26:27.76309', '2026-03-09', 'present', 1);
INSERT INTO public.attendance VALUES (55, 13, NULL, '2026-03-09 09:26:27.76309', '2026-03-09', 'present', 1);
INSERT INTO public.attendance VALUES (56, 14, NULL, '2026-03-09 09:26:27.76309', '2026-03-09', 'present', 1);
INSERT INTO public.attendance VALUES (57, 20, NULL, '2026-03-09 09:26:27.76309', '2026-03-09', 'present', 1);
INSERT INTO public.attendance VALUES (58, 22, NULL, '2026-03-09 09:26:27.76309', '2026-03-09', 'present', 1);
INSERT INTO public.attendance VALUES (59, 12, NULL, '2026-03-12 10:17:51.572382', '2026-03-12', 'present', 1);
INSERT INTO public.attendance VALUES (60, 13, NULL, '2026-03-12 10:17:51.572382', '2026-03-12', 'present', 1);
INSERT INTO public.attendance VALUES (61, 14, NULL, '2026-03-12 10:17:51.572382', '2026-03-12', 'present', 1);
INSERT INTO public.attendance VALUES (62, 20, NULL, '2026-03-12 10:17:51.572382', '2026-03-12', 'absent', 1);
INSERT INTO public.attendance VALUES (63, 22, NULL, '2026-03-12 10:17:51.572382', '2026-03-12', 'absent', 1);
INSERT INTO public.attendance VALUES (64, 26, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'absent', 1);
INSERT INTO public.attendance VALUES (65, 12, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (66, 25, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (67, 14, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (68, 13, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (69, 20, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (70, 22, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (71, 29, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (72, 30, NULL, '2026-03-19 11:41:01.884973', '2026-03-19', 'present', 1);
INSERT INTO public.attendance VALUES (73, 13, NULL, '2026-03-20 16:39:07.568691', '2026-03-20', 'present', 1);
INSERT INTO public.attendance VALUES (74, 14, NULL, '2026-03-20 16:39:07.568691', '2026-03-20', 'absent', 1);
INSERT INTO public.attendance VALUES (75, 12, NULL, '2026-03-20 16:39:07.568691', '2026-03-20', 'present', 1);
INSERT INTO public.attendance VALUES (76, 20, NULL, '2026-03-20 16:39:07.568691', '2026-03-20', 'absent', 1);
INSERT INTO public.attendance VALUES (77, 12, NULL, '2026-03-22 11:11:50.081821', '2026-03-22', 'absent', 1);
INSERT INTO public.attendance VALUES (78, 14, NULL, '2026-03-22 11:11:50.081821', '2026-03-22', 'absent', 1);
INSERT INTO public.attendance VALUES (79, 13, NULL, '2026-03-22 11:11:50.081821', '2026-03-22', 'present', 1);
INSERT INTO public.attendance VALUES (80, 20, NULL, '2026-03-22 11:11:50.081821', '2026-03-22', 'present', 1);
INSERT INTO public.attendance VALUES (81, 22, NULL, '2026-03-24 22:38:24.278048', '2026-03-24', 'present', 1);
INSERT INTO public.attendance VALUES (82, 32, NULL, '2026-03-24 22:38:24.278048', '2026-03-24', 'present', 1);
INSERT INTO public.attendance VALUES (83, 22, NULL, '2026-03-24 23:11:28.122756', '2026-03-24', 'present', 2);
INSERT INTO public.attendance VALUES (84, 32, NULL, '2026-03-24 23:11:28.122756', '2026-03-24', 'present', 2);
INSERT INTO public.attendance VALUES (85, 22, NULL, '2026-03-25 10:49:41.832511', '2026-03-25', 'absent', 1);
INSERT INTO public.attendance VALUES (86, 32, NULL, '2026-03-25 10:49:41.832511', '2026-03-25', 'present', 1);
INSERT INTO public.attendance VALUES (87, 12, NULL, '2026-04-08 15:34:58.809833', '2026-04-08', 'present', 1);
INSERT INTO public.attendance VALUES (88, 13, NULL, '2026-04-08 15:34:58.809833', '2026-04-08', 'absent', 1);
INSERT INTO public.attendance VALUES (89, 14, NULL, '2026-04-08 15:34:58.809833', '2026-04-08', 'present', 1);
INSERT INTO public.attendance VALUES (90, 20, NULL, '2026-04-08 15:34:58.809833', '2026-04-08', 'present', 1);
INSERT INTO public.attendance VALUES (91, 12, NULL, '2026-04-24 11:50:53.188642', '2026-04-24', 'present', 1);
INSERT INTO public.attendance VALUES (92, 13, NULL, '2026-04-24 11:50:53.188642', '2026-04-24', 'absent', 1);
INSERT INTO public.attendance VALUES (93, 14, NULL, '2026-04-24 11:50:53.188642', '2026-04-24', 'present', 1);
INSERT INTO public.attendance VALUES (94, 20, NULL, '2026-04-24 11:50:53.188642', '2026-04-24', 'present', 1);
INSERT INTO public.attendance VALUES (95, 12, NULL, '2026-06-01 16:14:43.559016', '2026-06-01', 'present', 2);
INSERT INTO public.attendance VALUES (96, 14, NULL, '2026-06-01 16:14:43.559016', '2026-06-01', 'absent', 2);
INSERT INTO public.attendance VALUES (97, 13, NULL, '2026-06-01 16:14:43.559016', '2026-06-01', 'present', 2);
INSERT INTO public.attendance VALUES (98, 20, NULL, '2026-06-01 16:14:43.559016', '2026-06-01', 'present', 2);
INSERT INTO public.attendance VALUES (99, 12, NULL, '2026-06-03 12:36:09.587311', '2026-06-03', 'present', 1);
INSERT INTO public.attendance VALUES (100, 13, NULL, '2026-06-03 12:36:09.587311', '2026-06-03', 'present', 1);
INSERT INTO public.attendance VALUES (101, 14, NULL, '2026-06-03 12:36:09.587311', '2026-06-03', 'present', 1);
INSERT INTO public.attendance VALUES (102, 20, NULL, '2026-06-03 12:36:09.587311', '2026-06-03', 'present', 1);
INSERT INTO public.attendance VALUES (103, 12, NULL, '2026-06-08 18:37:08.180587', '2026-06-08', 'present', 1);
INSERT INTO public.attendance VALUES (104, 14, NULL, '2026-06-08 18:37:08.180587', '2026-06-08', 'present', 1);
INSERT INTO public.attendance VALUES (105, 20, NULL, '2026-06-08 18:37:08.180587', '2026-06-08', 'present', 1);
INSERT INTO public.attendance VALUES (106, 13, NULL, '2026-06-08 18:37:08.180587', '2026-06-08', 'present', 1);
INSERT INTO public.attendance VALUES (107, 22, NULL, '2026-06-08 22:52:33.3891', '2026-06-08', 'present', 2);
INSERT INTO public.attendance VALUES (108, 32, NULL, '2026-06-08 22:52:33.3891', '2026-06-08', 'present', 2);
INSERT INTO public.attendance VALUES (109, 37, NULL, '2026-06-08 22:52:33.3891', '2026-06-08', 'absent', 2);
INSERT INTO public.attendance VALUES (110, 40, NULL, '2026-06-08 22:52:33.3891', '2026-06-08', 'present', 2);
INSERT INTO public.attendance VALUES (111, 22, NULL, '2026-06-09 07:22:18.546459', '2026-06-09', 'present', 1);
INSERT INTO public.attendance VALUES (112, 32, NULL, '2026-06-09 07:22:18.546459', '2026-06-09', 'present', 1);
INSERT INTO public.attendance VALUES (113, 37, NULL, '2026-06-09 07:22:18.546459', '2026-06-09', 'present', 1);
INSERT INTO public.attendance VALUES (114, 40, NULL, '2026-06-09 07:22:18.546459', '2026-06-09', 'absent', 1);
INSERT INTO public.attendance VALUES (115, 12, NULL, '2026-06-09 11:54:33.489965', '2026-06-09', 'present', 2);
INSERT INTO public.attendance VALUES (116, 14, NULL, '2026-06-09 11:54:33.489965', '2026-06-09', 'present', 2);
INSERT INTO public.attendance VALUES (117, 20, NULL, '2026-06-09 11:54:33.489965', '2026-06-09', 'present', 2);


--
-- Data for Name: batches; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.courses VALUES (2, 'functional', 2);
INSERT INTO public.courses VALUES (3, 'functional english', 2);
INSERT INTO public.courses VALUES (4, 'PYTHON', 2);
INSERT INTO public.courses VALUES (5, 'staticstics', 2);


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departments VALUES (2, 'mathematics', NULL);
INSERT INTO public.departments VALUES (5, 'Computer Science', 'CS01');
INSERT INTO public.departments VALUES (7, 'ZOOLOGY', 'ZG01');
INSERT INTO public.departments VALUES (8, 'MATHEMATICS', 'MS01');
INSERT INTO public.departments VALUES (11, 'ms', 'ms');


--
-- Data for Name: marks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marks VALUES (1, 1, 'english', 'sem', 36, 40, NULL, '2026-02-11 11:59:52.697144', NULL);
INSERT INTO public.marks VALUES (2, 1, 'Functional English', 'Midterm', 45, 50, NULL, '2026-02-11 17:25:53.223076', NULL);
INSERT INTO public.marks VALUES (3, 2, 'functional english', 'sem', 18, 30, NULL, '2026-02-13 10:49:33.108528', NULL);
INSERT INTO public.marks VALUES (4, 13, 'dbms', 'sem', 25, 50, NULL, '2026-03-06 12:48:43.5715', NULL);
INSERT INTO public.marks VALUES (5, 13, 'py', 'internal', 12, 40, NULL, '2026-03-06 13:10:18.47218', NULL);
INSERT INTO public.marks VALUES (6, 13, 'dbms', 'midterm', 8, 50, NULL, '2026-03-06 13:13:50.565884', NULL);
INSERT INTO public.marks VALUES (8, 13, 'pl', 'midterm', 5, 50, NULL, '2026-03-06 13:16:12.93145', NULL);
INSERT INTO public.marks VALUES (9, 14, 'DBMS', 'interan', 20, 40, NULL, '2026-03-06 20:43:48.285604', NULL);
INSERT INTO public.marks VALUES (10, 14, 'DBMS', 'interan', 20, 40, NULL, '2026-03-06 20:43:48.285793', NULL);
INSERT INTO public.marks VALUES (11, 14, 'DBMS', 'interan', 20, 40, NULL, '2026-03-06 20:43:48.286111', NULL);
INSERT INTO public.marks VALUES (12, 14, 'DBMS', 'interan', 20, 40, NULL, '2026-03-06 20:43:48.289915', NULL);
INSERT INTO public.marks VALUES (13, 14, 'DBMS', 'interan', 20, 40, NULL, '2026-03-06 20:43:48.293759', NULL);
INSERT INTO public.marks VALUES (14, 14, 'DBMS', 'interan', 20, 40, NULL, '2026-03-06 20:43:48.30259', NULL);
INSERT INTO public.marks VALUES (15, 13, 'DBMS', 'interan', 30, 40, NULL, '2026-03-06 20:43:48.342825', NULL);
INSERT INTO public.marks VALUES (16, 13, 'DBMS', 'interan', 30, 40, NULL, '2026-03-06 20:43:48.357502', NULL);
INSERT INTO public.marks VALUES (17, 13, 'DBMS', 'interan', 30, 40, NULL, '2026-03-06 20:43:48.359149', NULL);
INSERT INTO public.marks VALUES (18, 13, 'DBMS', 'interan', 30, 40, NULL, '2026-03-06 20:43:48.400541', NULL);
INSERT INTO public.marks VALUES (19, 13, 'DBMS', 'interan', 30, 40, NULL, '2026-03-06 20:43:48.414353', NULL);
INSERT INTO public.marks VALUES (20, 13, 'DBMS', 'interan', 30, 40, NULL, '2026-03-06 20:43:48.467027', NULL);
INSERT INTO public.marks VALUES (21, 14, 'DBMS', 'INTERNAL', 15, 20, NULL, '2026-03-07 14:16:25.797234', NULL);
INSERT INTO public.marks VALUES (22, 13, 'DBMS', 'INTERNAL', 18, 20, NULL, '2026-03-07 14:16:25.909273', NULL);
INSERT INTO public.marks VALUES (23, 20, 'DBMS', 'INTERNAL', 5, 20, NULL, '2026-03-07 14:16:25.924974', NULL);
INSERT INTO public.marks VALUES (31, 12, 'PYTHON', 'INTERNAL', 8, 20, NULL, '2026-03-08 11:34:54.602314', NULL);
INSERT INTO public.marks VALUES (32, 14, 'PYTHON', 'INTERNAL', 15, 20, NULL, '2026-03-08 11:34:54.67261', NULL);
INSERT INTO public.marks VALUES (33, 13, 'PYTHON', 'INTERNAL', 0, 20, NULL, '2026-03-08 11:34:54.68215', NULL);
INSERT INTO public.marks VALUES (34, 20, 'PYTHON', 'INTERNAL', 11, 20, NULL, '2026-03-08 11:34:54.6911', NULL);
INSERT INTO public.marks VALUES (35, 12, 'PYTHON', 'INTERNAL', 8, 20, NULL, '2026-03-08 12:06:52.890648', NULL);
INSERT INTO public.marks VALUES (36, 14, 'PYTHON', 'INTERNAL', 15, 20, NULL, '2026-03-08 12:06:52.942409', NULL);
INSERT INTO public.marks VALUES (37, 13, 'PYTHON', 'INTERNAL', 0, 20, NULL, '2026-03-08 12:06:52.956501', NULL);
INSERT INTO public.marks VALUES (38, 20, 'PYTHON', 'INTERNAL', 11, 20, NULL, '2026-03-08 12:06:52.968978', NULL);
INSERT INTO public.marks VALUES (39, 22, 'DBMS', 'MIDTERM', 30, 40, NULL, '2026-03-12 10:17:07.560699', NULL);
INSERT INTO public.marks VALUES (40, 32, 'PROGRAMMING LANGUAGE', 'MIDTERM', 15, 20, NULL, '2026-03-24 23:10:30.803984', NULL);
INSERT INTO public.marks VALUES (41, 22, 'PROGRAMMING LANGUAGE', 'MIDTERM', 10, 20, NULL, '2026-03-24 23:10:30.848892', NULL);
INSERT INTO public.marks VALUES (42, 12, 'OS', 'MIDTERM', 30, 40, NULL, '2026-05-18 13:59:46.067428', NULL);
INSERT INTO public.marks VALUES (43, 14, 'OS', 'MIDTERM', 35, 40, NULL, '2026-05-18 13:59:46.217219', NULL);
INSERT INTO public.marks VALUES (44, 13, 'OS', 'MIDTERM', 36, 40, NULL, '2026-05-18 13:59:46.227123', NULL);
INSERT INTO public.marks VALUES (45, 20, 'OS', 'MIDTERM', 15, 40, NULL, '2026-05-18 13:59:46.238575', NULL);
INSERT INTO public.marks VALUES (46, 12, 'MATHS', 'INTERNAL', 10, 20, NULL, '2026-06-03 12:22:31.331974', NULL);
INSERT INTO public.marks VALUES (47, 14, 'MATHS', 'INTERNAL', 15, 20, NULL, '2026-06-03 12:22:31.618932', NULL);
INSERT INTO public.marks VALUES (48, 13, 'MATHS', 'INTERNAL', 25, 20, NULL, '2026-06-03 12:22:31.634903', NULL);
INSERT INTO public.marks VALUES (49, 20, 'MATHS', 'INTERNAL', 14, 20, NULL, '2026-06-03 12:22:31.661022', NULL);
INSERT INTO public.marks VALUES (50, 32, 'functional', 'MODEL', 10, 25, NULL, '2026-06-09 07:20:47.41215', NULL);
INSERT INTO public.marks VALUES (51, 22, 'functional', 'MODEL', 18, 25, NULL, '2026-06-09 07:20:47.545852', NULL);
INSERT INTO public.marks VALUES (52, 40, 'functional', 'MODEL', 8, 25, NULL, '2026-06-09 07:20:47.559631', NULL);
INSERT INTO public.marks VALUES (53, 37, 'functional', 'MODEL', 20, 25, NULL, '2026-06-09 07:20:47.568773', NULL);
INSERT INTO public.marks VALUES (54, 32, 'operating system', 'model', 15, 20, NULL, '2026-06-09 07:42:46.347451', NULL);
INSERT INTO public.marks VALUES (55, 22, 'operating system', 'model', 18, 20, NULL, '2026-06-09 07:42:46.402374', NULL);
INSERT INTO public.marks VALUES (56, 37, 'operating system', 'model', 10, 20, NULL, '2026-06-09 07:42:46.408667', NULL);
INSERT INTO public.marks VALUES (57, 40, 'operating system', 'model', 11, 20, NULL, '2026-06-09 07:42:46.412568', NULL);


--
-- Data for Name: otp_verifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.performance VALUES (1, 1, 'Data Structures', 'Internal', 45, 100, '2026-01-20 10:37:53.247745');
INSERT INTO public.performance VALUES (2, 1, 'Data Structures', 'Internal', 45, 100, '2026-01-20 10:38:09.627134');
INSERT INTO public.performance VALUES (3, 1, 'Data Structures', 'Internal', 45, 50, '2026-01-21 17:14:22.584604');
INSERT INTO public.performance VALUES (4, 1, 'Maths', 'Internal', 35, 50, '2026-01-21 17:20:40.409475');
INSERT INTO public.performance VALUES (5, 2, 'Maths', 'Internal', 25, 50, '2026-01-21 17:21:11.58896');
INSERT INTO public.performance VALUES (6, 1, 'Maths', 'Midterm', 78, 100, '2026-01-21 17:27:49.322901');
INSERT INTO public.performance VALUES (7, 1, 'cs', 'Midterm', 88, 100, '2026-01-21 17:28:13.374893');
INSERT INTO public.performance VALUES (8, 1, 'eng', 'Midterm', 98, 100, '2026-01-21 17:28:31.076119');
INSERT INTO public.performance VALUES (9, 2, 'Maths', 'Midterm', 78, 100, '2026-01-21 18:22:58.860823');
INSERT INTO public.performance VALUES (10, 1, 'maths', 'internal', 19, 20, '2026-01-31 14:56:54.593083');
INSERT INTO public.performance VALUES (11, 1, 'science', 'sem', 30, 50, '2026-02-13 10:51:48.835348');


--
-- Data for Name: quiz_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.quiz_attempts VALUES (1, 11, 1, 0, '2026-03-08 18:15:40.110531');
INSERT INTO public.quiz_attempts VALUES (2, 7, 1, 1, '2026-03-08 18:17:32.901341');
INSERT INTO public.quiz_attempts VALUES (3, 10, 1, 1, '2026-03-08 18:19:20.893739');
INSERT INTO public.quiz_attempts VALUES (4, 12, 1, 2, '2026-03-08 18:23:22.884406');
INSERT INTO public.quiz_attempts VALUES (5, 7, 13, 3, '2026-03-09 00:23:27.561409');
INSERT INTO public.quiz_attempts VALUES (6, 10, 13, 2, '2026-03-09 12:00:36.695064');
INSERT INTO public.quiz_attempts VALUES (7, 14, 13, 2, '2026-03-09 12:44:39.303631');
INSERT INTO public.quiz_attempts VALUES (8, 11, 13, 1, '2026-03-12 10:11:32.244011');
INSERT INTO public.quiz_attempts VALUES (9, 12, 13, 7, '2026-03-12 10:14:27.20342');
INSERT INTO public.quiz_attempts VALUES (10, 1, 2, 0, '2026-03-17 14:08:45.839977');
INSERT INTO public.quiz_attempts VALUES (11, 15, 13, 0, '2026-03-18 10:21:31.440593');
INSERT INTO public.quiz_attempts VALUES (12, 18, 13, 0, '2026-03-18 10:22:44.618443');
INSERT INTO public.quiz_attempts VALUES (13, 16, 13, 0, '2026-03-18 10:24:11.330702');
INSERT INTO public.quiz_attempts VALUES (14, 17, 13, 1, '2026-03-18 21:55:24.592597');
INSERT INTO public.quiz_attempts VALUES (15, 19, 13, 0, '2026-03-25 11:01:07.115775');
INSERT INTO public.quiz_attempts VALUES (16, 26, 13, 4, '2026-06-01 15:53:52.048365');
INSERT INTO public.quiz_attempts VALUES (17, 34, 13, 3, '2026-06-08 17:23:20.322714');
INSERT INTO public.quiz_attempts VALUES (18, 35, 13, 1, '2026-06-09 11:57:10.577635');


--
-- Data for Name: quiz_malpractice_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: quiz_options; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: quiz_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.quiz_questions VALUES (1, 1, 'Which statement best describes Transaction?', 'Transaction improves system efficiency', 'Transaction manages data operations', 'Transaction defines logical structure', 'Transaction controls execution flow', 'D', 'Think about how Transaction is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (2, 1, 'What is the purpose of Transaction?', 'Transaction improves system efficiency', 'Transaction manages data operations', 'Transaction defines logical structure', 'Transaction controls execution flow', 'D', 'Think about how Transaction is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (3, 1, 'Why is Normalization important in computer science?', 'Normalization improves system efficiency', 'Normalization manages data operations', 'Normalization defines logical structure', 'Normalization controls execution flow', 'C', 'Think about how Normalization is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (4, 1, 'Why is Procedure important in computer science?', 'Procedure improves system efficiency', 'Procedure manages data operations', 'Procedure defines logical structure', 'Procedure controls execution flow', 'A', 'Think about how Procedure is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (5, 1, 'Why is SQL important in computer science?', 'SQL improves system efficiency', 'SQL manages data operations', 'SQL defines logical structure', 'SQL controls execution flow', 'B', 'Think about how SQL is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (6, 2, 'What is the purpose of Loop?', 'Loop improves system efficiency', 'Loop manages data operations', 'Loop defines logical structure', 'Loop controls execution flow', 'A', 'Think about how Loop is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (7, 2, 'What is the purpose of SQL?', 'SQL improves system efficiency', 'SQL manages data operations', 'SQL defines logical structure', 'SQL controls execution flow', 'D', 'Think about how SQL is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (8, 2, 'Which statement best describes Database?', 'Database improves system efficiency', 'Database manages data operations', 'Database defines logical structure', 'Database controls execution flow', 'A', 'Think about how Database is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (9, 2, 'Why is Index important in computer science?', 'Index improves system efficiency', 'Index manages data operations', 'Index defines logical structure', 'Index controls execution flow', 'A', 'Think about how Index is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (10, 2, 'What is the purpose of Function?', 'Function improves system efficiency', 'Function manages data operations', 'Function defines logical structure', 'Function controls execution flow', 'D', 'Think about how Function is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (11, 2, 'What is a key feature of Loop?', 'Loop improves system efficiency', 'Loop manages data operations', 'Loop defines logical structure', 'Loop controls execution flow', 'D', 'Think about how Loop is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (12, 2, 'Why is Database important in computer science?', 'Database improves system efficiency', 'Database manages data operations', 'Database defines logical structure', 'Database controls execution flow', 'A', 'Think about how Database is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (13, 2, 'What is a key feature of Normalization?', 'Normalization improves system efficiency', 'Normalization manages data operations', 'Normalization defines logical structure', 'Normalization controls execution flow', 'C', 'Think about how Normalization is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (14, 3, 'What is a key feature of SQL?', 'SQL improves system efficiency', 'SQL manages data operations', 'SQL defines logical structure', 'SQL controls execution flow', 'D', 'Think about how SQL is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (15, 3, 'Why is Procedure important in computer science?', 'Procedure improves system efficiency', 'Procedure manages data operations', 'Procedure defines logical structure', 'Procedure controls execution flow', 'C', 'Think about how Procedure is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (16, 3, 'What is a key feature of Loop?', 'Loop improves system efficiency', 'Loop manages data operations', 'Loop defines logical structure', 'Loop controls execution flow', 'C', 'Think about how Loop is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (17, 3, 'What is the purpose of Database?', 'Database improves system efficiency', 'Database manages data operations', 'Database defines logical structure', 'Database controls execution flow', 'D', 'Think about how Database is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (18, 3, 'Why is Procedure important in computer science?', 'Procedure improves system efficiency', 'Procedure manages data operations', 'Procedure defines logical structure', 'Procedure controls execution flow', 'B', 'Think about how Procedure is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (19, 3, 'What is the purpose of SQL?', 'SQL improves system efficiency', 'SQL manages data operations', 'SQL defines logical structure', 'SQL controls execution flow', 'A', 'Think about how SQL is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (20, 3, 'Which statement best describes SQL?', 'SQL improves system efficiency', 'SQL manages data operations', 'SQL defines logical structure', 'SQL controls execution flow', 'D', 'Think about how SQL is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (21, 3, 'What is the purpose of Transaction?', 'Transaction improves system efficiency', 'Transaction manages data operations', 'Transaction defines logical structure', 'Transaction controls execution flow', 'A', 'Think about how Transaction is used in programming or databases');
INSERT INTO public.quiz_questions VALUES (22, 4, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (23, 4, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (24, 4, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (25, 4, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (26, 4, 'Why is functions important in software development?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (27, 4, 'Which statement correctly describes functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (28, 4, 'Which statement correctly describes functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (29, 4, 'Why is functions important in software development?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (30, 5, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (31, 5, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (32, 5, 'Which statement correctly describes functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (33, 5, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (34, 5, 'Why is functions important in software development?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (35, 6, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (36, 6, 'Why is functions important in software development?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (37, 6, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (38, 6, 'Which statement correctly describes functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (39, 6, 'What is a key feature of functions?', 'functions helps structure program logic', 'functions improves code readability', 'functions controls program execution', 'functions manages data processing', 'A', 'Review how functions works in programming');
INSERT INTO public.quiz_questions VALUES (40, 7, 'What is the purpose of table in programming?', 'table helps structure program logic', 'table improves code readability', 'table controls program execution', 'table manages data processing', 'A', 'Review how table works in programming');
INSERT INTO public.quiz_questions VALUES (41, 7, 'Why is problem important in software development?', 'problem helps structure program logic', 'problem improves code readability', 'problem controls program execution', 'problem manages data processing', 'A', 'Review how problem works in programming');
INSERT INTO public.quiz_questions VALUES (42, 7, 'What is the purpose of problem in programming?', 'problem helps structure program logic', 'problem improves code readability', 'problem controls program execution', 'problem manages data processing', 'A', 'Review how problem works in programming');
INSERT INTO public.quiz_questions VALUES (43, 7, 'Why is dining important in software development?', 'dining helps structure program logic', 'dining improves code readability', 'dining controls program execution', 'dining manages data processing', 'A', 'Review how dining works in programming');
INSERT INTO public.quiz_questions VALUES (44, 7, 'What is a key feature of table?', 'table helps structure program logic', 'table improves code readability', 'table controls program execution', 'table manages data processing', 'A', 'Review how table works in programming');
INSERT INTO public.quiz_questions VALUES (45, 8, 'What is the primary purpose of a loop in programming?', 'A) To repeat a block of code multiple times.', 'B) To define a new function.', 'C) To store multiple values in a single variable.', 'D) To make decisions in code.', 'A', 'Think about what ''loop'' means in general – doing something again and again.');
INSERT INTO public.quiz_questions VALUES (46, 8, 'Which of the following is a common reason to use a loop?', 'A) To execute code only once.', 'B) To avoid writing the same code repeatedly.', 'C) To create a new data type.', 'D) To handle errors in the program.', 'B', 'Loops help make code more efficient and less redundant.');
INSERT INTO public.quiz_questions VALUES (47, 8, 'A loop continues to execute as long as its specified _______ is true.', 'A) variable', 'B) function', 'C) condition', 'D) comment', 'C', 'What determines if a loop keeps running or stops?');
INSERT INTO public.quiz_questions VALUES (48, 8, 'What is an ''infinite loop''?', 'A) A loop that runs only once.', 'B) A loop that never starts.', 'C) A loop that continues to run indefinitely because its termination condition is never met.', 'D) A loop that executes a fixed number of times.', 'C', 'Consider the meaning of ''infinite'' – without end.');
INSERT INTO public.quiz_questions VALUES (49, 8, 'Generally, loops are used to perform tasks that involve:', 'A) sequential execution of code.', 'B) random access of memory.', 'C) repeated execution of instructions.', 'D) defining static variables.', 'C', 'The core idea of a loop is repetition.');
INSERT INTO public.quiz_questions VALUES (50, 9, 'What is the primary characteristic of a mathematical function?', 'A. Each input must have exactly one output.', 'B. Each output must have exactly one input.', 'C. Inputs and outputs are randomly associated.', 'D. Functions only work with positive numbers.', 'A', 'Think about the consistency of a function''s behavior for any given input.');
INSERT INTO public.quiz_questions VALUES (51, 9, 'Which of the following notations is commonly used to represent a function?', 'A. f(x)', 'B. x + y = z', 'C. (x, y)', 'D. A = B', 'A', 'This notation explicitly shows the input variable for the function.');
INSERT INTO public.quiz_questions VALUES (52, 9, 'In the notation f(x), what does ''x'' typically represent?', 'A. The output value of the function.', 'B. The input value to the function.', 'C. The name of the function itself.', 'D. A constant number.', 'B', '''x'' is the value you ''feed into'' the function.');
INSERT INTO public.quiz_questions VALUES (53, 9, 'A relation is NOT considered a function if:', 'A. Every input has a unique output.', 'B. One input maps to more than one output.', 'C. All outputs are the same.', 'D. It involves only numbers.', 'B', 'Recall the fundamental rule about how many outputs an input can have.');
INSERT INTO public.quiz_questions VALUES (54, 9, 'If a function takes an input and processes it to produce a result, what is that result called?', 'A. The input.', 'B. The process.', 'C. The output.', 'D. The variable.', 'C', 'This is what comes ''out'' of the function after processing.');
INSERT INTO public.quiz_questions VALUES (55, 10, 'What is a key characteristic of the agile model?', 'A. Highly iterative and incremental development.', 'B. Strict, upfront planning with no changes allowed.', 'C. Long development cycles with minimal customer feedback.', 'D. Focus on delivering all features in a single, final release.', 'A', 'Agile emphasizes short cycles and continuous improvement.');
INSERT INTO public.quiz_questions VALUES (56, 10, 'Which of the following best describes the agile model''s approach to change?', 'A. Avoids change at all costs.', 'B. Responds to change rather than following a rigid plan.', 'C. Only accepts changes at the very beginning of a project.', 'D. Requires a complete project restart for any change.', 'B', 'Flexibility is a core principle of agile.');
INSERT INTO public.quiz_questions VALUES (57, 10, 'What does the agile model typically prioritize among these options?', 'A. Comprehensive documentation over working software.', 'B. Following a plan over responding to change.', 'C. Customer collaboration over contract negotiation.', 'D. Detailed process adherence over individual interactions.', 'C', 'Think about who is central to agile development.');
INSERT INTO public.quiz_questions VALUES (58, 10, 'How does the agile model typically deliver software?', 'A. In one large, final delivery at the end of the project.', 'B. Through frequent, small, working increments.', 'C. Only after all possible bugs have been removed in a single phase.', 'D. Without any user testing until the very end.', 'B', 'Agile values early and continuous delivery of valuable software.');
INSERT INTO public.quiz_questions VALUES (59, 10, 'Which of the following is NOT a general characteristic of the agile model?', 'A. Regular adaptation to changing circumstances.', 'B. Delivery of working software frequently.', 'C. Encouraging face-to-face conversations.', 'D. Detailed, upfront requirement specification for the entire project.', 'D', 'Agile avoids rigid, long-term upfront planning.');
INSERT INTO public.quiz_questions VALUES (60, 11, 'What is a variable?', 'A container', 'A function', 'A class', 'An error', 'A', 'Think of a box');
INSERT INTO public.quiz_questions VALUES (61, 12, 'What is the primary role of parsing in the context of computer science?', 'Executing the program instructions sequentially.', 'Converting source code into a stream of individual characters.', 'Checking the syntactic structure of an input against a grammar and building a structural representation.', 'Optimizing the performance of the generated machine code.', 'C', 'Parsing is about understanding the structural correctness and organization of the input.');
INSERT INTO public.quiz_questions VALUES (62, 12, 'Which of the following best describes the main outcome of a successful parsing process?', 'A hierarchical representation of the input program, like a parse tree or Abstract Syntax Tree (AST).', 'An executable binary file.', 'A list of all identified lexical tokens.', 'A report detailing all potential runtime errors.', 'A', 'Parsing aims to represent the program''s structure in a meaningful way.');
INSERT INTO public.quiz_questions VALUES (63, 12, 'How does the parsing phase typically receive its input from the lexical analysis phase?', 'As a raw stream of characters directly from the source file.', 'As a fully optimized machine code sequence.', 'As a list of detected semantic errors.', 'As a stream of tokens, each representing a meaningful unit.', 'D', 'The parser operates on the ''words'' of the language, not the raw characters.');
INSERT INTO public.quiz_questions VALUES (64, 12, 'The term ''syntax analysis'' is another name for which phase in a compiler or interpreter?', 'Code Generation', 'Parsing', 'Semantic Analysis', 'Lexical Analysis', 'B', 'This phase is specifically concerned with the grammatical structure of the input.');
INSERT INTO public.quiz_questions VALUES (65, 12, 'What type of formal grammar is predominantly used to define the syntax of programming languages, enabling parsers to recognize valid constructs?', 'Regular Grammars', 'Context-Sensitive Grammars', 'Context-Free Grammars (CFGs)', 'Unrestricted Grammars', 'C', 'This grammar type is essential for describing the nested and recursive structures found in programming languages.');
INSERT INTO public.quiz_questions VALUES (66, 12, 'What kind of errors is a parser designed to primarily identify?', 'Errors in program logic that lead to incorrect output.', 'Errors where the program attempts an invalid operation at runtime.', 'Errors related to incorrect data types or variable scope.', 'Errors in the grammatical structure of the code (e.g., missing parentheses or semicolons).', 'D', 'Parsing checks if the program adheres to the predefined structural rules.');
INSERT INTO public.quiz_questions VALUES (67, 12, 'What is the typical immediate input to a parser in the compilation process?', 'The original source code text file.', 'Binary executable instructions.', 'A completed Abstract Syntax Tree (AST).', 'A sequence of tokens from the lexical analyzer.', 'D', 'The parser builds structure from the foundational units provided by the previous stage.');
INSERT INTO public.quiz_questions VALUES (68, 12, 'A parser that attempts to match the input to a grammar by starting from the grammar''s start symbol and predicting productions is an example of which parsing strategy?', 'Bottom-up parsing.', 'Middle-out parsing.', 'Top-down parsing.', 'Left-recursive parsing.', 'C', 'Consider the direction of derivation from the general rule to specific input.');
INSERT INTO public.quiz_questions VALUES (69, 12, 'One of the primary purposes of generating an Abstract Syntax Tree (AST) during parsing is to:', 'Store all comments and whitespace from the source code.', 'Provide a simplified and canonical representation of the program''s structure, abstracting away syntactic noise.', 'Directly translate the source code into binary machine instructions.', 'Execute the program to check for runtime errors.', 'B', 'The ''abstract'' aspect means it focuses on essential meaning, not superficial details.');
INSERT INTO public.quiz_questions VALUES (70, 12, 'In a typical compiler or interpreter''s front end, where does the parsing phase usually occur?', 'After the semantic analysis phase.', 'Before the lexical analysis phase.', 'Simultaneously with code generation.', 'After lexical analysis but before semantic analysis.', 'D', 'It logically follows token identification and precedes meaning interpretation.');
INSERT INTO public.quiz_questions VALUES (71, 13, 'In Linear Algebra, what is a matrix?', 'A single real number', 'A rectangular array of numbers', 'A type of geometric shape', 'An operation to solve equations', 'B', 'Think about the visual representation of a matrix, typically enclosed in brackets.');
INSERT INTO public.quiz_questions VALUES (72, 13, 'Which of the following best describes a vector in the context of Linear Algebra?', 'An ordered list of numbers (components)', 'A single number representing magnitude only', 'A function that maps numbers to other numbers', 'A mathematical symbol for multiplication', 'A', 'Vectors are often represented as column or row arrays.');
INSERT INTO public.quiz_questions VALUES (73, 13, 'What is typically referred to as a ''scalar'' in Linear Algebra?', 'A special type of matrix', 'A sequence of vectors', 'A complex equation with multiple variables', 'A single real number', 'D', 'Scalars are used to ''scale'' vectors or matrices without changing their fundamental nature.');
INSERT INTO public.quiz_questions VALUES (74, 13, 'Linear Algebra primarily provides tools and methods for analyzing and solving systems of which type of equations?', 'Quadratic equations', 'Exponential equations', 'Linear equations', 'Trigonometric equations', 'C', 'The name ''Linear Algebra'' itself offers a significant clue to the type of equations it handles.');
INSERT INTO public.quiz_questions VALUES (75, 13, 'For two matrices, A and B, to be added together, what condition must their dimensions satisfy?', 'They must be square matrices', 'Matrix A must have more rows than Matrix B', 'They must have the same number of columns but different rows', 'They must have identical dimensions (same number of rows and columns)', 'D', 'Matrix addition is performed element-wise, requiring corresponding elements to exist.');
INSERT INTO public.quiz_questions VALUES (76, 14, 'What does the acronym SDLC primarily stand for in software development?', 'Software Development Life Cycle', 'System Design Logic Control', 'Software Design & Learning Center', 'Standardized Development Long Cycle', 'A', 'This acronym represents the entire structured process of creating software.');
INSERT INTO public.quiz_questions VALUES (77, 14, 'Which of the following is typically the *initial* phase of the Software Development Life Cycle (SDLC)?', 'Coding', 'Requirements Gathering', 'Deployment', 'Testing', 'B', 'Before building any software, it''s crucial to understand what the user needs.');
INSERT INTO public.quiz_questions VALUES (78, 14, 'What is the primary purpose of following a Software Development Life Cycle (SDLC)?', 'To extend the project timeline unnecessarily', 'To encourage unstructured and chaotic development', 'To provide a structured and systematic approach to software development', 'To eliminate the need for any documentation', 'C', 'It helps manage and organize the entire software creation process effectively.');
INSERT INTO public.quiz_questions VALUES (79, 14, 'Which phase of the SDLC involves writing the actual program code based on the design specifications?', 'Testing', 'Design', 'Deployment', 'Implementation/Coding', 'D', 'This is where the software officially comes into existence in terms of code.');
INSERT INTO public.quiz_questions VALUES (107, 20, 'The primary purpose of software texting applications is to facilitate:', 'Online shopping', 'Sending and receiving text-based messages', 'Playing complex video games', 'Editing professional documents', 'B', 'The term ''texting'' directly indicates the main function.');
INSERT INTO public.quiz_questions VALUES (80, 14, 'The phase of the SDLC that focuses on fixing bugs, enhancing features, and adapting the software after it has been released is called:', 'Design', 'Maintenance', 'Testing', 'Requirements Analysis', 'B', 'Software often requires ongoing care and updates throughout its lifespan after launch.');
INSERT INTO public.quiz_questions VALUES (81, 15, 'What is the primary goal of using iteration in programming?', 'To repeat a specific block of code multiple times.', 'To declare a new variable for calculations.', 'To define the structure of a function.', 'To output a single piece of information to the user.', 'A', 'Think about what ''to iterate'' means in a repetitive context.');
INSERT INTO public.quiz_questions VALUES (82, 15, 'Which programming construct is fundamental for performing iteration?', 'An if-else statement', 'A variable declaration', 'A loop (e.g., for loop, while loop)', 'A function call', 'C', 'Iteration involves repeating actions.');
INSERT INTO public.quiz_questions VALUES (83, 15, 'What is a common programming structure used to implement iteration?', 'A switch statement', 'A print statement', 'A return statement', 'A ''for'' loop', 'D', 'Consider the different types of structures that allow code to run repeatedly.');
INSERT INTO public.quiz_questions VALUES (84, 15, 'What happens if a loop''s condition never becomes false?', 'The loop runs indefinitely, known as an infinite loop.', 'The program automatically stops with an error.', 'The loop only executes once.', 'The loop is skipped entirely.', 'A', 'If a condition for repetition is always met, the repetition won''t stop.');
INSERT INTO public.quiz_questions VALUES (85, 15, 'Iteration is most useful when you need to process:', 'A single, unchanging constant.', 'Multiple items within a collection (like a list or array).', 'A condition that is only checked once.', 'The name of a program file.', 'B', 'Think about scenarios where you need to perform the same action on many different pieces of data.');
INSERT INTO public.quiz_questions VALUES (86, 16, 'What type of programming language is C generally considered?', 'Object-Oriented', 'Functional', 'Procedural', 'Scripting', 'C', 'C focuses on functions and a step-by-step execution model.');
INSERT INTO public.quiz_questions VALUES (87, 16, 'Every C program execution typically begins with which special function?', 'run()', 'execute()', 'start()', 'main()', 'D', 'This function serves as the entry point for program execution.');
INSERT INTO public.quiz_questions VALUES (88, 16, 'Which standard C library function is used to print output to the console?', 'printf()', 'scanf()', 'print_out()', 'readf()', 'A', 'This function is part of the <stdio.h> header and is used for formatted output.');
INSERT INTO public.quiz_questions VALUES (89, 16, 'Which keyword is used to declare a whole number variable in C?', 'char', 'int', 'decimal', 'float', 'B', 'This keyword is short for ''integer''.');
INSERT INTO public.quiz_questions VALUES (90, 16, 'What is the primary purpose of comments in a C program?', 'To store temporary data', 'To execute special instructions', 'To define new keywords', 'To make the code readable and explain sections', 'D', 'Comments are ignored by the compiler but are crucial for human understanding of the code.');
INSERT INTO public.quiz_questions VALUES (91, 17, 'The ER Model is primarily used for:', 'Designing conceptual database schemas', 'Writing operating system kernels', 'Performing complex mathematical calculations', 'Developing graphical user interfaces', 'A', 'Think about its role in database design.');
INSERT INTO public.quiz_questions VALUES (92, 17, 'Which of the following is NOT a fundamental component of the ER Model?', 'Relationships', 'Attributes', 'Entities', 'Stored Procedures', 'D', 'The ER Model''s core parts are Entities, Attributes, and Relationships.');
INSERT INTO public.quiz_questions VALUES (93, 17, 'In an ER Model, what does an ''Entity'' typically represent?', 'A real-world object or concept', 'A programming function', 'A physical database table', 'A rule or constraint for data entry', 'A', 'Entities are the ''things'' you want to model data about.');
INSERT INTO public.quiz_questions VALUES (94, 17, 'What is a characteristic or property that describes an entity in the ER Model?', 'A Query', 'An Algorithm', 'An Attribute', 'An Index', 'C', 'These are the details that define an entity.');
INSERT INTO public.quiz_questions VALUES (95, 17, 'An association or connection between two or more entities in the ER Model is called a:', 'Data type', 'Query language', 'Relationship', 'Operating system', 'C', 'This shows how different entities are linked together.');
INSERT INTO public.quiz_questions VALUES (96, 18, 'Which characteristic best describes the Agile Model?', 'A. Follows a strict, linear progression', 'B. Is highly iterative and incremental', 'C. Emphasizes upfront, detailed documentation', 'D. Discourages direct customer involvement', 'B', 'Agile projects are built in small, repeating cycles rather than one long sequence.');
INSERT INTO public.quiz_questions VALUES (97, 18, 'According to Agile principles, which of the following is typically valued more?', 'A. Comprehensive documentation over working software', 'B. Extensive contract negotiation over customer collaboration', 'C. Following a plan over responding to change', 'D. Working software over comprehensive documentation', 'D', 'Agile focuses on delivering tangible results frequently.');
INSERT INTO public.quiz_questions VALUES (98, 18, 'What is a typical approach to customer feedback in the Agile Model?', 'A. Feedback is gathered only at the project''s conclusion.', 'B. Feedback is continuous and integrated throughout the development process.', 'C. Feedback is only considered if major issues arise.', 'D. Customer feedback is minimized to avoid scope creep.', 'B', 'Agile emphasizes close collaboration and adaptation based on input.');
INSERT INTO public.quiz_questions VALUES (99, 18, 'What is the common term for a short, time-boxed period during which a specific set of work is completed in Agile development?', 'A. A phase', 'B. A milestone', 'C. A sprint', 'D. A stage', 'C', 'This term represents an iterative cycle where a functional increment is delivered.');
INSERT INTO public.quiz_questions VALUES (100, 18, 'The Agile Model prioritizes responding to change over what?', 'A. Delivering working software', 'B. Individual interactions', 'C. Responding to customer requests', 'D. Following a plan', 'D', 'Agile values flexibility and adaptation rather than strict adherence to initial designs.');
INSERT INTO public.quiz_questions VALUES (101, 19, 'What is the primary goal of software testing?', 'To write code faster', 'To design user interfaces', 'To market the software to customers', 'To identify defects and ensure software quality', 'D', 'Think about why we rigorously check software before it''s released to users.');
INSERT INTO public.quiz_questions VALUES (102, 19, 'What does effective software testing primarily aim to uncover?', 'New feature requests', 'Defects, errors, or bugs in the software', 'Project budget overruns', 'Marketing strategies for the product', 'B', 'This is what causes software to behave in an unintended or incorrect way.');
INSERT INTO public.quiz_questions VALUES (103, 19, 'In a typical software development lifecycle, when should software testing ideally begin?', 'Only after the software is fully deployed to users', 'Just before the final product release', 'From the early stages of the development process', 'Only when a user reports a problem', 'C', 'Catching issues early can prevent them from becoming more complex and costly later.');
INSERT INTO public.quiz_questions VALUES (104, 19, 'What is a ''bug'' in the context of software testing?', 'A new feature introduced in the latest update', 'A perfectly executed test case', 'An error, flaw, or fault in a computer program that causes it to produce an incorrect or unexpected result', 'A hardware component that needs to be replaced', 'C', 'This term refers to something that prevents the software from working as intended.');
INSERT INTO public.quiz_questions VALUES (105, 19, 'Beyond finding defects, what is another crucial benefit of thorough software testing?', 'It helps increase confidence in the software''s overall quality and reliability', 'It helps reduce the total number of developers on a project', 'It primarily focuses on changing the software''s initial requirements', 'It is solely for documenting user manuals', 'A', 'Good testing makes users and stakeholders trust the software more.');
INSERT INTO public.quiz_questions VALUES (106, 20, 'Which of these is a popular software application primarily used for sending instant text messages?', 'WhatsApp', 'Microsoft Word', 'Adobe Photoshop', 'Google Chrome', 'A', 'Think about apps commonly used for chatting on a smartphone.');
INSERT INTO public.quiz_questions VALUES (108, 20, 'On which type of device are software texting applications most commonly used?', 'Smart Refrigerator', 'Desktop Calculator', 'Smartphone', 'E-book Reader', 'C', 'Consider devices designed for mobile communication and connectivity.');
INSERT INTO public.quiz_questions VALUES (109, 20, 'Which of the following is a common feature you would expect to find in modern software texting applications?', 'Complex video editing suite', 'Professional accounting tools', 'Scientific data analysis', 'Ability to share photos and emojis', 'D', 'Modern messaging apps are known for supporting rich media and expressions.');
INSERT INTO public.quiz_questions VALUES (110, 20, 'What does the ''text'' in ''software texting'' primarily refer to?', 'Written words and characters sent as messages', 'A programming language''s source code', 'The texture of a digital image', 'A specific type of file format', 'A', 'Think about the basic content exchanged in a text message.');
INSERT INTO public.quiz_questions VALUES (111, 21, 'What is a fundamental characteristic of an AI agent?', 'It perceives its environment and acts upon it.', 'It only processes internal data without external interaction.', 'It generates random numbers without purpose.', 'It solely stores information without performing actions.', 'A', 'Consider the core interaction an agent has with its surroundings.');
INSERT INTO public.quiz_questions VALUES (112, 21, 'Which components allow an AI agent to perform actions in its environment?', 'Sensors', 'Effectors/Actuators', 'Memory units', 'Perceptors', 'B', 'These are the parts that *do* something in the physical or virtual world.');
INSERT INTO public.quiz_questions VALUES (113, 21, 'What part of an AI agent is primarily responsible for gathering information from its surroundings?', 'Actuators', 'Effectors', 'Sensors', 'Processors', 'C', 'How do agents (or even living beings) ''see'' or ''hear'' their environment?');
INSERT INTO public.quiz_questions VALUES (114, 21, 'The ''environment'' for an AI agent can be best described as:', 'The hardware platform it runs on.', 'The internal programming logic.', 'Other AI agents it interacts with.', 'The external world or context in which it operates.', 'D', 'Where does the agent exist and perform its functions?');
INSERT INTO public.quiz_questions VALUES (115, 21, 'An AI agent primarily operates by continuously performing which cycle?', 'Perception and Action', 'Data Storage and Retrieval', 'Code Compilation and Execution', 'Learning and Unlearning', 'A', 'Think about the two main phases of an agent''s interaction with its world.');
INSERT INTO public.quiz_questions VALUES (116, 22, 'What is the primary goal of Parts of Speech (POS) tagging?', 'Translating text into another language', 'Assigning grammatical categories to words in a text', 'Summarizing long documents', 'Identifying the sentiment of a sentence', 'B', 'POS tagging deals with the grammatical role of words.');
INSERT INTO public.quiz_questions VALUES (117, 22, 'When a word is ''tagged'' using Parts of Speech tagging, what kind of information is typically attached to it?', 'Its definition from a dictionary', 'Its phonetic pronunciation', 'Its grammatical category (e.g., noun, verb)', 'Its frequency of appearance in a corpus', 'C', 'Remember what ''parts of speech'' refers to.');
INSERT INTO public.quiz_questions VALUES (118, 22, 'Which of the following is NOT a direct output or goal of Parts of Speech (POS) tagging?', 'Identifying if a word is an adjective', 'Determining if a word is a preposition', 'Understanding the overall semantic meaning of a sentence', 'Assigning a specific tag like ''VB'' for a verb', 'C', 'POS tagging focuses on grammar, not deep contextual meaning.');
INSERT INTO public.quiz_questions VALUES (119, 22, 'In the context of ''Parts of Speech tagging,'' what do ''parts of speech'' primarily refer to?', 'Sections of a book or document', 'Grammatical classes or categories of words', 'Different languages spoken in a text', 'The individual letters that make up a word', 'B', 'Think about traditional grammar lessons.');
INSERT INTO public.quiz_questions VALUES (120, 22, 'Which of these is a common example of a grammatical category that Parts of Speech tagging aims to identify for words?', 'Paragraph', 'Sentiment', 'Noun', 'Topic', 'C', 'This is one of the fundamental types of words.');
INSERT INTO public.quiz_questions VALUES (121, 23, 'What is the primary purpose of Parts of Speech (POS) tagging a sentence?', 'A. To determine the overall sentiment of the sentence.', 'B. To identify the grammatical function (e.g., noun, verb) of each word.', 'C. To translate the sentence into another language.', 'D. To check for spelling and grammatical errors.', 'B', 'The name itself describes what is being identified for each word.');
INSERT INTO public.quiz_questions VALUES (122, 23, 'What does ''POS'' specifically refer to within the context of Natural Language Processing (NLP)?', 'A. Primary Operating System', 'B. Parallel Object Structure', 'C. Parts of Speech', 'D. Public Open Source', 'C', 'Look at the syllabus title for a direct clue.');
INSERT INTO public.quiz_questions VALUES (123, 23, 'Which of the following is a common tag assigned to a word like ''run'' (when used as an action) during POS tagging?', 'A. Adjective', 'B. Noun', 'C. Adverb', 'D. Verb', 'D', 'Think about what kind of word describes an action.');
INSERT INTO public.quiz_questions VALUES (124, 23, 'True or False: Parts of Speech Tagging is a basic step often performed early in an NLP pipeline.', 'A. True', 'B. False, it''s a very advanced and rare technique.', 'C. False, it''s only used for summarizing documents.', 'D. False, it''s primarily for generating new text.', 'A', 'Many NLP tasks benefit from knowing the grammatical role of words.');
INSERT INTO public.quiz_questions VALUES (125, 23, 'If a word is tagged as a ''noun,'' what does that indicate about its grammatical role?', 'A. It describes an action or state.', 'B. It describes a quality of a noun.', 'C. It names a person, place, thing, or idea.', 'D. It connects words, phrases, or clauses.', 'C', 'Recall the fundamental definition of what a noun represents.');
INSERT INTO public.quiz_questions VALUES (126, 24, 'In Object-Oriented Programming (OOP), what is a Class?', 'An instance of an object', 'A blueprint or template for creating objects', 'A specific value stored in memory', 'A method used to perform an action', 'B', 'A class defines the structure and behavior, but doesn''t hold actual data itself.');
INSERT INTO public.quiz_questions VALUES (127, 24, 'What does an ''Object'' represent in Object-Oriented Programming?', 'A type of programming language', 'An instance of a class', 'A static variable', 'A comment in the code', 'B', 'Think about what gets created from the blueprint (class).');
INSERT INTO public.quiz_questions VALUES (128, 24, 'Which OOP principle involves bundling data (attributes) and methods (functions) that operate on the data into a single unit?', 'Inheritance', 'Polymorphism', 'Encapsulation', 'Abstraction', 'C', 'This principle is often associated with ''data hiding'' and ''information hiding''.');
INSERT INTO public.quiz_questions VALUES (129, 24, 'The ability of a class to derive properties and behaviors from another class is known as which OOP concept?', 'Polymorphism', 'Encapsulation', 'Abstraction', 'Inheritance', 'D', 'This concept helps in creating a hierarchy among classes, like a family tree.');
INSERT INTO public.quiz_questions VALUES (130, 24, 'One of the primary benefits of using Object-Oriented Programming is:', 'Eliminates the need for compilers', 'Increases code reusability and modularity', 'Guarantees faster program execution speed', 'Only works with visual programming interfaces', 'B', 'OOP helps in building systems that are easier to maintain and extend due to its structured approach.');
INSERT INTO public.quiz_questions VALUES (131, 25, 'What keyword is used to define a function in Python?', 'func', 'define', 'def', 'function', 'C', 'Python uses a specific three-letter keyword to start a function definition.');
INSERT INTO public.quiz_questions VALUES (132, 25, 'How do you call a Python function named `calculate_sum` that takes no arguments?', 'call calculate_sum', 'calculate_sum()', 'run calculate_sum', 'calculate_sum.execute', 'B', 'To execute a function, you typically use its name followed by parentheses.');
INSERT INTO public.quiz_questions VALUES (133, 25, 'In a Python function definition like `def greet(name):`, what is `name` called?', 'An argument', 'A variable', 'A parameter', 'A return value', 'C', 'These are placeholders for values that will be passed into the function.');
INSERT INTO public.quiz_questions VALUES (134, 25, 'Which keyword allows a Python function to send a value back to the caller?', 'output', 'send', 'give', 'return', 'D', 'This keyword specifies the value that the function produces as its result.');
INSERT INTO public.quiz_questions VALUES (135, 25, 'What is a primary benefit of using functions in programming?', 'Increased code complexity', 'Code reusability', 'Slower program execution', 'Higher memory consumption', 'B', 'Functions help you write a piece of code once and use it many times.');
INSERT INTO public.quiz_questions VALUES (141, 26, 'What keyword is primarily used to define a user-defined function in Python?', 'function', 'define', 'def', 'create', 'C', 'This keyword signals the start of a function definition in Python.');
INSERT INTO public.quiz_questions VALUES (142, 26, 'Which of the following is an example of a built-in function in Python?', 'calculate_area()', 'my_custom_print()', 'get_data()', 'len()', 'D', 'Think of functions readily available without needing to be defined by the user or imported from most modules.');
INSERT INTO public.quiz_questions VALUES (143, 26, 'One of the main benefits of using user-defined functions in Python is to improve:', 'Only the speed of execution', 'Code readability and reusability', 'The file size only', 'The complexity of debugging', 'B', 'Consider why programmers break down tasks into smaller, manageable blocks of code.');
INSERT INTO public.quiz_questions VALUES (144, 26, 'A lambda function in Python is typically known as what type of function?', 'A nested function', 'A recursive function', 'An anonymous function', 'A generator function', 'C', 'This type of function is often small, single-expression, and does not require a formal name.');
INSERT INTO public.quiz_questions VALUES (145, 26, 'Which statement accurately describes a characteristic of Python''s built-in functions?', 'They are pre-defined and readily available for use', 'They can only perform mathematical operations', 'They must always be imported from a special module', 'They are defined by the user using the ''def'' keyword', 'A', 'Think about common functions like `print()` or `input()` and how you use them.');
INSERT INTO public.quiz_questions VALUES (146, 27, 'What is the primary goal of database normalization?', 'To reduce data redundancy', 'To increase data duplication', 'To speed up hardware performance', 'To complicate database design', 'A', 'Think about making data storage more efficient and consistent.');
INSERT INTO public.quiz_questions VALUES (147, 27, 'Which of the following is a key benefit of normalizing a database?', 'Making queries slower', 'Requiring more storage space', 'Introducing more data anomalies', 'Improving data integrity', 'D', 'Good data integrity means reliable and accurate data.');
INSERT INTO public.quiz_questions VALUES (148, 27, 'Database normalization primarily aims to minimize which of the following?', 'The total number of tables', 'Data anomalies (update, insertion, deletion)', 'The overall database size', 'The number of concurrent users', 'B', 'These are problems that can occur when data is poorly organized.');
INSERT INTO public.quiz_questions VALUES (149, 27, 'In the context of databases, what does normalization describe?', 'A method for backing up data', 'A type of data encryption standard', 'A process of organizing the columns and tables of a relational database', 'A language used for querying databases', 'C', 'It''s about structuring your database tables well.');
INSERT INTO public.quiz_questions VALUES (150, 27, 'What does normalization help to reduce within a database system?', 'Redundant data', 'The number of database users', 'The complexity of SQL queries', 'The hardware requirements of the server', 'A', 'Storing the same information multiple times is generally inefficient.');
INSERT INTO public.quiz_questions VALUES (151, 28, 'What is the primary purpose of database normalization?', 'To encrypt sensitive data.', 'To reduce data redundancy and improve data integrity.', 'To speed up data retrieval queries.', 'To design user interfaces.', 'B', 'Think about the core problems normalization solves in a database.');
INSERT INTO public.quiz_questions VALUES (152, 28, 'Which of the following problems does normalization primarily aim to minimize?', 'Data loss during power outages.', 'User authentication issues.', 'Insertion, deletion, and update anomalies.', 'Network latency.', 'C', 'Anomalies are common issues in unnormalized databases.');
INSERT INTO public.quiz_questions VALUES (153, 28, 'A relation is in First Normal Form (1NF) if all its attributes contain what kind of values?', 'Redundant values.', 'Atomic values.', 'Encrypted values.', 'Null values.', 'B', '1NF is about individual cells containing single, indivisible pieces of data.');
INSERT INTO public.quiz_questions VALUES (154, 28, 'To be in Second Normal Form (2NF), a relation must first be in 1NF and what else must be true about non-prime attributes?', 'They must be unique across all rows.', 'They must be encrypted.', 'They must be fully dependent on the primary key.', 'They must be non-null.', 'C', '2NF deals with partial dependencies on the primary key.');
INSERT INTO public.quiz_questions VALUES (155, 28, 'A relation is in Third Normal Form (3NF) if it is in 2NF and what type of dependency is eliminated?', 'Multivalued dependency.', 'Partial dependency.', 'Functional dependency.', 'Transitive dependency.', 'D', '3NF focuses on dependencies where one non-key attribute determines another non-key attribute.');
INSERT INTO public.quiz_questions VALUES (156, 29, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (157, 30, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (158, 31, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (159, 32, 'A thread is often described as a:', 'Light-weight process', 'Heavy-weight process', 'Standalone operating system', 'Virtual machine instance', 'A', 'Think about how threads compare to traditional processes in terms of resource consumption and overhead.');
INSERT INTO public.quiz_questions VALUES (160, 32, 'Which of the following resources are typically *shared* among multiple threads within the same process?', 'Program counter and stack', 'Registers and stack', 'Code segment and data segment', 'Each thread has its own separate address space', 'C', 'Consider what makes threads ''light-weight'' and how they differ from processes in terms of memory organization.');
INSERT INTO public.quiz_questions VALUES (161, 32, 'One significant advantage of using threads over separate processes is:', 'Increased memory isolation between concurrent tasks.', 'Lower overhead for context switching.', 'Guaranteed prevention of deadlocks.', 'Each thread has its own dedicated CPU core.', 'B', 'Focus on the amount of state that needs to be saved and restored when switching between execution units.');
INSERT INTO public.quiz_questions VALUES (162, 32, 'What is a key characteristic of threads that distinguishes them from processes?', 'Threads do not require an operating system to run.', 'Threads have their own completely separate memory space.', 'Threads within the same process share the same address space.', 'Threads can only perform I/O operations.', 'C', 'Consider the memory model that allows threads to interact efficiently within a single application.');
INSERT INTO public.quiz_questions VALUES (163, 32, 'Which of these components is generally *unique* to each individual thread within a process?', 'Global variables', 'Program code', 'Open files', 'Program counter and stack', 'D', 'For a thread to execute independently and maintain its own point of execution, it needs specific private components.');
INSERT INTO public.quiz_questions VALUES (164, 33, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (170, 34, 'What is the primary characteristic that defines supervised learning in Machine Learning?', 'A) It learns from data without any predefined outputs.', 'B) It identifies hidden structures within unlabeled data.', 'C) It learns from data that includes correct answers or ''labels''.', 'D) It performs actions in an environment to maximize a reward.', 'C', 'Think about the ''supervisor'' providing the correct answers during training.');
INSERT INTO public.quiz_questions VALUES (171, 34, 'Which type of data is essential for a supervised learning model to be trained effectively?', 'A) Unstructured data', 'B) Labeled data', 'C) Unlabeled data', 'D) Only numerical data', 'B', 'Supervised learning requires examples where the desired output is already known.');
INSERT INTO public.quiz_questions VALUES (172, 34, 'Predicting whether an email is ''spam'' or ''not spam'' is an example of which common supervised learning task?', 'A) Regression', 'B) Clustering', 'C) Classification', 'D) Dimensionality Reduction', 'C', 'This task involves assigning data points to predefined categories.');
INSERT INTO public.quiz_questions VALUES (173, 34, 'What is the main goal of a supervised learning algorithm?', 'A) To discover hidden groups in the data.', 'B) To predict a continuous output value based on input features.', 'C) To learn a mapping function from input variables to an output variable.', 'D) To simplify the data by reducing the number of features.', 'C', 'The algorithm''s aim is to understand how inputs correspond to their known outputs.');
INSERT INTO public.quiz_questions VALUES (174, 34, 'If a supervised learning model is used to predict a numerical value, such as the price of a house, what type of problem is it solving?', 'A) Regression', 'B) Classification', 'C) Association', 'D) Anomaly Detection', 'A', 'Problems that predict a continuous numerical output fall under this category.');
INSERT INTO public.quiz_questions VALUES (180, 35, 'What is a defining characteristic of supervised learning?', 'Learning from labeled datasets.', 'Discovering hidden patterns in unlabeled data.', 'Learning through trial and error with rewards.', 'Grouping similar data points together.', 'A', 'Think about what ''supervision'' implies for the data.');
INSERT INTO public.quiz_questions VALUES (181, 35, 'In supervised learning, what kind of data is typically used to train a model?', 'Unlabeled data only.', 'Data with input features and corresponding output labels.', 'Data consisting solely of input features.', 'Data generated randomly without any structure.', 'B', 'Supervised learning requires ''guidance'' from the data itself.');
INSERT INTO public.quiz_questions VALUES (182, 35, 'Which two main categories of problems are commonly addressed by supervised learning?', 'Clustering and Anomaly Detection.', 'Dimensionality Reduction and Association Rules.', 'Classification and Regression.', 'Reinforcement Learning and Generative Models.', 'C', 'These tasks involve predicting a category or a continuous value.');
INSERT INTO public.quiz_questions VALUES (183, 35, 'In the context of ''supervised learning,'' what does ''supervision'' primarily refer to?', 'The process of the model correcting its own errors automatically.', 'The human oversight required during the model training phase.', 'The ability of the model to learn without any external guidance.', 'The presence of known output labels or target values in the training data.', 'D', 'Think about what makes the learning ''guided'' or ''instructed''.');
INSERT INTO public.quiz_questions VALUES (184, 35, 'If you have a dataset where each data point includes a set of features and a corresponding ''correct answer'' or target value, what type of machine learning approach would be most suitable?', 'Unsupervised Learning', 'Supervised Learning', 'Reinforcement Learning', 'Semi-supervised Learning', 'B', 'The presence of ''correct answers'' is a key indicator.');
INSERT INTO public.quiz_questions VALUES (185, 36, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (186, 37, 'What is the primary characteristic of the data used in unsupervised learning?', 'It is labeled with known outcomes.', 'It requires human intervention for every data point.', 'It consists of input features only, without corresponding output labels.', 'It is always small and easily manageable.', 'C', 'Think about what ''unsupervised'' implies regarding guidance during learning.');
INSERT INTO public.quiz_questions VALUES (187, 37, 'What is the main objective of unsupervised learning?', 'To discover hidden patterns, structures, or groupings within data without explicit guidance.', 'To categorize data into predefined classes.', 'To minimize the error between predicted and actual values.', 'To predict future outcomes based on historical data.', 'A', 'Unsupervised methods explore data to find inherent organization.');
INSERT INTO public.quiz_questions VALUES (188, 37, 'How does unsupervised learning differ from supervised learning regarding data labels?', 'Both types of learning always use labeled data.', 'Unsupervised learning uses labeled data, while supervised learning uses unlabeled data.', 'Neither type of learning uses labeled data.', 'Unsupervised learning uses unlabeled data, while supervised learning uses labeled data.', 'D', 'The ''supervisor'' in supervised learning provides explicit answers.');
INSERT INTO public.quiz_questions VALUES (189, 37, 'Which of the following is a common task performed by unsupervised learning algorithms?', 'Regression', 'Clustering', 'Classification', 'Reinforcement', 'B', 'Think about grouping similar items together without prior knowledge of the groups.');
INSERT INTO public.quiz_questions VALUES (190, 37, 'Why is discovering hidden patterns in data important in unsupervised learning?', 'To understand the underlying structure of the data and gain insights.', 'To manually label all the data points after the process.', 'To directly achieve perfect prediction accuracy.', 'To only reduce the dataset''s size without further analysis.', 'A', 'Unsupervised learning is often used for exploratory data analysis.');
INSERT INTO public.quiz_questions VALUES (200, 38, 'What is the primary characteristic of unsupervised learning in machine learning?', 'It works with unlabeled data to find hidden patterns.', 'It uses labeled data for training.', 'It requires human supervision for every data point.', 'It predicts a specific output variable.', 'A', 'Think about the ''unsupervised'' aspect, implying no explicit guidance.');
INSERT INTO public.quiz_questions VALUES (201, 38, 'What is the main goal of unsupervised learning?', 'To classify data into predefined categories.', 'To discover hidden structures or patterns in data without explicit output labels.', 'To predict future values based on past data.', 'To learn a mapping from inputs to known outputs.', 'B', 'Unsupervised learning explores data to find inherent organization.');
INSERT INTO public.quiz_questions VALUES (202, 38, 'Which type of data is typically used in unsupervised learning algorithms?', 'Data with clear input-output pairs.', 'Data that has already been classified by an expert.', 'Data that includes both training and testing labels.', 'Data without any predefined labels or target variables.', 'D', 'The ''unsupervised'' part indicates a lack of explicit guidance in the data itself.');
INSERT INTO public.quiz_questions VALUES (203, 38, 'Which of the following is a common technique used in unsupervised learning to group similar data points together?', 'Regression', 'Classification', 'Reinforcement Learning', 'Clustering', 'D', 'This technique involves forming groups based on inherent similarities within the data.');
INSERT INTO public.quiz_questions VALUES (204, 38, 'K-Means is a popular algorithm primarily used for which unsupervised learning task?', 'Predicting numerical values.', 'Grouping data points into clusters.', 'Classifying images into categories.', 'Detecting anomalies in sequential data (when labels are available).', 'B', 'K-Means aims to partition data into K distinct groups based on feature similarity.');
INSERT INTO public.quiz_questions VALUES (205, 38, 'What is the primary purpose of dimensionality reduction techniques in unsupervised learning?', 'To increase the number of features in a dataset.', 'To assign labels to unlabeled data.', 'To predict a target variable more accurately.', 'To reduce the number of features while preserving important information.', 'D', 'These techniques simplify the data representation by finding a lower-dimensional projection.');
INSERT INTO public.quiz_questions VALUES (206, 38, 'How does unsupervised learning primarily differ from supervised learning?', 'Supervised learning is generally faster to train.', 'Unsupervised learning works with unlabeled data, whereas supervised learning uses labeled data.', 'Unsupervised learning requires a target variable, while supervised learning does not.', 'Supervised learning always achieves higher accuracy.', 'B', 'The key distinction lies in the type of data used for training.');
INSERT INTO public.quiz_questions VALUES (207, 38, 'Which of the following is a common application of unsupervised learning?', 'Predicting house prices based on features.', 'Classifying emails as spam or not spam.', 'Segmenting customers based on purchasing behavior.', 'Forecasting stock market trends.', 'C', 'This application often involves discovering natural groups within a customer base without prior definitions of those groups.');
INSERT INTO public.quiz_questions VALUES (208, 38, 'What is a significant benefit of using unsupervised learning?', 'It eliminates the need for any data preprocessing.', 'It can discover valuable insights from data without the need for expensive and time-consuming labeling.', 'It guarantees a perfect model accuracy for all tasks.', 'It is primarily used for generating new, synthetic data.', 'B', 'Consider the practical challenges of preparing data for machine learning, especially regarding labels.');
INSERT INTO public.quiz_questions VALUES (214, 39, 'What is a primary purpose of software requirements?', 'To define what the software should do.', 'To write the actual code for the software.', 'To test the completed software.', 'To market the software product.', 'A', 'Requirements focus on describing the desired functionality and characteristics.');
INSERT INTO public.quiz_questions VALUES (215, 39, 'Which initial phase of software development primarily focuses on identifying and documenting requirements?', 'Coding Phase', 'Requirements Elicitation', 'Deployment Phase', 'Maintenance Phase', 'B', 'This phase is about understanding what the stakeholders need.');
INSERT INTO public.quiz_questions VALUES (216, 39, 'What is a common consequence of having unclear or poorly defined software requirements?', 'Faster development cycles', 'Automatic bug fixes', 'Guaranteed project success', 'Increased risk of project failure or rework', 'D', 'Ambiguity in requirements can lead to misunderstandings and wasted effort.');
INSERT INTO public.quiz_questions VALUES (217, 39, 'A software requirement primarily describes a condition or capability that a system must satisfy. Is this statement generally true or false?', 'True', 'False', 'Only for hardware systems', 'Only for very simple software', 'A', 'This is the fundamental definition of a software requirement.');
INSERT INTO public.quiz_questions VALUES (218, 39, 'Who are key individuals or groups typically involved in eliciting (gathering) software requirements?', 'Only senior developers', 'Only sales and marketing staff', 'Users, customers, and business analysts', 'Only quality assurance testers', 'C', 'Multiple perspectives are crucial for comprehensive requirements gathering.');
INSERT INTO public.quiz_questions VALUES (224, 40, 'What does the term ''natural language'' primarily refer to?', 'Languages used by animals to communicate.', 'Computer programming languages such as Python or Java.', 'Languages that have developed naturally in humans, like English or Spanish.', 'Any language that is spoken outdoors in nature.', 'C', 'Think about the languages humans speak every day.');
INSERT INTO public.quiz_questions VALUES (225, 40, 'What is considered the primary purpose of natural language?', 'To perform complex mathematical calculations.', 'To enable communication and understanding between humans.', 'To control machinery and automation systems.', 'To store digital information efficiently.', 'B', 'Consider why people use language to interact with each other.');
INSERT INTO public.quiz_questions VALUES (226, 40, 'Which of the following is a fundamental characteristic of natural language?', 'It is always perfectly logical and free from ambiguity.', 'It is static and does not change over time.', 'It is typically learned through exposure and interaction from a young age.', 'It is designed by a single individual or committee.', 'C', 'How do children acquire their first language?');
INSERT INTO public.quiz_questions VALUES (227, 40, 'How do natural languages generally differ from artificial languages (like programming languages)?', 'Natural languages are formally designed, while artificial languages evolve organically.', 'Natural languages are typically universal, while artificial languages vary greatly.', 'Natural languages often contain ambiguity and context-dependency, unlike precise artificial languages.', 'Artificial languages are much older than natural languages.', 'C', 'Think about whether a human sentence or a line of code is more open to interpretation.');
INSERT INTO public.quiz_questions VALUES (228, 40, 'A key aspect of natural language is that its meaning can often depend heavily on the:', 'Age of the person speaking it.', 'Temperature of the surrounding environment.', 'Specific context in which it is used.', 'Number of syllables in each word.', 'C', 'Consider how the same word might mean different things in different situations.');
INSERT INTO public.quiz_questions VALUES (229, 41, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (230, 42, 'Failed to generate AI Question. Please edit this.', 'A', 'B', 'C', 'D', 'A', 'Edit me');
INSERT INTO public.quiz_questions VALUES (231, 43, 'Which of the following is the correct way to assign the integer value 10 to a variable named `x` in Python?', 'x = 10', 'x == 10', 'int x = 10', 'assign x to 10', 'A', 'Python uses a single equals sign for variable assignment.');
INSERT INTO public.quiz_questions VALUES (232, 43, 'What will be printed to the console by the following Python code?
`print("Hello")`', '"Hello"', 'Hello', 'print("Hello")', 'Error', 'B', 'The `print()` function outputs its argument to the console without the quotes.');
INSERT INTO public.quiz_questions VALUES (233, 43, 'What data type would Python assign to the variable `pi` if you wrote `pi = 3.14`?', 'integer', 'string', 'float', 'boolean', 'C', 'Numbers with a decimal point are represented by a specific numeric data type.');
INSERT INTO public.quiz_questions VALUES (234, 43, 'How do you create a single-line comment in Python?', '// This is a comment', '# This is a comment', '-- This is a comment', '/* This is a comment */', 'B', 'Comments are used for explanation and are ignored by the interpreter.');
INSERT INTO public.quiz_questions VALUES (235, 43, 'What is the result of the Python expression `7 + 3`?', '"73"', '"10"', '10', '73', 'C', 'The `+` operator performs arithmetic addition for numbers.');


--
-- Data for Name: quizzes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.quizzes VALUES (1, 'python', 'loops', 'draft', '2026-03-06 11:05:13.166778', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (2, 'python', 'loops', 'draft', '2026-03-06 11:05:27.51816', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (3, 'python', 'loops', 'draft', '2026-03-06 11:05:36.487084', NULL, 0, 10, 'medium', 10, false);
INSERT INTO public.quizzes VALUES (4, 'dbms', 'functions', 'draft', '2026-03-06 11:08:52.17832', NULL, 0, 10, 'medium', 10, false);
INSERT INTO public.quizzes VALUES (5, 'dbms', 'functions', 'draft', '2026-03-06 11:09:38.12701', NULL, 0, 10, 'hard', 10, false);
INSERT INTO public.quizzes VALUES (6, 'dbms', 'functions', 'draft', '2026-03-06 11:09:46.489385', NULL, 0, 10, 'medium', 10, false);
INSERT INTO public.quizzes VALUES (7, 'os', 'dining table problem', 'active', '2026-03-06 11:11:12.723463', NULL, 0, 10, 'medium', 10, false);
INSERT INTO public.quizzes VALUES (8, 'python', 'loops', 'draft', '2026-03-08 17:30:34.876264', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (9, 'dbms', 'functions
', 'draft', '2026-03-08 17:31:30.325994', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (10, 'software engineering', '
agile model', 'active', '2026-03-08 17:32:12.083213', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (11, 'Test Quiz', 'Python basics', 'active', '2026-03-08 18:02:43.661763', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (12, 'nlp', 'parsing', 'active', '2026-03-08 18:22:06.938543', NULL, 0, 10, 'medium', 10, false);
INSERT INTO public.quizzes VALUES (13, 'MATHS', 'LINEAR ALGEBRA', 'draft', '2026-03-08 23:59:00.04352', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (14, 'software engineering', 'software development life cycle', 'active', '2026-03-09 00:16:53.217554', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (15, 'c programing', 'iteration', 'active', '2026-03-09 00:43:27.898247', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (16, 'c programimn', 'c programing basics', 'active', '2026-03-09 00:48:15.009158', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (17, 'DBMS', 'ER MODEL', 'active', '2026-03-09 09:27:52.126217', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (18, 'SE', 'AGILE MODEL', 'active', '2026-03-09 12:40:22.469281', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (19, 'se', 'software testing', 'active', '2026-03-09 13:48:59.38761', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (20, 'se', 'software texting', 'draft', '2026-03-09 14:02:45.855008', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (21, 'ai', 'ai agents', 'draft', '2026-03-09 14:25:02.039895', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (22, 'nlp', 'parts of speech tagging', 'draft', '2026-03-19 23:20:15.365254', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (23, 'NLP', 'PARTS OF SPEECH TAGGING', 'draft', '2026-03-19 23:31:46.265958', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (24, 'PROGRAMMING LANGUAGE', 'OBJECT ORIENTED PROGRAMMING', 'draft', '2026-03-23 19:35:49.216273', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (25, 'PYTHON', 'FUNTIONS IN PYTHON', 'draft', '2026-03-24 22:40:19.187507', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (26, 'PYTHON', 'TYPES OFUNTIONS IN PYTHON', 'active', '2026-03-24 22:40:31.426247', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (27, 'DBMS', 'NORMALIZATION', 'draft', '2026-03-25 10:52:59.78577', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (28, 'DBMS', 'NORMALIZATION', 'draft', '2026-03-25 10:53:24.740433', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (29, 'Operating system', 'operating system process schedule', 'draft', '2026-04-20 11:33:01.484679', NULL, 0, 10, 'medium', 10, false);
INSERT INTO public.quizzes VALUES (30, 'cpp', 'cpp object oriented programming', 'draft', '2026-04-24 11:47:35.91958', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (31, 'cpp', 'cpp object oriented programming', 'draft', '2026-04-24 11:48:11.083618', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (32, 'OS', 'THREADS IN OPERATING SYSTEM', 'draft', '2026-05-18 14:00:29.429794', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (33, 'ml', 'supervised learnings ', 'draft', '2026-06-01 16:15:06.456656', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (34, 'MACHINE LARANING', 'SUPERVISED LEARNING IN ML', 'active', '2026-06-03 12:37:22.088627', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (35, 'machine learning', 'supervised learning', 'active', '2026-06-03 14:33:16.572514', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (36, 'machine learning', 'unsupervised learning', 'draft', '2026-06-08 18:52:01.432082', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (37, 'machine learning', 'unsupervised learning in macine learning', 'draft', '2026-06-08 18:52:32.717553', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (38, 'machine learning', 'unsupervised learning in machine learning', 'active', '2026-06-08 18:53:28.514581', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (39, 'SOFTWARE ENGINEERING', 'REQUIREMENTS IN SOFTWARE ENGINEERING', 'active', '2026-06-09 07:25:49.881681', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (40, 'NATURAL LANGUAGE', 'NATURAL LANGUAGE BASICS', 'active', '2026-06-09 09:49:10.843678', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (41, 'python', 'python basics', 'draft', '2026-06-09 11:53:08.437402', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (42, 'python', 'python basics', 'draft', '2026-06-09 11:53:21.175582', NULL, 0, 10, 'easy', 10, false);
INSERT INTO public.quizzes VALUES (43, 'python', 'python basics', 'draft', '2026-06-09 11:53:45.200912', NULL, 0, 10, 'easy', 10, false);


--
-- Data for Name: risk_predictions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: student_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: student_responses; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: student_risk; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.student_risk VALUES (2, 0, 'Average', 0.05088816583156586, 0.9260672330856323, 0.02304462343454361, '2026-03-06 13:14:16.387739', NULL);
INSERT INTO public.student_risk VALUES (3, 2, 'Good', 0, 0, 1, '2026-03-06 13:20:23.311097', NULL);
INSERT INTO public.student_risk VALUES (8, 12, 'At Risk', 0.3548401892185211, 0.3139815628528595, 0.33117830753326416, '2026-06-03 12:22:31.331974', 'HIGH');
INSERT INTO public.student_risk VALUES (4, 14, 'At Risk', 0.3601851761341095, 0.31416770815849304, 0.32564717531204224, '2026-06-03 12:22:31.618932', 'HIGH');
INSERT INTO public.student_risk VALUES (1, 13, 'At Risk', 0.3864007890224457, 0.3084273338317871, 0.30517181754112244, '2026-06-03 12:22:31.634903', 'HIGH');
INSERT INTO public.student_risk VALUES (7, 20, 'At Risk', 0.3738259971141815, 0.31032612919807434, 0.3158479332923889, '2026-06-03 12:22:31.661022', 'HIGH');
INSERT INTO public.student_risk VALUES (10, 32, 'At Risk', 0.37693002820014954, 0.3216433823108673, 0.30142661929130554, '2026-06-09 07:42:46.347451', 'HIGH');
INSERT INTO public.student_risk VALUES (9, 22, 'At Risk', 0.3803766667842865, 0.3252315819263458, 0.29439178109169006, '2026-06-09 07:42:46.402374', 'HIGH');
INSERT INTO public.student_risk VALUES (12, 37, 'At Risk', 0.3788612484931946, 0.32276901602745056, 0.29836973547935486, '2026-06-09 07:42:46.408667', 'HIGH');
INSERT INTO public.student_risk VALUES (11, 40, 'At Risk', 0.3761065602302551, 0.32500097155570984, 0.29889243841171265, '2026-06-09 07:42:46.412568', 'HIGH');


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students VALUES (1, 1, 'Alan Tom', 'CS2024001', 'MSc Computer Science', '2026-01-18 13:46:37.201125');
INSERT INTO public.students VALUES (2, 2, 'John', 'CS001', 'MSc CS', '2026-01-21 17:19:59.356915');
INSERT INTO public.students VALUES (7, 5, 'bbcb', 'c2bo5', 'maths', '2026-01-30 13:37:26.704341');
INSERT INTO public.students VALUES (8, 3, 'ahedf', 'c22556df', 'cs', '2026-02-03 14:49:04.107833');


--
-- Data for Name: study_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.study_materials VALUES (1, 'python basics', 7, 'video', 'https://youtu.be/fWjsdhR3z3c?si=M1cdIW4hbk7L1yoC', NULL, '2026-03-07 10:29:54.787589', 'CS01');
INSERT INTO public.study_materials VALUES (2, 'sy', 7, 'pdf', 'uploads/materials\M.Sc_Computer_Science_and_M.Sc_Computer_Science_with_Specialization_in_Artific_q00U7z5.pdf', NULL, '2026-03-07 10:43:01.225907', 'CS01');
INSERT INTO public.study_materials VALUES (3, 'loops', 7, 'video', 'https://youtu.be/94UHCEmprCY?si=r54LO6zkMb7Xi3nF', NULL, '2026-03-07 14:18:45.933413', 'CS01');
INSERT INTO public.study_materials VALUES (4, 'DBMS', 7, 'text', NULL, 'Why Manual and DL show different results

Your system now has two different prediction methods:

1️⃣ Manual Rule-Based Model

This uses fixed rules like:

attendance

marks

study time

failures

Example rule logic:

if marks < 40 → HIGH
if marks < 70 → MEDIUM
else → LOW

So your manual model predicted:

MEDIUM
2️⃣ Deep Learning Model

Your DL model uses the trained neural network:

studytime
failures
absences
G1
G2

The neural network learned patterns from data and predicted:

Good
This difference is NORMAL

It actually shows that:

Rule-based logic says Medium risk

AI model says Good performance

Your graph correctly shows:

Model	Score
Manual	2
DL	1

Which matches your mapping:

High → 3
Medium → 2
Good → 1

So your chart is correct.

What this means academically

This is very good for your MSc project, because you can explain:

The rule-based model uses simple thresholds, while the deep learning model captures complex relationships between study behaviour and performance, leading to different predictions.

This becomes a model comparison experiment.', '2026-03-08 10:30:05.243939', 'CS01');
INSERT INTO public.study_materials VALUES (5, 'PYTHON', 7, 'pdf', 'uploads/materials\DBMS - Copy.pptx', NULL, '2026-03-09 12:39:43.75304', 'CS01');
INSERT INTO public.study_materials VALUES (6, 'NLP', 7, 'video', 'https://youtu.be/fLvJ8VdHLA0?si=fcFk4tRHOlzAAWOv', NULL, '2026-03-24 22:39:31.917255', 'CS02');
INSERT INTO public.study_materials VALUES (7, 'PYHTON', 7, 'video', 'https://youtu.be/89cGQjB5R4M?si=OPXtD437ka-XJ3ds', NULL, '2026-03-25 10:50:34.876715', 'CS01');
INSERT INTO public.study_materials VALUES (8, 'project report', 7, 'pdf', 'uploads/materials\MAIN111 (1).pdf', NULL, '2026-03-29 12:37:00.672026', 'CS01');
INSERT INTO public.study_materials VALUES (9, 'TEACHER LIST', 7, 'pdf', 'uploads/materials\approved_teachers.pdf', NULL, '2026-06-09 07:23:04.399293', 'CS02');
INSERT INTO public.study_materials VALUES (10, 'PY', 7, 'video', ' https://share.google/F6wtwjsovIbddAcP9', NULL, '2026-06-09 07:24:16.29425', 'CS02');


--
-- Data for Name: study_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.study_sessions VALUES (1, 13, 1, '2026-03-07 19:40:12.405902', NULL);
INSERT INTO public.study_sessions VALUES (2, 13, 3, '2026-03-07 19:40:12.406963', NULL);
INSERT INTO public.study_sessions VALUES (3, 13, 2, '2026-03-07 19:40:44.289112', NULL);
INSERT INTO public.study_sessions VALUES (4, 13, 3, '2026-03-07 21:25:57.299476', NULL);
INSERT INTO public.study_sessions VALUES (5, 13, 3, '2026-03-08 00:53:34.844318', NULL);
INSERT INTO public.study_sessions VALUES (6, 13, 1, '2026-03-08 00:53:34.849506', NULL);
INSERT INTO public.study_sessions VALUES (7, 13, 1, '2026-03-08 01:18:13.220216', NULL);
INSERT INTO public.study_sessions VALUES (8, 13, 3, '2026-03-08 01:18:13.222935', NULL);
INSERT INTO public.study_sessions VALUES (9, 13, 3, '2026-03-08 10:32:04.108355', NULL);
INSERT INTO public.study_sessions VALUES (10, 13, 1, '2026-03-08 10:32:04.222443', NULL);
INSERT INTO public.study_sessions VALUES (11, 13, 4, '2026-03-08 10:32:05.16411', '2026-03-08 10:32:05.215279');
INSERT INTO public.study_sessions VALUES (12, 13, 1, '2026-03-08 12:06:06.038112', NULL);
INSERT INTO public.study_sessions VALUES (13, 13, 3, '2026-03-08 12:06:06.038955', NULL);
INSERT INTO public.study_sessions VALUES (14, 13, 4, '2026-03-08 12:06:06.318932', '2026-03-08 12:06:06.35328');
INSERT INTO public.study_sessions VALUES (15, 13, 4, '2026-03-08 12:06:08.781917', '2026-03-08 12:06:08.879712');
INSERT INTO public.study_sessions VALUES (16, 13, 1, '2026-03-08 12:06:09.007149', NULL);
INSERT INTO public.study_sessions VALUES (17, 13, 3, '2026-03-08 12:06:09.008444', NULL);
INSERT INTO public.study_sessions VALUES (18, 13, 4, '2026-03-08 18:35:00.955093', '2026-03-08 18:35:01.062922');
INSERT INTO public.study_sessions VALUES (19, 20, 4, '2026-03-08 23:53:14.936321', '2026-03-08 23:53:14.9651');
INSERT INTO public.study_sessions VALUES (20, 20, 1, '2026-03-08 23:53:15.180888', NULL);
INSERT INTO public.study_sessions VALUES (21, 20, 3, '2026-03-08 23:53:15.181763', NULL);
INSERT INTO public.study_sessions VALUES (22, 13, 1, '2026-03-09 00:20:23.905299', NULL);
INSERT INTO public.study_sessions VALUES (23, 13, 3, '2026-03-09 00:20:23.905997', NULL);
INSERT INTO public.study_sessions VALUES (24, 13, 4, '2026-03-09 00:20:24.548067', '2026-03-09 00:20:24.615711');
INSERT INTO public.study_sessions VALUES (25, 13, 1, '2026-03-09 01:45:37.478393', NULL);
INSERT INTO public.study_sessions VALUES (26, 13, 3, '2026-03-09 01:45:37.662355', NULL);
INSERT INTO public.study_sessions VALUES (27, 13, 4, '2026-03-09 01:45:39.892448', '2026-03-09 01:45:39.9709');
INSERT INTO public.study_sessions VALUES (28, 13, 3, '2026-03-09 02:22:35.670896', NULL);
INSERT INTO public.study_sessions VALUES (29, 13, 1, '2026-03-09 02:22:35.675514', NULL);
INSERT INTO public.study_sessions VALUES (30, 13, 1, '2026-03-09 03:00:30.907537', NULL);
INSERT INTO public.study_sessions VALUES (31, 13, 3, '2026-03-09 03:00:30.907922', NULL);
INSERT INTO public.study_sessions VALUES (32, 13, 4, '2026-03-09 03:00:57.44213', '2026-03-09 03:00:57.70037');
INSERT INTO public.study_sessions VALUES (33, 13, 4, '2026-03-09 03:04:10.754304', '2026-03-09 03:04:12.133629');
INSERT INTO public.study_sessions VALUES (34, 13, 3, '2026-03-09 03:06:28.900071', NULL);
INSERT INTO public.study_sessions VALUES (35, 13, 1, '2026-03-09 03:06:28.907315', NULL);
INSERT INTO public.study_sessions VALUES (36, 13, 3, '2026-03-09 03:10:49.815788', NULL);
INSERT INTO public.study_sessions VALUES (37, 13, 1, '2026-03-09 03:10:49.819039', NULL);
INSERT INTO public.study_sessions VALUES (38, 13, 3, '2026-03-09 03:23:33.047812', NULL);
INSERT INTO public.study_sessions VALUES (39, 13, 1, '2026-03-09 03:23:33.05485', NULL);
INSERT INTO public.study_sessions VALUES (40, 13, 3, '2026-03-09 09:29:40.389002', NULL);
INSERT INTO public.study_sessions VALUES (41, 13, 1, '2026-03-09 09:29:40.471761', NULL);
INSERT INTO public.study_sessions VALUES (42, 13, 1, '2026-03-09 12:00:45.075341', NULL);
INSERT INTO public.study_sessions VALUES (43, 13, 3, '2026-03-09 12:00:45.130547', NULL);
INSERT INTO public.study_sessions VALUES (44, 20, 3, '2026-03-09 12:29:24.477137', NULL);
INSERT INTO public.study_sessions VALUES (45, 20, 1, '2026-03-09 12:29:24.477457', NULL);
INSERT INTO public.study_sessions VALUES (46, 13, 4, '2026-03-09 12:44:55.97645', '2026-03-09 12:44:56.048486');
INSERT INTO public.study_sessions VALUES (47, 13, 4, '2026-03-09 12:44:57.403867', '2026-03-09 12:44:58.30642');
INSERT INTO public.study_sessions VALUES (48, 13, 4, '2026-03-09 12:44:58.613957', '2026-03-09 12:44:58.937644');
INSERT INTO public.study_sessions VALUES (49, 13, 4, '2026-03-09 12:45:01.071059', '2026-03-09 12:45:01.363153');
INSERT INTO public.study_sessions VALUES (50, 13, 4, '2026-03-09 12:45:01.327777', '2026-03-09 12:45:01.363153');
INSERT INTO public.study_sessions VALUES (51, 13, 1, '2026-03-09 13:31:56.331011', NULL);
INSERT INTO public.study_sessions VALUES (52, 13, 3, '2026-03-09 13:32:03.891276', NULL);
INSERT INTO public.study_sessions VALUES (53, 13, 2, '2026-03-09 13:32:04.014103', NULL);
INSERT INTO public.study_sessions VALUES (54, 13, 4, '2026-03-12 10:15:30.799249', '2026-03-12 10:15:31.337845');
INSERT INTO public.study_sessions VALUES (55, 13, 1, '2026-03-12 10:15:32.841423', NULL);
INSERT INTO public.study_sessions VALUES (56, 13, 3, '2026-03-12 10:15:32.858188', NULL);
INSERT INTO public.study_sessions VALUES (57, 13, 4, '2026-03-12 10:15:32.988317', '2026-03-12 10:15:33.493866');
INSERT INTO public.study_sessions VALUES (58, 13, 1, '2026-03-17 12:49:32.161745', NULL);
INSERT INTO public.study_sessions VALUES (59, 13, 3, '2026-03-17 12:49:32.392572', NULL);
INSERT INTO public.study_sessions VALUES (61, 13, 1, '2026-03-18 13:36:23.267201', NULL);
INSERT INTO public.study_sessions VALUES (62, 13, 3, '2026-03-18 13:36:23.922759', NULL);
INSERT INTO public.study_sessions VALUES (60, 13, 4, '2026-03-18 13:36:22.850672', '2026-03-18 13:36:24.274027');
INSERT INTO public.study_sessions VALUES (63, 13, 4, '2026-03-18 13:36:30.283218', '2026-03-18 13:36:31.200845');
INSERT INTO public.study_sessions VALUES (64, 13, 4, '2026-03-18 13:37:05.166632', '2026-03-18 13:37:05.575749');
INSERT INTO public.study_sessions VALUES (65, 13, 4, '2026-03-18 13:37:07.638696', '2026-03-18 13:37:08.848041');
INSERT INTO public.study_sessions VALUES (66, 13, 4, '2026-03-18 13:37:09.554893', '2026-03-18 13:37:09.666084');
INSERT INTO public.study_sessions VALUES (67, 13, 3, '2026-03-22 10:58:18.119082', NULL);
INSERT INTO public.study_sessions VALUES (68, 13, 1, '2026-03-22 10:58:18.408469', NULL);
INSERT INTO public.study_sessions VALUES (69, 13, 4, '2026-03-22 10:58:19.232733', '2026-03-22 10:58:20.478335');
INSERT INTO public.study_sessions VALUES (70, 13, 1, '2026-03-23 11:29:55.934664', NULL);
INSERT INTO public.study_sessions VALUES (71, 13, 3, '2026-03-23 11:29:55.93782', NULL);
INSERT INTO public.study_sessions VALUES (72, 13, 1, '2026-03-23 19:38:17.695133', NULL);
INSERT INTO public.study_sessions VALUES (73, 13, 3, '2026-03-23 19:38:18.086863', NULL);
INSERT INTO public.study_sessions VALUES (74, 32, 6, '2026-03-24 22:42:34.890244', NULL);
INSERT INTO public.study_sessions VALUES (76, 13, 1, '2026-03-25 11:01:27.998702', NULL);
INSERT INTO public.study_sessions VALUES (77, 13, 7, '2026-03-25 11:01:28.118723', NULL);
INSERT INTO public.study_sessions VALUES (78, 13, 3, '2026-03-25 11:01:28.130377', NULL);
INSERT INTO public.study_sessions VALUES (75, 13, 4, '2026-03-25 11:01:26.610801', '2026-03-25 11:01:28.287789');
INSERT INTO public.study_sessions VALUES (79, 13, 3, '2026-03-29 12:55:09.240295', NULL);
INSERT INTO public.study_sessions VALUES (80, 13, 1, '2026-03-29 12:55:09.297178', NULL);
INSERT INTO public.study_sessions VALUES (81, 13, 7, '2026-03-29 12:55:09.611343', NULL);
INSERT INTO public.study_sessions VALUES (82, 13, 1, '2026-03-29 13:00:05.665436', NULL);
INSERT INTO public.study_sessions VALUES (83, 13, 3, '2026-03-29 13:00:05.685172', NULL);
INSERT INTO public.study_sessions VALUES (84, 13, 7, '2026-03-29 13:00:08.044248', NULL);
INSERT INTO public.study_sessions VALUES (85, 13, 1, '2026-04-08 15:33:34.36042', NULL);
INSERT INTO public.study_sessions VALUES (86, 13, 7, '2026-04-08 15:33:34.56624', NULL);
INSERT INTO public.study_sessions VALUES (87, 13, 3, '2026-04-08 15:33:34.571773', NULL);
INSERT INTO public.study_sessions VALUES (88, 13, 4, '2026-04-08 15:33:37.386815', '2026-04-08 15:33:37.91238');
INSERT INTO public.study_sessions VALUES (89, 13, 3, '2026-04-17 14:31:07.315573', NULL);
INSERT INTO public.study_sessions VALUES (90, 13, 1, '2026-04-17 14:31:07.314599', NULL);
INSERT INTO public.study_sessions VALUES (91, 13, 7, '2026-04-17 14:31:07.521009', NULL);
INSERT INTO public.study_sessions VALUES (92, 13, 1, '2026-05-18 14:03:09.105006', NULL);
INSERT INTO public.study_sessions VALUES (93, 13, 7, '2026-05-18 14:03:09.519771', NULL);
INSERT INTO public.study_sessions VALUES (94, 13, 3, '2026-05-18 14:03:09.520394', NULL);
INSERT INTO public.study_sessions VALUES (95, 13, 1, '2026-06-01 16:45:32.495969', NULL);
INSERT INTO public.study_sessions VALUES (96, 13, 7, '2026-06-01 16:45:32.742504', NULL);
INSERT INTO public.study_sessions VALUES (97, 13, 3, '2026-06-01 16:45:32.744898', NULL);
INSERT INTO public.study_sessions VALUES (98, 13, 1, '2026-06-03 12:42:01.624941', NULL);
INSERT INTO public.study_sessions VALUES (99, 13, 7, '2026-06-03 12:42:01.701026', NULL);
INSERT INTO public.study_sessions VALUES (100, 13, 3, '2026-06-03 12:42:01.717952', NULL);
INSERT INTO public.study_sessions VALUES (101, 13, 3, '2026-06-03 13:27:19.378243', NULL);
INSERT INTO public.study_sessions VALUES (102, 13, 1, '2026-06-03 13:27:19.488174', NULL);
INSERT INTO public.study_sessions VALUES (103, 13, 7, '2026-06-03 13:27:19.550263', NULL);
INSERT INTO public.study_sessions VALUES (104, 13, 4, '2026-06-03 13:27:56.277471', '2026-06-03 13:27:56.314434');
INSERT INTO public.study_sessions VALUES (105, 13, 5, '2026-06-03 13:28:01.308563', NULL);
INSERT INTO public.study_sessions VALUES (106, 13, 4, '2026-06-03 13:28:06.26467', '2026-06-03 13:28:07.349453');
INSERT INTO public.study_sessions VALUES (107, 13, 4, '2026-06-03 13:28:07.619283', '2026-06-03 13:28:07.693617');
INSERT INTO public.study_sessions VALUES (108, 13, 4, '2026-06-03 13:28:26.142929', '2026-06-03 13:28:26.205541');
INSERT INTO public.study_sessions VALUES (109, 13, 3, '2026-06-08 17:23:39.463738', NULL);
INSERT INTO public.study_sessions VALUES (110, 13, 7, '2026-06-08 17:23:40.048077', NULL);
INSERT INTO public.study_sessions VALUES (111, 13, 1, '2026-06-08 17:23:40.048498', NULL);
INSERT INTO public.study_sessions VALUES (112, 13, 1, '2026-06-09 11:15:30.933445', NULL);
INSERT INTO public.study_sessions VALUES (113, 13, 7, '2026-06-09 11:15:30.950706', NULL);
INSERT INTO public.study_sessions VALUES (114, 13, 3, '2026-06-09 11:15:31.1662', NULL);
INSERT INTO public.study_sessions VALUES (115, 13, 1, '2026-06-09 11:57:25.019846', NULL);
INSERT INTO public.study_sessions VALUES (116, 13, 7, '2026-06-09 11:57:25.060505', NULL);
INSERT INTO public.study_sessions VALUES (117, 13, 3, '2026-06-09 11:57:25.087425', NULL);


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: syllabus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.syllabus VALUES (4, 1, 2, 'science', 'phy', '2026-02-11 16:54:14.481212', 'text', NULL);
INSERT INTO public.syllabus VALUES (5, 1, 2, 'english', 'verbs', '2026-03-01 17:28:14.078771', 'text', NULL);
INSERT INTO public.syllabus VALUES (9, 7, 2, 'python', NULL, '2026-03-07 12:20:42.600291', 'text', 'uploads/syllabus/M.Sc_Computer_Science_and_M.Sc_Computer_Science_with_Specialization_in_Artific_q00U7z5.pdf');
INSERT INTO public.syllabus VALUES (10, 7, 2, 'py', NULL, '2026-03-07 12:30:47.540509', 'text', 'uploads/syllabus/M.Sc_Computer_Science_and_M.Sc_Computer_Science_with_Specialization_in_Artific_q00U7z5.pdf');
INSERT INTO public.syllabus VALUES (12, 7, 2, 'python', NULL, '2026-03-07 13:24:44.629625', 'pdf', 'uploads/syllabus/M.Sc_Computer_Science_and_M.Sc_Computer_Science_with_Specialization_in_Artific_q00U7z5.pdf');
INSERT INTO public.syllabus VALUES (14, 7, 2, 'python', 'iteration', '2026-03-07 14:19:41.139248', 'text', NULL);
INSERT INTO public.syllabus VALUES (15, 7, 2, 'PYTHON', 'ITERATIONS', '2026-03-08 10:31:28.961436', 'text', NULL);
INSERT INTO public.syllabus VALUES (16, 7, 2, 'PYTHON', NULL, '2026-03-25 10:55:49.892618', 'pdf', 'uploads/syllabus/SmartEdu-ppt.pdf');
INSERT INTO public.syllabus VALUES (17, 7, 2, 'REPORT MODEL', NULL, '2026-06-09 07:27:46.83836', 'pdf', 'uploads/syllabus/MAIN111 (5).pdf');


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (6, 'abcd', '$2b$12$VEYPw44nRPQS4Dkz2ET1Bu2B4lRydlg6elTX0EUTQMIdMO0MwhRRu', 'TEACHER', '2026-01-29 14:08:17.107098', 'abcd@gmail.com', 'PENDING', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (12, 'sam', '$2b$12$8.RJ/38hjlcbRHNFMAZIHuiBnHgVHDlKPQMLzD9DFq/6at2lxD4GS', 'student', '2026-02-10 11:50:34.107636', 'sam@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS01');
INSERT INTO public.users VALUES (32, 'student12', '$2b$12$offcrBsttpNjFv62CW4qR.HZ442dGpWVyGWYCKqzTYjudViGFPi9u', 'student', '2026-03-24 22:34:18.48911', 'student12@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS02');
INSERT INTO public.users VALUES (8, 'aaaa', '$2b$12$RFV8NvPXzui7rfi0qVxyn.ceyAqTjGaIexQ4vMLrEkA3XLtHo3LQK', 'teacher', '2026-01-30 12:44:49.092035', 'aaa@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (16, 'amal', '$2b$12$.Zz.k0W9bFLZONhsliP8/eyCy2FIdCPPShZ6sgw0O0Ff8wBp3Jo5C', 'student', '2026-02-21 21:36:51.592183', 'amal@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (20, 'student11', '$2b$12$OB5.Cv4eoZAlKYilfZ4ckejxWrSllIGKPMR3xvrStCaqi1wfTsqaW', 'student', '2026-03-01 16:06:26.301012', 'student11@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS01');
INSERT INTO public.users VALUES (39, 'teacher112', '$2b$12$Q6W.b2DIqdj72cXFG23WneOKDJkyQvMaR1OL8AxKd9vWcyn016SO2', 'teacher', '2026-06-08 22:48:52.927125', 'teacher112@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (1, 'alan', '$2b$12$fKE4P8znYHifFsZCW1c8uOUbBRtrjeH7XMjBxJTqtvKEhYcoCTAO.', 'student', '2026-01-18 13:36:30.078535', NULL, 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (9, 'bbcb', '$2b$12$HVGcMrp6zFVaARnLJVsXYuJUMzPDFL0cX7wcsGoywg.3C5Z2c9a6W', 'student', '2026-01-30 13:42:08.759213', 'bbcb@example.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (7, 'teacher1', '$2b$12$eRKa38d8ygp2vEYpH/I/S./YNCsj.yFmmDfXcB6TZrg7FoTFUNpoK', 'teacher', '2026-01-29 19:37:14.115208', 'teacher1@gmail.com', 'APPROVED', true, true, false, false, NULL, NULL);
INSERT INTO public.users VALUES (36, 'teacher32', '$2b$12$X5Ll6H3K/6ngDF7RPFOEHubMI3C9ik2E4HzMddBmr1XYw.EWhFWaa', 'teacher', '2026-06-03 12:11:58.686017', 'teacher32@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (4, 'arun', '$2b$12$JCRLZQzVEfLLV6VeGvT/beLLn2bGq5AuESKqHv9W6fciM7BQwS5jC', 'teacher', '2026-01-21 18:14:17.240366', NULL, 'REJECTED', true, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (5, 'arjun', '$2b$12$Z1rjVvL4t6wIYxgO1gF0hO9d7Z5F5GZ7X0k2c6jRzF0nZz2uG8cOe', 'teacher', '2026-01-29 13:04:37.341835', NULL, 'REJECTED', true, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (3, 'student1', '$2b$12$HlwQaK4mIkwJRUleUaldQ.rQQ.GI/e7yDCCbS7Tizv59qTZGtMjsu', 'student', '2026-01-21 16:21:11.159746', NULL, 'REJECTED', false, true, false, false, NULL, NULL);
INSERT INTO public.users VALUES (15, 'sanu', '$2b$12$//XjagXmq2so6YyKV8uwtekkXmHF7l8YjuTWHQZ451wXTzN4ANHlG', 'teacher', '2026-02-13 10:40:08.680389', 'sanu@gmail.com', 'REJECTED', true, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (19, 'teacher2', '$2b$12$9HrZq5Kp983LlTwc84BH0e7B8B6rouiWAcCSDEQR78I1uNuHPfIQq', 'teacher', '2026-02-24 20:02:06.166741', 'teacher2@gmail.com', 'APPROVED', true, true, false, false, NULL, 'CS02');
INSERT INTO public.users VALUES (22, 'student2', '$2b$12$ozmHIm1NIFLTEBl/ZvVQBe7OYWOtFT/emQZ.IJMlSd9cCf2NfvJY6', 'student', '2026-03-08 00:59:45.996756', 'student2@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS02');
INSERT INTO public.users VALUES (14, 'sanjay', '$2b$12$pZbEdbVT09KUW4NXaQDsoubLM4whJlbGmh4yVrbDmdsLIBVGlkbI.', 'student', '2026-02-13 10:38:17.536762', 'sanj@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS01');
INSERT INTO public.users VALUES (13, 'sihijo', '$2b$12$gjr6yiR3nk1yvZixopV9z.uTrjIpBLwcR4paj55xxiCedG2ycE8r2', 'student', '2026-02-11 11:53:18.232869', 'shi@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS01');
INSERT INTO public.users VALUES (2, 'alan2', '$2b$12$pglgd1d6OoBCWtoobnisf.u7eOl2GzsOs8T1IQ/cqSCSDFjPK.sEC', 'student', '2026-01-20 10:36:20.896711', NULL, 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (23, 'teacher4', '$2b$12$eBQI.268mbdbnoEHWlkbiex9dVXmC/wigQah1XY7uuN0fua9pGDG.', 'teacher', '2026-03-08 01:14:25.985132', 'teacher4@gmail.com', 'APPROVED', true, true, false, false, NULL, 'CS01');
INSERT INTO public.users VALUES (33, 'teacher13', '$2b$12$uAoYURq3/gvEWEkB1govXeYiuVwNPVAaePpuUmAjfO6zI8mklkhYm', 'teacher', '2026-03-24 23:07:34.863145', 'teacher13@gmail.com', 'REJECTED', true, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (24, 'student5', '$2b$12$laTUhmOUtl.LLFRfzwfgU.nyqloFnu1BOYe1/lYqVFVHPbEGu1HKO', 'student', '2026-03-08 01:15:12.863106', 'student5@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (25, 'mystudent', '$2b$12$B1nzr4kA35v6Imnk8hXwl.8tptKshvbEHqcD3Q6FqHoVpEf0OAWES', 'student', '2026-03-09 02:50:20.66016', 'mystudent@gmail.com', 'APPROVED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (29, 'student8', '$2b$12$0DRpSCBF88IwBOK91A9cQuPsYnFEr2gjApLyWVa4bADKSLqjkCkcm', 'student', '2026-03-18 21:57:41.732033', 'student8@gmail.com', 'APPROVED', false, true, false, false, NULL, NULL);
INSERT INTO public.users VALUES (30, 'student9', '$2b$12$Q.x3PpB0MPbk.2M1ZQscYuvhwSFLe4kD62goWBOPFXxYjeaYN3lZC', 'student', '2026-03-18 22:22:02.692168', 'student9@gmail.com', 'APPROVED', false, true, false, false, NULL, NULL);
INSERT INTO public.users VALUES (26, '', '$2b$12$.QdNjcGgGvpGMmLS/IWxw.MdlqcUYRLQXkr3fbPGw7u7X3PnmU2Cm', 'student', '2026-03-09 02:51:44.870852', 'student@gmail.com', 'APPROVED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (31, 'teacher12', '$2b$12$wfZ31exxiVmFCg95/PO1le3A3cAfX.w1a715/4zxD63RfRZL7Lxqi', 'teacher', '2026-03-24 22:33:42.886941', 'teacher12@gmail.com', 'APPROVED', false, true, false, false, NULL, NULL);
INSERT INTO public.users VALUES (21, 'teacher3', '$2b$12$E0jJzgmkgWRVm6oS949s4eyfMWBMGYLVGjkzJeXZRBRam8.AImQPq', 'teacher', '2026-03-03 22:24:10.471989', 'teacher3@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (27, 'teststudent99', '$2b$12$snjJJhAev58hsp6MU8vyJuuzY6JQ9wNPnCZI/tQIdpSFtq4A5QCa6', 'student', '2026-03-09 02:55:57.282796', 'teststudent99@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (28, 'studentauto', '$2b$12$kcuFzZNXQsIvPsqsMJ9PZ.7STipMW3xcfvRilwob9iR5BsOBN83Zi', 'student', '2026-03-09 02:57:27.070195', 'studentauto@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (35, 'teacher34', '$2b$12$20RC/YY0x4cOpGlvvS0e6uKNj/7idwv.oCKZh8ZFYJ1iO7KOi/YV2', 'teacher', '2026-03-24 23:22:06.806333', 'teacher34@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (38, 'teacher111', '$2b$12$d8iK5AMwmJnlVPZLIorsvu6CUCiMTyFLcf85mHfOAQSgmx0Y926cK', 'teacher', '2026-06-03 12:14:28.870456', 'teacher111@gmail.com', 'APPROVED', true, true, false, false, NULL, 'CS02');
INSERT INTO public.users VALUES (34, 'teacher23', '$2b$12$qFJ6j4VJKp2aDetq2abyR.ZMLxRvc6eDjPakb.VJqJ/2Vlutwhdgi', 'teacher', '2026-03-24 23:16:13.367994', 'teacher23@gmail.com', 'REJECTED', false, false, false, false, NULL, NULL);
INSERT INTO public.users VALUES (37, 'student33', '$2b$12$SUNt9LKBvpx2Q3MZz.1MJ.W8XDHr7lpY6cv6bmYlcrKVCuC9ooovS', 'student', '2026-06-03 12:12:36.249604', 'student33@gmail.com', 'APPROVED', false, true, false, false, NULL, 'CS02');
INSERT INTO public.users VALUES (40, 'student321', '$2b$12$rFczorEhAsGHGJYaIRsRjuSe61c9yERbdsZn04O0f8DEVk8QSvcoq', 'student', '2026-06-08 22:49:51.868382', 'student321@gmqil.com', 'APPROVED', false, true, false, false, NULL, 'CS02');
INSERT INTO public.users VALUES (41, 'teacher332', '$2b$12$3Qi49WQf9kbB6HYJC67GROY/deUT/.ktE2wVOiMLMeEjO1HGuK3Tu', 'teacher', '2026-06-09 11:50:39.626502', 'teacher332@gmail.com', 'APPROVED', true, true, false, false, NULL, 'cs01');
INSERT INTO public.users VALUES (10, 'Super Admin', '$2b$12$7X24/VGH35zmvELy91KYSe2XU0wJQXxk8qQm9pSbWsnrEDqN3ru5C', 'admin', '2026-02-08 17:23:57.367061', 'admin@gmail.com', 'APPROVED', false, true, false, false, NULL, NULL);


--
-- Name: attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_id_seq', 117, true);


--
-- Name: batches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.batches_id_seq', 1, false);


--
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 8, true);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 11, true);


--
-- Name: marks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marks_id_seq', 57, true);


--
-- Name: otp_verifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_verifications_id_seq', 1, false);


--
-- Name: performance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.performance_id_seq', 11, true);


--
-- Name: quiz_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_attempts_id_seq', 18, true);


--
-- Name: quiz_malpractice_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_malpractice_logs_id_seq', 1, false);


--
-- Name: quiz_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_options_id_seq', 1, false);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quiz_questions_id_seq', 235, true);


--
-- Name: quizzes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.quizzes_id_seq', 43, true);


--
-- Name: risk_predictions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.risk_predictions_id_seq', 1, false);


--
-- Name: student_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_answers_id_seq', 1, false);


--
-- Name: student_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_responses_id_seq', 1, false);


--
-- Name: student_risk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_risk_id_seq', 12, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 8, true);


--
-- Name: study_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.study_materials_id_seq', 10, true);


--
-- Name: study_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.study_sessions_id_seq', 117, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 1, false);


--
-- Name: syllabus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.syllabus_id_seq', 17, true);


--
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 41, true);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (id);


--
-- Name: batches batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: departments departments_dept_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_dept_code_key UNIQUE (dept_code);


--
-- Name: departments departments_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_name_key UNIQUE (name);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: marks marks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marks
    ADD CONSTRAINT marks_pkey PRIMARY KEY (id);


--
-- Name: otp_verifications otp_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp_verifications
    ADD CONSTRAINT otp_verifications_pkey PRIMARY KEY (id);


--
-- Name: performance performance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance
    ADD CONSTRAINT performance_pkey PRIMARY KEY (id);


--
-- Name: quiz_attempts quiz_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_pkey PRIMARY KEY (id);


--
-- Name: quiz_malpractice_logs quiz_malpractice_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_malpractice_logs
    ADD CONSTRAINT quiz_malpractice_logs_pkey PRIMARY KEY (id);


--
-- Name: quiz_options quiz_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_options
    ADD CONSTRAINT quiz_options_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: risk_predictions risk_predictions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.risk_predictions
    ADD CONSTRAINT risk_predictions_pkey PRIMARY KEY (id);


--
-- Name: student_answers student_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_answers
    ADD CONSTRAINT student_answers_pkey PRIMARY KEY (id);


--
-- Name: student_responses student_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_responses
    ADD CONSTRAINT student_responses_pkey PRIMARY KEY (id);


--
-- Name: student_risk student_risk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_risk
    ADD CONSTRAINT student_risk_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students students_register_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_register_number_key UNIQUE (register_number);


--
-- Name: students students_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_key UNIQUE (user_id);


--
-- Name: study_materials study_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.study_materials
    ADD CONSTRAINT study_materials_pkey PRIMARY KEY (id);


--
-- Name: study_sessions study_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.study_sessions
    ADD CONSTRAINT study_sessions_pkey PRIMARY KEY (id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: syllabus syllabus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus
    ADD CONSTRAINT syllabus_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);


--
-- Name: teachers teachers_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_key UNIQUE (user_id);


--
-- Name: student_risk unique_student_risk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_risk
    ADD CONSTRAINT unique_student_risk UNIQUE (student_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: ix_batches_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_batches_id ON public.batches USING btree (id);


--
-- Name: ix_courses_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_courses_id ON public.courses USING btree (id);


--
-- Name: ix_departments_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_departments_id ON public.departments USING btree (id);


--
-- Name: ix_quiz_attempts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_quiz_attempts_id ON public.quiz_attempts USING btree (id);


--
-- Name: ix_subjects_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_subjects_id ON public.subjects USING btree (id);


--
-- Name: attendance attendance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: batches batches_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batches
    ADD CONSTRAINT batches_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: courses courses_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: performance performance_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance
    ADD CONSTRAINT performance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: quiz_attempts quiz_attempts_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_attempts
    ADD CONSTRAINT quiz_attempts_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quiz_questions quiz_questions_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: risk_predictions risk_predictions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.risk_predictions
    ADD CONSTRAINT risk_predictions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: student_answers student_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_answers
    ADD CONSTRAINT student_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);


--
-- Name: student_answers student_answers_response_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_answers
    ADD CONSTRAINT student_answers_response_id_fkey FOREIGN KEY (response_id) REFERENCES public.student_responses(id) ON DELETE CASCADE;


--
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: subjects subjects_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: syllabus syllabus_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.syllabus
    ADD CONSTRAINT syllabus_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: teachers teachers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users users_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

