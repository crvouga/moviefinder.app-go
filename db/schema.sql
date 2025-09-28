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

--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: Evaluationgroupstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Evaluationgroupstatus" AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DELETED'
);


--
-- Name: Operator; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Operator" AS ENUM (
    'AND',
    'OR'
);


--
-- Name: alignmenttype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.alignmenttype AS ENUM (
    'ODD_MAN_OUT',
    'ABSENT'
);


--
-- Name: appeventtype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.appeventtype AS ENUM (
    'USER_ADDED_USER',
    'USER_UPDATED_PROFILE',
    'USER_REVIEWED_SUGGESTIONS',
    'USER_UPLOADED_RULES',
    'USER_UPDATED_INST_PROFILE',
    'USER_UPDATED_INST_SETTINGS'
);


--
-- Name: boost_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.boost_type AS ENUM (
    'FIND_COURSE',
    'IMPROVE_RULE',
    'PARTNER_INSTITUTION'
);


--
-- Name: boosttype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.boosttype AS ENUM (
    'FIND_COURSE',
    'IMPROVE_RULE',
    'PARTNER_INSTITUTION'
);


--
-- Name: coding_scheme_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.coding_scheme_enum AS ENUM (
    'ACT',
    'CEEB',
    'FICE',
    'GEO',
    'IPEDS'
);


--
-- Name: condition; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.condition AS ENUM (
    'LT',
    'LTE',
    'GT',
    'GTE',
    'EQ'
);


--
-- Name: coursecreditunits; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.coursecreditunits AS ENUM (
    'QUARTER',
    'SEMESTER',
    'UNITS',
    'CLOCK_HOURS',
    'CARNEGIE_UNITS',
    'CONTINUING_EDUCATION_UNITS',
    'OTHER',
    'CREDITS',
    'NON_CREDIT',
    'TRIMESTER'
);


--
-- Name: courselevel; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.courselevel AS ENUM (
    'LOWER',
    'UPPER',
    'UNKNOWN',
    'REMEDIAL',
    'GRADUATE'
);


--
-- Name: courselevels; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.courselevels AS ENUM (
    'COLLEGE_PREPARATORY',
    'DUAL_GRAD_UPPER',
    'HONORS',
    'LOWER_DIVISION',
    'UPPER_DIVISION',
    'VOCATIONAL',
    'GRADUATE',
    'PROFESSIONAL',
    'UNDERGRADUATE'
);


--
-- Name: courselevelsenum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.courselevelsenum AS ENUM (
);


--
-- Name: customfiltervariabletype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.customfiltervariabletype AS ENUM (
    'LEVEL',
    'CREDIT_HOURS',
    'ABSOLUTE_GRADES'
);


--
-- Name: datasource; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.datasource AS ENUM (
    'COURSE_CATALOG_UPLOAD',
    'OPEN_SYLLABUS_API',
    'SIA_API'
);


--
-- Name: ingestionstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ingestionstatus AS ENUM (
    'STARTED',
    'VALIDATION_STARTED',
    'VALIDATION_FAILED',
    'VALIDATION_COMPLETED',
    'CANCELLED_BY_USER',
    'CANCELLED_BY_SYSTEM',
    'APPROVED_BY_USER',
    'UPLOADED',
    'PROCESSING',
    'FAILED',
    'COMPLETED'
);


--
-- Name: instlevel; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.instlevel AS ENUM (
    'LESS_THAN_TWO_YEAR',
    'FOUR_YEAR_OR_HIGHER',
    'TWO_BUT_LESS_THAN_4'
);


--
-- Name: inststatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.inststatus AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'SUSPENDED',
    'PENDING',
    'DELETED',
    'DATA_ACTIVATED'
);


--
-- Name: notificationfrequency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notificationfrequency AS ENUM (
    'DAILY',
    'WEEKLY',
    'BI_WEEKLY',
    'MONTHLY',
    'PAUSE'
);


--
-- Name: notificationtype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notificationtype AS ENUM (
    'BOOST_NOTIFICATION',
    'INACTIVE_USER_REPORT',
    'INST_REQUESTS',
    'MY_REVIEWER_TASK',
    'MY_TASK',
    'SUMMARY',
    'SUMMARY_TRIANGULATOR',
    'SUMMARY_WITH_DATA',
    'TASK_ASSIGNMENTS',
    'UNASSIGNED_SUGGESTIONS',
    'USER_REQUESTS'
);


--
-- Name: oauthtokenrequestsstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.oauthtokenrequestsstatus AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED'
);


--
-- Name: oauthtokenstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.oauthtokenstatus AS ENUM (
    'PENDING',
    'APPROVED',
    'DECLINED',
    'ACTIVE',
    'INACTIVE'
);


--
-- Name: passwordstate; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.passwordstate AS ENUM (
    'FORCE_CHANGE_PASSWORD',
    'NO_CHANGE_REQUIRED'
);


--
-- Name: recordtype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.recordtype AS ENUM (
    'SUGGESTION',
    'ALIGNMENT',
    'API_CALL',
    'STATE_CONNECT_SUGGESTION',
    'STATE_CONNECT_ALIGNMENT',
    'STATE_CONNECT',
    'STATE_ALIGNMENT'
);


--
-- Name: requestsource; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.requestsource AS ENUM (
    'OPEN_SYLLABUS_API',
    'SIA_API'
);


--
-- Name: suggestiondecision; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.suggestiondecision AS ENUM (
    'ACCEPTED',
    'DECLINED',
    'PENDING'
);


--
-- Name: suggestionrejectionreason; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.suggestionrejectionreason AS ENUM (
    'QUALITY__INACCURATE_SOURCE_DATA',
    'QUALITY__INACCURATE_TARGET_DATA',
    'QUALITY__SOURCE_DATA_MISSING',
    'QUALITY__TARGET_DATA_MISSING',
    'QUALITY__NOT_ENOUGH_SOURCE_DATA',
    'QUALITY__NOT_ENOUGH_TARGET_DATA',
    'QUALITY__SOURCE_SEQUENCE_NEEDED',
    'ACCURACY__NOT_EQUIVALENT',
    'ACCURACY__INACTIVE_SOURCE_COURSE',
    'ACCURACY__INACTIVE_TARGET_COURSE',
    'ACCURACY__SUBJECT_DIFFERENCE',
    'ACCURACY__INACCURATE_SOURCE_COMBINATION',
    'ACCURACY__INACCURATE_TARGET_COMBINATION',
    'ACCURACY__EXISTING_RULE',
    'ACCURACY__GRADUATE_LEVEL_SOURCE',
    'ACCURACY__GRADUATE_LEVEL_TARGET',
    'ACCURACY__BETTER_MATCH_AVAILABLE',
    'TRANSFER_POLICY__INSTITUTION_ACCREDITATION',
    'TRANSFER_POLICY__PROGRAM_ACCREDITATION',
    'TRANSFER_POLICY__GENERAL_POLICY_OR_PRACTICE',
    'TRANSFER_POLICY__LEVEL_DIFFERENCE',
    'TRANSFER_POLICY__CREDIT_DIFFERENCE',
    'TRANSFER_POLICY__VOCATIONAL',
    'TRANSFER_POLICY__REMEDIAL',
    'TRANSFER_POLICY__NEEDS_SECOND_REVIEW',
    'GRADUATE_LEVEL'
);


--
-- Name: suggestionrequeststatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.suggestionrequeststatus AS ENUM (
    'PROCESSING',
    'COMPLETED',
    'FAILED',
    'PARTIALLYCOMPLETED'
);


--
-- Name: suggestionsource; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.suggestionsource AS ENUM (
    'OPEN_SYLLABUS',
    'TRIANGULATOR',
    'SIA_API'
);


--
-- Name: useraction; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.useraction AS ENUM (
    'RESET_PASSWORD',
    'UNSUSPEND_USER'
);


--
-- Name: userrequeststatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.userrequeststatus AS ENUM (
    'PENDING',
    'ACCEPTED',
    'DECLINED'
);


--
-- Name: userrequesttype; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.userrequesttype AS ENUM (
    'ACCOUNT_ACTIVATION',
    'ACCOUNT_RE_ACTIVATION',
    'ACCOUNT_SUSPENSION',
    'INST_ACTIVATION',
    'INST_SUSPENSION',
    'INST_RE_ACTIVATION',
    'INST_DEACTIVATION'
);


--
-- Name: userrole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.userrole AS ENUM (
    'INSTITUTION_ADMIN',
    'TRIANGULATOR_ADMIN',
    'REVIEWER',
    'VIEW_ONLY'
);


--
-- Name: userstatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.userstatus AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'DELETED',
    'SUSPENDED',
    'PENDING'
);


--
-- Name: workflow_scheme_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.workflow_scheme_type AS ENUM (
    'WORKFLOW_SCHEME_APPROVER',
    'WORKFLOW_SCHEME_GROUP_APPROVER',
    'WORKFLOW_SCHEME_DUAL_COMMENTER_APPROVER',
    'WORKFLOW_SCHEME_COMMENTER_APPROVER',
    'WORKFLOW_SCHEME_COMMENTER_GROUP_APPROVER',
    'WORKFLOW_SCHEME_GROUP'
);


--
-- Name: create_partition_if_not_exists(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_partition_if_not_exists() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        DECLARE
            partition_name text;
        BEGIN
            partition_name := 'partitioned_rules_' || NEW.uploaded_institution_id;
            IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = partition_name) THEN
                EXECUTE format('CREATE TABLE %I PARTITION OF partitioned_rules FOR VALUES IN (%L)', partition_name, NEW.uploaded_institution_id);
            END IF;
            RETURN NEW;
        END;
        $$;


