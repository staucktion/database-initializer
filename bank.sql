DO $$ 
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'bank' AND pid <> pg_backend_pid();
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

DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE bank OWNER TO admin;

\connect bank

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

CREATE TABLE public.account (
    id integer NOT NULL,
    balance numeric(15,2) NOT NULL,
    provision numeric(15,2) DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.account OWNER TO admin;

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_id_seq OWNER TO admin;

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


CREATE TABLE public.auditlog (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    performed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.auditlog OWNER TO admin;

CREATE SEQUENCE public.auditlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditlog_id_seq OWNER TO admin;

ALTER SEQUENCE public.auditlog_id_seq OWNED BY public.auditlog.id;


CREATE TABLE public.card (
    id integer NOT NULL,
    account_id integer NOT NULL,
    number character varying(16) NOT NULL,
    expiration_date character varying(5) NOT NULL,
    cvv character(3) NOT NULL
);


ALTER TABLE public.card OWNER TO admin;

CREATE SEQUENCE public.card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_id_seq OWNER TO admin;

ALTER SEQUENCE public.card_id_seq OWNED BY public.card.id;


CREATE TABLE public.transaction (
    id integer NOT NULL,
    sender_account_id integer,
    receiver_account_id integer,
    sender_card_id integer,
    amount numeric(15,2) NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description character varying(255)
);


ALTER TABLE public.transaction OWNER TO admin;

CREATE SEQUENCE public.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_id_seq OWNER TO admin;

ALTER SEQUENCE public.transaction_id_seq OWNED BY public.transaction.id;


ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


ALTER TABLE ONLY public.auditlog ALTER COLUMN id SET DEFAULT nextval('public.auditlog_id_seq'::regclass);


ALTER TABLE ONLY public.card ALTER COLUMN id SET DEFAULT nextval('public.card_id_seq'::regclass);


ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);


COPY public.account (id, balance, provision, created_at, updated_at) FROM stdin;
1	1000000.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
2	1000000.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
3	4380.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
4	98120.50	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
5	25000.25	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
6	100.50	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
7	56230.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
8	49000.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
9	83010.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
10	72650.00	0.00	2024-12-18 18:44:00	2024-12-18 18:44:00
\.


COPY public.auditlog (id, action, performed_at) FROM stdin;
\.


COPY public.card (id, account_id, number, expiration_date, cvv) FROM stdin;
1	1	1234567890123456	12/28	123
2	2	4539187690234512	04/29	678
3	2	5276903421876543	01/30	456
4	3	6011472890318427	02/28	890
5	3	4023567890123456	02/28	789
6	4	6304758910238745	01/30	321
7	5	371529834719257	07/28	654
8	6	371449635398431	11/30	987
9	7	6011111111111117	10/28	213
10	8	4112679820345698	05/29	432
11	9	6011839245671283	03/28	567
12	10	3056930009020004	06/29	876
\.


COPY public.transaction (id, sender_account_id, receiver_account_id, sender_card_id, amount, transaction_date, description) FROM stdin;
\.


SELECT pg_catalog.setval('public.account_id_seq', 11, false);


SELECT pg_catalog.setval('public.auditlog_id_seq', 1, false);


SELECT pg_catalog.setval('public.card_id_seq', 13, false);


SELECT pg_catalog.setval('public.transaction_id_seq', 1, false);


ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.auditlog
    ADD CONSTRAINT auditlog_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.card
    ADD CONSTRAINT unique_card_number UNIQUE (number);


ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id) ON DELETE CASCADE NOT VALID;


ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_receiver_account_id_fkey FOREIGN KEY (receiver_account_id) REFERENCES public.account(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_sender_account_id_fkey FOREIGN KEY (sender_account_id) REFERENCES public.account(id) ON DELETE SET NULL NOT VALID;


ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_sender_card_id_fkey FOREIGN KEY (sender_card_id) REFERENCES public.card(id) ON DELETE SET NULL NOT VALID;


