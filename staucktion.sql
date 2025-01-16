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

CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    status_id integer NOT NULL,
    address character varying(255) NOT NULL,
    location_id bigint NOT NULL,
    valid_radius numeric(10,1) NOT NULL,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.category OWNER TO admin;

CREATE SEQUENCE public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO admin;

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


CREATE TABLE public.location (
    id bigint NOT NULL,
    latitude character varying(100) NOT NULL,
    longitude character varying(100) NOT NULL
);


ALTER TABLE public.location OWNER TO admin;

CREATE SEQUENCE public.location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.location_id_seq OWNER TO admin;

ALTER SEQUENCE public.location_id_seq OWNED BY public.location.id;


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
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.photo OWNER TO admin;

CREATE SEQUENCE public.photo_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_category_id_seq OWNER TO admin;

ALTER SEQUENCE public.photo_category_id_seq OWNED BY public.photo.category_id;


CREATE SEQUENCE public.photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_id_seq OWNER TO admin;

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


CREATE SEQUENCE public.photo_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_location_id_seq OWNER TO admin;

ALTER SEQUENCE public.photo_location_id_seq OWNED BY public.photo.location_id;


CREATE SEQUENCE public.photo_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_user_id_seq OWNER TO admin;

ALTER SEQUENCE public.photo_user_id_seq OWNED BY public.photo.user_id;


CREATE TABLE public.status (
    id integer NOT NULL,
    status character varying(100) NOT NULL
);


ALTER TABLE public.status OWNER TO admin;

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_id_seq OWNER TO admin;

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


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

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO admin;

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


CREATE TABLE public.user_role (
    id bigint NOT NULL,
    role character varying(100) NOT NULL
);


ALTER TABLE public.user_role OWNER TO admin;

CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_id_seq OWNER TO admin;

ALTER SEQUENCE public.user_role_id_seq OWNED BY public."user".role_id;


CREATE SEQUENCE public.user_role_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_id_seq1 OWNER TO admin;

ALTER SEQUENCE public.user_role_id_seq1 OWNED BY public.user_role.id;


ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


ALTER TABLE ONLY public.location ALTER COLUMN id SET DEFAULT nextval('public.location_id_seq'::regclass);


ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


ALTER TABLE ONLY public.photo ALTER COLUMN user_id SET DEFAULT nextval('public.photo_user_id_seq'::regclass);


ALTER TABLE ONLY public.photo ALTER COLUMN location_id SET DEFAULT nextval('public.photo_location_id_seq'::regclass);


ALTER TABLE ONLY public.photo ALTER COLUMN category_id SET DEFAULT nextval('public.photo_category_id_seq'::regclass);


ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


ALTER TABLE ONLY public."user" ALTER COLUMN role_id SET DEFAULT nextval('public.user_role_id_seq'::regclass);


ALTER TABLE ONLY public.user_role ALTER COLUMN id SET DEFAULT nextval('public.user_role_id_seq1'::regclass);


COPY public.category (id, name, status_id, address, location_id, valid_radius, is_deleted, created_at, updated_at) FROM stdin;
1	Düden Şelalesi	2	Turkey, Antalya, Düden Park	1	10	false	2025-01-16 10:00:00	2025-01-16 10:00:00
2	Kız Kulesi	2	Turkey, Istanbul, Bosphorus	2	10	false	2025-01-16 10:30:00	2025-01-16 10:30:00
\.


COPY public.location (id, latitude, longitude) FROM stdin;
1	36.9097	30.7375
2	41.0084	29.0290
3	41.0085	29.0291
4	41.0085	29.0291
\.


COPY public.photo (id, title, user_id, location_id, category_id, status_id, status_message, device_info, is_deleted, created_at, updated_at) FROM stdin;
1	Awesome Düden	2	3	1	2	Photo approved for Düden location	Samsung S6	false	2025-01-16 11:00:00	2025-01-16 11:00:00
2	Beautiful Sunset at Düden	2	4	1	2	Photo approved for Düden location	Samsung S6	false	2025-01-16 12:00:00	2025-01-16 12:00:00
\.


COPY public.status (id, status) FROM stdin;
1	Waiting
2	Approved
3	Disapproved
\.


COPY public."user" (id, username, email, password, first_name, last_name, role_id, is_deleted, created_at, updated_at) FROM stdin;
1	admin_user	admin@gmail.com	secret	Admin	Admin	1	false	2025-01-16 09:00:00	2025-01-16 09:00:00
2	photographer_user	photographer@gmail.com	secret	Ahmet	Oğuz	2	false	2025-01-16 09:30:00	2025-01-16 09:30:00
3	company_user	company@gmail.com	secret	Ahmett	Oğuzz	3	false	2025-01-16 10:00:00	2025-01-16 10:00:00
4	validator_user	validator@gmail.com	secret	Ahmettt	Oğuzzz	4	false	2025-01-16 10:30:00	2025-01-16 10:30:00
\.


COPY public.user_role (id, role) FROM stdin;
1	Admin
2	Photographer
3	Company
4	Validator
\.


SELECT pg_catalog.setval('public.category_id_seq', 1, false);


SELECT pg_catalog.setval('public.location_id_seq', 1, false);


SELECT pg_catalog.setval('public.photo_category_id_seq', 1, false);


SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


SELECT pg_catalog.setval('public.photo_location_id_seq', 1, false);


SELECT pg_catalog.setval('public.photo_user_id_seq', 1, false);


SELECT pg_catalog.setval('public.status_id_seq', 1, false);


SELECT pg_catalog.setval('public.user_id_seq', 1, false);


SELECT pg_catalog.setval('public.user_role_id_seq', 1, false);


SELECT pg_catalog.setval('public.user_role_id_seq1', 1, false);


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_name_key UNIQUE (name);


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_key UNIQUE (role);


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (id) REFERENCES public.user_role(id) ON DELETE SET NULL NOT VALID;


