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

CREATE TABLE public.auction (
    id bigint NOT NULL,
    category_id bigint,
    status_id integer,
    start_time timestamp without time zone NOT NULL,
    finish_time timestamp without time zone NOT NULL,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.auction OWNER TO admin;

CREATE SEQUENCE public.auction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auction_id_seq OWNER TO admin;

ALTER SEQUENCE public.auction_id_seq OWNED BY public.auction.id;


CREATE TABLE public.auction_photo (
    id bigint NOT NULL,
    photo_id bigint,
    auction_id bigint,
    status_id integer NOT NULL,
    last_bid_amount numeric(10,2),
    start_time timestamp without time zone NOT NULL,
    finish_time timestamp without time zone NOT NULL,
    current_winner_order integer,
    winner_user_id_1 bigint,
    winner_user_id_2 bigint,
    winner_user_id_3 bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.auction_photo OWNER TO admin;

CREATE SEQUENCE public.auction_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auction_photo_id_seq OWNER TO admin;

ALTER SEQUENCE public.auction_photo_id_seq OWNED BY public.auction_photo.id;


CREATE TABLE public.bid (
    id bigint NOT NULL,
    bid_amount numeric(10,2) NOT NULL,
    user_id bigint,
    auction_photo_id bigint,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.bid OWNER TO admin;

CREATE SEQUENCE public.bid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bid_id_seq OWNER TO admin;

ALTER SEQUENCE public.bid_id_seq OWNED BY public.bid.id;


CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    status_id integer,
    address character varying(255) NOT NULL,
    location_id bigint,
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


CREATE TABLE public.config (
    id integer NOT NULL,
    voter_comission_percentage numeric(10,2) NOT NULL,
    photographer_comission_percentage numeric(10,2) NOT NULL,
    photos_to_auction_percentage numeric(10,2) NOT NULL,
    is_timer_job_active boolean NOT NULL
);


ALTER TABLE public.config OWNER TO admin;

CREATE SEQUENCE public.config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.config_id_seq OWNER TO admin;

ALTER SEQUENCE public.config_id_seq OWNED BY public.config.id;


CREATE TABLE public.cron (
    id bigint NOT NULL,
    unit character(1) NOT NULL,
    "interval" integer NOT NULL,
    last_trigger_time timestamp without time zone,
    name character varying NOT NULL,
    next_trigger_time timestamp without time zone
);


ALTER TABLE public.cron OWNER TO admin;

CREATE SEQUENCE public.cron_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cron_id_seq OWNER TO admin;

ALTER SEQUENCE public.cron_id_seq OWNED BY public.cron.id;


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


CREATE TABLE public.notification (
    id bigint NOT NULL,
    sent_by_user_id bigint NOT NULL,
    sent_to_user_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    message character varying(255) NOT NULL,
    seen_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.notification OWNER TO admin;

CREATE SEQUENCE public.notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_id_seq OWNER TO admin;

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


CREATE TABLE public.photo (
    id bigint NOT NULL,
    file_path character varying(100),
    title character varying(100),
    user_id bigint,
    auction_id bigint,
    location_id bigint,
    category_id bigint,
    status_id integer,
    is_auctionable boolean NOT NULL,
    device_info character varying(255) NOT NULL,
    vote_count integer NOT NULL,
    purchase_now_price numeric(10,2),
    purchased_at timestamp without time zone,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.photo OWNER TO admin;

CREATE SEQUENCE public.photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photo_id_seq OWNER TO admin;

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


CREATE TABLE public.photographer_payment (
    id bigint NOT NULL,
    user_id bigint,
    status_id integer,
    payment_amount numeric(10,2) NOT NULL
);


ALTER TABLE public.photographer_payment OWNER TO admin;

CREATE SEQUENCE public.photographer_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.photographer_payment_id_seq OWNER TO admin;

ALTER SEQUENCE public.photographer_payment_id_seq OWNED BY public.photographer_payment.id;


CREATE TABLE public.purchased_photo (
    id bigint NOT NULL,
    photo_id bigint,
    user_id bigint,
    payment_amount numeric(10,2) NOT NULL
);


ALTER TABLE public.purchased_photo OWNER TO admin;

CREATE SEQUENCE public.purchased_photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchased_photo_id_seq OWNER TO admin;

ALTER SEQUENCE public.purchased_photo_id_seq OWNED BY public.purchased_photo.id;


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
    gmail_id character varying(100),
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    email_verified boolean NOT NULL default false,
    password character varying(255) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    tc_identity_no character varying(11),
    profile_picture text,
    role_id bigint,
    status_id integer,
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


CREATE SEQUENCE public.user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_role_id_seq OWNER TO admin;

ALTER SEQUENCE public.user_role_id_seq OWNED BY public."user".role_id;


CREATE TABLE public.user_role (
    id bigint DEFAULT nextval('public.user_role_id_seq'::regclass) NOT NULL,
    role character varying(100) NOT NULL
);


ALTER TABLE public.user_role OWNER TO admin;

CREATE TABLE public.vote (
    id bigint NOT NULL,
    auction_id bigint,
    user_id bigint,
    photo_id bigint,
    status_id integer,
    transfer_amount numeric(10,2)
);


ALTER TABLE public.vote OWNER TO admin;

CREATE SEQUENCE public.vote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vote_id_seq OWNER TO admin;

ALTER SEQUENCE public.vote_id_seq OWNED BY public.vote.id;


ALTER TABLE ONLY public.auction ALTER COLUMN id SET DEFAULT nextval('public.auction_id_seq'::regclass);


ALTER TABLE ONLY public.auction_photo ALTER COLUMN id SET DEFAULT nextval('public.auction_photo_id_seq'::regclass);


ALTER TABLE ONLY public.bid ALTER COLUMN id SET DEFAULT nextval('public.bid_id_seq'::regclass);


ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


ALTER TABLE ONLY public.config ALTER COLUMN id SET DEFAULT nextval('public.config_id_seq'::regclass);


ALTER TABLE ONLY public.cron ALTER COLUMN id SET DEFAULT nextval('public.cron_id_seq'::regclass);


ALTER TABLE ONLY public.location ALTER COLUMN id SET DEFAULT nextval('public.location_id_seq'::regclass);


ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


ALTER TABLE ONLY public.photographer_payment ALTER COLUMN id SET DEFAULT nextval('public.photographer_payment_id_seq'::regclass);


ALTER TABLE ONLY public.purchased_photo ALTER COLUMN id SET DEFAULT nextval('public.purchased_photo_id_seq'::regclass);


ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


ALTER TABLE ONLY public.vote ALTER COLUMN id SET DEFAULT nextval('public.vote_id_seq'::regclass);


COPY public.auction (id, category_id, status_id, start_time, finish_time, is_deleted, created_at, updated_at) FROM stdin;
\.


COPY public.auction_photo (id, photo_id, auction_id, status_id, last_bid_amount, start_time, finish_time, current_winner_order, winner_user_id_1, winner_user_id_2, winner_user_id_3, created_at, updated_at) FROM stdin;
\.


COPY public.bid (id, bid_amount, user_id, auction_photo_id, created_at) FROM stdin;
\.


COPY public.category (id, name, status_id, address, location_id, valid_radius, is_deleted, created_at, updated_at) FROM stdin;
1	Eiffel Tower 	2	France, Paris	1	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
2	Santorini	2	Greece, Santorini	2	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
3	Banff National Park	2	Canada, Alberta	3	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
4	Fushimi Inari Shrine	2	Japan, Kyoto	4	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
5	Hallstatt	2	Austria, Hallstatt	5	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
6	Burj Khalifa	2	UAE, Dubai	6	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
7	Colosseum	2	Italy, Rome	7	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
8	Taj Mahal	2	India, Agra	8	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
9	Pamukkale	2	Turkey, Denizli	9	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
10	CTIS	2	Turkey, Bilkent	10	10.0	f	2025-01-16 10:00:00	2025-01-16 10:00:00
\.


COPY public.config (id, voter_comission_percentage, photographer_comission_percentage, photos_to_auction_percentage, is_timer_job_active) FROM stdin;
1	20.00	50.00	50.00	t
\.


COPY public.cron (id, unit, "interval", last_trigger_time, name, next_trigger_time) FROM stdin;
1	d	5	\N	timer-starter	\N
2	d	5	\N	timer-vote	\N
3	d	1	\N	timer-auction	\N
4	h	6	\N	timer-purchase-after-auction	\N
\.


COPY public.location (id, latitude, longitude) FROM stdin;
1	48.8584	2.2945
2	36.3932	25.4615
3	51.4968	-115.9281
4	34.9671	135.7727
5	47.5613	13.6493
6	25.1972	55.2744
7	41.8902	12.4922
8	27.1751	78.0421
9	37.9137	29.1187
10	39.8714	32.7641
\.


COPY public.notification (id, sent_by_user_id, sent_to_user_id, type, message, seen_at, created_at, updated_at) FROM stdin;
\.


COPY public.photo (id, file_path, title, user_id, auction_id, location_id, category_id, status_id, is_auctionable, device_info, vote_count, purchase_now_price, purchased_at, is_deleted, created_at, updated_at) FROM stdin;
1	git_eiffel1.jpg	Eiffel Tower	2	\N	1	1	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
2	git_eiffel2.jpg	Eiffel Tower	2	\N	1	1	7	f	Samsung 527D9XQL0 (Android 14)	0	200	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
3	git_eiffel3.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
4	git_eiffel4.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
5	git_eiffel5.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
6	git_eiffel6.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
7	git_eiffel7.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
8	git_eiffel8.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
9	git_eiffel9.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
10	git_eiffel10.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
11	git_eiffel11.jpg	Eiffel Tower	2	\N	1	1	2	t	Iphone14 11VU5PCD8	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
12	git_santorini1.jpg	Santorini	2	\N	2	2	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
13	git_santorini2.jpg	Santorini	2	\N	2	2	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
14	git_banff1.jpg	Banff	2	\N	3	3	7	f	Xiaomi 23049PCD8G (Android 14)	0	300	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
15	git_banff2.jpg	Banff	2	\N	3	3	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
16	git_banff3.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
17	git_banff4.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
18	git_banff5.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
19	git_banff6.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
20	git_banff7.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
21	git_banff8.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
22	git_banff9.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
23	git_banff10.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
24	git_banff11.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
25	git_banff12.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
26	git_banff13.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
27	git_banff14.jpg	Banff	2	\N	3	3	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
28	git_fushimi1.jpg	Fushimi	2	\N	4	4	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
29	git_fushimi2.jpg	Fushimi	2	\N	4	4	2	t	Xiaomi 23049PCD8G (Android 14)	0	\N	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
30	git_hallstatt1.jpg	Hallstatt	2	\N	5	5	7	f	Xiaomi 23049PCD8G (Android 14)	0	300	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
31	git_hallstatt2.jpg	Hallstatt	2	\N	5	5	7	f	Xiaomi 23049PCD8G (Android 14)	0	200	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
32	git_khalifa1.jpg	Khalifa	2	\N	6	6	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
33	git_khalifa2.jpg	Khalifa	2	\N	6	6	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
34	git_colosseum1.jpg	Colosseum	2	\N	7	7	7	f	Xiaomi 23049PCD8G (Android 14)	0	50	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
35	git_colosseum2.jpg	Colosseum	2	\N	7	7	7	f	Xiaomi 23049PCD8G (Android 14)	0	50	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
36	git_taj1.jpg	Taj	12	\N	2	8	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
37	git_taj2.jpg	Taj	13	\N	2	8	7	f	Xiaomi 23049PCD8G (Android 14)	0	200	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
38	git_pamukkale1.jpg	Pamukkale	2	\N	9	9	7	f	Xiaomi 23049PCD8G (Android 14)	0	50	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
39	git_pamukkale2.jpg	Pamukkale	2	\N	9	9	7	f	Xiaomi 23049PCD8G (Android 14)	0	200	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
40	git_ctis1.jpg	CTIS	2	\N	10	10	7	f	Xiaomi 23049PCD8G (Android 14)	0	50	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
41	git_ctis2.jpg	CTIS	2	\N	10	10	7	f	Xiaomi 23049PCD8G (Android 14)	0	100	\N	f	2025-05-03 21:57:15.2	2025-05-03 21:57:15.2
\.


COPY public.photographer_payment (id, user_id, status_id, payment_amount) FROM stdin;
\.


COPY public.purchased_photo (id, photo_id, user_id, payment_amount) FROM stdin;
\.


COPY public.status (id, status) FROM stdin;
1	wait
2	approve
3	reject
4	upload
5	vote
6	auction
7	purchasable
8	finish
9	sold
10	wait_purchase_after_auction
11	banned
12	active
\.


COPY public."user" (id, gmail_id, username, email, email_verified, password, first_name, last_name, tc_identity_no, profile_picture, role_id, status_id, is_deleted, created_at, updated_at) FROM stdin;
1	\N	Admin User	admin@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Admin	Admin	\N	https://gravatar.com/avatar/0cd54fff7e0533dbfc333a4eb0cb817d?s=400&d=identicon&r=x	1	\N	f	2025-01-16 09:00:00	2025-01-16 09:00:00
2	\N	Photographer User	photographer@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Photographer	User	\N	https://gravatar.com/avatar/50139ca6519a0125bd983d290a552524?s=400&d=identicon&r=x	2	\N	f	2025-01-16 09:30:00	2025-01-16 09:30:00
3	\N	Company User	company@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Company	User	\N	https://gravatar.com/avatar/ce66042e297c35ead95356df002aece7?s=400&d=identicon&r=x	3	\N	f	2025-01-16 10:00:00	2025-01-16 10:00:00
4	\N	Validator User	validator@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Validator	Validator	\N	https://gravatar.com/avatar/24296862ce0ebafd34a4b4f5ebf05d7a?s=400&d=identicon&r=x	4	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
5	\N	Auction 1	auction1@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Auction	1	\N	https://gravatar.com/avatar/764f3cba4d2ce9fee9bba4395616d738?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
6	\N	Auction 2	auction2@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Auction	2	\N	https://gravatar.com/avatar/4e95255d11df40e8a87f4d6eb84730f4?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
7	\N	Auction 3	auction3@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Auction	3	\N	https://gravatar.com/avatar/44f110cb40ff1fddb1008ec526553c84?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
8	\N	Purchase 1	purchase1@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Purchase	1	\N	https://gravatar.com/avatar/f6f154a36eda0f4485411bf7f0914421?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
9	\N	Purchase 2	purchase2@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Purchase	2	\N	https://gravatar.com/avatar/26cc7e121419291b988d79d9e9f28359?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
10	\N	Purchase 3	purchase3@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Purchase	3	\N	https://gravatar.com/avatar/ecd371efa49b48a26bb41d126bbc7243?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
11	\N	Vote 1	vote1@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Vote	1	\N	https://gravatar.com/avatar/3e5caf166534571be450835a1930efa2?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
12	\N	Vote 2	vote2@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Vote	2	\N	https://gravatar.com/avatar/f74cc42412cba6d4e0c6728e9a695848?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
13	\N	Vote 3	vote3@staucktion.com.tr	true	$2b$10$pca7VYVzHkuDgBk.mQ16bOBzRWLnuPFSH4QbNwkeAFiXWzEwh.xPa	Vote	3	\N	https://gravatar.com/avatar/ee6c7792bdfe42bbdabd45aebb82518d?s=400&d=identicon&r=x	\N	\N	f	2025-01-16 10:30:00	2025-01-16 10:30:00
\.


COPY public.user_role (id, role) FROM stdin;
1	admin
2	photographer
3	company
4	validator
\.


COPY public.vote (id, auction_id, user_id, photo_id, status_id, transfer_amount) FROM stdin;
\.


SELECT pg_catalog.setval('public.auction_id_seq', 1, false);


SELECT pg_catalog.setval('public.auction_photo_id_seq', 1, false);


SELECT pg_catalog.setval('public.bid_id_seq', 1, false);


SELECT pg_catalog.setval('public.category_id_seq', 11, false);


SELECT pg_catalog.setval('public.config_id_seq', 1, true);


SELECT pg_catalog.setval('public.cron_id_seq', 4, true);


SELECT pg_catalog.setval('public.location_id_seq', 11, false);


SELECT pg_catalog.setval('public.notification_id_seq', 1, false);


SELECT pg_catalog.setval('public.photo_id_seq', 42, false);


SELECT pg_catalog.setval('public.photographer_payment_id_seq', 1, false);


SELECT pg_catalog.setval('public.purchased_photo_id_seq', 1, false);


SELECT pg_catalog.setval('public.status_id_seq', 13, false);


SELECT pg_catalog.setval('public.user_id_seq', 14, false);


SELECT pg_catalog.setval('public.user_role_id_seq', 5, false);


SELECT pg_catalog.setval('public.vote_id_seq', 1, false);


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_name_key UNIQUE (name);


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.cron
    ADD CONSTRAINT cron_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.photographer_payment
    ADD CONSTRAINT photographer_payment_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.purchased_photo
    ADD CONSTRAINT purchased_photo_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT user_role_role_key UNIQUE (role);


ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_pkey PRIMARY KEY (id);


CREATE INDEX notification_sent_to_user_id_seen_at_idx ON public.notification USING btree (sent_to_user_id, seen_at);


ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_auction_id_fkey FOREIGN KEY (auction_id) REFERENCES public.auction(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_winner_user_id_1_fkey FOREIGN KEY (winner_user_id_1) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_winner_user_id_2_fkey FOREIGN KEY (winner_user_id_2) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction_photo
    ADD CONSTRAINT auction_photo_winner_user_id_3_fkey FOREIGN KEY (winner_user_id_3) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_auction_photo_id_fkey FOREIGN KEY (auction_photo_id) REFERENCES public.auction_photo(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_sent_by_user_id_fkey FOREIGN KEY (sent_by_user_id) REFERENCES public."user"(id);


ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_sent_to_user_id_fkey FOREIGN KEY (sent_to_user_id) REFERENCES public."user"(id);


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_auction_id_fkey FOREIGN KEY (auction_id) REFERENCES public.auction(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.location(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photographer_payment
    ADD CONSTRAINT photographer_payment_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.photographer_payment
    ADD CONSTRAINT photographer_payment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.purchased_photo
    ADD CONSTRAINT purchased_photo_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.purchased_photo
    ADD CONSTRAINT purchased_photo_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.user_role(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_auction_id_fkey FOREIGN KEY (auction_id) REFERENCES public.auction(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.vote
    ADD CONSTRAINT vote_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE SET NULL NOT VALID;


