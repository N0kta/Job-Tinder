--
-- PostgreSQL database dump
--

\restrict 0q8nvSzk0BNUvSu7f4kjuYQIE0AhdUAiIpPS8w0Fwp4EBMjDIaj4ZqXfXURfYze

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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

--
-- Name: userrole; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.userrole AS ENUM (
    'seeker',
    'employer'
);


ALTER TYPE public.userrole OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application (
    id integer NOT NULL,
    seeker_id character varying NOT NULL,
    job_id integer NOT NULL,
    cv_text character varying,
    status character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    chat_room_id integer
);


ALTER TABLE public.application OWNER TO postgres;

--
-- Name: application_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.application_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.application_id_seq OWNER TO postgres;

--
-- Name: application_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.application_id_seq OWNED BY public.application.id;


--
-- Name: chatparticipant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chatparticipant (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    chat_room_id integer NOT NULL
);


ALTER TABLE public.chatparticipant OWNER TO postgres;

--
-- Name: chatparticipant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chatparticipant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chatparticipant_id_seq OWNER TO postgres;

--
-- Name: chatparticipant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chatparticipant_id_seq OWNED BY public.chatparticipant.id;


--
-- Name: chatroom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chatroom (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.chatroom OWNER TO postgres;

--
-- Name: chatroom_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chatroom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chatroom_id_seq OWNER TO postgres;

--
-- Name: chatroom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chatroom_id_seq OWNED BY public.chatroom.id;


--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job (
    id integer NOT NULL,
    titel character varying NOT NULL,
    description character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    employer_id character varying NOT NULL
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_id_seq OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_id_seq OWNED BY public.job.id;


--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id integer NOT NULL,
    chat_room_id integer NOT NULL,
    sender_id character varying NOT NULL,
    content character varying NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO postgres;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_seq OWNED BY public.message.id;


--
-- Name: template; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.template (
    id integer NOT NULL,
    type character varying NOT NULL,
    name character varying NOT NULL,
    structure json NOT NULL,
    created_by character varying
);


ALTER TABLE public.template OWNER TO postgres;

--
-- Name: template_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_id_seq OWNER TO postgres;

--
-- Name: template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.template_id_seq OWNED BY public.template.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id character varying NOT NULL,
    email character varying NOT NULL,
    role public.userrole NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: application id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application ALTER COLUMN id SET DEFAULT nextval('public.application_id_seq'::regclass);


--
-- Name: chatparticipant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatparticipant ALTER COLUMN id SET DEFAULT nextval('public.chatparticipant_id_seq'::regclass);


--
-- Name: chatroom id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatroom ALTER COLUMN id SET DEFAULT nextval('public.chatroom_id_seq'::regclass);


--
-- Name: job id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.job_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message ALTER COLUMN id SET DEFAULT nextval('public.message_id_seq'::regclass);


--
-- Name: template id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template ALTER COLUMN id SET DEFAULT nextval('public.template_id_seq'::regclass);


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.application (id, seeker_id, job_id, cv_text, status, created_at, chat_room_id) FROM stdin;
2	238e2985-b3ec-4b41-a98b-275492f9bac4	18	gib mir dide job	accepted	2025-09-23 16:19:27.118344	2
3	238e2985-b3ec-4b41-a98b-275492f9bac4	20	\N	pending	2025-09-23 20:04:36.760539	\N
4	238e2985-b3ec-4b41-a98b-275492f9bac4	18	\N	pending	2025-09-23 20:04:45.291707	\N
5	238e2985-b3ec-4b41-a98b-275492f9bac4	17	\N	pending	2025-09-23 20:04:51.021332	\N
6	238e2985-b3ec-4b41-a98b-275492f9bac4	14	\N	pending	2025-09-23 20:04:55.461002	\N
8	238e2985-b3ec-4b41-a98b-275492f9bac4	10	thas is cv	pending	2025-09-23 20:13:53.733212	\N
7	238e2985-b3ec-4b41-a98b-275492f9bac4	12	thas is cv	accepted	2025-09-23 20:13:50.086847	3
\.


--
-- Data for Name: chatparticipant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chatparticipant (id, user_id, chat_room_id) FROM stdin;
1	d0c56433-37ec-4812-8e45-76fb7f0e696f	1
2	238e2985-b3ec-4b41-a98b-275492f9bac4	1
3	d0c56433-37ec-4812-8e45-76fb7f0e696f	2
4	238e2985-b3ec-4b41-a98b-275492f9bac4	2
5	d0c56433-37ec-4812-8e45-76fb7f0e696f	3
6	238e2985-b3ec-4b41-a98b-275492f9bac4	3
\.


--
-- Data for Name: chatroom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chatroom (id, created_at) FROM stdin;
1	2025-09-23 16:31:24.813959
2	2025-09-23 18:06:51.335997
3	2025-09-23 20:15:00.608703
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job (id, titel, description, created_at, employer_id) FROM stdin;
1	Placeholder Job 1	This is placeholder job number 1	2025-09-23 15:50:39.051338	d0c56433-37ec-4812-8e45-76fb7f0e696f
2	Placeholder Job 2	This is placeholder job number 2	2025-09-23 15:50:39.065881	d0c56433-37ec-4812-8e45-76fb7f0e696f
3	Placeholder Job 3	This is placeholder job number 3	2025-09-23 15:50:39.080627	d0c56433-37ec-4812-8e45-76fb7f0e696f
4	Placeholder Job 4	This is placeholder job number 4	2025-09-23 15:50:39.093506	d0c56433-37ec-4812-8e45-76fb7f0e696f
5	Placeholder Job 5	This is placeholder job number 5	2025-09-23 15:50:39.106099	d0c56433-37ec-4812-8e45-76fb7f0e696f
6	Placeholder Job 6	This is placeholder job number 6	2025-09-23 15:50:39.119265	d0c56433-37ec-4812-8e45-76fb7f0e696f
7	Placeholder Job 7	This is placeholder job number 7	2025-09-23 15:50:39.131948	d0c56433-37ec-4812-8e45-76fb7f0e696f
8	Placeholder Job 8	This is placeholder job number 8	2025-09-23 15:50:39.145321	d0c56433-37ec-4812-8e45-76fb7f0e696f
9	Placeholder Job 9	This is placeholder job number 9	2025-09-23 15:50:39.158262	d0c56433-37ec-4812-8e45-76fb7f0e696f
10	Placeholder Job 10	This is placeholder job number 10	2025-09-23 15:50:39.171673	d0c56433-37ec-4812-8e45-76fb7f0e696f
11	Placeholder Job 11	This is placeholder job number 11	2025-09-23 15:50:39.183915	d0c56433-37ec-4812-8e45-76fb7f0e696f
12	Placeholder Job 12	This is placeholder job number 12	2025-09-23 15:50:39.196572	d0c56433-37ec-4812-8e45-76fb7f0e696f
13	Placeholder Job 13	This is placeholder job number 13	2025-09-23 15:50:39.209963	d0c56433-37ec-4812-8e45-76fb7f0e696f
14	Placeholder Job 14	This is placeholder job number 14	2025-09-23 15:50:39.223436	d0c56433-37ec-4812-8e45-76fb7f0e696f
15	Placeholder Job 15	This is placeholder job number 15	2025-09-23 15:50:39.236588	d0c56433-37ec-4812-8e45-76fb7f0e696f
16	Placeholder Job 16	This is placeholder job number 16	2025-09-23 15:50:39.250412	d0c56433-37ec-4812-8e45-76fb7f0e696f
17	Placeholder Job 17	This is placeholder job number 17	2025-09-23 15:50:39.263769	d0c56433-37ec-4812-8e45-76fb7f0e696f
18	Placeholder Job 18	This is placeholder job number 18	2025-09-23 15:50:39.277297	d0c56433-37ec-4812-8e45-76fb7f0e696f
19	Placeholder Job 19	This is placeholder job number 19	2025-09-23 15:50:39.291413	d0c56433-37ec-4812-8e45-76fb7f0e696f
20	Placeholder Job 20	This is placeholder job number 20	2025-09-23 15:50:39.306695	d0c56433-37ec-4812-8e45-76fb7f0e696f
21	Placeholder Job 21	This is placeholder job number 21	2025-09-23 15:50:39.321031	d0c56433-37ec-4812-8e45-76fb7f0e696f
22	Placeholder Job 22	This is placeholder job number 22	2025-09-23 15:50:39.333939	d0c56433-37ec-4812-8e45-76fb7f0e696f
23	Placeholder Job 23	This is placeholder job number 23	2025-09-23 15:50:39.3469	d0c56433-37ec-4812-8e45-76fb7f0e696f
24	Placeholder Job 24	This is placeholder job number 24	2025-09-23 15:50:39.361124	d0c56433-37ec-4812-8e45-76fb7f0e696f
25	Placeholder Job 25	This is placeholder job number 25	2025-09-23 15:50:39.374128	d0c56433-37ec-4812-8e45-76fb7f0e696f
26	Placeholder Job 26	This is placeholder job number 26	2025-09-23 15:50:39.388308	d0c56433-37ec-4812-8e45-76fb7f0e696f
27	Placeholder Job 27	This is placeholder job number 27	2025-09-23 15:50:39.401073	d0c56433-37ec-4812-8e45-76fb7f0e696f
28	Placeholder Job 28	This is placeholder job number 28	2025-09-23 15:50:39.413827	d0c56433-37ec-4812-8e45-76fb7f0e696f
29	Placeholder Job 29	This is placeholder job number 29	2025-09-23 15:50:39.427416	d0c56433-37ec-4812-8e45-76fb7f0e696f
30	Placeholder Job 30	This is placeholder job number 30	2025-09-23 15:50:39.441341	d0c56433-37ec-4812-8e45-76fb7f0e696f
31	Placeholder Job 31	This is placeholder job number 31	2025-09-23 15:50:39.455551	d0c56433-37ec-4812-8e45-76fb7f0e696f
32	Placeholder Job 32	This is placeholder job number 32	2025-09-23 15:50:39.467702	d0c56433-37ec-4812-8e45-76fb7f0e696f
33	Placeholder Job 33	This is placeholder job number 33	2025-09-23 15:50:39.481004	d0c56433-37ec-4812-8e45-76fb7f0e696f
34	Placeholder Job 34	This is placeholder job number 34	2025-09-23 15:50:39.493897	d0c56433-37ec-4812-8e45-76fb7f0e696f
35	Placeholder Job 35	This is placeholder job number 35	2025-09-23 15:50:39.506956	d0c56433-37ec-4812-8e45-76fb7f0e696f
36	Placeholder Job 36	This is placeholder job number 36	2025-09-23 15:50:39.520267	d0c56433-37ec-4812-8e45-76fb7f0e696f
37	Placeholder Job 37	This is placeholder job number 37	2025-09-23 15:50:39.533971	d0c56433-37ec-4812-8e45-76fb7f0e696f
38	Placeholder Job 38	This is placeholder job number 38	2025-09-23 15:50:39.546611	d0c56433-37ec-4812-8e45-76fb7f0e696f
39	Placeholder Job 39	This is placeholder job number 39	2025-09-23 15:50:39.560403	d0c56433-37ec-4812-8e45-76fb7f0e696f
40	Placeholder Job 40	This is placeholder job number 40	2025-09-23 15:50:39.573881	d0c56433-37ec-4812-8e45-76fb7f0e696f
41	Neue job	das ist eine sehr gute job	2025-09-23 20:47:09.071461	d0c56433-37ec-4812-8e45-76fb7f0e696f
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, chat_room_id, sender_id, content, "timestamp") FROM stdin;
1	1	d0c56433-37ec-4812-8e45-76fb7f0e696f	hallo	2025-09-23 17:55:00.414096
2	1	d0c56433-37ec-4812-8e45-76fb7f0e696f	job	2025-09-23 17:57:19.642217
3	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	hehe	2025-09-23 18:39:36.551282
4	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	test	2025-09-23 18:46:10.797204
5	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	test nochmal	2025-09-23 18:47:27.364098
6	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	test nochmal	2025-09-23 18:47:30.515002
7	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	ta	2025-09-23 18:48:56.313287
8	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	te	2025-09-23 18:49:09.361431
9	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	te	2025-09-23 18:50:22.275547
10	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	te	2025-09-23 18:50:28.924073
11	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	dd	2025-09-23 18:56:18.542033
12	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	afa	2025-09-23 18:56:43.409312
13	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	qew	2025-09-23 19:05:03.878718
14	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	qewssa	2025-09-23 19:05:25.170703
15	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	ws	2025-09-23 19:09:21.324437
16	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	q	2025-09-23 19:11:35.889727
17	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	qqqq	2025-09-23 19:12:15.548453
18	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	qqqqkk	2025-09-23 19:23:27.650774
19	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	zzzuz	2025-09-23 19:24:21.208826
20	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	wewwwew	2025-09-23 19:25:16.460353
21	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	oooo	2025-09-23 19:26:21.508198
22	2	d0c56433-37ec-4812-8e45-76fb7f0e696f	lplpl	2025-09-23 19:31:46.178411
23	2	238e2985-b3ec-4b41-a98b-275492f9bac4	qweqw	2025-09-23 19:42:58.069978
24	3	d0c56433-37ec-4812-8e45-76fb7f0e696f	12th job	2025-09-23 20:15:43.125808
25	3	238e2985-b3ec-4b41-a98b-275492f9bac4	hallo	2025-09-23 20:16:15.10014
\.


--
-- Data for Name: template; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.template (id, type, name, structure, created_by) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, role) FROM stdin;
d0c56433-37ec-4812-8e45-76fb7f0e696f	emp@gmail.com	employer
238e2985-b3ec-4b41-a98b-275492f9bac4	see@gmail.com	seeker
\.


