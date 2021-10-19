

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.polls DISABLE TRIGGER ALL;

INSERT INTO public.polls (id, name) VALUES ('8528f30e-ea61-4db7-b2ca-7806532f8e3f', 'Most adorable pet');
INSERT INTO public.polls (id, name) VALUES ('b0dfa5a5-f51a-42c6-82ca-5a1df390054b', 'Best movies');


ALTER TABLE public.polls ENABLE TRIGGER ALL;


ALTER TABLE public.options DISABLE TRIGGER ALL;



ALTER TABLE public.options ENABLE TRIGGER ALL;


ALTER TABLE public.votes DISABLE TRIGGER ALL;



ALTER TABLE public.votes ENABLE TRIGGER ALL;


ALTER TABLE public.ranks DISABLE TRIGGER ALL;



ALTER TABLE public.ranks ENABLE TRIGGER ALL;


