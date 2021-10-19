

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



ALTER TABLE public.polls ENABLE TRIGGER ALL;


ALTER TABLE public.options DISABLE TRIGGER ALL;



ALTER TABLE public.options ENABLE TRIGGER ALL;


ALTER TABLE public.votes DISABLE TRIGGER ALL;



ALTER TABLE public.votes ENABLE TRIGGER ALL;