--
-- Name: delete_from_partitioned_rules(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_from_partitioned_rules(p_uploaded_institution_id integer, p_auto_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
    BEGIN
        -- Delete the record from partitioned_rules
        DELETE FROM partitioned_rules
        WHERE auto_id = p_auto_id AND uploaded_institution_id = p_uploaded_institution_id;

        -- Update the partition_change_tracker table
        INSERT INTO partition_change_tracker (
            uploaded_institution_id,
            last_change_time,
            needs_refresh,
            needs_new_load_files
        )
        VALUES (
            p_uploaded_institution_id,
            NOW(),
            TRUE,
            TRUE
        )
        ON CONFLICT (uploaded_institution_id) DO UPDATE
        SET
            last_change_time = NOW(),
            needs_refresh = TRUE,
            needs_new_load_files = TRUE;
    END;
    $$;


--
-- Name: refresh_changed_partitions(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.refresh_changed_partitions() RETURNS void
    LANGUAGE plpgsql
    AS $$
    DECLARE
        r RECORD;
    BEGIN
        FOR r IN (SELECT uploaded_institution_id, mv_name FROM partition_change_tracker WHERE needs_refresh) LOOP
            BEGIN
                -- Log the materialized view being refreshed
                RAISE NOTICE 'Refreshing materialized view: %', r.mv_name;

                -- Refresh the materialized view for the changed partition
                EXECUTE format(
                    'REFRESH MATERIALIZED VIEW %I', r.mv_name
                );

                -- Update last_refresh_time and last_refresh_successful on success
                UPDATE partition_change_tracker
                SET last_refresh_time = NOW(),
                    last_refresh_successful = TRUE,
                    needs_refresh = FALSE
                WHERE uploaded_institution_id = r.uploaded_institution_id;

            EXCEPTION
                WHEN OTHERS THEN
                    -- Log the error and continue with the next record
                    RAISE NOTICE 'Failed to refresh materialized view: % with error: %', r.mv_name, SQLERRM;

                    -- Mark the refresh as unsuccessful
                    UPDATE partition_change_tracker
                    SET last_refresh_successful = FALSE
                    WHERE uploaded_institution_id = r.uploaded_institution_id;
            END;
        END LOOP;
    END;
    $$;


--
-- Name: refresh_media_mv(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.refresh_media_mv() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- First refresh without CONCURRENTLY to handle empty views
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_mv;
    END;

    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_images_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_images_mv;
    END;

    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY genres_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW genres_mv;
    END;

    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_genres_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_genres_mv;
    END;
END;
$$;


--
-- Name: update_partition_change_tracker(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_partition_change_tracker() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
            INSERT INTO partition_change_tracker (uploaded_institution_id, last_change_time, needs_refresh, needs_new_load_files, last_operation, partition_name, mv_name)
            VALUES (
                COALESCE(NEW.uploaded_institution_id, OLD.uploaded_institution_id),
                NOW(),
                TRUE,
                TRUE,
                TG_OP,
                'partitioned_rules_' || COALESCE(NEW.uploaded_institution_id, OLD.uploaded_institution_id),
                'mv_partitioned_rules_' || COALESCE(NEW.uploaded_institution_id, OLD.uploaded_institution_id)
            )
            ON CONFLICT (uploaded_institution_id) DO UPDATE
            SET last_change_time = EXCLUDED.last_change_time,
                needs_refresh = TRUE,
                needs_new_load_files = TRUE,
                last_operation = EXCLUDED.last_operation,
                partition_name = EXCLUDED.partition_name,
                mv_name = EXCLUDED.mv_name;
            RETURN NEW;
        END;
        $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _temp_catalog_1759060992_0ea3bc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060992_0ea3bc (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060992_0ea3bc_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060992_0ea3bc_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060992_0ea3bc_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060992_0ea3bc_auto_id_seq OWNED BY public._temp_catalog_1759060992_0ea3bc.auto_id;


--
-- Name: _temp_catalog_1759060993_ed1085; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060993_ed1085 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060993_ed1085_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060993_ed1085_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060993_ed1085_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060993_ed1085_auto_id_seq OWNED BY public._temp_catalog_1759060993_ed1085.auto_id;


--
-- Name: _temp_catalog_1759060994_0ff21d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060994_0ff21d (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060994_0ff21d_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060994_0ff21d_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060994_0ff21d_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060994_0ff21d_auto_id_seq OWNED BY public._temp_catalog_1759060994_0ff21d.auto_id;


--
-- Name: _temp_catalog_1759060994_157d59; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060994_157d59 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060994_157d59_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060994_157d59_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060994_157d59_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060994_157d59_auto_id_seq OWNED BY public._temp_catalog_1759060994_157d59.auto_id;


--
-- Name: _temp_catalog_1759060995_17fcf8; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060995_17fcf8 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060995_17fcf8_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060995_17fcf8_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060995_17fcf8_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060995_17fcf8_auto_id_seq OWNED BY public._temp_catalog_1759060995_17fcf8.auto_id;


--
-- Name: _temp_catalog_1759060996_c9a3ff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060996_c9a3ff (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060996_c9a3ff_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060996_c9a3ff_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060996_c9a3ff_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060996_c9a3ff_auto_id_seq OWNED BY public._temp_catalog_1759060996_c9a3ff.auto_id;


--
-- Name: _temp_catalog_1759060996_e454e2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060996_e454e2 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060996_e454e2_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060996_e454e2_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060996_e454e2_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060996_e454e2_auto_id_seq OWNED BY public._temp_catalog_1759060996_e454e2.auto_id;


--
-- Name: _temp_catalog_1759060997_c13594; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060997_c13594 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060997_c13594_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060997_c13594_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060997_c13594_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060997_c13594_auto_id_seq OWNED BY public._temp_catalog_1759060997_c13594.auto_id;


--
-- Name: _temp_catalog_1759060998_0dfa59; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060998_0dfa59 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060998_0dfa59_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060998_0dfa59_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060998_0dfa59_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060998_0dfa59_auto_id_seq OWNED BY public._temp_catalog_1759060998_0dfa59.auto_id;


--
-- Name: _temp_catalog_1759060998_c3631e; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060998_c3631e (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060998_c3631e_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060998_c3631e_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060998_c3631e_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060998_c3631e_auto_id_seq OWNED BY public._temp_catalog_1759060998_c3631e.auto_id;


--
-- Name: _temp_catalog_1759060999_1b0fe1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060999_1b0fe1 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060999_1b0fe1_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060999_1b0fe1_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060999_1b0fe1_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060999_1b0fe1_auto_id_seq OWNED BY public._temp_catalog_1759060999_1b0fe1.auto_id;


--
-- Name: _temp_catalog_1759060999_acbd29; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759060999_acbd29 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759060999_acbd29_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759060999_acbd29_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759060999_acbd29_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759060999_acbd29_auto_id_seq OWNED BY public._temp_catalog_1759060999_acbd29.auto_id;


--
-- Name: _temp_catalog_1759061000_9a0992; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061000_9a0992 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061000_9a0992_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061000_9a0992_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061000_9a0992_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061000_9a0992_auto_id_seq OWNED BY public._temp_catalog_1759061000_9a0992.auto_id;


--
-- Name: _temp_catalog_1759061000_dd02f1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061000_dd02f1 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061000_dd02f1_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061000_dd02f1_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061000_dd02f1_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061000_dd02f1_auto_id_seq OWNED BY public._temp_catalog_1759061000_dd02f1.auto_id;


--
-- Name: _temp_catalog_1759061001_e56456; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061001_e56456 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061001_e56456_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061001_e56456_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061001_e56456_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061001_e56456_auto_id_seq OWNED BY public._temp_catalog_1759061001_e56456.auto_id;


--
-- Name: _temp_catalog_1759061002_41ea00; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061002_41ea00 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061002_41ea00_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061002_41ea00_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061002_41ea00_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061002_41ea00_auto_id_seq OWNED BY public._temp_catalog_1759061002_41ea00.auto_id;


--
-- Name: _temp_catalog_1759061002_7c0f5a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061002_7c0f5a (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061002_7c0f5a_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061002_7c0f5a_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061002_7c0f5a_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061002_7c0f5a_auto_id_seq OWNED BY public._temp_catalog_1759061002_7c0f5a.auto_id;


--
-- Name: _temp_catalog_1759061003_dea9b4; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061003_dea9b4 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061003_dea9b4_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061003_dea9b4_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061003_dea9b4_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061003_dea9b4_auto_id_seq OWNED BY public._temp_catalog_1759061003_dea9b4.auto_id;


--
-- Name: _temp_catalog_1759061004_c7fe61; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061004_c7fe61 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061004_c7fe61_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061004_c7fe61_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061004_c7fe61_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061004_c7fe61_auto_id_seq OWNED BY public._temp_catalog_1759061004_c7fe61.auto_id;


--
-- Name: _temp_catalog_1759061005_633c1b; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061005_633c1b (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061005_633c1b_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061005_633c1b_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061005_633c1b_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061005_633c1b_auto_id_seq OWNED BY public._temp_catalog_1759061005_633c1b.auto_id;


--
-- Name: _temp_catalog_1759061005_e72243; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061005_e72243 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061005_e72243_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061005_e72243_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061005_e72243_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061005_e72243_auto_id_seq OWNED BY public._temp_catalog_1759061005_e72243.auto_id;


--
-- Name: _temp_catalog_1759061006_f58a15; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061006_f58a15 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061006_f58a15_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061006_f58a15_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061006_f58a15_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061006_f58a15_auto_id_seq OWNED BY public._temp_catalog_1759061006_f58a15.auto_id;


--
-- Name: _temp_catalog_1759061006_ff7a44; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061006_ff7a44 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061006_ff7a44_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061006_ff7a44_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061006_ff7a44_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061006_ff7a44_auto_id_seq OWNED BY public._temp_catalog_1759061006_ff7a44.auto_id;


--
-- Name: _temp_catalog_1759061007_50ae78; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061007_50ae78 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061007_50ae78_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061007_50ae78_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061007_50ae78_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061007_50ae78_auto_id_seq OWNED BY public._temp_catalog_1759061007_50ae78.auto_id;


--
-- Name: _temp_catalog_1759061007_a20784; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061007_a20784 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061007_a20784_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061007_a20784_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061007_a20784_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061007_a20784_auto_id_seq OWNED BY public._temp_catalog_1759061007_a20784.auto_id;


--
-- Name: _temp_catalog_1759061008_2c44e2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061008_2c44e2 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061008_2c44e2_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061008_2c44e2_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061008_2c44e2_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061008_2c44e2_auto_id_seq OWNED BY public._temp_catalog_1759061008_2c44e2.auto_id;


--
-- Name: _temp_catalog_1759061008_c92293; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061008_c92293 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061008_c92293_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061008_c92293_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061008_c92293_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061008_c92293_auto_id_seq OWNED BY public._temp_catalog_1759061008_c92293.auto_id;


--
-- Name: _temp_catalog_1759061009_9f4232; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061009_9f4232 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061009_9f4232_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061009_9f4232_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061009_9f4232_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061009_9f4232_auto_id_seq OWNED BY public._temp_catalog_1759061009_9f4232.auto_id;


--
-- Name: _temp_catalog_1759061010_0d3559; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061010_0d3559 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061010_0d3559_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061010_0d3559_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061010_0d3559_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061010_0d3559_auto_id_seq OWNED BY public._temp_catalog_1759061010_0d3559.auto_id;


--
-- Name: _temp_catalog_1759061011_0ccdde; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061011_0ccdde (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061011_0ccdde_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061011_0ccdde_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061011_0ccdde_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061011_0ccdde_auto_id_seq OWNED BY public._temp_catalog_1759061011_0ccdde.auto_id;


--
-- Name: _temp_catalog_1759061011_67ee4d; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061011_67ee4d (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061011_67ee4d_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061011_67ee4d_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061011_67ee4d_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061011_67ee4d_auto_id_seq OWNED BY public._temp_catalog_1759061011_67ee4d.auto_id;


--
-- Name: _temp_catalog_1759061011_9c8f93; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061011_9c8f93 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061011_9c8f93_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061011_9c8f93_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061011_9c8f93_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061011_9c8f93_auto_id_seq OWNED BY public._temp_catalog_1759061011_9c8f93.auto_id;


--
-- Name: _temp_catalog_1759061011_e633b4; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061011_e633b4 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061011_e633b4_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061011_e633b4_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061011_e633b4_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061011_e633b4_auto_id_seq OWNED BY public._temp_catalog_1759061011_e633b4.auto_id;


--
-- Name: _temp_catalog_1759061011_eae01f; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061011_eae01f (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061011_eae01f_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061011_eae01f_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061011_eae01f_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061011_eae01f_auto_id_seq OWNED BY public._temp_catalog_1759061011_eae01f.auto_id;


--
-- Name: _temp_catalog_1759061011_ed8547; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061011_ed8547 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061011_ed8547_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061011_ed8547_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061011_ed8547_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061011_ed8547_auto_id_seq OWNED BY public._temp_catalog_1759061011_ed8547.auto_id;


--
-- Name: _temp_catalog_1759061012_98fc90; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061012_98fc90 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061012_98fc90_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061012_98fc90_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061012_98fc90_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061012_98fc90_auto_id_seq OWNED BY public._temp_catalog_1759061012_98fc90.auto_id;


--
-- Name: _temp_catalog_1759061017_8917f4; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061017_8917f4 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061017_8917f4_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061017_8917f4_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061017_8917f4_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061017_8917f4_auto_id_seq OWNED BY public._temp_catalog_1759061017_8917f4.auto_id;


--
-- Name: _temp_catalog_1759061044_94f913; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061044_94f913 (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061044_94f913_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061044_94f913_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061044_94f913_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061044_94f913_auto_id_seq OWNED BY public._temp_catalog_1759061044_94f913.auto_id;


--
-- Name: _temp_catalog_1759061050_db1f9a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._temp_catalog_1759061050_db1f9a (
    auto_id integer NOT NULL,
    course_id text,
    inst_unique_id integer,
    given_inst_unique_id text,
    course_identifier text,
    active_course_indicator text,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_subject text,
    course_number text,
    course_long_title text,
    course_description text,
    course_credit_min_value text,
    course_credit_max_value text,
    course_long_dept_name text,
    course_level text,
    gened_description text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_errors text,
    format_errors text,
    translated boolean DEFAULT false
);


--
-- Name: _temp_catalog_1759061050_db1f9a_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public._temp_catalog_1759061050_db1f9a_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: _temp_catalog_1759061050_db1f9a_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public._temp_catalog_1759061050_db1f9a_auto_id_seq OWNED BY public._temp_catalog_1759061050_db1f9a.auto_id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


--
-- Name: analytics_table_alignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analytics_table_alignments (
    id integer NOT NULL,
    institution_id integer NOT NULL,
    institution_name text NOT NULL,
    ran_at timestamp without time zone DEFAULT now() NOT NULL,
    number_of_active_rules integer NOT NULL,
    number_of_accepted_suggestions integer NOT NULL,
    delta_of_alignments integer NOT NULL,
    alignments_before_run integer NOT NULL,
    alignments_after_run integer NOT NULL
);


--
-- Name: analytics_table_alignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analytics_table_alignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analytics_table_alignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analytics_table_alignments_id_seq OWNED BY public.analytics_table_alignments.id;


--
-- Name: analytics_table_boost; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analytics_table_boost (
    id integer NOT NULL,
    institution_id integer NOT NULL,
    institution_name text NOT NULL,
    ran_at timestamp without time zone DEFAULT now() NOT NULL,
    boost_type public.boost_type NOT NULL,
    delta_of_suggestions integer NOT NULL,
    suggestions_before_run integer NOT NULL,
    suggestions_after_run integer NOT NULL,
    request_id character varying NOT NULL
);


--
-- Name: analytics_table_boost_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analytics_table_boost_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analytics_table_boost_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analytics_table_boost_id_seq OWNED BY public.analytics_table_boost.id;


--
-- Name: analytics_table_suggestions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analytics_table_suggestions (
    id integer NOT NULL,
    institution_id integer NOT NULL,
    institution_name text NOT NULL,
    ran_at timestamp without time zone DEFAULT now() NOT NULL,
    number_of_active_rules integer NOT NULL,
    number_of_accepted_suggestions integer NOT NULL,
    delta_of_suggestions integer NOT NULL,
    suggestions_before_run integer NOT NULL,
    suggestions_after_run integer NOT NULL
);


--
-- Name: analytics_table_suggestions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analytics_table_suggestions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analytics_table_suggestions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analytics_table_suggestions_id_seq OWNED BY public.analytics_table_suggestions.id;


--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_tokens (
    token_id integer NOT NULL,
    authoriser_id integer,
    user_id integer NOT NULL,
    inst_id integer NOT NULL,
    status public.oauthtokenstatus NOT NULL,
    created_at timestamp without time zone NOT NULL,
    modified_at timestamp without time zone NOT NULL,
    last_used_at timestamp without time zone,
    usage_count integer,
    max_usage integer,
    expires_at timestamp without time zone
);


--
-- Name: app_event; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event (
    id integer NOT NULL,
    event_type public.appeventtype NOT NULL,
    event_payload jsonb,
    "timestamp" timestamp without time zone NOT NULL
);


--
-- Name: app_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.app_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: app_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.app_event_id_seq OWNED BY public.app_event.id;


--
-- Name: app_event_updated_inst_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event_updated_inst_profile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    updated_institution_id integer NOT NULL,
    before jsonb,
    after jsonb,
    user_inst_id integer
);


--
-- Name: app_event_updated_inst_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event_updated_inst_settings (
    id integer NOT NULL,
    user_id integer NOT NULL,
    updated_institution_id integer NOT NULL,
    before jsonb,
    after jsonb,
    user_inst_id integer
);


--
-- Name: app_event_user_added_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event_user_added_user (
    id integer NOT NULL,
    user_id integer NOT NULL,
    added_user_id integer NOT NULL,
    user_inst_id integer,
    added_user_inst_id integer
);


--
-- Name: app_event_user_reviewed_suggestions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event_user_reviewed_suggestions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    accepted_count integer NOT NULL,
    rejected_count integer NOT NULL,
    user_inst_id integer
);


--
-- Name: app_event_user_updated_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event_user_updated_profile (
    id integer NOT NULL,
    user_id integer NOT NULL,
    updated_user_id integer NOT NULL,
    before jsonb,
    after jsonb,
    user_inst_id integer,
    updated_user_inst_id integer
);


--
-- Name: app_event_user_uploaded_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_event_user_uploaded_rules (
    id integer NOT NULL,
    user_id integer NOT NULL,
    uploaded_institution_id integer NOT NULL,
    new_rule_count integer NOT NULL,
    user_inst_id integer
);


--
-- Name: audit_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_table (
    request_id uuid NOT NULL,
    request_timestamp timestamp without time zone,
    response_timestamp timestamp without time zone,
    request_params jsonb,
    response_received jsonb,
    source_host_ip text,
    destination_ip text,
    retry_count integer,
    credentials text,
    record_count integer,
    user_id integer NOT NULL
);


--
-- Name: audit_table_publish_course_inventory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_table_publish_course_inventory (
    auto_id integer NOT NULL,
    user_id integer NOT NULL,
    request_timestamp timestamp without time zone,
    response_timestamp timestamp without time zone,
    request_params jsonb,
    response_received jsonb,
    source_host_ip text,
    credentials text,
    record_count integer
);


--
-- Name: audit_table_publish_course_inventory_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_table_publish_course_inventory_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_table_publish_course_inventory_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_table_publish_course_inventory_auto_id_seq OWNED BY public.audit_table_publish_course_inventory.auto_id;


--
-- Name: audit_table_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_table_requests (
    id integer NOT NULL,
    request_source public.requestsource NOT NULL,
    request_id uuid NOT NULL,
    request_method text NOT NULL,
    request_url text NOT NULL,
    request_body jsonb,
    request_timestamp timestamp without time zone,
    response_status_code integer,
    response_body jsonb,
    response_timestamp timestamp without time zone
);


--
-- Name: audit_table_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_table_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_table_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_table_requests_id_seq OWNED BY public.audit_table_requests.id;


--
-- Name: course_catalog_upload_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_catalog_upload_status (
    auto_id integer NOT NULL,
    file_name text,
    upload_type text,
    upload_date timestamp without time zone,
    status text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_error_info jsonb,
    format_error_info jsonb,
    total_courses integer,
    total_active_courses integer,
    new_active_courses integer,
    file_name_raw text,
    is_applied boolean,
    total_new_courses integer,
    s3_uri text,
    catalog_ingestion_table_name text,
    ingestion_status public.ingestionstatus,
    ingestion_failure_reason text
);


--
-- Name: course_catalog_upload_status_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_catalog_upload_status_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_catalog_upload_status_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_catalog_upload_status_auto_id_seq OWNED BY public.course_catalog_upload_status.auto_id;


--
-- Name: master_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_courses (
    course_id uuid NOT NULL,
    institution_id integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    course_order text,
    course_order_link integer,
    course_credits double precision,
    course_elective_indicator text,
    parent_course_id uuid,
    gened_category_name text,
    course_title text,
    course_level public.courselevel,
    graph_vertex_id uuid,
    child_course_id uuid,
    child_course_operator public."Operator",
    active_course_indicator boolean DEFAULT false NOT NULL
);


--
-- Name: unprocessed_equivalencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unprocessed_equivalencies (
    auto_id integer NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer NOT NULL,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    course_id uuid,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    upload_date timestamp without time zone,
    last_accepted_suggestion_date timestamp without time zone,
    is_modified_rule boolean DEFAULT false,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: grouped_rules_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.grouped_rules_view AS
 WITH src AS (
         SELECT ue.unique_rule_identifier,
            ue.unique_identifier AS institution_id,
            ue.institution_name,
            json_object_agg(ue.course_order, json_build_object('course_id', ue.course_id, 'course_subject', ue.course_subject, 'course_number', ue.course_number, 'course_order', ue.course_order, 'operator', ue.operator, 'institution_id', ue.unique_identifier)) AS course_data
           FROM public.unprocessed_equivalencies ue
          WHERE (ue.course_type = 'source'::text)
          GROUP BY ue.unique_rule_identifier, ue.unique_identifier, ue.institution_name
        ), trg AS (
         SELECT ue.unique_rule_identifier,
            ue.unique_identifier AS institution_id,
            ue.institution_name,
            json_object_agg(ue.course_order, json_build_object('course_id', ue.course_id, 'course_subject', ue.course_subject, 'course_number', ue.course_number, 'course_order', ue.course_order, 'operator', ue.operator, 'institution_id', ue.unique_identifier)) AS course_data
           FROM (public.unprocessed_equivalencies ue
             JOIN public.master_courses mc ON ((ue.course_id = mc.course_id)))
          WHERE ((ue.course_type = 'target'::text) AND (mc.active_course_indicator = true))
          GROUP BY ue.unique_rule_identifier, ue.unique_identifier, ue.institution_name
        )
 SELECT trg.unique_rule_identifier AS rule_identifier,
    src.institution_id AS source_institution_id,
    src.institution_name AS source_institution_name,
    src.course_data AS source_cg,
    md5((src.course_data)::text) AS source_cg_hash,
    trg.institution_id AS target_institution_id,
    trg.institution_name AS target_institution_name,
    trg.course_data AS target_cg,
    md5((trg.course_data)::text) AS target_cg_hash
   FROM (trg
     JOIN src ON ((src.unique_rule_identifier = trg.unique_rule_identifier)))
  ORDER BY src.unique_rule_identifier;


--
-- Name: course_groups; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.course_groups AS
 SELECT DISTINCT grouped_rules_view.source_cg_hash AS group_hash,
    (source_cg_first_course.value ->> 'course_id'::text) AS first_course_id,
    (source_cg_first_course.value ->> 'course_subject'::text) AS first_course_subject,
    (source_cg_first_course.value ->> 'course_number'::text) AS first_course_number,
    (source_cg_first_course.value ->> 'institution_id'::text) AS institution_id,
    (grouped_rules_view.source_cg)::jsonb AS course_group_data
   FROM public.grouped_rules_view,
    LATERAL ( SELECT jsonb_each.value
           FROM jsonb_each((grouped_rules_view.source_cg)::jsonb) jsonb_each(key, value)
          ORDER BY (jsonb_each.key)::integer
         LIMIT 1) source_cg_first_course
UNION
 SELECT DISTINCT grouped_rules_view.target_cg_hash AS group_hash,
    (target_cg_first_course.value ->> 'course_id'::text) AS first_course_id,
    (target_cg_first_course.value ->> 'course_subject'::text) AS first_course_subject,
    (target_cg_first_course.value ->> 'course_number'::text) AS first_course_number,
    (target_cg_first_course.value ->> 'institution_id'::text) AS institution_id,
    (grouped_rules_view.target_cg)::jsonb AS course_group_data
   FROM public.grouped_rules_view,
    LATERAL ( SELECT jsonb_each.value
           FROM jsonb_each((grouped_rules_view.target_cg)::jsonb) jsonb_each(key, value)
          ORDER BY (jsonb_each.key)::integer
         LIMIT 1) target_cg_first_course
  WITH NO DATA;


--
-- Name: course_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_metadata (
    course_id text NOT NULL,
    provided_course_identifier text NOT NULL,
    master_course_id uuid NOT NULL,
    data_source public.datasource NOT NULL,
    inst_unique_id integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    course_long_title text NOT NULL,
    course_long_dept_name text,
    course_description text NOT NULL,
    course_credit_units public.coursecreditunits,
    course_credit_min_value double precision NOT NULL,
    course_credit_max_value double precision NOT NULL,
    course_level public.courselevels,
    gen_ed_category_code text,
    course_prerequisite_id character varying,
    course_corequisite_id character varying,
    course_anti_requisite_id character varying,
    active_course_indicator boolean NOT NULL,
    course_effective_year_month text,
    course_expiration_year_month text,
    course_credits double precision,
    requisite_description text,
    course_level_category text GENERATED ALWAYS AS (
CASE
    WHEN (course_level IS NULL) THEN NULL::text
    WHEN (course_level = 'LOWER_DIVISION'::public.courselevels) THEN 'LOWER'::text
    WHEN (course_level = 'UNDERGRADUATE'::public.courselevels) THEN 'OTHER'::text
    WHEN (course_level = 'UPPER_DIVISION'::public.courselevels) THEN 'UPPER'::text
    WHEN (course_level = 'DUAL_GRAD_UPPER'::public.courselevels) THEN 'UPPER'::text
    WHEN (course_level = 'GRADUATE'::public.courselevels) THEN 'OTHER'::text
    WHEN (course_level = 'PROFESSIONAL'::public.courselevels) THEN 'OTHER'::text
    WHEN (course_level = 'HONORS'::public.courselevels) THEN 'OTHER'::text
    WHEN (course_level = 'COLLEGE_PREPARATORY'::public.courselevels) THEN 'OTHER'::text
    WHEN (course_level = 'VOCATIONAL'::public.courselevels) THEN 'OTHER'::text
    ELSE 'OTHER'::text
END) STORED,
    gened_description text
);


--
-- Name: custom_filter_custom_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_filter_custom_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_filter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_filter (
    institution_id integer,
    creator_user_id integer,
    source_variable_value text,
    condition public.condition,
    target_variable_value text,
    source_variable public.customfiltervariabletype,
    target_variable public.customfiltervariabletype,
    custom_filter_id integer DEFAULT nextval('public.custom_filter_custom_filter_id_seq'::regclass) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: custom_logic_filter_custom_logic_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_logic_filter_custom_logic_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_logic_filter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_logic_filter (
    institution_id integer,
    creator_user_id integer,
    source_condition public.condition,
    source_variable_value text,
    target_condition public.condition,
    target_variable_value text,
    source_variable public.customfiltervariabletype,
    target_variable public.customfiltervariabletype,
    custom_logic_filter_id integer DEFAULT nextval('public.custom_logic_filter_custom_logic_filter_id_seq'::regclass) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: deployment_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deployment_status (
    id integer NOT NULL,
    app_deployment_id text NOT NULL,
    utc_started_at timestamp without time zone NOT NULL,
    utc_ended_at timestamp without time zone,
    created_by_user_id integer,
    utc_created_at timestamp without time zone NOT NULL
);


--
-- Name: deployment_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deployment_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deployment_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deployment_status_id_seq OWNED BY public.deployment_status.id;


--
-- Name: district_rule_map; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.district_rule_map (
    auto_id integer NOT NULL,
    original_rule_identifier text NOT NULL,
    district_rule_identifier text NOT NULL,
    source_unique_identifier integer,
    target_unique_identifier integer
);


--
-- Name: district_rule_map_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.district_rule_map_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: district_rule_map_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.district_rule_map_auto_id_seq OWNED BY public.district_rule_map.auto_id;


--
-- Name: districts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.districts (
    district_id integer NOT NULL,
    creator_user_id integer,
    district_name text,
    institution_ids integer[],
    creator_inst_id integer
);


--
-- Name: districts_district_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.districts_district_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: districts_district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.districts_district_id_seq OWNED BY public.districts.district_id;


--
-- Name: master_universities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_universities (
    auto_id integer NOT NULL,
    institution_id integer,
    name text,
    city text,
    state text,
    death_year text,
    closed_at text,
    date_created timestamp without time zone,
    date_updated timestamp without time zone,
    last_updated_by integer,
    web_address text,
    primary_contact_first_name text,
    primary_contact_last_name text,
    primary_contact_email text,
    site_id text,
    district_id text,
    label text,
    ipeds_info jsonb,
    graph_vertex_id integer,
    next_suggestion_date timestamp without time zone,
    last_suggestion_date timestamp without time zone,
    status public.inststatus,
    deactivation_date timestamp without time zone,
    avatar_url text,
    zip_code text,
    about text,
    offerings text[],
    third_party_data_available boolean DEFAULT false NOT NULL,
    public_email text,
    state_connect_indicator boolean DEFAULT false NOT NULL
);


--
-- Name: districts_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.districts_mat_view AS
 SELECT (mu1.ipeds_info ->> 'DistrictIdentifier'::text) AS district_id,
    (NULLIF((mu1.ipeds_info ->> 'DistrictIdentifier'::text), ''::text))::integer AS district_id_int,
    mu2.name AS district_name,
    mu2.city AS district_city,
    mu2.state AS district_state,
    (mu1.institution_id)::text AS member_id,
    mu1.institution_id AS member_id_int,
    mu1.name AS member_name,
    mu1.city AS member_city,
    mu1.state AS member_state,
    false AS is_district_member
   FROM (public.master_universities mu1
     JOIN public.master_universities mu2 ON (((mu1.ipeds_info ->> 'DistrictIdentifier'::text) = (mu2.institution_id)::text)))
  WHERE ((mu1.ipeds_info ->> 'DistrictIdentifier'::text) <> 'No data'::text)
UNION ALL
 SELECT (mu.institution_id)::text AS district_id,
    mu.institution_id AS district_id_int,
    mu.name AS district_name,
    mu.city AS district_city,
    mu.state AS district_state,
    (mu.institution_id)::text AS member_id,
    mu.institution_id AS member_id_int,
    mu.name AS member_name,
    mu.city AS member_city,
    mu.state AS member_state,
    true AS is_district_member
   FROM public.master_universities mu
  WHERE ((mu.ipeds_info ->> 'DistrictIndicator'::text) = 'Y'::text)
  WITH NO DATA;


--
-- Name: districts_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.districts_view AS
 SELECT (mu1.ipeds_info ->> 'DistrictIdentifier'::text) AS district_id,
    mu2.name AS district_name,
    mu2.city AS district_city,
    mu2.state AS district_state,
    mu1.institution_id AS member_id,
    mu1.name AS member_name,
    mu1.city AS member_city,
    mu1.state AS member_state
   FROM (public.master_universities mu1
     JOIN public.master_universities mu2 ON (((mu1.ipeds_info ->> 'DistrictIdentifier'::text) = (mu2.institution_id)::text)))
  WHERE ((mu1.ipeds_info ->> 'DistrictIdentifier'::text) <> 'No data'::text);


--
-- Name: entities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entities (
    id text NOT NULL,
    type text NOT NULL,
    data jsonb NOT NULL,
    updated_at_epoch bigint NOT NULL
);


--
-- Name: graph_db_output; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.graph_db_output (
    uuid integer NOT NULL,
    source_institution_id integer,
    source_course_id uuid NOT NULL,
    credit_hours integer,
    target_institution_id integer,
    target_course_id uuid NOT NULL,
    score double precision,
    date_created timestamp without time zone,
    date_last_modified timestamp without time zone,
    assignee_id integer,
    decision public.suggestiondecision DEFAULT 'PENDING'::public.suggestiondecision,
    decision_maker_id integer,
    effective_begin_year_month text,
    effective_end_year_month text,
    date_decided timestamp without time zone,
    suggestion_relation_id_neptune text NOT NULL,
    common_institution_id integer,
    common_course_id uuid,
    target_to_source_rule_id text,
    target_to_common_rule_id text,
    common_to_target_rule_id text,
    common_to_source_rule_id text,
    source_to_common_rule_id text,
    source_suggestion public.suggestionsource DEFAULT 'TRIANGULATOR'::public.suggestionsource NOT NULL,
    source_suggestion_request_id text,
    record_type public.recordtype,
    alignment_peer_course_ids uuid[],
    alignment_peer_to_target_rule_identifiers text[],
    alignment_source_to_peer_rule_identifiers text[],
    alignment_odd_man_out_target_course_id uuid,
    alignment_type public.alignmenttype,
    source_suggestion_rule_identifier text,
    request_id text,
    source_course_group jsonb DEFAULT '{}'::jsonb NOT NULL,
    target_course_group jsonb DEFAULT '{}'::jsonb NOT NULL,
    odd_man_out_rule text,
    rule_to_be_improved text,
    date_deleted timestamp without time zone,
    deletion_reason text,
    all_rules_involved text[],
    accepted_suggestions_involved text[],
    pattern integer,
    extra_data jsonb DEFAULT '{}'::jsonb,
    boost_type public.boosttype,
    workflow_id integer
);


--
-- Name: COLUMN graph_db_output.all_rules_involved; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.graph_db_output.all_rules_involved IS 'List of all rules involved in the suggestion.';


--
-- Name: COLUMN graph_db_output.accepted_suggestions_involved; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.graph_db_output.accepted_suggestions_involved IS 'List of all accepted suggestions involved in the suggestion.';


--
-- Name: COLUMN graph_db_output.boost_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.graph_db_output.boost_type IS 'Type of boost associated with the suggestion, if applicable';


--
-- Name: equivalencies_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalencies_mat_view AS
 WITH rules AS (
         SELECT DISTINCT ON (source.unique_rule_identifier) source.unique_rule_identifier AS equivalency_id,
            source.unique_identifier AS source_institution_id,
            source.course_id AS source_course_id,
            target.unique_identifier AS target_institution_id,
            target.course_id AS target_course_id,
            source.effective_begin_year_month,
            source.effective_end_year_month,
            'RULE'::text AS equivalency_type,
            (grouped_rules_view.source_cg)::jsonb AS source_course_group,
            (grouped_rules_view.target_cg)::jsonb AS target_course_group,
            source.operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM ((public.unprocessed_equivalencies source
             JOIN public.unprocessed_equivalencies target ON ((source.unique_rule_identifier = target.unique_rule_identifier)))
             LEFT JOIN public.grouped_rules_view ON ((source.unique_rule_identifier = grouped_rules_view.rule_identifier)))
          WHERE ((source.course_type = 'source'::text) AND (target.course_type = 'target'::text))
          ORDER BY source.unique_rule_identifier
        ), accepted_suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            graph_db_output.effective_begin_year_month,
            graph_db_output.effective_end_year_month,
            'SUGGESTION'::text AS equivalency_type,
            graph_db_output.source_course_group,
            graph_db_output.target_course_group,
            NULL::text AS operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM public.graph_db_output
          WHERE ((graph_db_output.date_deleted IS NULL) AND (graph_db_output.decision = 'ACCEPTED'::public.suggestiondecision))
        ), equivalencies AS (
         SELECT rules.equivalency_id,
            rules.source_institution_id,
            rules.source_course_id,
            rules.target_institution_id,
            rules.target_course_id,
            rules.effective_begin_year_month,
            rules.effective_end_year_month,
            rules.equivalency_type,
            rules.source_course_group,
            rules.target_course_group,
            rules.operator,
            rules.many_source_course_ids,
            rules.many_target_course_ids
           FROM rules
        UNION ALL
         SELECT accepted_suggestions.equivalency_id,
            accepted_suggestions.source_institution_id,
            accepted_suggestions.source_course_id,
            accepted_suggestions.target_institution_id,
            accepted_suggestions.target_course_id,
            accepted_suggestions.effective_begin_year_month,
            accepted_suggestions.effective_end_year_month,
            accepted_suggestions.equivalency_type,
            accepted_suggestions.source_course_group,
            accepted_suggestions.target_course_group,
            accepted_suggestions.operator,
            accepted_suggestions.many_source_course_ids,
            accepted_suggestions.many_target_course_ids
           FROM accepted_suggestions
        ), deduplicated_equivalencies AS (
         SELECT DISTINCT ON (equivalencies.source_course_id, equivalencies.target_course_id) equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.effective_begin_year_month,
            equivalencies.effective_end_year_month,
            equivalencies.equivalency_type,
            equivalencies.source_course_group,
            equivalencies.target_course_group,
            equivalencies.operator,
            equivalencies.many_source_course_ids,
            equivalencies.many_target_course_ids
           FROM equivalencies
          ORDER BY equivalencies.source_course_id, equivalencies.target_course_id, equivalencies.equivalency_id
        )
 SELECT deduplicated_equivalencies.equivalency_id,
    deduplicated_equivalencies.source_institution_id,
    deduplicated_equivalencies.source_course_id,
    deduplicated_equivalencies.target_institution_id,
    deduplicated_equivalencies.target_course_id,
    deduplicated_equivalencies.effective_begin_year_month,
    deduplicated_equivalencies.effective_end_year_month,
    deduplicated_equivalencies.equivalency_type,
    deduplicated_equivalencies.source_course_group,
    deduplicated_equivalencies.target_course_group,
    deduplicated_equivalencies.operator,
    deduplicated_equivalencies.many_source_course_ids,
    deduplicated_equivalencies.many_target_course_ids
   FROM deduplicated_equivalencies
  WITH NO DATA;


--
-- Name: equivalencies_mat_view_prev_feb_2024_02_02; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalencies_mat_view_prev_feb_2024_02_02 AS
 WITH rules AS (
         SELECT DISTINCT ON (source.rule_identifier) source.rule_identifier AS equivalency_id,
            source.unique_identifier AS source_institution_id,
            source.course_id AS source_course_id,
            target.unique_identifier AS target_institution_id,
            target.course_id AS target_course_id,
            'RULE'::text AS equivalency_type
           FROM (public.unprocessed_equivalencies source
             JOIN public.unprocessed_equivalencies target ON ((source.rule_identifier = target.rule_identifier)))
          WHERE ((source.course_type = 'source'::text) AND (target.course_type = 'target'::text))
          ORDER BY source.rule_identifier
        ), accepted_suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            'SUGGESTION'::text AS equivalency_type
           FROM public.graph_db_output
          WHERE (graph_db_output.decision = 'ACCEPTED'::public.suggestiondecision)
        ), equivalencies AS (
         SELECT rules.equivalency_id,
            rules.source_institution_id,
            rules.source_course_id,
            rules.target_institution_id,
            rules.target_course_id,
            rules.equivalency_type
           FROM rules
        UNION ALL
         SELECT accepted_suggestions.equivalency_id,
            accepted_suggestions.source_institution_id,
            accepted_suggestions.source_course_id,
            accepted_suggestions.target_institution_id,
            accepted_suggestions.target_course_id,
            accepted_suggestions.equivalency_type
           FROM accepted_suggestions
        ), deduplicated_equivalencies AS (
         SELECT DISTINCT ON (equivalencies.source_course_id, equivalencies.target_course_id) equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.equivalency_type
           FROM equivalencies
          ORDER BY equivalencies.source_course_id, equivalencies.target_course_id, equivalencies.equivalency_id
        )
 SELECT deduplicated_equivalencies.equivalency_id,
    deduplicated_equivalencies.source_institution_id,
    deduplicated_equivalencies.source_course_id,
    deduplicated_equivalencies.target_institution_id,
    deduplicated_equivalencies.target_course_id,
    deduplicated_equivalencies.equivalency_type
   FROM deduplicated_equivalencies
  WITH NO DATA;


--
-- Name: equivalencies_mat_view_prev_mat_2024_03_01; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalencies_mat_view_prev_mat_2024_03_01 AS
 WITH rules AS (
         SELECT DISTINCT ON (source.rule_identifier) source.rule_identifier AS equivalency_id,
            source.unique_identifier AS source_institution_id,
            source.course_id AS source_course_id,
            target.unique_identifier AS target_institution_id,
            target.course_id AS target_course_id,
            source.effective_begin_year_month,
            source.effective_end_year_month,
            source.operator,
            'RULE'::text AS equivalency_type,
            ( SELECT jsonb_object_agg(unprocessed_equivalencies.course_id, unprocessed_equivalencies.operator) AS jsonb_object_agg
                   FROM public.unprocessed_equivalencies
                  WHERE ((unprocessed_equivalencies.course_type = 'source'::text) AND (unprocessed_equivalencies.unique_identifier = source.unique_identifier) AND (unprocessed_equivalencies.rule_identifier = source.rule_identifier))) AS many_source_course_ids,
            ( SELECT jsonb_object_agg(unprocessed_equivalencies.course_id, unprocessed_equivalencies.operator) AS jsonb_object_agg
                   FROM public.unprocessed_equivalencies
                  WHERE ((unprocessed_equivalencies.course_type = 'target'::text) AND (unprocessed_equivalencies.unique_identifier = target.unique_identifier) AND (unprocessed_equivalencies.rule_identifier = source.rule_identifier))) AS many_target_course_ids
           FROM (public.unprocessed_equivalencies source
             JOIN public.unprocessed_equivalencies target ON ((source.rule_identifier = target.rule_identifier)))
          WHERE ((source.course_type = 'source'::text) AND (target.course_type = 'target'::text))
          ORDER BY source.rule_identifier
        ), accepted_suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            graph_db_output.effective_begin_year_month,
            graph_db_output.effective_end_year_month,
            'SUGGESTION'::text AS equivalency_type,
            NULL::text AS operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM public.graph_db_output
          WHERE (graph_db_output.decision = 'ACCEPTED'::public.suggestiondecision)
        ), equivalencies AS (
         SELECT rules.equivalency_id,
            rules.source_institution_id,
            rules.source_course_id,
            rules.target_institution_id,
            rules.target_course_id,
            rules.effective_begin_year_month,
            rules.effective_end_year_month,
            rules.operator,
            rules.equivalency_type,
            rules.many_source_course_ids,
            rules.many_target_course_ids
           FROM rules
        UNION ALL
         SELECT accepted_suggestions.equivalency_id,
            accepted_suggestions.source_institution_id,
            accepted_suggestions.source_course_id,
            accepted_suggestions.target_institution_id,
            accepted_suggestions.target_course_id,
            accepted_suggestions.effective_begin_year_month,
            accepted_suggestions.effective_end_year_month,
            accepted_suggestions.equivalency_type,
            accepted_suggestions.operator,
            accepted_suggestions.many_source_course_ids,
            accepted_suggestions.many_target_course_ids
           FROM accepted_suggestions
        ), deduplicated_equivalencies AS (
         SELECT DISTINCT ON (equivalencies.source_course_id, equivalencies.target_course_id) equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.effective_begin_year_month,
            equivalencies.effective_end_year_month,
            equivalencies.operator,
            equivalencies.equivalency_type,
            equivalencies.many_source_course_ids,
            equivalencies.many_target_course_ids
           FROM equivalencies
          ORDER BY equivalencies.source_course_id, equivalencies.target_course_id, equivalencies.equivalency_id
        )
 SELECT deduplicated_equivalencies.equivalency_id,
    deduplicated_equivalencies.source_institution_id,
    deduplicated_equivalencies.source_course_id,
    deduplicated_equivalencies.target_institution_id,
    deduplicated_equivalencies.target_course_id,
    deduplicated_equivalencies.effective_begin_year_month,
    deduplicated_equivalencies.effective_end_year_month,
    deduplicated_equivalencies.operator,
    deduplicated_equivalencies.equivalency_type,
    deduplicated_equivalencies.many_source_course_ids,
    deduplicated_equivalencies.many_target_course_ids
   FROM deduplicated_equivalencies
  WITH NO DATA;


--
-- Name: equivalencies_mat_view_prev_nov_2023_11_05; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalencies_mat_view_prev_nov_2023_11_05 AS
 WITH rules AS (
         SELECT DISTINCT ON (source.rule_identifier) source.rule_identifier AS equivalency_id,
            source.unique_identifier AS source_institution_id,
            source.course_id AS source_course_id,
            target.unique_identifier AS target_institution_id,
            target.course_id AS target_course_id,
            'RULE'::text AS equivalency_type
           FROM (public.unprocessed_equivalencies source
             JOIN public.unprocessed_equivalencies target ON ((source.rule_identifier = target.rule_identifier)))
          WHERE ((source.course_type = 'source'::text) AND (target.course_type = 'target'::text))
          ORDER BY source.rule_identifier
        ), accepted_suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            'SUGGESTION'::text AS equivalency_type
           FROM public.graph_db_output
          WHERE (graph_db_output.decision = 'ACCEPTED'::public.suggestiondecision)
        )
 SELECT rules.equivalency_id,
    rules.source_institution_id,
    rules.source_course_id,
    rules.target_institution_id,
    rules.target_course_id,
    rules.equivalency_type
   FROM rules
UNION ALL
 SELECT accepted_suggestions.equivalency_id,
    accepted_suggestions.source_institution_id,
    accepted_suggestions.source_course_id,
    accepted_suggestions.target_institution_id,
    accepted_suggestions.target_course_id,
    accepted_suggestions.equivalency_type
   FROM accepted_suggestions
  WITH NO DATA;


--
-- Name: equivalencies_with_implied_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalencies_with_implied_mat_view AS
 WITH equivalencies AS (
         SELECT equivalencies_mat_view.equivalency_id AS implied_equivalency_id,
            equivalencies_mat_view.equivalency_id,
            equivalencies_mat_view.source_institution_id,
            equivalencies_mat_view.source_course_id,
            equivalencies_mat_view.target_institution_id,
            equivalencies_mat_view.target_course_id,
            equivalencies_mat_view.effective_begin_year_month,
            equivalencies_mat_view.effective_end_year_month,
            equivalencies_mat_view.equivalency_type,
                CASE
                    WHEN (equivalencies_mat_view.source_course_group = 'null'::jsonb) THEN NULL::jsonb
                    ELSE equivalencies_mat_view.source_course_group
                END AS source_course_group,
                CASE
                    WHEN (equivalencies_mat_view.target_course_group = 'null'::jsonb) THEN NULL::jsonb
                    ELSE equivalencies_mat_view.target_course_group
                END AS target_course_group,
            false AS is_implied
           FROM public.equivalencies_mat_view
        ), implied_equivalencies AS (
         SELECT ((districts_mat_view.member_id || '__'::text) || emv.equivalency_id) AS implied_equivalency_id,
            emv.equivalency_id,
            districts_mat_view.member_id_int AS source_institution_id,
            emv.source_course_id,
            emv.target_institution_id,
            emv.target_course_id,
            emv.effective_begin_year_month,
            emv.effective_end_year_month,
            emv.equivalency_type,
                CASE
                    WHEN (emv.source_course_group = 'null'::jsonb) THEN NULL::jsonb
                    ELSE emv.source_course_group
                END AS source_course_group,
                CASE
                    WHEN (emv.target_course_group = 'null'::jsonb) THEN NULL::jsonb
                    ELSE emv.target_course_group
                END AS target_course_group,
            true AS is_implied
           FROM (public.equivalencies_mat_view emv
             JOIN public.districts_mat_view ON ((districts_mat_view.district_id_int = emv.source_institution_id)))
          WHERE (districts_mat_view.is_district_member = false)
        ), all_equivalencies AS (
         SELECT equivalencies.implied_equivalency_id,
            equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.effective_begin_year_month,
            equivalencies.effective_end_year_month,
            equivalencies.equivalency_type,
            equivalencies.source_course_group,
            equivalencies.target_course_group,
            equivalencies.is_implied
           FROM equivalencies
        UNION ALL
         SELECT implied_equivalencies.implied_equivalency_id,
            implied_equivalencies.equivalency_id,
            implied_equivalencies.source_institution_id,
            implied_equivalencies.source_course_id,
            implied_equivalencies.target_institution_id,
            implied_equivalencies.target_course_id,
            implied_equivalencies.effective_begin_year_month,
            implied_equivalencies.effective_end_year_month,
            implied_equivalencies.equivalency_type,
            implied_equivalencies.source_course_group,
            implied_equivalencies.target_course_group,
            implied_equivalencies.is_implied
           FROM implied_equivalencies
        )
 SELECT all_equivalencies.implied_equivalency_id,
    all_equivalencies.equivalency_id,
    all_equivalencies.source_institution_id,
    all_equivalencies.source_course_id,
    all_equivalencies.target_institution_id,
    all_equivalencies.target_course_id,
    all_equivalencies.effective_begin_year_month,
    all_equivalencies.effective_end_year_month,
    all_equivalencies.equivalency_type,
    all_equivalencies.source_course_group,
    all_equivalencies.target_course_group,
    all_equivalencies.is_implied
   FROM all_equivalencies
  WITH NO DATA;


--
-- Name: equivalency_source_course_mapping_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalency_source_course_mapping_mat_view AS
 WITH mapping_from_source_course_group AS (
         SELECT e.equivalency_id,
            (kv.value ->> 'course_id'::text) AS course_id,
                CASE
                    WHEN ((kv.value ->> 'course_id'::text) ~* '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'::text) THEN ((kv.value ->> 'course_id'::text))::uuid
                    ELSE NULL::uuid
                END AS course_id_uuid
           FROM (public.equivalencies_mat_view e
             CROSS JOIN LATERAL jsonb_each(COALESCE(e.source_course_group, '{}'::jsonb)) kv(key, value))
          WHERE ((jsonb_typeof(e.source_course_group) = 'object'::text) AND ((kv.value ->> 'course_id'::text) IS NOT NULL) AND ((kv.value ->> 'course_id'::text) <> ''::text))
        ), mapping_from_source_course AS (
         SELECT e.equivalency_id,
            (e.source_course_id)::text AS course_id,
            e.source_course_id AS course_id_uuid
           FROM public.equivalencies_mat_view e
        ), mapping AS (
         SELECT mapping_from_source_course_group.equivalency_id,
            mapping_from_source_course_group.course_id,
            mapping_from_source_course_group.course_id_uuid
           FROM mapping_from_source_course_group
        UNION ALL
         SELECT mapping_from_source_course.equivalency_id,
            mapping_from_source_course.course_id,
            mapping_from_source_course.course_id_uuid
           FROM mapping_from_source_course
        ), distinct_mapping AS (
         SELECT DISTINCT ON (mapping.course_id, mapping.equivalency_id) mapping.equivalency_id,
            mapping.course_id,
            mapping.course_id_uuid
           FROM mapping
        )
 SELECT distinct_mapping.equivalency_id,
    distinct_mapping.course_id,
    distinct_mapping.course_id_uuid
   FROM distinct_mapping
  WITH NO DATA;


--
-- Name: equivalency_target_course_mapping_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.equivalency_target_course_mapping_mat_view AS
 WITH mapping_from_target_course_group AS (
         SELECT DISTINCT e.equivalency_id,
            (kv.value ->> 'course_id'::text) AS course_id,
                CASE
                    WHEN ((kv.value ->> 'course_id'::text) ~* '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'::text) THEN ((kv.value ->> 'course_id'::text))::uuid
                    ELSE NULL::uuid
                END AS course_id_uuid
           FROM (public.equivalencies_mat_view e
             CROSS JOIN LATERAL jsonb_each(COALESCE(e.target_course_group, '{}'::jsonb)) kv(key, value))
          WHERE ((jsonb_typeof(e.target_course_group) = 'object'::text) AND ((kv.value ->> 'course_id'::text) IS NOT NULL) AND ((kv.value ->> 'course_id'::text) <> ''::text))
        ), mapping_from_target_course AS (
         SELECT DISTINCT e.equivalency_id,
            (e.target_course_id)::text AS course_id,
            e.target_course_id AS course_id_uuid
           FROM public.equivalencies_mat_view e
        ), mapping AS (
         SELECT mapping_from_target_course_group.equivalency_id,
            mapping_from_target_course_group.course_id,
            mapping_from_target_course_group.course_id_uuid
           FROM mapping_from_target_course_group
        UNION ALL
         SELECT mapping_from_target_course.equivalency_id,
            mapping_from_target_course.course_id,
            mapping_from_target_course.course_id_uuid
           FROM mapping_from_target_course
        ), distinct_mapping AS (
         SELECT DISTINCT ON (mapping.course_id, mapping.equivalency_id) mapping.equivalency_id,
            mapping.course_id,
            mapping.course_id_uuid
           FROM mapping
        )
 SELECT distinct_mapping.equivalency_id,
    distinct_mapping.course_id,
    distinct_mapping.course_id_uuid
   FROM distinct_mapping
  WITH NO DATA;


--
-- Name: equivalency_upload_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.equivalency_upload_status (
    auto_id integer NOT NULL,
    file_name text,
    upload_type text,
    upload_date text,
    status text,
    institution_total integer,
    institution_new integer,
    rules_total integer,
    rules_new integer,
    rules_affected integer,
    rules_deleted integer,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    missing_rule_id integer,
    missing_source_target_id integer,
    error text,
    format_error text,
    critical_error_info jsonb,
    format_error_info jsonb,
    file_name_raw text,
    is_applied boolean,
    district_translation integer,
    s3_uri text,
    rule_ingestion_table_name text,
    course_ingestion_table_name text,
    district_rule_map_table_name text,
    ingestion_status public.ingestionstatus,
    rules_total_accepted integer,
    rows_total integer,
    rows_total_accepted integer,
    institution_accepted integer
);


--
-- Name: equivalency_upload_status_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.equivalency_upload_status_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: equivalency_upload_status_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.equivalency_upload_status_auto_id_seq OWNED BY public.equivalency_upload_status.auto_id;


--
-- Name: evaluation_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.evaluation_group (
    evaluation_group_id integer NOT NULL,
    evaluation_group_name text NOT NULL,
    description text,
    user_ids integer[],
    inst_id integer,
    status public."Evaluationgroupstatus" NOT NULL,
    created_by_user_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    updated_by_user_id integer
);


--
-- Name: evaluation_group_evaluation_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.evaluation_group_evaluation_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evaluation_group_evaluation_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.evaluation_group_evaluation_group_id_seq OWNED BY public.evaluation_group.evaluation_group_id;


--
-- Name: faq_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faq_link (
    id integer NOT NULL,
    faq_link text NOT NULL
);


--
-- Name: faq_link_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faq_link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faq_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faq_link_id_seq OWNED BY public.faq_link.id;


--
-- Name: feed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feed (
    id text NOT NULL,
    current_feed_index bigint NOT NULL,
    created_at_epoch bigint NOT NULL,
    updated_at_epoch bigint NOT NULL
);


--
-- Name: feed_session_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feed_session_mapping (
    id text NOT NULL,
    feed_id text NOT NULL,
    session_id text NOT NULL,
    created_at_epoch bigint NOT NULL,
    updated_at_epoch bigint NOT NULL
);


--
-- Name: file_normalization_job; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_normalization_job (
    job_id text NOT NULL,
    created_by_user_id text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    input_file_download_url text NOT NULL,
    input_file_name text NOT NULL,
    output_file_upload_url text NOT NULL,
    output_file_download_url text NOT NULL,
    output_file_name text NOT NULL,
    status text NOT NULL,
    result jsonb NOT NULL,
    error_message text NOT NULL,
    data jsonb NOT NULL,
    input_s3_key text NOT NULL,
    output_s3_key text NOT NULL,
    s3_bucket_name text NOT NULL
);


--
-- Name: file_upload_process; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_upload_process (
    uuid integer NOT NULL,
    file_name text,
    format text,
    meta text,
    uploaded_by_id integer,
    status text,
    reason text
);


--
-- Name: file_upload_process_uuid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.file_upload_process_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_upload_process_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.file_upload_process_uuid_seq OWNED BY public.file_upload_process.uuid;


--
-- Name: general_education_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.general_education_category (
    general_education_category_id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    creator_user_id integer NOT NULL,
    last_updater_user_id integer NOT NULL
);


--
-- Name: general_education_category_general_education_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.general_education_category_general_education_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: general_education_category_general_education_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.general_education_category_general_education_category_id_seq OWNED BY public.general_education_category.general_education_category_id;


--
-- Name: general_education_crosswalk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.general_education_crosswalk (
    general_education_crosswalk_id integer NOT NULL,
    institution_id integer NOT NULL,
    prefix text,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    creator_user_id integer NOT NULL,
    last_updater_user_id integer NOT NULL,
    category_id integer NOT NULL
);


--
-- Name: general_education_crosswalk_general_education_crosswalk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.general_education_crosswalk_general_education_crosswalk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: general_education_crosswalk_general_education_crosswalk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.general_education_crosswalk_general_education_crosswalk_id_seq OWNED BY public.general_education_crosswalk.general_education_crosswalk_id;


--
-- Name: genres_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.genres_mv AS
 SELECT DISTINCT ed.id,
    (ed.data ->> 'name'::text) AS name
   FROM public.entities ed
  WHERE (ed.type = 'tmdb/genres/movie'::text)
  WITH NO DATA;


--
-- Name: global_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.global_auto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: graph_db_output_uuid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.graph_db_output_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: graph_db_output_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.graph_db_output_uuid_seq OWNED BY public.graph_db_output.uuid;


--
-- Name: identity_providers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_providers (
    uuid integer NOT NULL,
    name text,
    data_created timestamp without time zone
);


--
-- Name: identity_providers_uuid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.identity_providers_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identity_providers_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.identity_providers_uuid_seq OWNED BY public.identity_providers.uuid;


--
-- Name: inquiry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inquiry (
    inquiry_id uuid NOT NULL,
    from_email text NOT NULL,
    subject text NOT NULL,
    message text NOT NULL,
    utc_created_at timestamp with time zone NOT NULL,
    to_inst_id integer NOT NULL
);


--
-- Name: institution_profile_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institution_profile_link (
    auto_id integer NOT NULL,
    institution_id integer,
    url text NOT NULL,
    label text NOT NULL,
    "order" integer NOT NULL
);


--
-- Name: institution_profile_link_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.institution_profile_link_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_profile_link_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.institution_profile_link_auto_id_seq OWNED BY public.institution_profile_link.auto_id;


--
-- Name: institution_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institution_settings (
    id integer NOT NULL,
    institution_id integer,
    suggestion_management_email_frequency public.notificationfrequency,
    minimum_confidence_score_percentage_for_review double precision,
    course_effective_date timestamp without time zone,
    should_receive_alignment_suggestions boolean,
    coding_scheme public.coding_scheme_enum DEFAULT 'IPEDS'::public.coding_scheme_enum NOT NULL,
    should_align_state_connect_suggestions boolean DEFAULT false,
    should_receive_state_connect_suggestions boolean DEFAULT true,
    suggestion_configurations jsonb,
    threshold_for_state_align integer,
    should_exclude_inactive_courses boolean
);


--
-- Name: institution_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.institution_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.institution_settings_id_seq OWNED BY public.institution_settings.id;


--
-- Name: institutions_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.institutions_mat_view AS
 SELECT master_universities.auto_id,
    master_universities.institution_id,
    TRIM(BOTH FROM master_universities.name) AS name,
    master_universities.city,
    master_universities.state,
    master_universities.death_year,
    master_universities.closed_at,
    master_universities.date_created,
    master_universities.date_updated,
    master_universities.last_updated_by,
    master_universities.web_address,
    master_universities.primary_contact_first_name,
    master_universities.primary_contact_last_name,
    master_universities.primary_contact_email,
    master_universities.site_id,
    master_universities.district_id,
    master_universities.label,
    master_universities.ipeds_info,
    master_universities.graph_vertex_id,
    master_universities.next_suggestion_date,
    master_universities.last_suggestion_date,
    master_universities.status,
    master_universities.deactivation_date,
    master_universities.avatar_url,
    master_universities.zip_code,
    master_universities.about,
    master_universities.offerings,
    (
        CASE
            WHEN ((master_universities.ipeds_info ->> 'DistrictIdentifier'::text) ~ '^[0-9]+$'::text) THEN (master_universities.ipeds_info ->> 'DistrictIdentifier'::text)
            ELSE '-1'::text
        END)::integer AS district_identifier,
    master_universities.third_party_data_available,
        CASE
            WHEN ((jsonb_typeof(master_universities.ipeds_info) = 'object'::text) AND (jsonb_typeof((master_universities.ipeds_info -> 'HideIndicator'::text)) = 'string'::text) AND (TRIM(BOTH FROM upper((master_universities.ipeds_info ->> 'HideIndicator'::text))) = 'Y'::text)) THEN true
            ELSE false
        END AS is_hidden
   FROM public.master_universities
  WITH NO DATA;


--
-- Name: ipeds_upload_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ipeds_upload_status (
    auto_id integer NOT NULL,
    file_name text,
    upload_type text,
    upload_date text,
    institution_total text,
    status text,
    ingestion_status public.ingestionstatus,
    file_name_raw text,
    s3_uri text
);


--
-- Name: ipeds_upload_status_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ipeds_upload_status_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ipeds_upload_status_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ipeds_upload_status_auto_id_seq OWNED BY public.ipeds_upload_status.auto_id;


--
-- Name: key_value_store; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.key_value_store (
    key text NOT NULL,
    value text NOT NULL
);


--
-- Name: master_institution_name_aliases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_institution_name_aliases (
    alias_spelling text NOT NULL,
    master_institution_name text,
    name text
);


--
-- Name: master_ipeds_export; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_ipeds_export (
    unit_id integer NOT NULL,
    institution_name text NOT NULL,
    address text,
    city text,
    state text,
    death_year text,
    closed_at text
);


--
-- Name: master_ipeds_export_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_ipeds_export_unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_ipeds_export_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_ipeds_export_unit_id_seq OWNED BY public.master_ipeds_export.unit_id;


--
-- Name: master_universities_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.master_universities_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: master_universities_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.master_universities_auto_id_seq OWNED BY public.master_universities.auto_id;


--
-- Name: media_images_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.media_images_mv AS
 WITH config_data AS (
         SELECT entities.data
           FROM public.entities
          WHERE ((entities.type = 'tmdb/configuration'::text) AND (entities.data ? 'images'::text) AND ((entities.data -> 'images'::text) ? 'secure_base_url'::text) AND ((entities.data -> 'images'::text) ? 'poster_sizes'::text) AND ((entities.data -> 'images'::text) ? 'backdrop_sizes'::text) AND (jsonb_typeof(((entities.data -> 'images'::text) -> 'poster_sizes'::text)) = 'array'::text) AND (jsonb_typeof(((entities.data -> 'images'::text) -> 'backdrop_sizes'::text)) = 'array'::text))
         LIMIT 1
        ), tmdb_config AS (
         SELECT ((cd.data -> 'images'::text) ->> 'secure_base_url'::text) AS base_url,
            poster_elem.value AS poster_size,
            (poster_elem.ordinality - 1) AS resolution_order,
            poster_elem.ordinality AS poster_idx
           FROM (config_data cd
             CROSS JOIN LATERAL jsonb_array_elements_text(((cd.data -> 'images'::text) -> 'poster_sizes'::text)) WITH ORDINALITY poster_elem(value, ordinality))
        ), poster_images AS (
         SELECT (((((ed.data ->> 'id'::text) || '_poster_'::text) || tc.poster_size) || '_'::text) || (tc.poster_idx - 1)) AS id,
            (ed.data ->> 'id'::text) AS media_id,
            'poster'::text AS image_type,
            tc.poster_size AS resolution,
            tc.resolution_order,
            ((tc.base_url || tc.poster_size) || (ed.data ->> 'poster_path'::text)) AS url
           FROM (public.entities ed
             CROSS JOIN tmdb_config tc)
          WHERE ((ed.type = 'tmdb/movie'::text) AND (ed.data ? 'poster_path'::text) AND ((ed.data ->> 'poster_path'::text) IS NOT NULL) AND ((ed.data ->> 'poster_path'::text) <> ''::text) AND (tc.base_url IS NOT NULL))
        ), backdrop_config AS (
         SELECT ((cd.data -> 'images'::text) ->> 'secure_base_url'::text) AS base_url,
            backdrop_elem.value AS backdrop_size,
            (backdrop_elem.ordinality - 1) AS resolution_order,
            backdrop_elem.ordinality AS backdrop_idx
           FROM (config_data cd
             CROSS JOIN LATERAL jsonb_array_elements_text(((cd.data -> 'images'::text) -> 'backdrop_sizes'::text)) WITH ORDINALITY backdrop_elem(value, ordinality))
        ), backdrop_images AS (
         SELECT (((((ed.data ->> 'id'::text) || '_backdrop_'::text) || bc.backdrop_size) || '_'::text) || (bc.backdrop_idx - 1)) AS id,
            (ed.data ->> 'id'::text) AS media_id,
            'backdrop'::text AS image_type,
            bc.backdrop_size AS resolution,
            bc.resolution_order,
            ((bc.base_url || bc.backdrop_size) || (ed.data ->> 'backdrop_path'::text)) AS url
           FROM (public.entities ed
             CROSS JOIN backdrop_config bc)
          WHERE ((ed.type = 'tmdb/movie'::text) AND (ed.data ? 'backdrop_path'::text) AND ((ed.data ->> 'backdrop_path'::text) IS NOT NULL) AND ((ed.data ->> 'backdrop_path'::text) <> ''::text) AND (bc.base_url IS NOT NULL))
        )
 SELECT poster_images.id,
    poster_images.media_id,
    poster_images.image_type,
    poster_images.resolution,
    poster_images.resolution_order,
    poster_images.url
   FROM poster_images
UNION ALL
 SELECT backdrop_images.id,
    backdrop_images.media_id,
    backdrop_images.image_type,
    backdrop_images.resolution,
    backdrop_images.resolution_order,
    backdrop_images.url
   FROM backdrop_images
  WITH NO DATA;


--
-- Name: media_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.media_mv AS
 SELECT COALESCE((entities.data ->> 'id'::text), md5((random())::text)) AS id,
    COALESCE((entities.data ->> 'title'::text), ''::text) AS title,
    COALESCE((entities.data ->> 'overview'::text), ''::text) AS description,
    COALESCE(((entities.data ->> 'popularity'::text))::double precision, (0)::double precision) AS popularity,
    COALESCE((entities.data ->> 'release_date'::text), ''::text) AS release_date,
    COALESCE(((entities.data ->> 'vote_average'::text))::double precision, (0)::double precision) AS vote_average,
    COALESCE(((entities.data ->> 'vote_count'::text))::integer, 0) AS vote_count,
    COALESCE(NULLIF(((entities.data ->> 'runtime'::text))::integer, 0), 0) AS runtime,
    COALESCE(((entities.data ->> 'adult'::text))::boolean, false) AS is_adult,
    COALESCE(((entities.data ->> 'id'::text))::integer, 0) AS tmdb_id
   FROM public.entities
  WHERE ((entities.type = 'tmdb/movie'::text) AND (entities.data ? 'id'::text))
  WITH NO DATA;


--
-- Name: media_denormalized_v; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.media_denormalized_v AS
 SELECT m.id,
    m.title,
    m.description,
    m.popularity,
    m.is_adult,
    COALESCE(( SELECT media_images_mv.url
           FROM public.media_images_mv
          WHERE ((media_images_mv.media_id = m.id) AND (media_images_mv.image_type = 'poster'::text))
          ORDER BY media_images_mv.resolution_order DESC
         LIMIT 1), ''::text) AS poster_url,
    COALESCE(( SELECT media_images_mv.url
           FROM public.media_images_mv
          WHERE ((media_images_mv.media_id = m.id) AND (media_images_mv.image_type = 'backdrop'::text))
          ORDER BY media_images_mv.resolution_order DESC
         LIMIT 1), ''::text) AS backdrop_url
   FROM public.media_mv m;


--
-- Name: media_genres_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.media_genres_mv AS
 SELECT (ed.data ->> 'id'::text) AS media_id,
    (genre_id.value)::text AS genre_id
   FROM (public.entities ed
     CROSS JOIN LATERAL jsonb_array_elements((ed.data -> 'genre_ids'::text)) genre_id(value))
  WHERE ((ed.type = 'tmdb/movie'::text) AND (ed.data ? 'genre_ids'::text) AND (jsonb_typeof((ed.data -> 'genre_ids'::text)) = 'array'::text))
  WITH NO DATA;


--
-- Name: partitioned_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
)
PARTITION BY LIST (uploaded_institution_id);


--
-- Name: partitioned_rules_0; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_0 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: mv_partitioned_rules_0; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_partitioned_rules_0 AS
 WITH rules AS (
         SELECT DISTINCT ON (source.unique_rule_identifier) source.unique_rule_identifier AS equivalency_id,
            source.unique_identifier AS source_institution_id,
            source.course_id AS source_course_id,
            target.unique_identifier AS target_institution_id,
            target.course_id AS target_course_id,
            source.effective_begin_year_month,
            source.effective_end_year_month,
            'RULE'::text AS equivalency_type,
            (grouped_rules_view.source_cg)::jsonb AS source_course_group,
            (grouped_rules_view.target_cg)::jsonb AS target_course_group,
            source.operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM ((public.partitioned_rules_0 source
             JOIN public.partitioned_rules_0 target ON ((source.unique_rule_identifier = target.unique_rule_identifier)))
             LEFT JOIN public.grouped_rules_view ON ((source.unique_rule_identifier = grouped_rules_view.rule_identifier)))
          WHERE ((source.course_type = 'source'::text) AND (target.course_type = 'target'::text))
          ORDER BY source.unique_rule_identifier
        ), accepted_suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            graph_db_output.effective_begin_year_month,
            graph_db_output.effective_end_year_month,
            'SUGGESTION'::text AS equivalency_type,
            graph_db_output.source_course_group,
            graph_db_output.target_course_group,
            NULL::text AS operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM public.graph_db_output
          WHERE ((graph_db_output.date_deleted IS NULL) AND (graph_db_output.decision = 'ACCEPTED'::public.suggestiondecision) AND (graph_db_output.target_institution_id = 0))
        ), equivalencies AS (
         SELECT rules.equivalency_id,
            rules.source_institution_id,
            rules.source_course_id,
            rules.target_institution_id,
            rules.target_course_id,
            rules.effective_begin_year_month,
            rules.effective_end_year_month,
            rules.equivalency_type,
            rules.source_course_group,
            rules.target_course_group,
            rules.operator,
            rules.many_source_course_ids,
            rules.many_target_course_ids
           FROM rules
        UNION ALL
         SELECT accepted_suggestions.equivalency_id,
            accepted_suggestions.source_institution_id,
            accepted_suggestions.source_course_id,
            accepted_suggestions.target_institution_id,
            accepted_suggestions.target_course_id,
            accepted_suggestions.effective_begin_year_month,
            accepted_suggestions.effective_end_year_month,
            accepted_suggestions.equivalency_type,
            accepted_suggestions.source_course_group,
            accepted_suggestions.target_course_group,
            accepted_suggestions.operator,
            accepted_suggestions.many_source_course_ids,
            accepted_suggestions.many_target_course_ids
           FROM accepted_suggestions
        ), deduplicated_equivalencies AS (
         SELECT DISTINCT ON (equivalencies.source_course_id, equivalencies.target_course_id) equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.effective_begin_year_month,
            equivalencies.effective_end_year_month,
            equivalencies.equivalency_type,
            equivalencies.source_course_group,
            equivalencies.target_course_group,
            equivalencies.operator,
            equivalencies.many_source_course_ids,
            equivalencies.many_target_course_ids
           FROM equivalencies
          ORDER BY equivalencies.source_course_id, equivalencies.target_course_id, equivalencies.equivalency_id
        )
 SELECT deduplicated_equivalencies.equivalency_id,
    deduplicated_equivalencies.source_institution_id,
    deduplicated_equivalencies.source_course_id,
    deduplicated_equivalencies.target_institution_id,
    deduplicated_equivalencies.target_course_id,
    deduplicated_equivalencies.effective_begin_year_month,
    deduplicated_equivalencies.effective_end_year_month,
    deduplicated_equivalencies.equivalency_type,
    deduplicated_equivalencies.source_course_group,
    deduplicated_equivalencies.target_course_group,
    deduplicated_equivalencies.operator,
    deduplicated_equivalencies.many_source_course_ids,
    deduplicated_equivalencies.many_target_course_ids
   FROM deduplicated_equivalencies
  WITH NO DATA;


--
-- Name: partitioned_rules_1; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_1 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: mv_partitioned_rules_1; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_partitioned_rules_1 AS
 WITH rules AS (
         SELECT DISTINCT ON (source.unique_rule_identifier) source.unique_rule_identifier AS equivalency_id,
            source.unique_identifier AS source_institution_id,
            source.course_id AS source_course_id,
            target.unique_identifier AS target_institution_id,
            target.course_id AS target_course_id,
            source.effective_begin_year_month,
            source.effective_end_year_month,
            'RULE'::text AS equivalency_type,
            (grouped_rules_view.source_cg)::jsonb AS source_course_group,
            (grouped_rules_view.target_cg)::jsonb AS target_course_group,
            source.operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM ((public.partitioned_rules_1 source
             JOIN public.partitioned_rules_1 target ON ((source.unique_rule_identifier = target.unique_rule_identifier)))
             LEFT JOIN public.grouped_rules_view ON ((source.unique_rule_identifier = grouped_rules_view.rule_identifier)))
          WHERE ((source.course_type = 'source'::text) AND (target.course_type = 'target'::text))
          ORDER BY source.unique_rule_identifier
        ), accepted_suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            graph_db_output.effective_begin_year_month,
            graph_db_output.effective_end_year_month,
            'SUGGESTION'::text AS equivalency_type,
            graph_db_output.source_course_group,
            graph_db_output.target_course_group,
            NULL::text AS operator,
            '{}'::jsonb AS many_source_course_ids,
            '{}'::jsonb AS many_target_course_ids
           FROM public.graph_db_output
          WHERE ((graph_db_output.date_deleted IS NULL) AND (graph_db_output.decision = 'ACCEPTED'::public.suggestiondecision) AND (graph_db_output.target_institution_id = 1))
        ), equivalencies AS (
         SELECT rules.equivalency_id,
            rules.source_institution_id,
            rules.source_course_id,
            rules.target_institution_id,
            rules.target_course_id,
            rules.effective_begin_year_month,
            rules.effective_end_year_month,
            rules.equivalency_type,
            rules.source_course_group,
            rules.target_course_group,
            rules.operator,
            rules.many_source_course_ids,
            rules.many_target_course_ids
           FROM rules
        UNION ALL
         SELECT accepted_suggestions.equivalency_id,
            accepted_suggestions.source_institution_id,
            accepted_suggestions.source_course_id,
            accepted_suggestions.target_institution_id,
            accepted_suggestions.target_course_id,
            accepted_suggestions.effective_begin_year_month,
            accepted_suggestions.effective_end_year_month,
            accepted_suggestions.equivalency_type,
            accepted_suggestions.source_course_group,
            accepted_suggestions.target_course_group,
            accepted_suggestions.operator,
            accepted_suggestions.many_source_course_ids,
            accepted_suggestions.many_target_course_ids
           FROM accepted_suggestions
        ), deduplicated_equivalencies AS (
         SELECT DISTINCT ON (equivalencies.source_course_id, equivalencies.target_course_id) equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.effective_begin_year_month,
            equivalencies.effective_end_year_month,
            equivalencies.equivalency_type,
            equivalencies.source_course_group,
            equivalencies.target_course_group,
            equivalencies.operator,
            equivalencies.many_source_course_ids,
            equivalencies.many_target_course_ids
           FROM equivalencies
          ORDER BY equivalencies.source_course_id, equivalencies.target_course_id, equivalencies.equivalency_id
        )
 SELECT deduplicated_equivalencies.equivalency_id,
    deduplicated_equivalencies.source_institution_id,
    deduplicated_equivalencies.source_course_id,
    deduplicated_equivalencies.target_institution_id,
    deduplicated_equivalencies.target_course_id,
    deduplicated_equivalencies.effective_begin_year_month,
    deduplicated_equivalencies.effective_end_year_month,
    deduplicated_equivalencies.equivalency_type,
    deduplicated_equivalencies.source_course_group,
    deduplicated_equivalencies.target_course_group,
    deduplicated_equivalencies.operator,
    deduplicated_equivalencies.many_source_course_ids,
    deduplicated_equivalencies.many_target_course_ids
   FROM deduplicated_equivalencies
  WITH NO DATA;


--
-- Name: oauth2_authorization_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth2_authorization_codes (
    id integer NOT NULL,
    code character varying(100) NOT NULL,
    redirect_uri character varying(255),
    expires_in integer NOT NULL,
    user_id integer NOT NULL,
    client_id character varying(40) NOT NULL
);


--
-- Name: oauth2_authorization_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth2_authorization_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_authorization_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth2_authorization_codes_id_seq OWNED BY public.oauth2_authorization_codes.id;


--
-- Name: oauth2_clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth2_clients (
    id integer NOT NULL,
    client_id character varying(40) NOT NULL,
    client_secret character varying(55) NOT NULL,
    redirect_uris character varying(255) NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: oauth2_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth2_clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth2_clients_id_seq OWNED BY public.oauth2_clients.id;


--
-- Name: oauth2_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth2_tokens (
    id integer NOT NULL,
    access_token character varying(100) NOT NULL,
    refresh_token character varying(100),
    token_type character varying(40) NOT NULL,
    expires_in integer NOT NULL,
    user_id integer NOT NULL,
    client_id character varying(40) NOT NULL
);


--
-- Name: oauth2_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth2_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth2_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth2_tokens_id_seq OWNED BY public.oauth2_tokens.id;


--
-- Name: oauth_tokens_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_tokens_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_tokens_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_tokens_token_id_seq OWNED BY public.api_tokens.token_id;


--
-- Name: partition_change_tracker; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partition_change_tracker (
    id integer NOT NULL,
    uploaded_institution_id integer NOT NULL,
    last_change_time timestamp without time zone DEFAULT now() NOT NULL,
    needs_refresh boolean DEFAULT false NOT NULL,
    needs_new_load_files boolean DEFAULT false NOT NULL,
    last_operation text DEFAULT 'INSERT'::text NOT NULL,
    partition_name text NOT NULL,
    mv_name text NOT NULL,
    last_refresh_time timestamp without time zone,
    last_refresh_successful boolean DEFAULT false
);


--
-- Name: partition_change_tracker_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.partition_change_tracker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: partition_change_tracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.partition_change_tracker_id_seq OWNED BY public.partition_change_tracker.id;


--
-- Name: partitioned_rules_104179; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_104179 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: partitioned_rules_105330; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_105330 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: partitioned_rules_105525; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_105525 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: partitioned_rules_182290; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_182290 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: partitioned_rules_206941; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_206941 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: partitioned_rules_223816; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.partitioned_rules_223816 (
    auto_id integer DEFAULT nextval('public.global_auto_id_seq'::regclass) NOT NULL,
    rule_identifier text NOT NULL,
    course_type text NOT NULL,
    institution_name text NOT NULL,
    unique_identifier integer,
    city text,
    state text,
    country text,
    course_order integer NOT NULL,
    course_subject text NOT NULL,
    course_number text NOT NULL,
    level text,
    course_title text,
    min_rule_credit_hours double precision,
    min_credit_hours double precision,
    max_credit_hours double precision,
    effective_begin_year_month text,
    effective_end_year_month text,
    operator text,
    elective_indicator text,
    gened_category_name text,
    exclude_from_triangulation text,
    uploaded_user_id integer,
    uploaded_institution_id integer NOT NULL,
    is_modified_rule boolean,
    course_id uuid,
    upload_date timestamp without time zone DEFAULT now(),
    last_accepted_suggestion_date timestamp without time zone,
    graph_edge_id uuid,
    graph_source_vertex_id uuid,
    graph_target_vertex_id uuid,
    unique_rule_identifier text GENERATED ALWAYS AS ((((uploaded_institution_id)::text || '__'::text) || rule_identifier)) STORED NOT NULL
);


--
-- Name: peer_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.peer_groups (
    peer_group_id text NOT NULL,
    peer_group_name text NOT NULL,
    belongs_to_inst_id integer,
    inst_ids integer[] NOT NULL,
    match_threshold integer NOT NULL,
    created_by_user_id integer NOT NULL,
    utc_created_at timestamp without time zone,
    utc_updated_at timestamp without time zone,
    updated_by_user_id integer NOT NULL
);


--
-- Name: rate_limiting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_limiting (
    auto_id integer NOT NULL,
    user_id integer NOT NULL,
    request_timestamp timestamp without time zone
);


--
-- Name: rate_limiting_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rate_limiting_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_limiting_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_limiting_auto_id_seq OWNED BY public.rate_limiting.auto_id;


--
-- Name: run_triangulation_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.run_triangulation_log (
    id integer NOT NULL,
    ran_at_datetime timestamp without time zone NOT NULL,
    ran_by_user_id integer NOT NULL,
    ran_for_inst_id integer NOT NULL,
    run_log_id text NOT NULL
);


--
-- Name: run_triangulation_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.run_triangulation_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: run_triangulation_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.run_triangulation_log_id_seq OWNED BY public.run_triangulation_log.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: suggestion_decisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_decisions (
    decision_id integer NOT NULL,
    suggestion_id integer NOT NULL,
    decision public.suggestiondecision NOT NULL,
    decided_at_utc timestamp without time zone,
    decided_by_user_id integer NOT NULL,
    rejection_reasons public.suggestionrejectionreason[],
    deleted_at_utc timestamp without time zone,
    deleted_by_user_id integer,
    workflow_id integer
);


--
-- Name: suggestion_decisions_decision_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.suggestion_decisions_decision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suggestion_decisions_decision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.suggestion_decisions_decision_id_seq OWNED BY public.suggestion_decisions.decision_id;


--
-- Name: suggestion_request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_request (
    id integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    name text NOT NULL,
    description text,
    status public.suggestionrequeststatus NOT NULL,
    request_date timestamp without time zone NOT NULL,
    assigned_user_id integer,
    requested_by_user_id integer NOT NULL,
    request_id text,
    requested_by_inst_id integer NOT NULL,
    completed_date timestamp without time zone,
    updated_date timestamp without time zone,
    minimun_confidence_score double precision
);


--
-- Name: suggestion_request_align_course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_request_align_course (
    id integer NOT NULL,
    source_institution_levels public.instlevel[] NOT NULL,
    is_all_institution_levels boolean NOT NULL,
    source_states text[] NOT NULL,
    source_institution_ids integer[] NOT NULL,
    target_course_subject text,
    target_course_number text
);


--
-- Name: suggestion_request_find_course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_request_find_course (
    id integer NOT NULL,
    target_course_subject text,
    target_course_number text,
    source_institution_levels public.instlevel[] NOT NULL,
    is_all_institution_levels boolean NOT NULL,
    source_states text[] NOT NULL,
    source_institution_ids integer[] NOT NULL,
    source_course_subject text,
    source_course_number text
);


--
-- Name: suggestion_request_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.suggestion_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suggestion_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.suggestion_request_id_seq OWNED BY public.suggestion_request.id;


--
-- Name: suggestion_request_improve_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_request_improve_rules (
    id integer NOT NULL,
    target_course_subject text,
    is_all_target_course_subject boolean,
    target_course_number text,
    is_all_target_course_number boolean,
    source_institution_levels public.instlevel[],
    source_states text[],
    source_institution_ids integer[],
    source_course_request jsonb
);


--
-- Name: suggestion_request_partner_institution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.suggestion_request_partner_institution (
    id integer NOT NULL,
    source_institution_ids integer[] NOT NULL,
    source_states text[] NOT NULL,
    source_institution_levels public.instlevel[]
);


--
-- Name: suggestion_types_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.suggestion_types_mat_view AS
 WITH state_connect AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'STATE_CONNECT'::text AS suggestion_type,
            'State connect'::text AS label,
            1 AS priority
           FROM public.graph_db_output
          WHERE (graph_db_output.record_type = 'STATE_CONNECT'::public.recordtype)
        ), state_align AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'STATE_ALIGNMENT'::text AS suggestion_type,
            'State alignment'::text AS label,
            7 AS priority
           FROM public.graph_db_output
          WHERE (graph_db_output.record_type = 'STATE_ALIGNMENT'::public.recordtype)
        ), alignment_new AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'ALIGNMENT_NEW'::text AS suggestion_type,
            'New alignment'::text AS label,
            3 AS priority
           FROM public.graph_db_output
          WHERE (graph_db_output.alignment_type = 'ABSENT'::public.alignmenttype)
        ), alignment_out_of AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'ALIGNMENT_OUT_OF'::text AS suggestion_type,
            'Out of alignment'::text AS label,
            4 AS priority
           FROM public.graph_db_output
          WHERE (graph_db_output.alignment_type = 'ODD_MAN_OUT'::public.alignmenttype)
        ), boost_find_course AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'BOOST_FIND_COURSE'::text AS suggestion_type,
            'Find Course Boost'::text AS label,
            5 AS priority
           FROM ((public.graph_db_output
             JOIN public.suggestion_request ON ((graph_db_output.source_suggestion_request_id = suggestion_request.request_id)))
             JOIN public.suggestion_request_find_course ON ((suggestion_request.id = suggestion_request_find_course.id)))
        ), boost_improve_rules AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'BOOST_IMPROVE_RULES'::text AS suggestion_type,
            'Improve Rules Boost'::text AS label,
            6 AS priority
           FROM ((public.graph_db_output
             JOIN public.suggestion_request ON ((graph_db_output.source_suggestion_request_id = suggestion_request.request_id)))
             JOIN public.suggestion_request_improve_rules ON ((suggestion_request.id = suggestion_request_improve_rules.id)))
        ), boost_partner_inst AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'BOOST_PARTNER_INST'::text AS suggestion_type,
            'Partner Institution Boost'::text AS label,
            7 AS priority
           FROM ((public.graph_db_output
             JOIN public.suggestion_request ON ((graph_db_output.source_suggestion_request_id = suggestion_request.request_id)))
             JOIN public.suggestion_request_partner_institution ON ((suggestion_request.id = suggestion_request_partner_institution.id)))
        ), triangulation AS (
         SELECT graph_db_output.uuid AS suggestion_id,
            'TRIANGULATION'::text AS suggestion_type,
            'Triangulation'::text AS label,
            8 AS priority
           FROM public.graph_db_output
        ), combined AS (
         SELECT alignment_new.suggestion_id,
            alignment_new.suggestion_type,
            alignment_new.label,
            alignment_new.priority
           FROM alignment_new
        UNION ALL
         SELECT alignment_out_of.suggestion_id,
            alignment_out_of.suggestion_type,
            alignment_out_of.label,
            alignment_out_of.priority
           FROM alignment_out_of
        UNION ALL
         SELECT boost_find_course.suggestion_id,
            boost_find_course.suggestion_type,
            boost_find_course.label,
            boost_find_course.priority
           FROM boost_find_course
        UNION ALL
         SELECT boost_improve_rules.suggestion_id,
            boost_improve_rules.suggestion_type,
            boost_improve_rules.label,
            boost_improve_rules.priority
           FROM boost_improve_rules
        UNION ALL
         SELECT boost_partner_inst.suggestion_id,
            boost_partner_inst.suggestion_type,
            boost_partner_inst.label,
            boost_partner_inst.priority
           FROM boost_partner_inst
        UNION ALL
         SELECT state_connect.suggestion_id,
            state_connect.suggestion_type,
            state_connect.label,
            state_connect.priority
           FROM state_connect
        UNION ALL
         SELECT state_align.suggestion_id,
            state_align.suggestion_type,
            state_align.label,
            state_align.priority
           FROM state_align
        UNION ALL
         SELECT triangulation.suggestion_id,
            triangulation.suggestion_type,
            triangulation.label,
            triangulation.priority
           FROM triangulation
        ), ranked AS (
         SELECT combined.suggestion_id,
            combined.suggestion_type,
            combined.label,
            combined.priority,
            row_number() OVER (PARTITION BY combined.suggestion_id ORDER BY combined.priority) AS rn
           FROM combined
        )
 SELECT ranked.suggestion_id,
    ranked.suggestion_type,
    ranked.label
   FROM ranked
  WHERE (ranked.rn = 1)
  WITH NO DATA;


--
-- Name: suggestions_or_equivalencies_mat_view; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.suggestions_or_equivalencies_mat_view AS
 WITH suggestions AS (
         SELECT (graph_db_output.uuid)::text AS equivalency_id,
            graph_db_output.source_institution_id,
            graph_db_output.source_course_id,
            graph_db_output.target_institution_id,
            graph_db_output.target_course_id,
            graph_db_output.effective_begin_year_month,
            graph_db_output.effective_end_year_month,
            'SUGGESTION'::text AS equivalency_type
           FROM public.graph_db_output
          WHERE (graph_db_output.date_deleted IS NULL)
        ), equivalencies AS (
         SELECT equivalencies_mat_view.equivalency_id,
            equivalencies_mat_view.source_institution_id,
            equivalencies_mat_view.source_course_id,
            equivalencies_mat_view.target_institution_id,
            equivalencies_mat_view.target_course_id,
            equivalencies_mat_view.effective_begin_year_month,
            equivalencies_mat_view.effective_end_year_month,
            equivalencies_mat_view.equivalency_type
           FROM public.equivalencies_mat_view
        ), combined AS (
         SELECT suggestions.equivalency_id,
            suggestions.source_institution_id,
            suggestions.source_course_id,
            suggestions.target_institution_id,
            suggestions.target_course_id,
            suggestions.effective_begin_year_month,
            suggestions.effective_end_year_month,
            suggestions.equivalency_type
           FROM suggestions
        UNION ALL
         SELECT equivalencies.equivalency_id,
            equivalencies.source_institution_id,
            equivalencies.source_course_id,
            equivalencies.target_institution_id,
            equivalencies.target_course_id,
            equivalencies.effective_begin_year_month,
            equivalencies.effective_end_year_month,
            equivalencies.equivalency_type
           FROM equivalencies
        ), deduplicated AS (
         SELECT DISTINCT ON (combined.equivalency_id, combined.equivalency_type) combined.equivalency_id,
            combined.source_institution_id,
            combined.source_course_id,
            combined.target_institution_id,
            combined.target_course_id,
            combined.effective_begin_year_month,
            combined.effective_end_year_month,
            combined.equivalency_type
           FROM combined
          ORDER BY combined.equivalency_id, combined.equivalency_type
        )
 SELECT deduplicated.equivalency_id,
    deduplicated.source_institution_id,
    deduplicated.source_course_id,
    deduplicated.target_institution_id,
    deduplicated.target_course_id,
    deduplicated.effective_begin_year_month,
    deduplicated.effective_end_year_month,
    deduplicated.equivalency_type
   FROM deduplicated
  WITH NO DATA;


--
-- Name: syllabus_upload_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.syllabus_upload_status (
    auto_id integer NOT NULL,
    file_name text,
    upload_type text,
    upload_date timestamp without time zone,
    status text,
    uploaded_user_id integer,
    uploaded_institution_id integer,
    critical_error_info jsonb,
    format_error_info jsonb,
    file_name_raw text,
    is_applied boolean,
    s3_uri text,
    ingestion_status public.ingestionstatus
);


--
-- Name: syllabus_upload_status_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.syllabus_upload_status_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: syllabus_upload_status_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.syllabus_upload_status_auto_id_seq OWNED BY public.syllabus_upload_status.auto_id;


--
-- Name: threshold_value; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.threshold_value (
    threshold_value_id integer NOT NULL,
    institution_id integer,
    creator_user_id integer,
    target_course_subject text,
    target_course_number text,
    condition public.condition,
    confidence_score_percentage double precision,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: threshold_value_threshold_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.threshold_value_threshold_value_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: threshold_value_threshold_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.threshold_value_threshold_value_id_seq OWNED BY public.threshold_value.threshold_value_id;


--
-- Name: unprocessed_equivalencies_auto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unprocessed_equivalencies_auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unprocessed_equivalencies_auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unprocessed_equivalencies_auto_id_seq OWNED BY public.unprocessed_equivalencies.auto_id;


--
-- Name: user_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_accounts (
    user_id text NOT NULL,
    phone_number text NOT NULL,
    created_at_epoch bigint NOT NULL,
    last_updated_at_epoch bigint NOT NULL
);


--
-- Name: user_action_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_action_tokens (
    token_id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying NOT NULL,
    action public.useraction NOT NULL,
    created_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    used_at timestamp without time zone,
    extra jsonb,
    issued_by_user_id integer NOT NULL
);


--
-- Name: user_action_tokens_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_action_tokens_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_action_tokens_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_action_tokens_token_id_seq OWNED BY public.user_action_tokens.token_id;


--
-- Name: user_notification_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_notification_settings (
    uuid integer NOT NULL,
    user_id integer NOT NULL,
    notification_type public.notificationtype,
    notification_frequency public.notificationfrequency,
    active boolean
);


--
-- Name: user_notification_settings_uuid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_notification_settings_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_notification_settings_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_notification_settings_uuid_seq OWNED BY public.user_notification_settings.uuid;


--
-- Name: user_password_hashes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_password_hashes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    password_hash character varying NOT NULL,
    utc_created_at timestamp without time zone NOT NULL
);


--
-- Name: user_password_hashes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_password_hashes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_password_hashes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_password_hashes_id_seq OWNED BY public.user_password_hashes.id;


--
-- Name: user_request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_request (
    request_id integer NOT NULL,
    uuid integer NOT NULL,
    user_request_type public.userrequesttype NOT NULL,
    user_request_status public.userrequeststatus NOT NULL,
    date_created timestamp without time zone,
    decided_by_user_id integer,
    extra jsonb
);


--
-- Name: user_request_request_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_request_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_request_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_request_request_id_seq OWNED BY public.user_request.request_id;


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    user_session_id text NOT NULL,
    user_id text NOT NULL,
    session_id text NOT NULL,
    created_at_epoch bigint NOT NULL,
    ended_at_epoch bigint NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    uuid integer NOT NULL,
    email public.citext,
    first_name text NOT NULL,
    last_name text NOT NULL,
    identity_vendor_user_id text,
    role public.userrole NOT NULL,
    status public.userstatus NOT NULL,
    institution_id integer,
    profile_avatar text,
    assignee text,
    change_assignee text,
    last_login timestamp without time zone,
    date_created timestamp without time zone,
    password_state public.passwordstate,
    title text,
    pre_inst_suspend_status public.userstatus
);


--
-- Name: users_uuid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_uuid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_uuid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_uuid_seq OWNED BY public.users.uuid;


--
-- Name: workflow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    source_state character varying[],
    source_institution text[],
    target_subject text[],
    target_level text[],
    workflow_type public.workflow_scheme_type NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    modified_at timestamp without time zone DEFAULT now() NOT NULL,
    created_by integer,
    inst_id integer,
    target_course_range_temp jsonb,
    target_course_range jsonb[],
    score integer,
    is_deleted boolean DEFAULT false
);


--
-- Name: workflow_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workflow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workflow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workflow_id_seq OWNED BY public.workflow.id;


--
-- Name: workflow_response; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_response (
    id text NOT NULL,
    user_id text NOT NULL,
    inst_id integer,
    workflow_id integer,
    group_id integer,
    comments text,
    response text,
    suggestion_id text,
    response_status text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: workflow_response_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_response_status (
    id text NOT NULL,
    workflow_id integer NOT NULL,
    suggestion_id text NOT NULL,
    status text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: workflow_scheme_approver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_scheme_approver (
    id integer NOT NULL,
    approver integer NOT NULL
);


--
-- Name: workflow_scheme_commenter_approver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_scheme_commenter_approver (
    id integer NOT NULL,
    commenter integer NOT NULL,
    approver integer NOT NULL
);


--
-- Name: workflow_scheme_commenter_group_approver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_scheme_commenter_group_approver (
    id integer NOT NULL,
    commenter integer NOT NULL,
    group_id integer NOT NULL,
    approver integer NOT NULL,
    group_days_threshold text,
    group_vote_threshold text
);


--
-- Name: workflow_scheme_dual_commenter_approver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_scheme_dual_commenter_approver (
    id integer NOT NULL,
    first_commenter integer NOT NULL,
    second_commenter integer NOT NULL,
    approver integer NOT NULL
);


--
-- Name: workflow_scheme_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_scheme_group (
    id integer NOT NULL,
    group_id integer NOT NULL,
    group_days_threshold text,
    group_vote_threshold text
);


--
-- Name: workflow_scheme_group_approver; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_scheme_group_approver (
    id integer NOT NULL,
    group_id integer NOT NULL,
    approver integer NOT NULL,
    group_days_threshold text,
    group_vote_threshold text
);


--
-- Name: zip_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zip_codes (
    zip_code character varying(20) NOT NULL,
    city character varying(50),
    state_full character varying(50),
    state_abbr character(2),
    county character varying(50),
    county_code integer,
    latitude double precision,
    longitude double precision,
    geom public.geometry(Point,4326)
);


--
-- Name: partitioned_rules_0; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_0 FOR VALUES IN (0);


--
-- Name: partitioned_rules_1; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_1 FOR VALUES IN (1);


--
-- Name: partitioned_rules_104179; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_104179 FOR VALUES IN (104179);


--
-- Name: partitioned_rules_105330; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_105330 FOR VALUES IN (105330);


--
-- Name: partitioned_rules_105525; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_105525 FOR VALUES IN (105525);


--
-- Name: partitioned_rules_182290; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_182290 FOR VALUES IN (182290);


--
-- Name: partitioned_rules_206941; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_206941 FOR VALUES IN (206941);


--
-- Name: partitioned_rules_223816; Type: TABLE ATTACH; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules ATTACH PARTITION public.partitioned_rules_223816 FOR VALUES IN (223816);


--
-- Name: _temp_catalog_1759060992_0ea3bc auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060992_0ea3bc ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060992_0ea3bc_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060993_ed1085 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060993_ed1085 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060993_ed1085_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060994_0ff21d auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060994_0ff21d ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060994_0ff21d_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060994_157d59 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060994_157d59 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060994_157d59_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060995_17fcf8 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060995_17fcf8 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060995_17fcf8_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060996_c9a3ff auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060996_c9a3ff ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060996_c9a3ff_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060996_e454e2 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060996_e454e2 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060996_e454e2_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060997_c13594 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060997_c13594 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060997_c13594_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060998_0dfa59 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060998_0dfa59 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060998_0dfa59_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060998_c3631e auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060998_c3631e ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060998_c3631e_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060999_1b0fe1 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060999_1b0fe1 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060999_1b0fe1_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060999_acbd29 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060999_acbd29 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759060999_acbd29_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061000_9a0992 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061000_9a0992 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061000_9a0992_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061000_dd02f1 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061000_dd02f1 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061000_dd02f1_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061001_e56456 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061001_e56456 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061001_e56456_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061002_41ea00 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061002_41ea00 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061002_41ea00_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061002_7c0f5a auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061002_7c0f5a ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061002_7c0f5a_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061003_dea9b4 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061003_dea9b4 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061003_dea9b4_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061004_c7fe61 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061004_c7fe61 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061004_c7fe61_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061005_633c1b auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061005_633c1b ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061005_633c1b_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061005_e72243 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061005_e72243 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061005_e72243_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061006_f58a15 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061006_f58a15 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061006_f58a15_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061006_ff7a44 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061006_ff7a44 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061006_ff7a44_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061007_50ae78 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061007_50ae78 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061007_50ae78_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061007_a20784 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061007_a20784 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061007_a20784_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061008_2c44e2 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061008_2c44e2 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061008_2c44e2_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061008_c92293 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061008_c92293 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061008_c92293_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061009_9f4232 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061009_9f4232 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061009_9f4232_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061010_0d3559 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061010_0d3559 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061010_0d3559_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061011_0ccdde auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_0ccdde ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061011_0ccdde_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061011_67ee4d auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_67ee4d ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061011_67ee4d_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061011_9c8f93 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_9c8f93 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061011_9c8f93_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061011_e633b4 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_e633b4 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061011_e633b4_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061011_eae01f auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_eae01f ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061011_eae01f_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061011_ed8547 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_ed8547 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061011_ed8547_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061012_98fc90 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061012_98fc90 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061012_98fc90_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061017_8917f4 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061017_8917f4 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061017_8917f4_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061044_94f913 auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061044_94f913 ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061044_94f913_auto_id_seq'::regclass);


--
-- Name: _temp_catalog_1759061050_db1f9a auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061050_db1f9a ALTER COLUMN auto_id SET DEFAULT nextval('public._temp_catalog_1759061050_db1f9a_auto_id_seq'::regclass);


--
-- Name: analytics_table_alignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_alignments ALTER COLUMN id SET DEFAULT nextval('public.analytics_table_alignments_id_seq'::regclass);


--
-- Name: analytics_table_boost id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_boost ALTER COLUMN id SET DEFAULT nextval('public.analytics_table_boost_id_seq'::regclass);


--
-- Name: analytics_table_suggestions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_suggestions ALTER COLUMN id SET DEFAULT nextval('public.analytics_table_suggestions_id_seq'::regclass);


--
-- Name: api_tokens token_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens ALTER COLUMN token_id SET DEFAULT nextval('public.oauth_tokens_token_id_seq'::regclass);


--
-- Name: app_event id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event ALTER COLUMN id SET DEFAULT nextval('public.app_event_id_seq'::regclass);


--
-- Name: audit_table_publish_course_inventory auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table_publish_course_inventory ALTER COLUMN auto_id SET DEFAULT nextval('public.audit_table_publish_course_inventory_auto_id_seq'::regclass);


--
-- Name: audit_table_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table_requests ALTER COLUMN id SET DEFAULT nextval('public.audit_table_requests_id_seq'::regclass);


--
-- Name: course_catalog_upload_status auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_catalog_upload_status ALTER COLUMN auto_id SET DEFAULT nextval('public.course_catalog_upload_status_auto_id_seq'::regclass);


--
-- Name: deployment_status id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deployment_status ALTER COLUMN id SET DEFAULT nextval('public.deployment_status_id_seq'::regclass);


--
-- Name: district_rule_map auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district_rule_map ALTER COLUMN auto_id SET DEFAULT nextval('public.district_rule_map_auto_id_seq'::regclass);


--
-- Name: districts district_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts ALTER COLUMN district_id SET DEFAULT nextval('public.districts_district_id_seq'::regclass);


--
-- Name: equivalency_upload_status auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equivalency_upload_status ALTER COLUMN auto_id SET DEFAULT nextval('public.equivalency_upload_status_auto_id_seq'::regclass);


--
-- Name: evaluation_group evaluation_group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group ALTER COLUMN evaluation_group_id SET DEFAULT nextval('public.evaluation_group_evaluation_group_id_seq'::regclass);


--
-- Name: faq_link id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_link ALTER COLUMN id SET DEFAULT nextval('public.faq_link_id_seq'::regclass);


--
-- Name: file_upload_process uuid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_upload_process ALTER COLUMN uuid SET DEFAULT nextval('public.file_upload_process_uuid_seq'::regclass);


--
-- Name: general_education_category general_education_category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_category ALTER COLUMN general_education_category_id SET DEFAULT nextval('public.general_education_category_general_education_category_id_seq'::regclass);


--
-- Name: general_education_crosswalk general_education_crosswalk_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk ALTER COLUMN general_education_crosswalk_id SET DEFAULT nextval('public.general_education_crosswalk_general_education_crosswalk_id_seq'::regclass);


--
-- Name: graph_db_output uuid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output ALTER COLUMN uuid SET DEFAULT nextval('public.graph_db_output_uuid_seq'::regclass);


--
-- Name: identity_providers uuid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_providers ALTER COLUMN uuid SET DEFAULT nextval('public.identity_providers_uuid_seq'::regclass);


--
-- Name: institution_profile_link auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institution_profile_link ALTER COLUMN auto_id SET DEFAULT nextval('public.institution_profile_link_auto_id_seq'::regclass);


--
-- Name: institution_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institution_settings ALTER COLUMN id SET DEFAULT nextval('public.institution_settings_id_seq'::regclass);


--
-- Name: ipeds_upload_status auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ipeds_upload_status ALTER COLUMN auto_id SET DEFAULT nextval('public.ipeds_upload_status_auto_id_seq'::regclass);


--
-- Name: master_ipeds_export unit_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_ipeds_export ALTER COLUMN unit_id SET DEFAULT nextval('public.master_ipeds_export_unit_id_seq'::regclass);


--
-- Name: master_universities auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_universities ALTER COLUMN auto_id SET DEFAULT nextval('public.master_universities_auto_id_seq'::regclass);


--
-- Name: oauth2_authorization_codes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_authorization_codes ALTER COLUMN id SET DEFAULT nextval('public.oauth2_authorization_codes_id_seq'::regclass);


--
-- Name: oauth2_clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_clients ALTER COLUMN id SET DEFAULT nextval('public.oauth2_clients_id_seq'::regclass);


--
-- Name: oauth2_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_tokens ALTER COLUMN id SET DEFAULT nextval('public.oauth2_tokens_id_seq'::regclass);


--
-- Name: partition_change_tracker id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partition_change_tracker ALTER COLUMN id SET DEFAULT nextval('public.partition_change_tracker_id_seq'::regclass);


--
-- Name: rate_limiting auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limiting ALTER COLUMN auto_id SET DEFAULT nextval('public.rate_limiting_auto_id_seq'::regclass);


--
-- Name: run_triangulation_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.run_triangulation_log ALTER COLUMN id SET DEFAULT nextval('public.run_triangulation_log_id_seq'::regclass);


--
-- Name: suggestion_decisions decision_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_decisions ALTER COLUMN decision_id SET DEFAULT nextval('public.suggestion_decisions_decision_id_seq'::regclass);


--
-- Name: suggestion_request id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request ALTER COLUMN id SET DEFAULT nextval('public.suggestion_request_id_seq'::regclass);


--
-- Name: syllabus_upload_status auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.syllabus_upload_status ALTER COLUMN auto_id SET DEFAULT nextval('public.syllabus_upload_status_auto_id_seq'::regclass);


--
-- Name: threshold_value threshold_value_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.threshold_value ALTER COLUMN threshold_value_id SET DEFAULT nextval('public.threshold_value_threshold_value_id_seq'::regclass);


--
-- Name: unprocessed_equivalencies auto_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unprocessed_equivalencies ALTER COLUMN auto_id SET DEFAULT nextval('public.unprocessed_equivalencies_auto_id_seq'::regclass);


--
-- Name: user_action_tokens token_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_action_tokens ALTER COLUMN token_id SET DEFAULT nextval('public.user_action_tokens_token_id_seq'::regclass);


--
-- Name: user_notification_settings uuid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_notification_settings ALTER COLUMN uuid SET DEFAULT nextval('public.user_notification_settings_uuid_seq'::regclass);


--
-- Name: user_password_hashes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_password_hashes ALTER COLUMN id SET DEFAULT nextval('public.user_password_hashes_id_seq'::regclass);


--
-- Name: user_request request_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_request ALTER COLUMN request_id SET DEFAULT nextval('public.user_request_request_id_seq'::regclass);


--
-- Name: users uuid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN uuid SET DEFAULT nextval('public.users_uuid_seq'::regclass);


--
-- Name: workflow id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow ALTER COLUMN id SET DEFAULT nextval('public.workflow_id_seq'::regclass);


--
-- Name: _temp_catalog_1759060992_0ea3bc _temp_catalog_1759060992_0ea3bc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060992_0ea3bc
    ADD CONSTRAINT _temp_catalog_1759060992_0ea3bc_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060993_ed1085 _temp_catalog_1759060993_ed1085_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060993_ed1085
    ADD CONSTRAINT _temp_catalog_1759060993_ed1085_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060994_0ff21d _temp_catalog_1759060994_0ff21d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060994_0ff21d
    ADD CONSTRAINT _temp_catalog_1759060994_0ff21d_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060994_157d59 _temp_catalog_1759060994_157d59_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060994_157d59
    ADD CONSTRAINT _temp_catalog_1759060994_157d59_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060995_17fcf8 _temp_catalog_1759060995_17fcf8_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060995_17fcf8
    ADD CONSTRAINT _temp_catalog_1759060995_17fcf8_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060996_c9a3ff _temp_catalog_1759060996_c9a3ff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060996_c9a3ff
    ADD CONSTRAINT _temp_catalog_1759060996_c9a3ff_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060996_e454e2 _temp_catalog_1759060996_e454e2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060996_e454e2
    ADD CONSTRAINT _temp_catalog_1759060996_e454e2_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060997_c13594 _temp_catalog_1759060997_c13594_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060997_c13594
    ADD CONSTRAINT _temp_catalog_1759060997_c13594_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060998_0dfa59 _temp_catalog_1759060998_0dfa59_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060998_0dfa59
    ADD CONSTRAINT _temp_catalog_1759060998_0dfa59_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060998_c3631e _temp_catalog_1759060998_c3631e_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060998_c3631e
    ADD CONSTRAINT _temp_catalog_1759060998_c3631e_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060999_1b0fe1 _temp_catalog_1759060999_1b0fe1_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060999_1b0fe1
    ADD CONSTRAINT _temp_catalog_1759060999_1b0fe1_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759060999_acbd29 _temp_catalog_1759060999_acbd29_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759060999_acbd29
    ADD CONSTRAINT _temp_catalog_1759060999_acbd29_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061000_9a0992 _temp_catalog_1759061000_9a0992_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061000_9a0992
    ADD CONSTRAINT _temp_catalog_1759061000_9a0992_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061000_dd02f1 _temp_catalog_1759061000_dd02f1_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061000_dd02f1
    ADD CONSTRAINT _temp_catalog_1759061000_dd02f1_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061001_e56456 _temp_catalog_1759061001_e56456_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061001_e56456
    ADD CONSTRAINT _temp_catalog_1759061001_e56456_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061002_41ea00 _temp_catalog_1759061002_41ea00_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061002_41ea00
    ADD CONSTRAINT _temp_catalog_1759061002_41ea00_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061002_7c0f5a _temp_catalog_1759061002_7c0f5a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061002_7c0f5a
    ADD CONSTRAINT _temp_catalog_1759061002_7c0f5a_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061003_dea9b4 _temp_catalog_1759061003_dea9b4_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061003_dea9b4
    ADD CONSTRAINT _temp_catalog_1759061003_dea9b4_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061004_c7fe61 _temp_catalog_1759061004_c7fe61_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061004_c7fe61
    ADD CONSTRAINT _temp_catalog_1759061004_c7fe61_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061005_633c1b _temp_catalog_1759061005_633c1b_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061005_633c1b
    ADD CONSTRAINT _temp_catalog_1759061005_633c1b_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061005_e72243 _temp_catalog_1759061005_e72243_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061005_e72243
    ADD CONSTRAINT _temp_catalog_1759061005_e72243_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061006_f58a15 _temp_catalog_1759061006_f58a15_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061006_f58a15
    ADD CONSTRAINT _temp_catalog_1759061006_f58a15_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061006_ff7a44 _temp_catalog_1759061006_ff7a44_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061006_ff7a44
    ADD CONSTRAINT _temp_catalog_1759061006_ff7a44_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061007_50ae78 _temp_catalog_1759061007_50ae78_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061007_50ae78
    ADD CONSTRAINT _temp_catalog_1759061007_50ae78_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061007_a20784 _temp_catalog_1759061007_a20784_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061007_a20784
    ADD CONSTRAINT _temp_catalog_1759061007_a20784_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061008_2c44e2 _temp_catalog_1759061008_2c44e2_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061008_2c44e2
    ADD CONSTRAINT _temp_catalog_1759061008_2c44e2_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061008_c92293 _temp_catalog_1759061008_c92293_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061008_c92293
    ADD CONSTRAINT _temp_catalog_1759061008_c92293_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061009_9f4232 _temp_catalog_1759061009_9f4232_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061009_9f4232
    ADD CONSTRAINT _temp_catalog_1759061009_9f4232_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061010_0d3559 _temp_catalog_1759061010_0d3559_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061010_0d3559
    ADD CONSTRAINT _temp_catalog_1759061010_0d3559_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061011_0ccdde _temp_catalog_1759061011_0ccdde_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_0ccdde
    ADD CONSTRAINT _temp_catalog_1759061011_0ccdde_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061011_67ee4d _temp_catalog_1759061011_67ee4d_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_67ee4d
    ADD CONSTRAINT _temp_catalog_1759061011_67ee4d_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061011_9c8f93 _temp_catalog_1759061011_9c8f93_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_9c8f93
    ADD CONSTRAINT _temp_catalog_1759061011_9c8f93_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061011_e633b4 _temp_catalog_1759061011_e633b4_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_e633b4
    ADD CONSTRAINT _temp_catalog_1759061011_e633b4_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061011_eae01f _temp_catalog_1759061011_eae01f_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_eae01f
    ADD CONSTRAINT _temp_catalog_1759061011_eae01f_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061011_ed8547 _temp_catalog_1759061011_ed8547_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061011_ed8547
    ADD CONSTRAINT _temp_catalog_1759061011_ed8547_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061012_98fc90 _temp_catalog_1759061012_98fc90_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061012_98fc90
    ADD CONSTRAINT _temp_catalog_1759061012_98fc90_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061017_8917f4 _temp_catalog_1759061017_8917f4_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061017_8917f4
    ADD CONSTRAINT _temp_catalog_1759061017_8917f4_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061044_94f913 _temp_catalog_1759061044_94f913_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061044_94f913
    ADD CONSTRAINT _temp_catalog_1759061044_94f913_pkey PRIMARY KEY (auto_id);


--
-- Name: _temp_catalog_1759061050_db1f9a _temp_catalog_1759061050_db1f9a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._temp_catalog_1759061050_db1f9a
    ADD CONSTRAINT _temp_catalog_1759061050_db1f9a_pkey PRIMARY KEY (auto_id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: analytics_table_alignments analytics_table_alignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_alignments
    ADD CONSTRAINT analytics_table_alignments_pkey PRIMARY KEY (id);


--
-- Name: analytics_table_boost analytics_table_boost_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_boost
    ADD CONSTRAINT analytics_table_boost_pkey PRIMARY KEY (id);


--
-- Name: analytics_table_suggestions analytics_table_suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_suggestions
    ADD CONSTRAINT analytics_table_suggestions_pkey PRIMARY KEY (id);


--
-- Name: app_event app_event_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event
    ADD CONSTRAINT app_event_pkey PRIMARY KEY (id);


--
-- Name: app_event_updated_inst_profile app_event_updated_inst_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_profile
    ADD CONSTRAINT app_event_updated_inst_profile_pkey PRIMARY KEY (id);


--
-- Name: app_event_updated_inst_settings app_event_updated_inst_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_settings
    ADD CONSTRAINT app_event_updated_inst_settings_pkey PRIMARY KEY (id);


--
-- Name: app_event_user_added_user app_event_user_added_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_added_user
    ADD CONSTRAINT app_event_user_added_user_pkey PRIMARY KEY (id);


--
-- Name: app_event_user_reviewed_suggestions app_event_user_reviewed_suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_reviewed_suggestions
    ADD CONSTRAINT app_event_user_reviewed_suggestions_pkey PRIMARY KEY (id);


--
-- Name: app_event_user_updated_profile app_event_user_updated_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_updated_profile
    ADD CONSTRAINT app_event_user_updated_profile_pkey PRIMARY KEY (id);


--
-- Name: app_event_user_uploaded_rules app_event_user_uploaded_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_uploaded_rules
    ADD CONSTRAINT app_event_user_uploaded_rules_pkey PRIMARY KEY (id);


--
-- Name: audit_table audit_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table
    ADD CONSTRAINT audit_table_pkey PRIMARY KEY (request_id);


--
-- Name: audit_table_publish_course_inventory audit_table_publish_course_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table_publish_course_inventory
    ADD CONSTRAINT audit_table_publish_course_inventory_pkey PRIMARY KEY (auto_id);


--
-- Name: audit_table_requests audit_table_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table_requests
    ADD CONSTRAINT audit_table_requests_pkey PRIMARY KEY (id);


--
-- Name: course_catalog_upload_status course_catalog_upload_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_catalog_upload_status
    ADD CONSTRAINT course_catalog_upload_status_pkey PRIMARY KEY (auto_id);


--
-- Name: course_metadata course_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_metadata
    ADD CONSTRAINT course_metadata_pkey PRIMARY KEY (course_id);


--
-- Name: custom_filter custom_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_filter
    ADD CONSTRAINT custom_filter_pkey PRIMARY KEY (custom_filter_id);


--
-- Name: custom_logic_filter custom_logic_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_logic_filter
    ADD CONSTRAINT custom_logic_filter_pkey PRIMARY KEY (custom_logic_filter_id);


--
-- Name: deployment_status deployment_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deployment_status
    ADD CONSTRAINT deployment_status_pkey PRIMARY KEY (id);


--
-- Name: district_rule_map district_rule_map_original_rule_identifier_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district_rule_map
    ADD CONSTRAINT district_rule_map_original_rule_identifier_key UNIQUE (original_rule_identifier, target_unique_identifier);


--
-- Name: districts districts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_pkey PRIMARY KEY (district_id);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (id, type);


--
-- Name: equivalency_upload_status equivalency_upload_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.equivalency_upload_status
    ADD CONSTRAINT equivalency_upload_status_pkey PRIMARY KEY (auto_id);


--
-- Name: evaluation_group evaluation_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group
    ADD CONSTRAINT evaluation_group_pkey PRIMARY KEY (evaluation_group_id);


--
-- Name: faq_link faq_link_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faq_link
    ADD CONSTRAINT faq_link_pkey PRIMARY KEY (id);


--
-- Name: feed feed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed
    ADD CONSTRAINT feed_pkey PRIMARY KEY (id);


--
-- Name: feed_session_mapping feed_session_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_pkey PRIMARY KEY (id);


--
-- Name: file_normalization_job file_normalization_job_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_normalization_job
    ADD CONSTRAINT file_normalization_job_pkey PRIMARY KEY (job_id);


--
-- Name: file_upload_process file_upload_process_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_upload_process
    ADD CONSTRAINT file_upload_process_pkey PRIMARY KEY (uuid);


--
-- Name: general_education_category general_education_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_category
    ADD CONSTRAINT general_education_category_pkey PRIMARY KEY (general_education_category_id);


--
-- Name: general_education_crosswalk general_education_crosswalk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk
    ADD CONSTRAINT general_education_crosswalk_pkey PRIMARY KEY (general_education_crosswalk_id);


--
-- Name: graph_db_output graph_db_output_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_pkey PRIMARY KEY (uuid);


--
-- Name: identity_providers identity_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_providers
    ADD CONSTRAINT identity_providers_pkey PRIMARY KEY (uuid);


--
-- Name: inquiry inquiry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_pkey PRIMARY KEY (inquiry_id);


--
-- Name: institution_profile_link institution_profile_link_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institution_profile_link
    ADD CONSTRAINT institution_profile_link_pkey PRIMARY KEY (auto_id);


--
-- Name: institution_settings institution_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institution_settings
    ADD CONSTRAINT institution_settings_pkey PRIMARY KEY (id);


--
-- Name: ipeds_upload_status ipeds_upload_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ipeds_upload_status
    ADD CONSTRAINT ipeds_upload_status_pkey PRIMARY KEY (auto_id);


--
-- Name: key_value_store key_value_store_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.key_value_store
    ADD CONSTRAINT key_value_store_pkey PRIMARY KEY (key);


--
-- Name: master_courses master_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_courses
    ADD CONSTRAINT master_courses_pkey PRIMARY KEY (course_id);


--
-- Name: master_institution_name_aliases master_institution_name_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_institution_name_aliases
    ADD CONSTRAINT master_institution_name_aliases_pkey PRIMARY KEY (alias_spelling);


--
-- Name: master_ipeds_export master_ipeds_export_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_ipeds_export
    ADD CONSTRAINT master_ipeds_export_pkey PRIMARY KEY (unit_id);


--
-- Name: master_universities master_universities_graph_vertex_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_universities
    ADD CONSTRAINT master_universities_graph_vertex_id_key UNIQUE (graph_vertex_id);


--
-- Name: master_universities master_universities_institution_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_universities
    ADD CONSTRAINT master_universities_institution_id_key UNIQUE (institution_id);


--
-- Name: master_universities master_universities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_universities
    ADD CONSTRAINT master_universities_pkey PRIMARY KEY (auto_id);


--
-- Name: unprocessed_equivalencies no_duplicates_constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unprocessed_equivalencies
    ADD CONSTRAINT no_duplicates_constraint UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_code_key UNIQUE (code);


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_pkey PRIMARY KEY (id);


--
-- Name: oauth2_clients oauth2_clients_client_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_clients
    ADD CONSTRAINT oauth2_clients_client_id_key UNIQUE (client_id);


--
-- Name: oauth2_clients oauth2_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_clients
    ADD CONSTRAINT oauth2_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth2_tokens oauth2_tokens_access_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_access_token_key UNIQUE (access_token);


--
-- Name: oauth2_tokens oauth2_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth2_tokens oauth2_tokens_refresh_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_refresh_token_key UNIQUE (refresh_token);


--
-- Name: api_tokens oauth_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT oauth_tokens_pkey PRIMARY KEY (token_id);


--
-- Name: partition_change_tracker partition_change_tracker_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partition_change_tracker
    ADD CONSTRAINT partition_change_tracker_pkey PRIMARY KEY (id);


--
-- Name: partitioned_rules partitioned_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules
    ADD CONSTRAINT partitioned_rules_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_0 partitioned_rules_0_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_0
    ADD CONSTRAINT partitioned_rules_0_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules partitioned_rules_rule_identifier_course_id_uploaded_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules
    ADD CONSTRAINT partitioned_rules_rule_identifier_course_id_uploaded_instit_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_0 partitioned_rules_0_rule_identifier_course_id_uploaded_inst_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_0
    ADD CONSTRAINT partitioned_rules_0_rule_identifier_course_id_uploaded_inst_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules partitioned_rules_rule_identifier_course_type_institution_n_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules
    ADD CONSTRAINT partitioned_rules_rule_identifier_course_type_institution_n_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_0 partitioned_rules_0_rule_identifier_course_type_institution_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_0
    ADD CONSTRAINT partitioned_rules_0_rule_identifier_course_type_institution_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_104179 partitioned_rules_104179_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_104179
    ADD CONSTRAINT partitioned_rules_104179_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_104179 partitioned_rules_104179_rule_identifier_course_id_uploaded_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_104179
    ADD CONSTRAINT partitioned_rules_104179_rule_identifier_course_id_uploaded_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_104179 partitioned_rules_104179_rule_identifier_course_type_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_104179
    ADD CONSTRAINT partitioned_rules_104179_rule_identifier_course_type_instit_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_105330 partitioned_rules_105330_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_105330
    ADD CONSTRAINT partitioned_rules_105330_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_105330 partitioned_rules_105330_rule_identifier_course_id_uploaded_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_105330
    ADD CONSTRAINT partitioned_rules_105330_rule_identifier_course_id_uploaded_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_105330 partitioned_rules_105330_rule_identifier_course_type_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_105330
    ADD CONSTRAINT partitioned_rules_105330_rule_identifier_course_type_instit_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_105525 partitioned_rules_105525_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_105525
    ADD CONSTRAINT partitioned_rules_105525_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_105525 partitioned_rules_105525_rule_identifier_course_id_uploaded_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_105525
    ADD CONSTRAINT partitioned_rules_105525_rule_identifier_course_id_uploaded_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_105525 partitioned_rules_105525_rule_identifier_course_type_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_105525
    ADD CONSTRAINT partitioned_rules_105525_rule_identifier_course_type_instit_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_182290 partitioned_rules_182290_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_182290
    ADD CONSTRAINT partitioned_rules_182290_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_182290 partitioned_rules_182290_rule_identifier_course_id_uploaded_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_182290
    ADD CONSTRAINT partitioned_rules_182290_rule_identifier_course_id_uploaded_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_182290 partitioned_rules_182290_rule_identifier_course_type_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_182290
    ADD CONSTRAINT partitioned_rules_182290_rule_identifier_course_type_instit_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_1 partitioned_rules_1_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_1
    ADD CONSTRAINT partitioned_rules_1_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_1 partitioned_rules_1_rule_identifier_course_id_uploaded_inst_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_1
    ADD CONSTRAINT partitioned_rules_1_rule_identifier_course_id_uploaded_inst_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_1 partitioned_rules_1_rule_identifier_course_type_institution_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_1
    ADD CONSTRAINT partitioned_rules_1_rule_identifier_course_type_institution_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_206941 partitioned_rules_206941_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_206941
    ADD CONSTRAINT partitioned_rules_206941_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_206941 partitioned_rules_206941_rule_identifier_course_id_uploaded_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_206941
    ADD CONSTRAINT partitioned_rules_206941_rule_identifier_course_id_uploaded_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_206941 partitioned_rules_206941_rule_identifier_course_type_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_206941
    ADD CONSTRAINT partitioned_rules_206941_rule_identifier_course_type_instit_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: partitioned_rules_223816 partitioned_rules_223816_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_223816
    ADD CONSTRAINT partitioned_rules_223816_pkey PRIMARY KEY (auto_id, uploaded_institution_id);


--
-- Name: partitioned_rules_223816 partitioned_rules_223816_rule_identifier_course_id_uploaded_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_223816
    ADD CONSTRAINT partitioned_rules_223816_rule_identifier_course_id_uploaded_key UNIQUE (rule_identifier, course_id, uploaded_institution_id);


--
-- Name: partitioned_rules_223816 partitioned_rules_223816_rule_identifier_course_type_instit_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partitioned_rules_223816
    ADD CONSTRAINT partitioned_rules_223816_rule_identifier_course_type_instit_key UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation, uploaded_institution_id);


--
-- Name: peer_groups peer_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.peer_groups
    ADD CONSTRAINT peer_groups_pkey PRIMARY KEY (peer_group_id);


--
-- Name: district_rule_map pk_district_rule_map; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district_rule_map
    ADD CONSTRAINT pk_district_rule_map PRIMARY KEY (auto_id);


--
-- Name: rate_limiting rate_limiting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limiting
    ADD CONSTRAINT rate_limiting_pkey PRIMARY KEY (auto_id);


--
-- Name: run_triangulation_log run_triangulation_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.run_triangulation_log
    ADD CONSTRAINT run_triangulation_log_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: suggestion_decisions suggestion_decisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_decisions
    ADD CONSTRAINT suggestion_decisions_pkey PRIMARY KEY (decision_id);


--
-- Name: suggestion_request_align_course suggestion_request_align_course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_align_course
    ADD CONSTRAINT suggestion_request_align_course_pkey PRIMARY KEY (id);


--
-- Name: suggestion_request_find_course suggestion_request_find_course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_find_course
    ADD CONSTRAINT suggestion_request_find_course_pkey PRIMARY KEY (id);


--
-- Name: suggestion_request_improve_rules suggestion_request_improve_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_improve_rules
    ADD CONSTRAINT suggestion_request_improve_rules_pkey PRIMARY KEY (id);


--
-- Name: suggestion_request_partner_institution suggestion_request_partner_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_partner_institution
    ADD CONSTRAINT suggestion_request_partner_institution_pkey PRIMARY KEY (id);


--
-- Name: suggestion_request suggestion_request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request
    ADD CONSTRAINT suggestion_request_pkey PRIMARY KEY (id);


--
-- Name: syllabus_upload_status syllabus_upload_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.syllabus_upload_status
    ADD CONSTRAINT syllabus_upload_status_pkey PRIMARY KEY (auto_id);


--
-- Name: threshold_value threshold_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.threshold_value
    ADD CONSTRAINT threshold_value_pkey PRIMARY KEY (threshold_value_id);


--
-- Name: unprocessed_equivalencies unique_combination_constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unprocessed_equivalencies
    ADD CONSTRAINT unique_combination_constraint UNIQUE (rule_identifier, course_type, institution_name, unique_identifier, city, state, country, course_order, course_subject, course_number, level, course_title, min_rule_credit_hours, min_credit_hours, max_credit_hours, effective_begin_year_month, effective_end_year_month, operator, elective_indicator, gened_category_name, exclude_from_triangulation);


--
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: master_courses unique_institution_courses_constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_courses
    ADD CONSTRAINT unique_institution_courses_constraint UNIQUE (institution_id, course_subject, course_number);


--
-- Name: suggestion_request unique_suggestion_request_id_constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request
    ADD CONSTRAINT unique_suggestion_request_id_constraint UNIQUE (request_id);


--
-- Name: partition_change_tracker unique_uploaded_institution_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.partition_change_tracker
    ADD CONSTRAINT unique_uploaded_institution_id UNIQUE (uploaded_institution_id);


--
-- Name: unprocessed_equivalencies unprocessed_equivalencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unprocessed_equivalencies
    ADD CONSTRAINT unprocessed_equivalencies_pkey PRIMARY KEY (auto_id);


--
-- Name: course_metadata uq_course_metadata_combination_master_course; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_metadata
    ADD CONSTRAINT uq_course_metadata_combination_master_course UNIQUE (master_course_id, data_source, inst_unique_id, course_subject, course_number, course_effective_year_month, course_expiration_year_month);


--
-- Name: users uq_email; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_email UNIQUE (email);


--
-- Name: user_accounts user_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_accounts
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (user_id);


--
-- Name: user_action_tokens user_action_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_action_tokens
    ADD CONSTRAINT user_action_tokens_pkey PRIMARY KEY (token_id);


--
-- Name: user_action_tokens user_action_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_action_tokens
    ADD CONSTRAINT user_action_tokens_token_key UNIQUE (token);


--
-- Name: user_notification_settings user_notification_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_notification_settings
    ADD CONSTRAINT user_notification_settings_pkey PRIMARY KEY (uuid);


--
-- Name: user_password_hashes user_password_hashes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_password_hashes
    ADD CONSTRAINT user_password_hashes_pkey PRIMARY KEY (id, user_id);


--
-- Name: user_request user_request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_request
    ADD CONSTRAINT user_request_pkey PRIMARY KEY (request_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (user_session_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uuid);


--
-- Name: workflow workflow_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow
    ADD CONSTRAINT workflow_pkey PRIMARY KEY (id);


--
-- Name: workflow_response workflow_response_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_response
    ADD CONSTRAINT workflow_response_pkey PRIMARY KEY (id);


--
-- Name: workflow_response_status workflow_response_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_response_status
    ADD CONSTRAINT workflow_response_status_pkey PRIMARY KEY (id);


--
-- Name: workflow_scheme_approver workflow_scheme_approver_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_approver
    ADD CONSTRAINT workflow_scheme_approver_pkey PRIMARY KEY (id, approver);


--
-- Name: workflow_scheme_commenter_approver workflow_scheme_commenter_approver_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_approver
    ADD CONSTRAINT workflow_scheme_commenter_approver_pkey PRIMARY KEY (id, commenter, approver);


--
-- Name: workflow_scheme_commenter_group_approver workflow_scheme_commenter_group_approver_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_group_approver
    ADD CONSTRAINT workflow_scheme_commenter_group_approver_pkey PRIMARY KEY (id);


--
-- Name: workflow_scheme_dual_commenter_approver workflow_scheme_dual_commenter_approver_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_dual_commenter_approver
    ADD CONSTRAINT workflow_scheme_dual_commenter_approver_pkey PRIMARY KEY (id, first_commenter, second_commenter, approver);


--
-- Name: workflow_scheme_group_approver workflow_scheme_group_approver_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group_approver
    ADD CONSTRAINT workflow_scheme_group_approver_pkey PRIMARY KEY (id);


--
-- Name: workflow_scheme_group workflow_scheme_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group
    ADD CONSTRAINT workflow_scheme_group_pkey PRIMARY KEY (id);


--
-- Name: zip_codes zip_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zip_codes
    ADD CONSTRAINT zip_codes_pkey PRIMARY KEY (zip_code);


--
-- Name: graph_db_output_unique_combination_constraint_with_date_deleted; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX graph_db_output_unique_combination_constraint_with_date_deleted ON public.graph_db_output USING btree (source_suggestion, source_course_id, source_course_group, target_course_id, target_course_group) WHERE (date_deleted IS NULL);


--
-- Name: idx__temp_catalog_1759060992_0ea3bc_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060992_0ea3bc_auto_id ON public._temp_catalog_1759060992_0ea3bc USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060992_0ea3bc_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060992_0ea3bc_course_identifier ON public._temp_catalog_1759060992_0ea3bc USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060992_0ea3bc_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060992_0ea3bc_errors ON public._temp_catalog_1759060992_0ea3bc USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060992_0ea3bc_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060992_0ea3bc_subject_number ON public._temp_catalog_1759060992_0ea3bc USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060993_ed1085_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060993_ed1085_auto_id ON public._temp_catalog_1759060993_ed1085 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060993_ed1085_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060993_ed1085_course_identifier ON public._temp_catalog_1759060993_ed1085 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060993_ed1085_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060993_ed1085_errors ON public._temp_catalog_1759060993_ed1085 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060993_ed1085_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060993_ed1085_subject_number ON public._temp_catalog_1759060993_ed1085 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060994_0ff21d_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_0ff21d_auto_id ON public._temp_catalog_1759060994_0ff21d USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060994_0ff21d_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_0ff21d_course_identifier ON public._temp_catalog_1759060994_0ff21d USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060994_0ff21d_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_0ff21d_errors ON public._temp_catalog_1759060994_0ff21d USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060994_0ff21d_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_0ff21d_subject_number ON public._temp_catalog_1759060994_0ff21d USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060994_157d59_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_157d59_auto_id ON public._temp_catalog_1759060994_157d59 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060994_157d59_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_157d59_course_identifier ON public._temp_catalog_1759060994_157d59 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060994_157d59_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_157d59_errors ON public._temp_catalog_1759060994_157d59 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060994_157d59_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060994_157d59_subject_number ON public._temp_catalog_1759060994_157d59 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060995_17fcf8_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060995_17fcf8_auto_id ON public._temp_catalog_1759060995_17fcf8 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060995_17fcf8_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060995_17fcf8_course_identifier ON public._temp_catalog_1759060995_17fcf8 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060995_17fcf8_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060995_17fcf8_errors ON public._temp_catalog_1759060995_17fcf8 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060995_17fcf8_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060995_17fcf8_subject_number ON public._temp_catalog_1759060995_17fcf8 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060996_c9a3ff_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_c9a3ff_auto_id ON public._temp_catalog_1759060996_c9a3ff USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060996_c9a3ff_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_c9a3ff_course_identifier ON public._temp_catalog_1759060996_c9a3ff USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060996_c9a3ff_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_c9a3ff_errors ON public._temp_catalog_1759060996_c9a3ff USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060996_c9a3ff_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_c9a3ff_subject_number ON public._temp_catalog_1759060996_c9a3ff USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060996_e454e2_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_e454e2_auto_id ON public._temp_catalog_1759060996_e454e2 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060996_e454e2_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_e454e2_course_identifier ON public._temp_catalog_1759060996_e454e2 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060996_e454e2_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_e454e2_errors ON public._temp_catalog_1759060996_e454e2 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060996_e454e2_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060996_e454e2_subject_number ON public._temp_catalog_1759060996_e454e2 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060997_c13594_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060997_c13594_auto_id ON public._temp_catalog_1759060997_c13594 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060997_c13594_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060997_c13594_course_identifier ON public._temp_catalog_1759060997_c13594 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060997_c13594_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060997_c13594_errors ON public._temp_catalog_1759060997_c13594 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060997_c13594_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060997_c13594_subject_number ON public._temp_catalog_1759060997_c13594 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060998_0dfa59_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_0dfa59_auto_id ON public._temp_catalog_1759060998_0dfa59 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060998_0dfa59_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_0dfa59_course_identifier ON public._temp_catalog_1759060998_0dfa59 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060998_0dfa59_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_0dfa59_errors ON public._temp_catalog_1759060998_0dfa59 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060998_0dfa59_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_0dfa59_subject_number ON public._temp_catalog_1759060998_0dfa59 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060998_c3631e_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_c3631e_auto_id ON public._temp_catalog_1759060998_c3631e USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060998_c3631e_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_c3631e_course_identifier ON public._temp_catalog_1759060998_c3631e USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060998_c3631e_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_c3631e_errors ON public._temp_catalog_1759060998_c3631e USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060998_c3631e_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060998_c3631e_subject_number ON public._temp_catalog_1759060998_c3631e USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060999_1b0fe1_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_1b0fe1_auto_id ON public._temp_catalog_1759060999_1b0fe1 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060999_1b0fe1_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_1b0fe1_course_identifier ON public._temp_catalog_1759060999_1b0fe1 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060999_1b0fe1_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_1b0fe1_errors ON public._temp_catalog_1759060999_1b0fe1 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060999_1b0fe1_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_1b0fe1_subject_number ON public._temp_catalog_1759060999_1b0fe1 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759060999_acbd29_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_acbd29_auto_id ON public._temp_catalog_1759060999_acbd29 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759060999_acbd29_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_acbd29_course_identifier ON public._temp_catalog_1759060999_acbd29 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759060999_acbd29_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_acbd29_errors ON public._temp_catalog_1759060999_acbd29 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759060999_acbd29_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759060999_acbd29_subject_number ON public._temp_catalog_1759060999_acbd29 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061000_9a0992_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_9a0992_auto_id ON public._temp_catalog_1759061000_9a0992 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061000_9a0992_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_9a0992_course_identifier ON public._temp_catalog_1759061000_9a0992 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061000_9a0992_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_9a0992_errors ON public._temp_catalog_1759061000_9a0992 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061000_9a0992_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_9a0992_subject_number ON public._temp_catalog_1759061000_9a0992 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061000_dd02f1_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_dd02f1_auto_id ON public._temp_catalog_1759061000_dd02f1 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061000_dd02f1_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_dd02f1_course_identifier ON public._temp_catalog_1759061000_dd02f1 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061000_dd02f1_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_dd02f1_errors ON public._temp_catalog_1759061000_dd02f1 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061000_dd02f1_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061000_dd02f1_subject_number ON public._temp_catalog_1759061000_dd02f1 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061001_e56456_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061001_e56456_auto_id ON public._temp_catalog_1759061001_e56456 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061001_e56456_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061001_e56456_course_identifier ON public._temp_catalog_1759061001_e56456 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061001_e56456_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061001_e56456_errors ON public._temp_catalog_1759061001_e56456 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061001_e56456_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061001_e56456_subject_number ON public._temp_catalog_1759061001_e56456 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061002_41ea00_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_41ea00_auto_id ON public._temp_catalog_1759061002_41ea00 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061002_41ea00_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_41ea00_course_identifier ON public._temp_catalog_1759061002_41ea00 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061002_41ea00_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_41ea00_errors ON public._temp_catalog_1759061002_41ea00 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061002_41ea00_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_41ea00_subject_number ON public._temp_catalog_1759061002_41ea00 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061002_7c0f5a_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_7c0f5a_auto_id ON public._temp_catalog_1759061002_7c0f5a USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061002_7c0f5a_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_7c0f5a_course_identifier ON public._temp_catalog_1759061002_7c0f5a USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061002_7c0f5a_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_7c0f5a_errors ON public._temp_catalog_1759061002_7c0f5a USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061002_7c0f5a_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061002_7c0f5a_subject_number ON public._temp_catalog_1759061002_7c0f5a USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061003_dea9b4_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061003_dea9b4_auto_id ON public._temp_catalog_1759061003_dea9b4 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061003_dea9b4_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061003_dea9b4_course_identifier ON public._temp_catalog_1759061003_dea9b4 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061003_dea9b4_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061003_dea9b4_errors ON public._temp_catalog_1759061003_dea9b4 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061003_dea9b4_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061003_dea9b4_subject_number ON public._temp_catalog_1759061003_dea9b4 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061004_c7fe61_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061004_c7fe61_auto_id ON public._temp_catalog_1759061004_c7fe61 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061004_c7fe61_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061004_c7fe61_course_identifier ON public._temp_catalog_1759061004_c7fe61 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061004_c7fe61_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061004_c7fe61_errors ON public._temp_catalog_1759061004_c7fe61 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061004_c7fe61_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061004_c7fe61_subject_number ON public._temp_catalog_1759061004_c7fe61 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061005_633c1b_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_633c1b_auto_id ON public._temp_catalog_1759061005_633c1b USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061005_633c1b_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_633c1b_course_identifier ON public._temp_catalog_1759061005_633c1b USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061005_633c1b_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_633c1b_errors ON public._temp_catalog_1759061005_633c1b USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061005_633c1b_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_633c1b_subject_number ON public._temp_catalog_1759061005_633c1b USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061005_e72243_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_e72243_auto_id ON public._temp_catalog_1759061005_e72243 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061005_e72243_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_e72243_course_identifier ON public._temp_catalog_1759061005_e72243 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061005_e72243_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_e72243_errors ON public._temp_catalog_1759061005_e72243 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061005_e72243_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061005_e72243_subject_number ON public._temp_catalog_1759061005_e72243 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061006_f58a15_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_f58a15_auto_id ON public._temp_catalog_1759061006_f58a15 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061006_f58a15_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_f58a15_course_identifier ON public._temp_catalog_1759061006_f58a15 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061006_f58a15_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_f58a15_errors ON public._temp_catalog_1759061006_f58a15 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061006_f58a15_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_f58a15_subject_number ON public._temp_catalog_1759061006_f58a15 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061006_ff7a44_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_ff7a44_auto_id ON public._temp_catalog_1759061006_ff7a44 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061006_ff7a44_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_ff7a44_course_identifier ON public._temp_catalog_1759061006_ff7a44 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061006_ff7a44_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_ff7a44_errors ON public._temp_catalog_1759061006_ff7a44 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061006_ff7a44_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061006_ff7a44_subject_number ON public._temp_catalog_1759061006_ff7a44 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061007_50ae78_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_50ae78_auto_id ON public._temp_catalog_1759061007_50ae78 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061007_50ae78_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_50ae78_course_identifier ON public._temp_catalog_1759061007_50ae78 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061007_50ae78_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_50ae78_errors ON public._temp_catalog_1759061007_50ae78 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061007_50ae78_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_50ae78_subject_number ON public._temp_catalog_1759061007_50ae78 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061007_a20784_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_a20784_auto_id ON public._temp_catalog_1759061007_a20784 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061007_a20784_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_a20784_course_identifier ON public._temp_catalog_1759061007_a20784 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061007_a20784_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_a20784_errors ON public._temp_catalog_1759061007_a20784 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061007_a20784_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061007_a20784_subject_number ON public._temp_catalog_1759061007_a20784 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061008_2c44e2_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_2c44e2_auto_id ON public._temp_catalog_1759061008_2c44e2 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061008_2c44e2_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_2c44e2_course_identifier ON public._temp_catalog_1759061008_2c44e2 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061008_2c44e2_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_2c44e2_errors ON public._temp_catalog_1759061008_2c44e2 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061008_2c44e2_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_2c44e2_subject_number ON public._temp_catalog_1759061008_2c44e2 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061008_c92293_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_c92293_auto_id ON public._temp_catalog_1759061008_c92293 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061008_c92293_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_c92293_course_identifier ON public._temp_catalog_1759061008_c92293 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061008_c92293_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_c92293_errors ON public._temp_catalog_1759061008_c92293 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061008_c92293_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061008_c92293_subject_number ON public._temp_catalog_1759061008_c92293 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061009_9f4232_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061009_9f4232_auto_id ON public._temp_catalog_1759061009_9f4232 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061009_9f4232_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061009_9f4232_course_identifier ON public._temp_catalog_1759061009_9f4232 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061009_9f4232_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061009_9f4232_errors ON public._temp_catalog_1759061009_9f4232 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061009_9f4232_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061009_9f4232_subject_number ON public._temp_catalog_1759061009_9f4232 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061010_0d3559_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061010_0d3559_auto_id ON public._temp_catalog_1759061010_0d3559 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061010_0d3559_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061010_0d3559_course_identifier ON public._temp_catalog_1759061010_0d3559 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061010_0d3559_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061010_0d3559_errors ON public._temp_catalog_1759061010_0d3559 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061010_0d3559_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061010_0d3559_subject_number ON public._temp_catalog_1759061010_0d3559 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061011_0ccdde_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_0ccdde_auto_id ON public._temp_catalog_1759061011_0ccdde USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061011_0ccdde_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_0ccdde_course_identifier ON public._temp_catalog_1759061011_0ccdde USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061011_0ccdde_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_0ccdde_errors ON public._temp_catalog_1759061011_0ccdde USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061011_0ccdde_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_0ccdde_subject_number ON public._temp_catalog_1759061011_0ccdde USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061011_67ee4d_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_67ee4d_auto_id ON public._temp_catalog_1759061011_67ee4d USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061011_67ee4d_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_67ee4d_course_identifier ON public._temp_catalog_1759061011_67ee4d USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061011_67ee4d_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_67ee4d_errors ON public._temp_catalog_1759061011_67ee4d USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061011_67ee4d_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_67ee4d_subject_number ON public._temp_catalog_1759061011_67ee4d USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061011_9c8f93_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_9c8f93_auto_id ON public._temp_catalog_1759061011_9c8f93 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061011_9c8f93_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_9c8f93_course_identifier ON public._temp_catalog_1759061011_9c8f93 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061011_9c8f93_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_9c8f93_errors ON public._temp_catalog_1759061011_9c8f93 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061011_9c8f93_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_9c8f93_subject_number ON public._temp_catalog_1759061011_9c8f93 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061011_e633b4_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_e633b4_auto_id ON public._temp_catalog_1759061011_e633b4 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061011_e633b4_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_e633b4_course_identifier ON public._temp_catalog_1759061011_e633b4 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061011_e633b4_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_e633b4_errors ON public._temp_catalog_1759061011_e633b4 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061011_e633b4_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_e633b4_subject_number ON public._temp_catalog_1759061011_e633b4 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061011_eae01f_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_eae01f_auto_id ON public._temp_catalog_1759061011_eae01f USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061011_eae01f_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_eae01f_course_identifier ON public._temp_catalog_1759061011_eae01f USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061011_eae01f_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_eae01f_errors ON public._temp_catalog_1759061011_eae01f USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061011_eae01f_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_eae01f_subject_number ON public._temp_catalog_1759061011_eae01f USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061011_ed8547_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_ed8547_auto_id ON public._temp_catalog_1759061011_ed8547 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061011_ed8547_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_ed8547_course_identifier ON public._temp_catalog_1759061011_ed8547 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061011_ed8547_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_ed8547_errors ON public._temp_catalog_1759061011_ed8547 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061011_ed8547_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061011_ed8547_subject_number ON public._temp_catalog_1759061011_ed8547 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061012_98fc90_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061012_98fc90_auto_id ON public._temp_catalog_1759061012_98fc90 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061012_98fc90_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061012_98fc90_course_identifier ON public._temp_catalog_1759061012_98fc90 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061012_98fc90_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061012_98fc90_errors ON public._temp_catalog_1759061012_98fc90 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061012_98fc90_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061012_98fc90_subject_number ON public._temp_catalog_1759061012_98fc90 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061017_8917f4_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061017_8917f4_auto_id ON public._temp_catalog_1759061017_8917f4 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061017_8917f4_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061017_8917f4_course_identifier ON public._temp_catalog_1759061017_8917f4 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061017_8917f4_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061017_8917f4_errors ON public._temp_catalog_1759061017_8917f4 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061017_8917f4_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061017_8917f4_subject_number ON public._temp_catalog_1759061017_8917f4 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061044_94f913_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061044_94f913_auto_id ON public._temp_catalog_1759061044_94f913 USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061044_94f913_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061044_94f913_course_identifier ON public._temp_catalog_1759061044_94f913 USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061044_94f913_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061044_94f913_errors ON public._temp_catalog_1759061044_94f913 USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061044_94f913_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061044_94f913_subject_number ON public._temp_catalog_1759061044_94f913 USING btree (course_subject, course_number);


--
-- Name: idx__temp_catalog_1759061050_db1f9a_auto_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061050_db1f9a_auto_id ON public._temp_catalog_1759061050_db1f9a USING btree (auto_id);


--
-- Name: idx__temp_catalog_1759061050_db1f9a_course_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061050_db1f9a_course_identifier ON public._temp_catalog_1759061050_db1f9a USING btree (course_identifier);


--
-- Name: idx__temp_catalog_1759061050_db1f9a_errors; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061050_db1f9a_errors ON public._temp_catalog_1759061050_db1f9a USING btree (critical_errors, format_errors);


--
-- Name: idx__temp_catalog_1759061050_db1f9a_subject_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx__temp_catalog_1759061050_db1f9a_subject_number ON public._temp_catalog_1759061050_db1f9a USING btree (course_subject, course_number);


--
-- Name: idx_app_deployment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_app_deployment_id ON public.deployment_status USING btree (app_deployment_id);


--
-- Name: idx_assignee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assignee_id ON public.graph_db_output USING btree (assignee_id);


--
-- Name: idx_audit_table_requests_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_table_requests_request_id ON public.audit_table_requests USING btree (request_id);


--
-- Name: idx_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_id ON public.master_courses USING btree (course_id);


--
-- Name: idx_course_metadata_master_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_metadata_master_course_id ON public.course_metadata USING btree (master_course_id);


--
-- Name: idx_districts_mat_view_district_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_districts_mat_view_district_id ON public.districts_mat_view USING btree (district_id);


--
-- Name: idx_districts_mat_view_district_id_int; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_districts_mat_view_district_id_int ON public.districts_mat_view USING btree (district_id_int);


--
-- Name: idx_districts_mat_view_is_district_member; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_districts_mat_view_is_district_member ON public.districts_mat_view USING btree (is_district_member);


--
-- Name: idx_districts_mat_view_member_id_int; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_districts_mat_view_member_id_int ON public.districts_mat_view USING btree (member_id_int);


--
-- Name: idx_drm_district_rule_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_drm_district_rule_identifier ON public.district_rule_map USING btree (district_rule_identifier);


--
-- Name: idx_drm_source_unique_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_drm_source_unique_identifier ON public.district_rule_map USING btree (source_unique_identifier);


--
-- Name: idx_entities_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_data ON public.entities USING gin (data);


--
-- Name: idx_entities_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_type ON public.entities USING btree (type);


--
-- Name: idx_entities_updated_at_epoch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_updated_at_epoch ON public.entities USING btree (updated_at_epoch);


--
-- Name: idx_equivalencies_mat_view_equivalency_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_id ON public.equivalencies_mat_view USING btree (equivalency_id);


--
-- Name: idx_equivalencies_mat_view_equivalency_id_prev_feb_2024_02_02; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_id_prev_feb_2024_02_02 ON public.equivalencies_mat_view_prev_feb_2024_02_02 USING btree (equivalency_id);


--
-- Name: idx_equivalencies_mat_view_equivalency_id_prev_mat_2024_03_01; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_id_prev_mat_2024_03_01 ON public.equivalencies_mat_view_prev_mat_2024_03_01 USING btree (equivalency_id);


--
-- Name: idx_equivalencies_mat_view_equivalency_id_prev_nov_2023_11_05; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_id_prev_nov_2023_11_05 ON public.equivalencies_mat_view_prev_nov_2023_11_05 USING btree (equivalency_id);


--
-- Name: idx_equivalencies_mat_view_equivalency_id_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_equivalencies_mat_view_equivalency_id_type ON public.equivalencies_mat_view USING btree (equivalency_id, equivalency_type);


--
-- Name: idx_equivalencies_mat_view_equivalency_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_type ON public.equivalencies_mat_view USING btree (equivalency_type);


--
-- Name: idx_equivalencies_mat_view_equivalency_type_prev_feb_2024_02_02; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_type_prev_feb_2024_02_02 ON public.equivalencies_mat_view_prev_feb_2024_02_02 USING btree (equivalency_type);


--
-- Name: idx_equivalencies_mat_view_equivalency_type_prev_mat_2024_03_01; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_type_prev_mat_2024_03_01 ON public.equivalencies_mat_view_prev_mat_2024_03_01 USING btree (equivalency_type);


--
-- Name: idx_equivalencies_mat_view_equivalency_type_prev_nov_2023_11_05; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_equivalency_type_prev_nov_2023_11_05 ON public.equivalencies_mat_view_prev_nov_2023_11_05 USING btree (equivalency_type);


--
-- Name: idx_equivalencies_mat_view_source_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_course_id ON public.equivalencies_mat_view USING btree (source_course_id);


--
-- Name: idx_equivalencies_mat_view_source_course_id_prev_feb_2024_02_02; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_course_id_prev_feb_2024_02_02 ON public.equivalencies_mat_view_prev_feb_2024_02_02 USING btree (source_course_id);


--
-- Name: idx_equivalencies_mat_view_source_course_id_prev_mat_2024_03_01; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_course_id_prev_mat_2024_03_01 ON public.equivalencies_mat_view_prev_mat_2024_03_01 USING btree (source_course_id);


--
-- Name: idx_equivalencies_mat_view_source_course_id_prev_nov_2023_11_05; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_course_id_prev_nov_2023_11_05 ON public.equivalencies_mat_view_prev_nov_2023_11_05 USING btree (source_course_id);


--
-- Name: idx_equivalencies_mat_view_source_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_institution_id ON public.equivalencies_mat_view USING btree (source_institution_id);


--
-- Name: idx_equivalencies_mat_view_source_institution_id_prev_feb_2024_; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_institution_id_prev_feb_2024_ ON public.equivalencies_mat_view_prev_feb_2024_02_02 USING btree (source_institution_id);


--
-- Name: idx_equivalencies_mat_view_source_institution_id_prev_mat_2024_; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_institution_id_prev_mat_2024_ ON public.equivalencies_mat_view_prev_mat_2024_03_01 USING btree (source_institution_id);


--
-- Name: idx_equivalencies_mat_view_source_institution_id_prev_nov_2023_; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_source_institution_id_prev_nov_2023_ ON public.equivalencies_mat_view_prev_nov_2023_11_05 USING btree (source_institution_id);


--
-- Name: idx_equivalencies_mat_view_target_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_course_id ON public.equivalencies_mat_view USING btree (target_course_id);


--
-- Name: idx_equivalencies_mat_view_target_course_id_prev_feb_2024_02_02; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_course_id_prev_feb_2024_02_02 ON public.equivalencies_mat_view_prev_feb_2024_02_02 USING btree (target_course_id);


--
-- Name: idx_equivalencies_mat_view_target_course_id_prev_mat_2024_03_01; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_course_id_prev_mat_2024_03_01 ON public.equivalencies_mat_view_prev_mat_2024_03_01 USING btree (target_course_id);


--
-- Name: idx_equivalencies_mat_view_target_course_id_prev_nov_2023_11_05; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_course_id_prev_nov_2023_11_05 ON public.equivalencies_mat_view_prev_nov_2023_11_05 USING btree (target_course_id);


--
-- Name: idx_equivalencies_mat_view_target_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_institution_id ON public.equivalencies_mat_view USING btree (target_institution_id);


--
-- Name: idx_equivalencies_mat_view_target_institution_id_prev_feb_2024_; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_institution_id_prev_feb_2024_ ON public.equivalencies_mat_view_prev_feb_2024_02_02 USING btree (target_institution_id);


--
-- Name: idx_equivalencies_mat_view_target_institution_id_prev_mat_2024_; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_institution_id_prev_mat_2024_ ON public.equivalencies_mat_view_prev_mat_2024_03_01 USING btree (target_institution_id);


--
-- Name: idx_equivalencies_mat_view_target_institution_id_prev_nov_2023_; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_mat_view_target_institution_id_prev_nov_2023_ ON public.equivalencies_mat_view_prev_nov_2023_11_05 USING btree (target_institution_id);


--
-- Name: idx_equivalencies_with_implied_mat_view_equivalency_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_equivalency_id ON public.equivalencies_with_implied_mat_view USING btree (equivalency_id);


--
-- Name: idx_equivalencies_with_implied_mat_view_equivalency_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_equivalency_type ON public.equivalencies_with_implied_mat_view USING btree (equivalency_type);


--
-- Name: idx_equivalencies_with_implied_mat_view_is_implied; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_is_implied ON public.equivalencies_with_implied_mat_view USING btree (is_implied);


--
-- Name: idx_equivalencies_with_implied_mat_view_source_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_source_course_id ON public.equivalencies_with_implied_mat_view USING btree (source_course_id);


--
-- Name: idx_equivalencies_with_implied_mat_view_source_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_source_institution_id ON public.equivalencies_with_implied_mat_view USING btree (source_institution_id);


--
-- Name: idx_equivalencies_with_implied_mat_view_target_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_target_course_id ON public.equivalencies_with_implied_mat_view USING btree (target_course_id);


--
-- Name: idx_equivalencies_with_implied_mat_view_target_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_equivalencies_with_implied_mat_view_target_institution_id ON public.equivalencies_with_implied_mat_view USING btree (target_institution_id);


--
-- Name: idx_eval_groups_user_ids; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_eval_groups_user_ids ON public.evaluation_group USING gin (user_ids);


--
-- Name: idx_evaluation_group_user_ids_gin; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_evaluation_group_user_ids_gin ON public.evaluation_group USING gin (user_ids);


--
-- Name: idx_feed_session_mapping_feed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feed_session_mapping_feed_id ON public.feed_session_mapping USING btree (feed_id);


--
-- Name: idx_feed_session_mapping_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feed_session_mapping_session_id ON public.feed_session_mapping USING btree (session_id);


--
-- Name: idx_genres_mv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_genres_mv_id ON public.genres_mv USING btree (id);


--
-- Name: idx_graph_db_output_assignee_decision; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graph_db_output_assignee_decision ON public.graph_db_output USING btree (assignee_id, decision) WHERE (decision = 'PENDING'::public.suggestiondecision);


--
-- Name: idx_graph_db_output_date_deleted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graph_db_output_date_deleted ON public.graph_db_output USING btree (date_deleted);


--
-- Name: idx_graph_db_output_date_deleted_is_null; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graph_db_output_date_deleted_is_null ON public.graph_db_output USING btree (date_deleted) WHERE (date_deleted IS NULL);


--
-- Name: idx_graph_db_output_odd_man_out_rule; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graph_db_output_odd_man_out_rule ON public.graph_db_output USING btree (odd_man_out_rule);


--
-- Name: idx_graph_db_output_rule_to_be_improved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graph_db_output_rule_to_be_improved ON public.graph_db_output USING btree (rule_to_be_improved);


--
-- Name: idx_graph_db_output_workflow_decision; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graph_db_output_workflow_decision ON public.graph_db_output USING btree (workflow_id, decision) WHERE (decision = 'PENDING'::public.suggestiondecision);


--
-- Name: idx_graphdb_assignee; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graphdb_assignee ON public.graph_db_output USING btree (assignee_id);


--
-- Name: idx_graphdb_pending; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graphdb_pending ON public.graph_db_output USING btree (decision) WHERE (decision = 'PENDING'::public.suggestiondecision);


--
-- Name: idx_graphdb_workflow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_graphdb_workflow ON public.graph_db_output USING btree (workflow_id);


--
-- Name: idx_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institution_id ON public.institution_settings USING btree (institution_id);


--
-- Name: idx_institution_settings_fields; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institution_settings_fields ON public.institution_settings USING btree (institution_id, suggestion_management_email_frequency);


--
-- Name: idx_institutions_mat_view_district_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_district_identifier ON public.institutions_mat_view USING btree (district_identifier);


--
-- Name: idx_institutions_mat_view_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_institutions_mat_view_institution_id ON public.institutions_mat_view USING btree (institution_id);


--
-- Name: idx_institutions_mat_view_ipeds_district_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_ipeds_district_identifier ON public.institutions_mat_view USING btree (((ipeds_info ->> 'DistrictIdentifier'::text)));


--
-- Name: idx_institutions_mat_view_ipeds_hide_indicator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_ipeds_hide_indicator ON public.institutions_mat_view USING btree (((ipeds_info ->> 'HideIndicator'::text)));


--
-- Name: idx_institutions_mat_view_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_name ON public.institutions_mat_view USING btree (name);


--
-- Name: idx_institutions_mat_view_name_fulltext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_name_fulltext ON public.institutions_mat_view USING gin (to_tsvector('english'::regconfig, name));


--
-- Name: idx_institutions_mat_view_name_sorting; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_name_sorting ON public.institutions_mat_view USING btree (name);


--
-- Name: idx_institutions_mat_view_non_hidden; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_non_hidden ON public.institutions_mat_view USING btree (institution_id) WHERE (is_hidden = false);


--
-- Name: idx_institutions_mat_view_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_state ON public.institutions_mat_view USING btree (state);


--
-- Name: idx_institutions_mat_view_trimmed_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_institutions_mat_view_trimmed_name ON public.institutions_mat_view USING btree (TRIM(BOTH FROM name));


--
-- Name: idx_ipeds_info_district_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ipeds_info_district_identifier ON public.master_universities USING btree (((ipeds_info ->> 'DistrictIdentifier'::text)));


--
-- Name: idx_ipeds_info_hide_indicator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ipeds_info_hide_indicator ON public.master_universities USING btree (((ipeds_info ->> 'HideIndicator'::text)));


--
-- Name: idx_master_courses_on_course_id_text; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_master_courses_on_course_id_text ON public.master_courses USING btree (((course_id)::text));


--
-- Name: idx_master_universities_districtidentifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_master_universities_districtidentifier ON public.master_universities USING btree (((ipeds_info ->> 'DistrictIdentifier'::text)));


--
-- Name: idx_master_universities_districtindicator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_master_universities_districtindicator ON public.master_universities USING btree (upper((ipeds_info ->> 'DistrictIndicator'::text)));


--
-- Name: idx_master_universities_hideindicator; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_master_universities_hideindicator ON public.master_universities USING btree (((ipeds_info ->> 'HideIndicator'::text)));


--
-- Name: idx_master_universities_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_master_universities_institution_id ON public.master_universities USING btree (institution_id);


--
-- Name: idx_master_universities_ipeds_info; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_master_universities_ipeds_info ON public.master_universities USING gin (ipeds_info);


--
-- Name: idx_media_genres_mv_genre_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_genres_mv_genre_id ON public.media_genres_mv USING btree (genre_id);


--
-- Name: idx_media_genres_mv_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_genres_mv_media_id ON public.media_genres_mv USING btree (media_id);


--
-- Name: idx_media_genres_mv_pkey; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_media_genres_mv_pkey ON public.media_genres_mv USING btree (media_id, genre_id);


--
-- Name: idx_media_images_mv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_media_images_mv_id ON public.media_images_mv USING btree (id);


--
-- Name: idx_media_images_mv_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_images_mv_lookup ON public.media_images_mv USING btree (media_id, image_type, url);


--
-- Name: idx_media_mv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_media_mv_id ON public.media_mv USING btree (id);


--
-- Name: idx_media_mv_is_adult; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_mv_is_adult ON public.media_mv USING btree (is_adult) WHERE (is_adult = false);


--
-- Name: idx_media_mv_popularity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_mv_popularity ON public.media_mv USING btree (popularity DESC);


--
-- Name: idx_partitioned_rules_course_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partitioned_rules_course_number ON ONLY public.partitioned_rules USING btree (course_number);


--
-- Name: idx_partitioned_rules_course_subject; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partitioned_rules_course_subject ON ONLY public.partitioned_rules USING btree (course_subject);


--
-- Name: idx_partitioned_rules_upload_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_partitioned_rules_upload_date ON ONLY public.partitioned_rules USING btree (upload_date);


--
-- Name: idx_rule_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rule_identifier ON public.unprocessed_equivalencies USING btree (rule_identifier);


--
-- Name: idx_source_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_source_course_id ON public.graph_db_output USING btree (source_course_id);


--
-- Name: idx_source_course_id_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_source_course_id_mapping ON public.equivalency_source_course_mapping_mat_view USING btree (course_id);


--
-- Name: idx_source_course_id_uuid_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_source_course_id_uuid_mapping ON public.equivalency_source_course_mapping_mat_view USING btree (course_id_uuid);


--
-- Name: idx_source_equivalency_course_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_source_equivalency_course_mapping ON public.equivalency_source_course_mapping_mat_view USING btree (equivalency_id);


--
-- Name: idx_source_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_source_institution_id ON public.graph_db_output USING btree (source_institution_id);


--
-- Name: idx_suggestion_deduplication; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestion_deduplication ON public.graph_db_output USING btree (source_course_id, target_course_id, source_suggestion) WHERE (date_deleted IS NULL);


--
-- Name: idx_suggestion_types_mat_view_suggestion_label; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestion_types_mat_view_suggestion_label ON public.suggestion_types_mat_view USING btree (label);


--
-- Name: idx_suggestion_types_mat_view_suggestion_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestion_types_mat_view_suggestion_type ON public.suggestion_types_mat_view USING btree (suggestion_type);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_equivalency_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestions_or_equivalencies_mat_view_equivalency_id ON public.suggestions_or_equivalencies_mat_view USING btree (equivalency_id);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_equivalency_id_type; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_suggestions_or_equivalencies_mat_view_equivalency_id_type ON public.suggestions_or_equivalencies_mat_view USING btree (equivalency_id, equivalency_type);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_equivalency_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestions_or_equivalencies_mat_view_equivalency_type ON public.suggestions_or_equivalencies_mat_view USING btree (equivalency_type);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_source_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestions_or_equivalencies_mat_view_source_course_id ON public.suggestions_or_equivalencies_mat_view USING btree (source_course_id);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_source_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestions_or_equivalencies_mat_view_source_institution_id ON public.suggestions_or_equivalencies_mat_view USING btree (source_institution_id);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_target_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestions_or_equivalencies_mat_view_target_course_id ON public.suggestions_or_equivalencies_mat_view USING btree (target_course_id);


--
-- Name: idx_suggestions_or_equivalencies_mat_view_target_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_suggestions_or_equivalencies_mat_view_target_institution_id ON public.suggestions_or_equivalencies_mat_view USING btree (target_institution_id);


--
-- Name: idx_target_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_target_course_id ON public.graph_db_output USING btree (target_course_id);


--
-- Name: idx_target_course_id_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_target_course_id_mapping ON public.equivalency_target_course_mapping_mat_view USING btree (course_id);


--
-- Name: idx_target_course_id_uuid_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_target_course_id_uuid_mapping ON public.equivalency_target_course_mapping_mat_view USING btree (course_id_uuid);


--
-- Name: idx_target_equivalency_course_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_target_equivalency_course_mapping ON public.equivalency_target_course_mapping_mat_view USING btree (equivalency_id);


--
-- Name: idx_target_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_target_institution_id ON public.graph_db_output USING btree (target_institution_id);


--
-- Name: idx_trim_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_trim_name ON public.master_universities USING btree (btrim(name));


--
-- Name: idx_ue_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ue_course_id ON public.unprocessed_equivalencies USING btree (course_id);


--
-- Name: idx_unique_equivalency_source_course_mapping_mat_view; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_unique_equivalency_source_course_mapping_mat_view ON public.equivalency_source_course_mapping_mat_view USING btree (course_id, equivalency_id);


--
-- Name: idx_unique_equivalency_target_course_mapping_mat_view; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_unique_equivalency_target_course_mapping_mat_view ON public.equivalency_target_course_mapping_mat_view USING btree (course_id, equivalency_id);


--
-- Name: idx_unique_suggestion_types_mat_view; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_unique_suggestion_types_mat_view ON public.suggestion_types_mat_view USING btree (suggestion_id);


--
-- Name: idx_unprocessed_equivalencies_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_course_id ON public.unprocessed_equivalencies USING btree (course_id);


--
-- Name: idx_unprocessed_equivalencies_course_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_course_type ON public.unprocessed_equivalencies USING btree (course_type);


--
-- Name: idx_unprocessed_equivalencies_is_modified_rule; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_is_modified_rule ON public.unprocessed_equivalencies USING btree (is_modified_rule);


--
-- Name: idx_unprocessed_equivalencies_unique_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_unique_identifier ON public.unprocessed_equivalencies USING btree (unique_identifier);


--
-- Name: idx_unprocessed_equivalencies_unique_identifier_course_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_unique_identifier_course_type ON public.unprocessed_equivalencies USING btree (unique_identifier, course_type);


--
-- Name: idx_unprocessed_equivalencies_unique_rule_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_unique_rule_identifier ON public.unprocessed_equivalencies USING btree (unique_rule_identifier);


--
-- Name: idx_unprocessed_equivalencies_uploaded_institution_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_unprocessed_equivalencies_uploaded_institution_id ON public.unprocessed_equivalencies USING btree (uploaded_institution_id);


--
-- Name: idx_user_accounts_phone_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_accounts_phone_number ON public.user_accounts USING btree (phone_number);


--
-- Name: idx_user_sessions_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_active ON public.user_sessions USING btree (session_id) WHERE (ended_at_epoch IS NOT NULL);


--
-- Name: idx_user_sessions_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_session_id ON public.user_sessions USING btree (session_id);


--
-- Name: idx_wf_response_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wf_response_composite ON public.workflow_response USING btree (workflow_id, suggestion_id, user_id);


--
-- Name: idx_wf_response_pending; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wf_response_pending ON public.workflow_response USING btree (response) WHERE (response = 'Pending'::text);


--
-- Name: idx_wf_status_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wf_status_composite ON public.workflow_response_status USING btree (workflow_id, status);


--
-- Name: idx_wf_status_suggestion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wf_status_suggestion ON public.workflow_response_status USING btree (suggestion_id);


--
-- Name: idx_wf_status_workflow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wf_status_workflow ON public.workflow_response_status USING btree (workflow_id);


--
-- Name: idx_workflow_response_status_workflow_suggestion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workflow_response_status_workflow_suggestion ON public.workflow_response_status USING btree (workflow_id, suggestion_id);


--
-- Name: idx_zip_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_zip_code ON public.master_universities USING btree (zip_code);


--
-- Name: ix_evaluation_groups_eval_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_evaluation_groups_eval_id ON public.evaluation_group USING btree (evaluation_group_id);


--
-- Name: ix_graph_db_output_assignee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_graph_db_output_assignee_id ON public.graph_db_output USING btree (assignee_id);


--
-- Name: ix_graph_db_output_decision; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_graph_db_output_decision ON public.graph_db_output USING btree (decision);


--
-- Name: ix_graph_db_output_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_graph_db_output_uuid ON public.graph_db_output USING btree (uuid);


--
-- Name: ix_graph_db_output_workflow_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_graph_db_output_workflow_id ON public.graph_db_output USING btree (workflow_id);


--
-- Name: ix_graph_db_output_workflow_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_graph_db_output_workflow_uuid ON public.graph_db_output USING btree (workflow_id, uuid);


--
-- Name: ix_workflow_scheme_approver_approver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_approver_approver ON public.workflow_scheme_approver USING btree (approver);


--
-- Name: ix_workflow_scheme_commenter_approver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_commenter_approver ON public.workflow_scheme_commenter_approver USING btree (approver);


--
-- Name: ix_workflow_scheme_commenter_commenter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_commenter_commenter ON public.workflow_scheme_commenter_approver USING btree (commenter);


--
-- Name: ix_workflow_scheme_commenter_group_approver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_commenter_group_approver ON public.workflow_scheme_commenter_group_approver USING btree (approver);


--
-- Name: ix_workflow_scheme_commenter_group_approver_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_commenter_group_approver_group_id ON public.workflow_scheme_commenter_group_approver USING btree (group_id);


--
-- Name: ix_workflow_scheme_commenter_group_commenter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_commenter_group_commenter ON public.workflow_scheme_commenter_group_approver USING btree (commenter);


--
-- Name: ix_workflow_scheme_dual_commenter_approver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_dual_commenter_approver ON public.workflow_scheme_dual_commenter_approver USING btree (approver);


--
-- Name: ix_workflow_scheme_dual_commenter_first; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_dual_commenter_first ON public.workflow_scheme_dual_commenter_approver USING btree (first_commenter);


--
-- Name: ix_workflow_scheme_dual_commenter_second; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_dual_commenter_second ON public.workflow_scheme_dual_commenter_approver USING btree (second_commenter);


--
-- Name: ix_workflow_scheme_group_approver; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_group_approver ON public.workflow_scheme_group_approver USING btree (approver);


--
-- Name: ix_workflow_scheme_group_approver_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_group_approver_group_id ON public.workflow_scheme_group_approver USING btree (group_id);


--
-- Name: ix_workflow_scheme_group_group_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_scheme_group_group_id ON public.workflow_scheme_group USING btree (group_id);


--
-- Name: ix_workflow_status_suggestion_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_status_suggestion_status ON public.workflow_response_status USING btree (suggestion_id, status);


--
-- Name: ix_workflow_status_wf_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_workflow_status_wf_status ON public.workflow_response_status USING btree (workflow_id, status);


--
-- Name: partitioned_rules_0_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_0_course_number_idx ON public.partitioned_rules_0 USING btree (course_number);


--
-- Name: partitioned_rules_0_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_0_course_subject_idx ON public.partitioned_rules_0 USING btree (course_subject);


--
-- Name: partitioned_rules_0_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_0_upload_date_idx ON public.partitioned_rules_0 USING btree (upload_date);


--
-- Name: partitioned_rules_104179_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_104179_course_number_idx ON public.partitioned_rules_104179 USING btree (course_number);


--
-- Name: partitioned_rules_104179_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_104179_course_subject_idx ON public.partitioned_rules_104179 USING btree (course_subject);


--
-- Name: partitioned_rules_104179_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_104179_upload_date_idx ON public.partitioned_rules_104179 USING btree (upload_date);


--
-- Name: partitioned_rules_105330_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_105330_course_number_idx ON public.partitioned_rules_105330 USING btree (course_number);


--
-- Name: partitioned_rules_105330_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_105330_course_subject_idx ON public.partitioned_rules_105330 USING btree (course_subject);


--
-- Name: partitioned_rules_105330_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_105330_upload_date_idx ON public.partitioned_rules_105330 USING btree (upload_date);


--
-- Name: partitioned_rules_105525_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_105525_course_number_idx ON public.partitioned_rules_105525 USING btree (course_number);


--
-- Name: partitioned_rules_105525_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_105525_course_subject_idx ON public.partitioned_rules_105525 USING btree (course_subject);


--
-- Name: partitioned_rules_105525_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_105525_upload_date_idx ON public.partitioned_rules_105525 USING btree (upload_date);


--
-- Name: partitioned_rules_182290_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_182290_course_number_idx ON public.partitioned_rules_182290 USING btree (course_number);


--
-- Name: partitioned_rules_182290_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_182290_course_subject_idx ON public.partitioned_rules_182290 USING btree (course_subject);


--
-- Name: partitioned_rules_182290_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_182290_upload_date_idx ON public.partitioned_rules_182290 USING btree (upload_date);


--
-- Name: partitioned_rules_1_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_1_course_number_idx ON public.partitioned_rules_1 USING btree (course_number);


--
-- Name: partitioned_rules_1_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_1_course_subject_idx ON public.partitioned_rules_1 USING btree (course_subject);


--
-- Name: partitioned_rules_1_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_1_upload_date_idx ON public.partitioned_rules_1 USING btree (upload_date);


--
-- Name: partitioned_rules_206941_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_206941_course_number_idx ON public.partitioned_rules_206941 USING btree (course_number);


--
-- Name: partitioned_rules_206941_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_206941_course_subject_idx ON public.partitioned_rules_206941 USING btree (course_subject);


--
-- Name: partitioned_rules_206941_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_206941_upload_date_idx ON public.partitioned_rules_206941 USING btree (upload_date);


--
-- Name: partitioned_rules_223816_course_number_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_223816_course_number_idx ON public.partitioned_rules_223816 USING btree (course_number);


--
-- Name: partitioned_rules_223816_course_subject_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_223816_course_subject_idx ON public.partitioned_rules_223816 USING btree (course_subject);


--
-- Name: partitioned_rules_223816_upload_date_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX partitioned_rules_223816_upload_date_idx ON public.partitioned_rules_223816 USING btree (upload_date);


--
-- Name: uq_districts_mat_view_member_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_districts_mat_view_member_id ON public.districts_mat_view USING btree (member_id);


--
-- Name: uq_equivalencies_with_implied_mat_view_implied_equivalency_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_equivalencies_with_implied_mat_view_implied_equivalency_id ON public.equivalencies_with_implied_mat_view USING btree (implied_equivalency_id, equivalency_type);


--
-- Name: zip_codes_geom_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX zip_codes_geom_idx ON public.zip_codes USING gist (geom);


--
-- Name: partitioned_rules_0_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_0_course_number_idx;


--
-- Name: partitioned_rules_0_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_0_course_subject_idx;


--
-- Name: partitioned_rules_0_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_0_pkey;


--
-- Name: partitioned_rules_0_rule_identifier_course_id_uploaded_inst_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_0_rule_identifier_course_id_uploaded_inst_key;


--
-- Name: partitioned_rules_0_rule_identifier_course_type_institution_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_0_rule_identifier_course_type_institution_key;


--
-- Name: partitioned_rules_0_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_0_upload_date_idx;


--
-- Name: partitioned_rules_104179_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_104179_course_number_idx;


--
-- Name: partitioned_rules_104179_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_104179_course_subject_idx;


--
-- Name: partitioned_rules_104179_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_104179_pkey;


--
-- Name: partitioned_rules_104179_rule_identifier_course_id_uploaded_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_104179_rule_identifier_course_id_uploaded_key;


--
-- Name: partitioned_rules_104179_rule_identifier_course_type_instit_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_104179_rule_identifier_course_type_instit_key;


--
-- Name: partitioned_rules_104179_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_104179_upload_date_idx;


--
-- Name: partitioned_rules_105330_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_105330_course_number_idx;


--
-- Name: partitioned_rules_105330_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_105330_course_subject_idx;


--
-- Name: partitioned_rules_105330_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_105330_pkey;


--
-- Name: partitioned_rules_105330_rule_identifier_course_id_uploaded_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_105330_rule_identifier_course_id_uploaded_key;


--
-- Name: partitioned_rules_105330_rule_identifier_course_type_instit_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_105330_rule_identifier_course_type_instit_key;


--
-- Name: partitioned_rules_105330_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_105330_upload_date_idx;


--
-- Name: partitioned_rules_105525_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_105525_course_number_idx;


--
-- Name: partitioned_rules_105525_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_105525_course_subject_idx;


--
-- Name: partitioned_rules_105525_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_105525_pkey;


--
-- Name: partitioned_rules_105525_rule_identifier_course_id_uploaded_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_105525_rule_identifier_course_id_uploaded_key;


--
-- Name: partitioned_rules_105525_rule_identifier_course_type_instit_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_105525_rule_identifier_course_type_instit_key;


--
-- Name: partitioned_rules_105525_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_105525_upload_date_idx;


--
-- Name: partitioned_rules_182290_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_182290_course_number_idx;


--
-- Name: partitioned_rules_182290_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_182290_course_subject_idx;


--
-- Name: partitioned_rules_182290_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_182290_pkey;


--
-- Name: partitioned_rules_182290_rule_identifier_course_id_uploaded_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_182290_rule_identifier_course_id_uploaded_key;


--
-- Name: partitioned_rules_182290_rule_identifier_course_type_instit_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_182290_rule_identifier_course_type_instit_key;


--
-- Name: partitioned_rules_182290_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_182290_upload_date_idx;


--
-- Name: partitioned_rules_1_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_1_course_number_idx;


--
-- Name: partitioned_rules_1_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_1_course_subject_idx;


--
-- Name: partitioned_rules_1_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_1_pkey;


--
-- Name: partitioned_rules_1_rule_identifier_course_id_uploaded_inst_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_1_rule_identifier_course_id_uploaded_inst_key;


--
-- Name: partitioned_rules_1_rule_identifier_course_type_institution_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_1_rule_identifier_course_type_institution_key;


--
-- Name: partitioned_rules_1_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_1_upload_date_idx;


--
-- Name: partitioned_rules_206941_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_206941_course_number_idx;


--
-- Name: partitioned_rules_206941_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_206941_course_subject_idx;


--
-- Name: partitioned_rules_206941_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_206941_pkey;


--
-- Name: partitioned_rules_206941_rule_identifier_course_id_uploaded_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_206941_rule_identifier_course_id_uploaded_key;


--
-- Name: partitioned_rules_206941_rule_identifier_course_type_instit_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_206941_rule_identifier_course_type_instit_key;


--
-- Name: partitioned_rules_206941_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_206941_upload_date_idx;


--
-- Name: partitioned_rules_223816_course_number_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_number ATTACH PARTITION public.partitioned_rules_223816_course_number_idx;


--
-- Name: partitioned_rules_223816_course_subject_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_course_subject ATTACH PARTITION public.partitioned_rules_223816_course_subject_idx;


--
-- Name: partitioned_rules_223816_pkey; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_pkey ATTACH PARTITION public.partitioned_rules_223816_pkey;


--
-- Name: partitioned_rules_223816_rule_identifier_course_id_uploaded_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_id_uploaded_instit_key ATTACH PARTITION public.partitioned_rules_223816_rule_identifier_course_id_uploaded_key;


--
-- Name: partitioned_rules_223816_rule_identifier_course_type_instit_key; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.partitioned_rules_rule_identifier_course_type_institution_n_key ATTACH PARTITION public.partitioned_rules_223816_rule_identifier_course_type_instit_key;


--
-- Name: partitioned_rules_223816_upload_date_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_partitioned_rules_upload_date ATTACH PARTITION public.partitioned_rules_223816_upload_date_idx;


--
-- Name: partitioned_rules create_partition_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER create_partition_trigger BEFORE INSERT ON public.partitioned_rules FOR EACH ROW EXECUTE FUNCTION public.create_partition_if_not_exists();


--
-- Name: partitioned_rules partition_change_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER partition_change_trigger AFTER INSERT OR DELETE OR UPDATE ON public.partitioned_rules FOR EACH ROW EXECUTE FUNCTION public.update_partition_change_tracker();


--
-- Name: analytics_table_alignments analytics_table_alignments_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_alignments
    ADD CONSTRAINT analytics_table_alignments_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: analytics_table_boost analytics_table_boost_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_boost
    ADD CONSTRAINT analytics_table_boost_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: analytics_table_boost analytics_table_boost_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_boost
    ADD CONSTRAINT analytics_table_boost_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.suggestion_request(request_id);


--
-- Name: analytics_table_suggestions analytics_table_suggestions_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analytics_table_suggestions
    ADD CONSTRAINT analytics_table_suggestions_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_updated_inst_profile app_event_updated_inst_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_profile
    ADD CONSTRAINT app_event_updated_inst_profile_id_fkey FOREIGN KEY (id) REFERENCES public.app_event(id) ON DELETE CASCADE;


--
-- Name: app_event_updated_inst_profile app_event_updated_inst_profile_updated_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_profile
    ADD CONSTRAINT app_event_updated_inst_profile_updated_institution_id_fkey FOREIGN KEY (updated_institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_updated_inst_profile app_event_updated_inst_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_profile
    ADD CONSTRAINT app_event_updated_inst_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_updated_inst_profile app_event_updated_inst_profile_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_profile
    ADD CONSTRAINT app_event_updated_inst_profile_user_inst_id_fkey FOREIGN KEY (user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_updated_inst_settings app_event_updated_inst_settings_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_settings
    ADD CONSTRAINT app_event_updated_inst_settings_id_fkey FOREIGN KEY (id) REFERENCES public.app_event(id) ON DELETE CASCADE;


--
-- Name: app_event_updated_inst_settings app_event_updated_inst_settings_updated_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_settings
    ADD CONSTRAINT app_event_updated_inst_settings_updated_institution_id_fkey FOREIGN KEY (updated_institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_updated_inst_settings app_event_updated_inst_settings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_settings
    ADD CONSTRAINT app_event_updated_inst_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_updated_inst_settings app_event_updated_inst_settings_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_updated_inst_settings
    ADD CONSTRAINT app_event_updated_inst_settings_user_inst_id_fkey FOREIGN KEY (user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_added_user app_event_user_added_user_added_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_added_user
    ADD CONSTRAINT app_event_user_added_user_added_user_id_fkey FOREIGN KEY (added_user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_user_added_user app_event_user_added_user_added_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_added_user
    ADD CONSTRAINT app_event_user_added_user_added_user_inst_id_fkey FOREIGN KEY (added_user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_added_user app_event_user_added_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_added_user
    ADD CONSTRAINT app_event_user_added_user_id_fkey FOREIGN KEY (id) REFERENCES public.app_event(id) ON DELETE CASCADE;


--
-- Name: app_event_user_added_user app_event_user_added_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_added_user
    ADD CONSTRAINT app_event_user_added_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_user_added_user app_event_user_added_user_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_added_user
    ADD CONSTRAINT app_event_user_added_user_user_inst_id_fkey FOREIGN KEY (user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_reviewed_suggestions app_event_user_reviewed_suggestions_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_reviewed_suggestions
    ADD CONSTRAINT app_event_user_reviewed_suggestions_id_fkey FOREIGN KEY (id) REFERENCES public.app_event(id) ON DELETE CASCADE;


--
-- Name: app_event_user_reviewed_suggestions app_event_user_reviewed_suggestions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_reviewed_suggestions
    ADD CONSTRAINT app_event_user_reviewed_suggestions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_user_reviewed_suggestions app_event_user_reviewed_suggestions_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_reviewed_suggestions
    ADD CONSTRAINT app_event_user_reviewed_suggestions_user_inst_id_fkey FOREIGN KEY (user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_updated_profile app_event_user_updated_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_updated_profile
    ADD CONSTRAINT app_event_user_updated_profile_id_fkey FOREIGN KEY (id) REFERENCES public.app_event(id) ON DELETE CASCADE;


--
-- Name: app_event_user_updated_profile app_event_user_updated_profile_updated_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_updated_profile
    ADD CONSTRAINT app_event_user_updated_profile_updated_user_id_fkey FOREIGN KEY (updated_user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_user_updated_profile app_event_user_updated_profile_updated_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_updated_profile
    ADD CONSTRAINT app_event_user_updated_profile_updated_user_inst_id_fkey FOREIGN KEY (updated_user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_updated_profile app_event_user_updated_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_updated_profile
    ADD CONSTRAINT app_event_user_updated_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_user_updated_profile app_event_user_updated_profile_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_updated_profile
    ADD CONSTRAINT app_event_user_updated_profile_user_inst_id_fkey FOREIGN KEY (user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_uploaded_rules app_event_user_uploaded_rules_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_uploaded_rules
    ADD CONSTRAINT app_event_user_uploaded_rules_id_fkey FOREIGN KEY (id) REFERENCES public.app_event(id) ON DELETE CASCADE;


--
-- Name: app_event_user_uploaded_rules app_event_user_uploaded_rules_uploaded_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_uploaded_rules
    ADD CONSTRAINT app_event_user_uploaded_rules_uploaded_institution_id_fkey FOREIGN KEY (uploaded_institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: app_event_user_uploaded_rules app_event_user_uploaded_rules_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_uploaded_rules
    ADD CONSTRAINT app_event_user_uploaded_rules_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: app_event_user_uploaded_rules app_event_user_uploaded_rules_user_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_event_user_uploaded_rules
    ADD CONSTRAINT app_event_user_uploaded_rules_user_inst_id_fkey FOREIGN KEY (user_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: audit_table_publish_course_inventory audit_table_publish_course_inventory_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table_publish_course_inventory
    ADD CONSTRAINT audit_table_publish_course_inventory_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: audit_table audit_table_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_table
    ADD CONSTRAINT audit_table_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: course_metadata course_metadata_inst_unique_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_metadata
    ADD CONSTRAINT course_metadata_inst_unique_id_fkey FOREIGN KEY (inst_unique_id) REFERENCES public.master_universities(institution_id);


--
-- Name: course_metadata course_metadata_master_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_metadata
    ADD CONSTRAINT course_metadata_master_course_id_fkey FOREIGN KEY (master_course_id) REFERENCES public.master_courses(course_id);


--
-- Name: custom_filter custom_filter_creator_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_filter
    ADD CONSTRAINT custom_filter_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES public.users(uuid);


--
-- Name: custom_filter custom_filter_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_filter
    ADD CONSTRAINT custom_filter_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: custom_logic_filter custom_logic_filter_creator_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_logic_filter
    ADD CONSTRAINT custom_logic_filter_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES public.users(uuid);


--
-- Name: custom_logic_filter custom_logic_filter_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_logic_filter
    ADD CONSTRAINT custom_logic_filter_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: district_rule_map district_rule_map_source_unique_identifier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district_rule_map
    ADD CONSTRAINT district_rule_map_source_unique_identifier_fkey FOREIGN KEY (source_unique_identifier) REFERENCES public.master_universities(institution_id);


--
-- Name: district_rule_map district_rule_map_target_unique_identifier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.district_rule_map
    ADD CONSTRAINT district_rule_map_target_unique_identifier_fkey FOREIGN KEY (target_unique_identifier) REFERENCES public.master_universities(institution_id);


--
-- Name: districts districts_creator_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_creator_inst_id_fkey FOREIGN KEY (creator_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: districts districts_creator_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.districts
    ADD CONSTRAINT districts_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES public.users(uuid);


--
-- Name: evaluation_group evaluation_group_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group
    ADD CONSTRAINT evaluation_group_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(uuid);


--
-- Name: evaluation_group evaluation_group_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group
    ADD CONSTRAINT evaluation_group_inst_id_fkey FOREIGN KEY (inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: evaluation_group evaluation_group_updated_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.evaluation_group
    ADD CONSTRAINT evaluation_group_updated_by_user_id_fkey FOREIGN KEY (updated_by_user_id) REFERENCES public.users(uuid);


--
-- Name: feed_session_mapping feed_session_mapping_feed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_feed_id_fkey FOREIGN KEY (feed_id) REFERENCES public.feed(id) ON DELETE CASCADE;


--
-- Name: file_upload_process file_upload_process_uploaded_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_upload_process
    ADD CONSTRAINT file_upload_process_uploaded_by_id_fkey FOREIGN KEY (uploaded_by_id) REFERENCES public.users(uuid);


--
-- Name: general_education_crosswalk fk_creator_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk
    ADD CONSTRAINT fk_creator_user_id FOREIGN KEY (creator_user_id) REFERENCES public.users(uuid);


--
-- Name: graph_db_output fk_graph_db_output_workflow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT fk_graph_db_output_workflow FOREIGN KEY (workflow_id) REFERENCES public.workflow(id) ON DELETE SET NULL;


--
-- Name: general_education_crosswalk fk_institution_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk
    ADD CONSTRAINT fk_institution_id FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: graph_db_output fk_request_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT fk_request_id FOREIGN KEY (request_id) REFERENCES public.suggestion_request(request_id);


--
-- Name: suggestion_decisions fk_suggestion_decisions_workflow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_decisions
    ADD CONSTRAINT fk_suggestion_decisions_workflow FOREIGN KEY (workflow_id) REFERENCES public.workflow(id) ON DELETE SET NULL;


--
-- Name: user_action_tokens fk_user_action_tokens_issued_by_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_action_tokens
    ADD CONSTRAINT fk_user_action_tokens_issued_by_user_id FOREIGN KEY (issued_by_user_id) REFERENCES public.users(uuid);


--
-- Name: workflow fk_workflow_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow
    ADD CONSTRAINT fk_workflow_created_by FOREIGN KEY (created_by) REFERENCES public.users(uuid) ON DELETE SET NULL;


--
-- Name: workflow fk_workflow_inst_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow
    ADD CONSTRAINT fk_workflow_inst_id FOREIGN KEY (inst_id) REFERENCES public.master_universities(institution_id) ON DELETE SET NULL;


--
-- Name: general_education_category general_education_category_creator_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_category
    ADD CONSTRAINT general_education_category_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES public.users(uuid);


--
-- Name: general_education_category general_education_category_last_updater_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_category
    ADD CONSTRAINT general_education_category_last_updater_user_id_fkey FOREIGN KEY (last_updater_user_id) REFERENCES public.users(uuid);


--
-- Name: general_education_crosswalk general_education_crosswalk_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk
    ADD CONSTRAINT general_education_crosswalk_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.general_education_category(general_education_category_id) ON DELETE CASCADE;


--
-- Name: general_education_crosswalk general_education_crosswalk_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk
    ADD CONSTRAINT general_education_crosswalk_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id) ON DELETE CASCADE;


--
-- Name: general_education_crosswalk general_education_crosswalk_last_updater_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.general_education_crosswalk
    ADD CONSTRAINT general_education_crosswalk_last_updater_user_id_fkey FOREIGN KEY (last_updater_user_id) REFERENCES public.users(uuid);


--
-- Name: graph_db_output graph_db_output_assignee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_assignee_id_fkey FOREIGN KEY (assignee_id) REFERENCES public.users(uuid);


--
-- Name: graph_db_output graph_db_output_common_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_common_course_id_fkey FOREIGN KEY (common_course_id) REFERENCES public.master_courses(course_id);


--
-- Name: graph_db_output graph_db_output_common_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_common_institution_id_fkey FOREIGN KEY (common_institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: graph_db_output graph_db_output_decision_maker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_decision_maker_id_fkey FOREIGN KEY (decision_maker_id) REFERENCES public.users(uuid);


--
-- Name: graph_db_output graph_db_output_source_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_source_course_id_fkey FOREIGN KEY (source_course_id) REFERENCES public.master_courses(course_id);


--
-- Name: graph_db_output graph_db_output_source_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_source_institution_id_fkey FOREIGN KEY (source_institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: graph_db_output graph_db_output_suggestion_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_suggestion_request_id_fkey FOREIGN KEY (source_suggestion_request_id) REFERENCES public.suggestion_request(request_id);


--
-- Name: graph_db_output graph_db_output_target_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_target_course_id_fkey FOREIGN KEY (target_course_id) REFERENCES public.master_courses(course_id);


--
-- Name: graph_db_output graph_db_output_target_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.graph_db_output
    ADD CONSTRAINT graph_db_output_target_institution_id_fkey FOREIGN KEY (target_institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: inquiry inquiry_to_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_to_inst_id_fkey FOREIGN KEY (to_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: institution_profile_link institution_profile_link_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institution_profile_link
    ADD CONSTRAINT institution_profile_link_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: institution_settings institution_settings_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institution_settings
    ADD CONSTRAINT institution_settings_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: master_courses master_courses_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_courses
    ADD CONSTRAINT master_courses_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: master_courses master_courses_parent_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_courses
    ADD CONSTRAINT master_courses_parent_course_id_fkey FOREIGN KEY (parent_course_id) REFERENCES public.master_courses(course_id);


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.oauth2_clients(client_id);


--
-- Name: oauth2_authorization_codes oauth2_authorization_codes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_authorization_codes
    ADD CONSTRAINT oauth2_authorization_codes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: oauth2_clients oauth2_clients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_clients
    ADD CONSTRAINT oauth2_clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: oauth2_tokens oauth2_tokens_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.oauth2_clients(client_id);


--
-- Name: oauth2_tokens oauth2_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth2_tokens
    ADD CONSTRAINT oauth2_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: api_tokens oauth_tokens_authoriser_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT oauth_tokens_authoriser_id_fkey FOREIGN KEY (authoriser_id) REFERENCES public.users(uuid);


--
-- Name: api_tokens oauth_tokens_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT oauth_tokens_inst_id_fkey FOREIGN KEY (inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: api_tokens oauth_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT oauth_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: peer_groups peer_groups_belongs_to_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.peer_groups
    ADD CONSTRAINT peer_groups_belongs_to_inst_id_fkey FOREIGN KEY (belongs_to_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: peer_groups peer_groups_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.peer_groups
    ADD CONSTRAINT peer_groups_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(uuid);


--
-- Name: peer_groups peer_groups_updated_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.peer_groups
    ADD CONSTRAINT peer_groups_updated_by_user_id_fkey FOREIGN KEY (updated_by_user_id) REFERENCES public.users(uuid);


--
-- Name: rate_limiting rate_limiting_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limiting
    ADD CONSTRAINT rate_limiting_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: run_triangulation_log run_triangulation_log_ran_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.run_triangulation_log
    ADD CONSTRAINT run_triangulation_log_ran_by_user_id_fkey FOREIGN KEY (ran_by_user_id) REFERENCES public.users(uuid);


--
-- Name: run_triangulation_log run_triangulation_log_ran_for_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.run_triangulation_log
    ADD CONSTRAINT run_triangulation_log_ran_for_inst_id_fkey FOREIGN KEY (ran_for_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: suggestion_decisions suggestion_decisions_decided_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_decisions
    ADD CONSTRAINT suggestion_decisions_decided_by_user_id_fkey FOREIGN KEY (decided_by_user_id) REFERENCES public.users(uuid);


--
-- Name: suggestion_decisions suggestion_decisions_deleted_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_decisions
    ADD CONSTRAINT suggestion_decisions_deleted_by_user_id_fkey FOREIGN KEY (deleted_by_user_id) REFERENCES public.users(uuid);


--
-- Name: suggestion_decisions suggestion_decisions_suggestion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_decisions
    ADD CONSTRAINT suggestion_decisions_suggestion_id_fkey FOREIGN KEY (suggestion_id) REFERENCES public.graph_db_output(uuid);


--
-- Name: suggestion_request_align_course suggestion_request_align_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_align_course
    ADD CONSTRAINT suggestion_request_align_course_id_fkey FOREIGN KEY (id) REFERENCES public.suggestion_request(id) ON DELETE CASCADE;


--
-- Name: suggestion_request suggestion_request_assigned_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request
    ADD CONSTRAINT suggestion_request_assigned_user_id_fkey FOREIGN KEY (assigned_user_id) REFERENCES public.users(uuid);


--
-- Name: suggestion_request_find_course suggestion_request_find_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_find_course
    ADD CONSTRAINT suggestion_request_find_course_id_fkey FOREIGN KEY (id) REFERENCES public.suggestion_request(id) ON DELETE CASCADE;


--
-- Name: suggestion_request_improve_rules suggestion_request_improve_rules_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_improve_rules
    ADD CONSTRAINT suggestion_request_improve_rules_id_fkey FOREIGN KEY (id) REFERENCES public.suggestion_request(id) ON DELETE CASCADE;


--
-- Name: suggestion_request_partner_institution suggestion_request_partner_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request_partner_institution
    ADD CONSTRAINT suggestion_request_partner_institution_id_fkey FOREIGN KEY (id) REFERENCES public.suggestion_request(id) ON DELETE CASCADE;


--
-- Name: suggestion_request suggestion_request_requested_by_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request
    ADD CONSTRAINT suggestion_request_requested_by_inst_id_fkey FOREIGN KEY (requested_by_inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: suggestion_request suggestion_request_requested_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.suggestion_request
    ADD CONSTRAINT suggestion_request_requested_by_user_id_fkey FOREIGN KEY (requested_by_user_id) REFERENCES public.users(uuid);


--
-- Name: threshold_value threshold_value_creator_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.threshold_value
    ADD CONSTRAINT threshold_value_creator_user_id_fkey FOREIGN KEY (creator_user_id) REFERENCES public.users(uuid);


--
-- Name: threshold_value threshold_value_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.threshold_value
    ADD CONSTRAINT threshold_value_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: unprocessed_equivalencies unprocessed_equivalencies_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unprocessed_equivalencies
    ADD CONSTRAINT unprocessed_equivalencies_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.master_courses(course_id);


--
-- Name: user_action_tokens user_action_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_action_tokens
    ADD CONSTRAINT user_action_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: user_notification_settings user_notification_settings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_notification_settings
    ADD CONSTRAINT user_notification_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: user_password_hashes user_password_hashes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_password_hashes
    ADD CONSTRAINT user_password_hashes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(uuid);


--
-- Name: users users_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.master_universities(institution_id);


--
-- Name: workflow_response workflow_response_inst_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_response
    ADD CONSTRAINT workflow_response_inst_id_fkey FOREIGN KEY (inst_id) REFERENCES public.master_universities(institution_id);


--
-- Name: workflow_scheme_approver workflow_scheme_approver_approver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_approver
    ADD CONSTRAINT workflow_scheme_approver_approver_fkey FOREIGN KEY (approver) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_approver workflow_scheme_approver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_approver
    ADD CONSTRAINT workflow_scheme_approver_id_fkey FOREIGN KEY (id) REFERENCES public.workflow(id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_approver workflow_scheme_commenter_approver_approver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_approver
    ADD CONSTRAINT workflow_scheme_commenter_approver_approver_fkey FOREIGN KEY (approver) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_approver workflow_scheme_commenter_approver_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_approver
    ADD CONSTRAINT workflow_scheme_commenter_approver_commenter_fkey FOREIGN KEY (commenter) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_approver workflow_scheme_commenter_approver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_approver
    ADD CONSTRAINT workflow_scheme_commenter_approver_id_fkey FOREIGN KEY (id) REFERENCES public.workflow(id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_group_approver workflow_scheme_commenter_group_approver_approver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_group_approver
    ADD CONSTRAINT workflow_scheme_commenter_group_approver_approver_fkey FOREIGN KEY (approver) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_group_approver workflow_scheme_commenter_group_approver_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_group_approver
    ADD CONSTRAINT workflow_scheme_commenter_group_approver_commenter_fkey FOREIGN KEY (commenter) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_group_approver workflow_scheme_commenter_group_approver_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_group_approver
    ADD CONSTRAINT workflow_scheme_commenter_group_approver_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.evaluation_group(evaluation_group_id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_commenter_group_approver workflow_scheme_commenter_group_approver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_commenter_group_approver
    ADD CONSTRAINT workflow_scheme_commenter_group_approver_id_fkey FOREIGN KEY (id) REFERENCES public.workflow(id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_dual_commenter_approver workflow_scheme_dual_commenter_approver_approver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_dual_commenter_approver
    ADD CONSTRAINT workflow_scheme_dual_commenter_approver_approver_fkey FOREIGN KEY (approver) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_dual_commenter_approver workflow_scheme_dual_commenter_approver_first_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_dual_commenter_approver
    ADD CONSTRAINT workflow_scheme_dual_commenter_approver_first_commenter_fkey FOREIGN KEY (first_commenter) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_dual_commenter_approver workflow_scheme_dual_commenter_approver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_dual_commenter_approver
    ADD CONSTRAINT workflow_scheme_dual_commenter_approver_id_fkey FOREIGN KEY (id) REFERENCES public.workflow(id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_dual_commenter_approver workflow_scheme_dual_commenter_approver_second_commenter_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_dual_commenter_approver
    ADD CONSTRAINT workflow_scheme_dual_commenter_approver_second_commenter_fkey FOREIGN KEY (second_commenter) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_group_approver workflow_scheme_group_approver_approver_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group_approver
    ADD CONSTRAINT workflow_scheme_group_approver_approver_fkey FOREIGN KEY (approver) REFERENCES public.users(uuid) ON DELETE CASCADE;


--
-- Name: workflow_scheme_group_approver workflow_scheme_group_approver_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group_approver
    ADD CONSTRAINT workflow_scheme_group_approver_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.evaluation_group(evaluation_group_id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_group_approver workflow_scheme_group_approver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group_approver
    ADD CONSTRAINT workflow_scheme_group_approver_id_fkey FOREIGN KEY (id) REFERENCES public.workflow(id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_group workflow_scheme_group_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group
    ADD CONSTRAINT workflow_scheme_group_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.evaluation_group(evaluation_group_id) ON DELETE CASCADE;


--
-- Name: workflow_scheme_group workflow_scheme_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_scheme_group
    ADD CONSTRAINT workflow_scheme_group_id_fkey FOREIGN KEY (id) REFERENCES public.workflow(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20250606035631'),
    ('20250606050831'),
    ('20250606073703'),
    ('20250606082308'),
    ('20250620011605'),
    ('20250621052321'),
    ('20250621073938'),
    ('20250621074526'),
    ('20250621210214');
