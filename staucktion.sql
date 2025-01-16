--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-16 17:04:05 UTC

DO $$ 
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'staucktion' AND pid <> pg_backend_pid();
END;
$$;


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS staucktion;
--
-- TOC entry 3432 (class 1262 OID 26763)
-- Name: staucktion; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE staucktion WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE staucktion OWNER TO admin;

\connect staucktion

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 232 (class 1259 OID 26829)
-- Name: category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    address character varying(255) NOT NULL,
    location_id bigint NOT NULL,
    valid_radius numeric(10,2) NOT NULL
);


ALTER TABLE public.category OWNER TO admin;

--
-- TOC entry 231 (class 1259 OID 26828)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO admin;

--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 231
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- TOC entry 230 (class 1259 OID 26822)
-- Name: location; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.location (
    id bigint NOT NULL,
    latitude character varying(100) NOT NULL,
    longitude character varying(100) NOT NULL
);


ALTER TABLE public.location OWNER TO admin;

--
-- TOC entry 229 (class 1259 OID 26821)
-- Name: location_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.location_id_seq OWNER TO admin;

--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 229
-- Name: location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.location_id_seq OWNED BY public.location.id;


--
-- TOC entry 226 (class 1259 OID 26803)
-- Name: photo; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.photo (
    id bigint NOT NULL,
    title character varying(100),
    user_id bigint NOT NULL,
    location_id bigint NOT NULL,
    category_id bigint NOT NULL,
    status_id integer NOT NULL,
    status_message character varying(255) NOT NULL,
    device_info character varying(255) NOT NULL,
    is_deleted boolean NOT NULL,
    created_at time without time zone NOT NULL,
    updated_at time without time zone NOT NULL
);


ALTER TABLE public.photo OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 26802)
-- Name: photo_category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.photo_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_category_id_seq OWNER TO admin;

--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 225
-- Name: photo_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.photo_category_id_seq OWNED BY public.photo.category_id;


--
-- TOC entry 222 (class 1259 OID 26799)
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_id_seq OWNER TO admin;

--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 222
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- TOC entry 224 (class 1259 OID 26801)
-- Name: photo_location_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.photo_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_location_id_seq OWNER TO admin;

--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 224
-- Name: photo_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.photo_location_id_seq OWNED BY public.photo.location_id;


--
-- TOC entry 223 (class 1259 OID 26800)
-- Name: photo_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.photo_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_user_id_seq OWNER TO admin;

--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 223
-- Name: photo_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.photo_user_id_seq OWNED BY public.photo.user_id;


--
-- TOC entry 228 (class 1259 OID 26815)
-- Name: status; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.status (
    id integer NOT NULL,
    status character varying(100) NOT NULL
);


ALTER TABLE public.status OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 26814)
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_id_seq OWNER TO admin;

--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 227
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- TOC entry 219 (class 1259 OID 26766)
-- Name: user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."user" (
    id bigint NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    role_id integer,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public."user" OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 26764)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO admin;

--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 221 (class 1259 OID 26776)
-- Name: user_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_role (
    id bigint NOT NULL,
    role character varying(100) NOT NULL
);


ALTER TABLE public.user_role OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 26765)
-- Name: user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_id_seq OWNER TO admin;

--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_role_id_seq OWNED BY public."user".role_id;


--
-- TOC entry 220 (class 1259 OID 26775)
-- Name: user_role_id_seq1; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_role_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_id_seq1 OWNER TO admin;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_role_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_role_id_seq1 OWNED BY public.user_role.id;


--
-- TOC entry 3248 (class 2604 OID 26832)
-- Name: category id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- TOC entry 3247 (class 2604 OID 26825)
-- Name: location id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.location ALTER COLUMN id SET DEFAULT nextval('public.location_id_seq'::regclass);


--
-- TOC entry 3242 (class 2604 OID 26806)
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- TOC entry 3243 (class 2604 OID 26807)
-- Name: photo user_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo ALTER COLUMN user_id SET DEFAULT nextval('public.photo_user_id_seq'::regclass);


--
-- TOC entry 3244 (class 2604 OID 26808)
-- Name: photo location_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo ALTER COLUMN location_id SET DEFAULT nextval('public.photo_location_id_seq'::regclass);


--
-- TOC entry 3245 (class 2604 OID 26809)
-- Name: photo category_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo ALTER COLUMN category_id SET DEFAULT nextval('public.photo_category_id_seq'::regclass);


--
-- TOC entry 3246 (class 2604 OID 26818)
-- Name: status id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- TOC entry 3239 (class 2604 OID 26769)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 3240 (class 2604 OID 26770)
-- Name: user role_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user" ALTER COLUMN role_id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


--
-- TOC entry 3241 (class 2604 OID 26787)
-- Name: user_role id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq1'::regclass);


--
-- TOC entry 3426 (class 0 OID 26829)
-- Dependencies: 232
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.category (id, name, address, location_id, valid_radius) FROM stdin;
\.


--
-- TOC entry 3424 (class 0 OID 26822)
-- Dependencies: 230
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.location (id, latitude, longitude) FROM stdin;
\.


--
-- TOC entry 3420 (class 0 OID 26803)
-- Dependencies: 226
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.photo (id, title, user_id, location_id, category_id, status_id, status_message, device_info, is_deleted, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3422 (class 0 OID 26815)
-- Dependencies: 228
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.status (id, status) FROM stdin;
\.


--
-- TOC entry 3413 (class 0 OID 26766)
-- Dependencies: 219
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."user" (id, username, email, password, first_name, last_name, role_id, is_deleted, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3415 (class 0 OID 26776)
-- Dependencies: 221
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_role (id, role) FROM stdin;
\.


--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 231
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.category_id_seq', 1, false);


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 229
-- Name: location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.location_id_seq', 1, false);


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 225
-- Name: photo_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.photo_category_id_seq', 1, false);


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 222
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 224
-- Name: photo_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.photo_location_id_seq', 1, false);


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 223
-- Name: photo_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.photo_user_id_seq', 1, false);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 227
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_role_id_seq', 1, false);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_role_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_role_id_seq1', 1, false);


--
-- TOC entry 3260 (class 2606 OID 26834)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3258 (class 2606 OID 26827)
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 26813)
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 26820)
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 26774)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3252 (class 2606 OID 26789)
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- TOC entry 3262 (class 2606 OID 26840)
-- Name: photo photo_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3263 (class 2606 OID 26845)
-- Name: photo photo_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3264 (class 2606 OID 26850)
-- Name: photo photo_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3265 (class 2606 OID 26835)
-- Name: photo photo_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3261 (class 2606 OID 26790)
-- Name: user user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (id) REFERENCES public.user_role(id) ON DELETE SET NULL NOT VALID;


-- Completed on 2025-01-16 17:04:05 UTC

--
-- PostgreSQL database dump complete
--

