

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

INSERT INTO public.polls (id, name, created_at, is_released) VALUES ('8528f30e-ea61-4db7-b2ca-7806532f8e3f', 'Most adorable pet', '2021-10-19 01:11:16.894597-07', false);
INSERT INTO public.polls (id, name, created_at, is_released) VALUES ('e9078ecb-f1e4-4b96-88a5-bb19f6415935', 'Best song', '2021-10-19 22:02:46.757796-07', false);
INSERT INTO public.polls (id, name, created_at, is_released) VALUES ('b0dfa5a5-f51a-42c6-82ca-5a1df390054b', 'Best movies', '2021-10-19 01:11:16.895669-07', true);


ALTER TABLE public.polls ENABLE TRIGGER ALL;


ALTER TABLE public.options DISABLE TRIGGER ALL;

INSERT INTO public.options (id, option_label, poll_id, created_at) VALUES ('33e26116-ebdd-4668-b068-f38cb260cc1f', 'movie 1', 'b0dfa5a5-f51a-42c6-82ca-5a1df390054b', '2021-10-19 01:46:34.271083-07');
INSERT INTO public.options (id, option_label, poll_id, created_at) VALUES ('7a4a0335-32bb-4c9f-9eba-e3e0fd9e5f36', 'movie 2', 'b0dfa5a5-f51a-42c6-82ca-5a1df390054b', '2021-10-19 01:47:02.287218-07');
INSERT INTO public.options (id, option_label, poll_id, created_at) VALUES ('eb1a8156-faad-496b-8a1a-a2c193ffa9ac', 'movie 3', 'b0dfa5a5-f51a-42c6-82ca-5a1df390054b', '2021-10-19 01:52:18.655924-07');
INSERT INTO public.options (id, option_label, poll_id, created_at) VALUES ('a411c4dd-9d78-4929-bfc5-fd357fc6d467', 'e', 'b0dfa5a5-f51a-42c6-82ca-5a1df390054b', '2021-10-19 02:03:51.089054-07');


ALTER TABLE public.options ENABLE TRIGGER ALL;


ALTER TABLE public.votes DISABLE TRIGGER ALL;



ALTER TABLE public.votes ENABLE TRIGGER ALL;


ALTER TABLE public.ranks DISABLE TRIGGER ALL;



ALTER TABLE public.ranks ENABLE TRIGGER ALL;