--
-- Name: application_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.application_id_seq', 8, true);


--
-- Name: chatparticipant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chatparticipant_id_seq', 6, true);


--
-- Name: chatroom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chatroom_id_seq', 3, true);


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_id_seq', 41, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_seq', 25, true);


--
-- Name: template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.template_id_seq', 1, false);


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);


--
-- Name: chatparticipant chatparticipant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatparticipant
    ADD CONSTRAINT chatparticipant_pkey PRIMARY KEY (id);


--
-- Name: chatroom chatroom_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatroom
    ADD CONSTRAINT chatroom_pkey PRIMARY KEY (id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: template template_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT template_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: ix_user_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_user_role ON public."user" USING btree (role);


--
-- Name: application application_chat_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_chat_room_id_fkey FOREIGN KEY (chat_room_id) REFERENCES public.chatroom(id);


--
-- Name: application application_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job(id);


--
-- Name: application application_seeker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_seeker_id_fkey FOREIGN KEY (seeker_id) REFERENCES public."user"(id);


--
-- Name: chatparticipant chatparticipant_chat_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatparticipant
    ADD CONSTRAINT chatparticipant_chat_room_id_fkey FOREIGN KEY (chat_room_id) REFERENCES public.chatroom(id);


--
-- Name: chatparticipant chatparticipant_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatparticipant
    ADD CONSTRAINT chatparticipant_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: job job_employer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_employer_id_fkey FOREIGN KEY (employer_id) REFERENCES public."user"(id);


--
-- Name: message message_chat_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_chat_room_id_fkey FOREIGN KEY (chat_room_id) REFERENCES public.chatroom(id);


--
-- Name: message message_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public."user"(id);


--
-- Name: template template_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT template_created_by_fkey FOREIGN KEY (created_by) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 0q8nvSzk0BNUvSu7f4kjuYQIE0AhdUAiIpPS8w0Fwp4EBMjDIaj4ZqXfXURfYze

