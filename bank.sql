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
1	1000000.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
2	1000000.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
3	4380.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
4	98120.50	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
5	25000.25	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
6	34560.50	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
7	56230.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
8	49000.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
9	83010.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
10	72650.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
\.


COPY public.auditlog (id, action, performed_at) FROM stdin;
\.


COPY public.card (id, account_id, number, expiration_date, cvv) FROM stdin;
1	1	4242424242424242	12/25	123
2	2	4000056655665556	04/26	678
3	2	5555555555554444	01/25	456
4	3	2223003122003222	02/27	890
5	3	5200828282828210	02/26	789
6	4	5105105105105100	01/25	321
7	5	378282246310005	07/26	654
8	6	371449635398431	11/27	987
9	7	6011111111111117	10/27	213
10	8	6011000990139424	05/27	432
11	9	6011981111111113	03/28	567
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


