--
-- PostgreSQL database dump
--

-- Dumped from database version 10.7
-- Dumped by pg_dump version 10.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    author_id uuid NOT NULL,
    gist_id uuid NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    body text NOT NULL
);


--
-- Name: forks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forks (
    forked_from_id uuid NOT NULL,
    forked_to_id uuid NOT NULL
);


--
-- Name: gists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gists (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    author_id uuid NOT NULL,
    created_at timestamp without time zone,
    description text,
    private_gist boolean DEFAULT true NOT NULL
);


--
-- Name: gists_revisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gists_revisions (
    gist_id uuid NOT NULL,
    revision_id uuid NOT NULL
);


--
-- Name: revisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.revisions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    author_id uuid NOT NULL,
    created_at timestamp without time zone,
    diff text NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    filename text NOT NULL
);


--
-- Name: stars; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stars (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    gist_id uuid NOT NULL,
    created_at timestamp without time zone
);


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscriptions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    subscriber_id uuid NOT NULL,
    gist_id uuid NOT NULL,
    created_at timestamp without time zone
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone,
    password text NOT NULL,
    handle public.citext NOT NULL,
    display_name text NOT NULL
);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: forks forks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forks
    ADD CONSTRAINT forks_pkey PRIMARY KEY (forked_from_id, forked_to_id);


--
-- Name: gists gists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gists
    ADD CONSTRAINT gists_pkey PRIMARY KEY (id);


--
-- Name: gists_revisions gists_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gists_revisions
    ADD CONSTRAINT gists_revisions_pkey PRIMARY KEY (gist_id, revision_id);


--
-- Name: revisions revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: stars stars_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: forks_forked_from_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX forks_forked_from_id_index ON public.forks USING btree (forked_from_id);


--
-- Name: forks_forked_to_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX forks_forked_to_id_index ON public.forks USING btree (forked_to_id);


--
-- Name: gists_author_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gists_author_id_index ON public.gists USING btree (author_id);


--
-- Name: gists_revisions_gist_id_revision_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX gists_revisions_gist_id_revision_id_index ON public.gists_revisions USING btree (gist_id, revision_id);


--
-- Name: revisions_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX revisions_created_at_index ON public.revisions USING btree (created_at);


--
-- Name: stars_gist_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stars_gist_id_index ON public.stars USING btree (gist_id);


--
-- Name: stars_user_id_gist_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX stars_user_id_gist_id_index ON public.stars USING btree (user_id, gist_id);


--
-- Name: subscriptions_gist_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX subscriptions_gist_id_index ON public.subscriptions USING btree (gist_id);


--
-- Name: subscriptions_subscriber_id_gist_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX subscriptions_subscriber_id_gist_id_index ON public.subscriptions USING btree (subscriber_id, gist_id);


--
-- Name: users_handle_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_handle_index ON public.users USING btree (handle);


--
-- Name: comments comments_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: comments comments_gist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_gist_id_fkey FOREIGN KEY (gist_id) REFERENCES public.gists(id);


--
-- Name: forks forks_forked_from_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forks
    ADD CONSTRAINT forks_forked_from_id_fkey FOREIGN KEY (forked_from_id) REFERENCES public.gists(id);


--
-- Name: forks forks_forked_to_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forks
    ADD CONSTRAINT forks_forked_to_id_fkey FOREIGN KEY (forked_to_id) REFERENCES public.gists(id);


--
-- Name: gists gists_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gists
    ADD CONSTRAINT gists_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: gists_revisions gists_revisions_gist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gists_revisions
    ADD CONSTRAINT gists_revisions_gist_id_fkey FOREIGN KEY (gist_id) REFERENCES public.gists(id) ON DELETE CASCADE;


--
-- Name: gists_revisions gists_revisions_revision_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gists_revisions
    ADD CONSTRAINT gists_revisions_revision_id_fkey FOREIGN KEY (revision_id) REFERENCES public.revisions(id);


--
-- Name: revisions revisions_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.revisions
    ADD CONSTRAINT revisions_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- Name: stars stars_gist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_gist_id_fkey FOREIGN KEY (gist_id) REFERENCES public.gists(id);


--
-- Name: stars stars_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: subscriptions subscriptions_gist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_gist_id_fkey FOREIGN KEY (gist_id) REFERENCES public.gists(id);


--
-- Name: subscriptions subscriptions_subscriber_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_subscriber_id_fkey FOREIGN KEY (subscriber_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;
INSERT INTO "schema_migrations" ("filename") VALUES ('20190511201659_create_core_models.rb');
INSERT INTO "schema_migrations" ("filename") VALUES ('20190513170550_add_social_tables.rb');