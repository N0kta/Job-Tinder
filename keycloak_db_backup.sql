--
-- PostgreSQL database dump
--

\restrict eTIin1ShxEpES2nB32fCZxwEo3Kjn1cLIpCq1a8JYVkfWKIIu9yJXezhLs94Eav

-- Dumped from database version 15.14 (Debian 15.14-1.pgdg13+1)
-- Dumped by pg_dump version 15.14 (Debian 15.14-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
9c5e05c2-e3a1-4501-b9de-cfea43aac0f2	\N	auth-cookie	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	e747ce19-5b69-41ad-b0e2-c7e7e955d67e	2	10	f	\N	\N
caa64d31-19f7-4701-9f1c-c5f26bc4d3fe	\N	auth-spnego	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	e747ce19-5b69-41ad-b0e2-c7e7e955d67e	3	20	f	\N	\N
cc35e692-1163-4e66-866c-fe41c593e2fe	\N	identity-provider-redirector	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	e747ce19-5b69-41ad-b0e2-c7e7e955d67e	2	25	f	\N	\N
94891f4d-b21f-42b0-b1ed-0e693d95672b	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	e747ce19-5b69-41ad-b0e2-c7e7e955d67e	2	30	t	0576ad8a-9edc-41d8-8982-f62c4dcac62b	\N
f32e763f-cac8-4b59-93f3-305a6ecb5b15	\N	auth-username-password-form	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	0576ad8a-9edc-41d8-8982-f62c4dcac62b	0	10	f	\N	\N
632942cc-429d-46a9-ab09-bb2d92e19b96	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	0576ad8a-9edc-41d8-8982-f62c4dcac62b	1	20	t	3a0655bb-08c9-4449-822c-213b7b2f4cb7	\N
2c009869-1081-4a81-bd56-4c2c8a2d06da	\N	conditional-user-configured	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	3a0655bb-08c9-4449-822c-213b7b2f4cb7	0	10	f	\N	\N
69a1bae2-7a67-49d7-827d-5633f82d4049	\N	auth-otp-form	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	3a0655bb-08c9-4449-822c-213b7b2f4cb7	0	20	f	\N	\N
596a4d98-6529-4f1e-9ea1-3c93243b5b89	\N	direct-grant-validate-username	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ecc625ce-9f43-4f58-94ea-1feaf19a1304	0	10	f	\N	\N
4eedcd47-1f8d-4373-aaa9-8602ab5ad27d	\N	direct-grant-validate-password	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ecc625ce-9f43-4f58-94ea-1feaf19a1304	0	20	f	\N	\N
1f0a7ebf-12e3-40a1-aebf-dc7a85e87038	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ecc625ce-9f43-4f58-94ea-1feaf19a1304	1	30	t	89120547-aaa6-4d34-b4ea-7b295c70e248	\N
cd3cc507-70d9-4437-99be-c058bd39eae6	\N	conditional-user-configured	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	89120547-aaa6-4d34-b4ea-7b295c70e248	0	10	f	\N	\N
ffcef3f1-ced8-439f-8d68-34badd5fe0df	\N	direct-grant-validate-otp	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	89120547-aaa6-4d34-b4ea-7b295c70e248	0	20	f	\N	\N
c5e6a75b-56a2-4603-bda6-3b32c69136bb	\N	registration-page-form	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	906eb68f-0099-4927-9efa-d476651aa0eb	0	10	t	ed1d8327-809c-461b-9a64-1a16c60b42d3	\N
a736a96d-b96a-4b0e-92ee-f3bff2c7b26d	\N	registration-user-creation	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ed1d8327-809c-461b-9a64-1a16c60b42d3	0	20	f	\N	\N
103a7049-c4e4-4d3f-823a-66f091c3232c	\N	registration-password-action	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ed1d8327-809c-461b-9a64-1a16c60b42d3	0	50	f	\N	\N
6447958e-9572-46c1-bda5-5fbc8bdaf2cb	\N	registration-recaptcha-action	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ed1d8327-809c-461b-9a64-1a16c60b42d3	3	60	f	\N	\N
341bb1bc-6db0-4439-a142-8d52aa547542	\N	registration-terms-and-conditions	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	ed1d8327-809c-461b-9a64-1a16c60b42d3	3	70	f	\N	\N
3e9bb507-bb4e-4fc1-8c74-30f68132e939	\N	reset-credentials-choose-user	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d7f82324-2695-4c08-b571-751a9f613f01	0	10	f	\N	\N
5793c433-2aeb-43db-bc85-939636095e99	\N	reset-credential-email	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d7f82324-2695-4c08-b571-751a9f613f01	0	20	f	\N	\N
be5203e3-cc7b-4510-90cb-877dddb04811	\N	reset-password	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d7f82324-2695-4c08-b571-751a9f613f01	0	30	f	\N	\N
0708e5bc-d734-4c9e-863e-3b7c9d489a80	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d7f82324-2695-4c08-b571-751a9f613f01	1	40	t	46d48a10-36dc-4a55-a988-bc4a6cf97452	\N
8cf961b4-289a-4895-9269-32543ad0912d	\N	conditional-user-configured	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	46d48a10-36dc-4a55-a988-bc4a6cf97452	0	10	f	\N	\N
7dcf798f-800f-4bee-9b90-3c681ead22f3	\N	reset-otp	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	46d48a10-36dc-4a55-a988-bc4a6cf97452	0	20	f	\N	\N
f7346482-9173-4dab-8950-84cdfd362b62	\N	client-secret	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	5e85c13b-c819-43a9-a125-a1b1876e0b1a	2	10	f	\N	\N
268373d3-1dc9-4fc8-b8df-e305e4ea263d	\N	client-jwt	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	5e85c13b-c819-43a9-a125-a1b1876e0b1a	2	20	f	\N	\N
2413954d-c62e-4b37-bd90-3aa0d4b620ec	\N	client-secret-jwt	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	5e85c13b-c819-43a9-a125-a1b1876e0b1a	2	30	f	\N	\N
6432f57e-f176-490a-b3bd-b7a0a27ea4c0	\N	client-x509	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	5e85c13b-c819-43a9-a125-a1b1876e0b1a	2	40	f	\N	\N
212fc456-4aa9-4e39-95a7-648e5f06171d	\N	idp-review-profile	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	599b8e91-b4c3-4fd5-bfb3-8417c192c99a	0	10	f	\N	85d5d74c-b030-4142-a22c-c732e5499c77
1eaffdfa-267e-42b4-844a-ef086c3a6d12	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	599b8e91-b4c3-4fd5-bfb3-8417c192c99a	0	20	t	05955d5b-3b04-4683-bef6-f2fec3ceae1c	\N
79f25010-8ad2-404e-82bc-08cbd17ee5db	\N	idp-create-user-if-unique	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	05955d5b-3b04-4683-bef6-f2fec3ceae1c	2	10	f	\N	64c65b0d-3783-4e35-80ac-5cc8b2ab8364
7ab196d3-d64c-45aa-897b-895f8f250d74	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	05955d5b-3b04-4683-bef6-f2fec3ceae1c	2	20	t	a3b2d2c9-7258-4b74-b550-63e7747b2372	\N
4d4359a2-1de6-419a-936e-cf05336640ef	\N	idp-confirm-link	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	a3b2d2c9-7258-4b74-b550-63e7747b2372	0	10	f	\N	\N
530d8623-a99d-414c-90b1-cada00138fc8	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	a3b2d2c9-7258-4b74-b550-63e7747b2372	0	20	t	d2eac9fd-6276-4b7a-8ec6-f51a918446c4	\N
e5d7b605-12e5-49a2-acff-a6c2df3d9839	\N	idp-email-verification	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d2eac9fd-6276-4b7a-8ec6-f51a918446c4	2	10	f	\N	\N
3ba8fd35-c045-42f5-b859-e9ca60515e92	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d2eac9fd-6276-4b7a-8ec6-f51a918446c4	2	20	t	02444011-7f2a-4e3b-9f03-1b45c10424c5	\N
46e7fea8-c3ea-4509-991b-9bb9fbbb1372	\N	idp-username-password-form	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	02444011-7f2a-4e3b-9f03-1b45c10424c5	0	10	f	\N	\N
438051b2-0fac-4a2f-9571-cf9e2b90217f	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	02444011-7f2a-4e3b-9f03-1b45c10424c5	1	20	t	87544f2b-c297-49be-af5d-d64387d686f0	\N
25abea31-05a0-44b4-baea-7ba9d13184f5	\N	conditional-user-configured	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	87544f2b-c297-49be-af5d-d64387d686f0	0	10	f	\N	\N
1485e607-98c0-4fda-ab14-2405c45b272b	\N	auth-otp-form	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	87544f2b-c297-49be-af5d-d64387d686f0	0	20	f	\N	\N
1c9a0ac3-5bac-47d1-9f1b-375e589ccf07	\N	http-basic-authenticator	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f977789e-dffd-4f7f-afac-0b4b4f918353	0	10	f	\N	\N
2da3de0b-b620-4be1-b1d6-50f871e281ec	\N	docker-http-basic-authenticator	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	31a56ade-ae4c-4a68-b705-88b9dbf9a293	0	10	f	\N	\N
270ca802-f2e4-4287-ba7e-6a6a758eac7c	\N	auth-cookie	5cadf19d-2afe-4405-a6f0-974df43fe807	f835643f-9a57-4c91-b271-748959f07b1a	2	10	f	\N	\N
26090cb4-e866-4155-a4c6-d21d1ba602da	\N	auth-spnego	5cadf19d-2afe-4405-a6f0-974df43fe807	f835643f-9a57-4c91-b271-748959f07b1a	3	20	f	\N	\N
1ab19140-40b0-4fc9-80d1-6a9c5410b943	\N	identity-provider-redirector	5cadf19d-2afe-4405-a6f0-974df43fe807	f835643f-9a57-4c91-b271-748959f07b1a	2	25	f	\N	\N
329a9d83-33c5-4b3d-beaa-bf4f28817fcb	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	f835643f-9a57-4c91-b271-748959f07b1a	2	30	t	f396c72f-c03e-4319-9e58-a0c984d57634	\N
0b20e016-a924-4546-a640-721c2e5041f4	\N	auth-username-password-form	5cadf19d-2afe-4405-a6f0-974df43fe807	f396c72f-c03e-4319-9e58-a0c984d57634	0	10	f	\N	\N
7483bab7-8ed2-48d4-9ec3-9b0d60ce92f0	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	f396c72f-c03e-4319-9e58-a0c984d57634	1	20	t	0670d71d-3062-4654-9588-0fb0d791e588	\N
4b80169f-4326-4d4a-b6a9-ccc3a06a8502	\N	conditional-user-configured	5cadf19d-2afe-4405-a6f0-974df43fe807	0670d71d-3062-4654-9588-0fb0d791e588	0	10	f	\N	\N
dfb10682-624c-4727-bf04-05eadca9854a	\N	auth-otp-form	5cadf19d-2afe-4405-a6f0-974df43fe807	0670d71d-3062-4654-9588-0fb0d791e588	0	20	f	\N	\N
36dff0c2-116b-464d-b688-de79fbe0c2c5	\N	direct-grant-validate-username	5cadf19d-2afe-4405-a6f0-974df43fe807	ec2f66f8-b31d-43ae-b83c-8931a681cc45	0	10	f	\N	\N
7f384527-3aca-4e64-bcc3-7101bcf85b98	\N	direct-grant-validate-password	5cadf19d-2afe-4405-a6f0-974df43fe807	ec2f66f8-b31d-43ae-b83c-8931a681cc45	0	20	f	\N	\N
d653a2c6-d81a-4849-bc43-56e3097484ca	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	ec2f66f8-b31d-43ae-b83c-8931a681cc45	1	30	t	ea418592-c594-406d-a95d-cb7f4dd0ddf3	\N
8fed9496-5b4a-4f14-b5f4-60f32f986641	\N	conditional-user-configured	5cadf19d-2afe-4405-a6f0-974df43fe807	ea418592-c594-406d-a95d-cb7f4dd0ddf3	0	10	f	\N	\N
70b3e38c-fa0b-4e0b-a4cc-8861aff97ba2	\N	direct-grant-validate-otp	5cadf19d-2afe-4405-a6f0-974df43fe807	ea418592-c594-406d-a95d-cb7f4dd0ddf3	0	20	f	\N	\N
b64dfaeb-20fd-4570-a5ce-49e7db596135	\N	registration-page-form	5cadf19d-2afe-4405-a6f0-974df43fe807	b040176f-c2e9-40d2-92f7-6c31a3f4a3bb	0	10	t	3e1655b0-a16a-4a6e-b518-6011deffccdb	\N
644738ce-4f33-4460-890e-e45b5643d534	\N	registration-user-creation	5cadf19d-2afe-4405-a6f0-974df43fe807	3e1655b0-a16a-4a6e-b518-6011deffccdb	0	20	f	\N	\N
277a0f74-0e0c-4b54-9471-99f786991393	\N	registration-password-action	5cadf19d-2afe-4405-a6f0-974df43fe807	3e1655b0-a16a-4a6e-b518-6011deffccdb	0	50	f	\N	\N
fd6b853c-5496-4348-b1d7-47d371223187	\N	registration-recaptcha-action	5cadf19d-2afe-4405-a6f0-974df43fe807	3e1655b0-a16a-4a6e-b518-6011deffccdb	3	60	f	\N	\N
5cc0c118-fabd-4304-a609-a86056ae3918	\N	reset-credentials-choose-user	5cadf19d-2afe-4405-a6f0-974df43fe807	69297c8d-f075-465c-825a-492a85a1bdc5	0	10	f	\N	\N
9e3a93d9-baf1-4aac-bb45-1d0da4dab447	\N	reset-credential-email	5cadf19d-2afe-4405-a6f0-974df43fe807	69297c8d-f075-465c-825a-492a85a1bdc5	0	20	f	\N	\N
6796d1ed-c955-4b78-89a5-bcef68b60733	\N	reset-password	5cadf19d-2afe-4405-a6f0-974df43fe807	69297c8d-f075-465c-825a-492a85a1bdc5	0	30	f	\N	\N
009b0a1c-21eb-415a-9404-2cf6140c14f8	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	69297c8d-f075-465c-825a-492a85a1bdc5	1	40	t	1789d4b7-603b-436d-8820-129de652a9df	\N
b81f6663-2a71-4ca8-b6e0-a51686fdcec1	\N	conditional-user-configured	5cadf19d-2afe-4405-a6f0-974df43fe807	1789d4b7-603b-436d-8820-129de652a9df	0	10	f	\N	\N
6ab3f1d2-48fb-4afa-84f1-5ec20408be31	\N	reset-otp	5cadf19d-2afe-4405-a6f0-974df43fe807	1789d4b7-603b-436d-8820-129de652a9df	0	20	f	\N	\N
6fa78480-10c2-4860-8724-8a0a2f00612c	\N	client-secret	5cadf19d-2afe-4405-a6f0-974df43fe807	6b0d0ab7-20da-445e-9415-4f254eae67a7	2	10	f	\N	\N
f1fd8a3c-59d7-4824-9439-4ac040d234a6	\N	client-jwt	5cadf19d-2afe-4405-a6f0-974df43fe807	6b0d0ab7-20da-445e-9415-4f254eae67a7	2	20	f	\N	\N
8754730d-0dc2-4f0b-9e4b-7bdbcfe1096e	\N	client-secret-jwt	5cadf19d-2afe-4405-a6f0-974df43fe807	6b0d0ab7-20da-445e-9415-4f254eae67a7	2	30	f	\N	\N
290f1d49-22a5-4edf-85f9-b7de74213865	\N	client-x509	5cadf19d-2afe-4405-a6f0-974df43fe807	6b0d0ab7-20da-445e-9415-4f254eae67a7	2	40	f	\N	\N
7e7dbded-4b53-4a72-8e24-c38034d50e73	\N	idp-review-profile	5cadf19d-2afe-4405-a6f0-974df43fe807	ab8bf2be-9fb3-4198-bb6c-1ffbc139bb69	0	10	f	\N	cdc75508-2192-4c28-9b35-efefb06737bd
037d0a01-8983-4126-91ed-4693b5a769e5	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	ab8bf2be-9fb3-4198-bb6c-1ffbc139bb69	0	20	t	82a69e8e-a166-45d4-ac66-69798705e271	\N
501baa11-0c22-4602-b962-34c28e96048e	\N	idp-create-user-if-unique	5cadf19d-2afe-4405-a6f0-974df43fe807	82a69e8e-a166-45d4-ac66-69798705e271	2	10	f	\N	a128e02c-9af4-4fe5-a19c-4c9b69be5d23
ad3fe814-8dda-4b65-b8d7-06188ec2a2f8	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	82a69e8e-a166-45d4-ac66-69798705e271	2	20	t	197f62f7-6647-4f12-a684-e9ed74da6251	\N
cd5903d6-0461-4fa5-86ff-959f6a8c5868	\N	idp-confirm-link	5cadf19d-2afe-4405-a6f0-974df43fe807	197f62f7-6647-4f12-a684-e9ed74da6251	0	10	f	\N	\N
1be3fbb8-c8d5-40d9-8f6f-674c63ee2777	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	197f62f7-6647-4f12-a684-e9ed74da6251	0	20	t	90099e07-cda0-4283-a790-33dbc2e29c13	\N
31558dad-db17-4e21-956a-6f03e9333f59	\N	idp-email-verification	5cadf19d-2afe-4405-a6f0-974df43fe807	90099e07-cda0-4283-a790-33dbc2e29c13	2	10	f	\N	\N
685cad39-7643-427a-8f5e-6b28c0291f73	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	90099e07-cda0-4283-a790-33dbc2e29c13	2	20	t	dda8a637-4da7-4253-b677-dc20fb16aa55	\N
ce83c7eb-6089-4100-b753-d05671d64011	\N	idp-username-password-form	5cadf19d-2afe-4405-a6f0-974df43fe807	dda8a637-4da7-4253-b677-dc20fb16aa55	0	10	f	\N	\N
222d5b1b-9281-4df2-9b78-c13fbaf50dd0	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	dda8a637-4da7-4253-b677-dc20fb16aa55	1	20	t	6fda358d-962e-45db-abe2-1c066bb15975	\N
8e04e451-c4de-4723-837f-6ccedb900cd5	\N	conditional-user-configured	5cadf19d-2afe-4405-a6f0-974df43fe807	6fda358d-962e-45db-abe2-1c066bb15975	0	10	f	\N	\N
6d3ac2f3-29f9-4770-b11f-144d847aff32	\N	auth-otp-form	5cadf19d-2afe-4405-a6f0-974df43fe807	6fda358d-962e-45db-abe2-1c066bb15975	0	20	f	\N	\N
2f92f32b-286f-4342-a4e4-7db2dde69a01	\N	http-basic-authenticator	5cadf19d-2afe-4405-a6f0-974df43fe807	dde373ef-9c99-4aeb-90d3-f0b841d47dd4	0	10	f	\N	\N
2a654bea-a8dc-43bf-b81d-78ba54afa444	\N	docker-http-basic-authenticator	5cadf19d-2afe-4405-a6f0-974df43fe807	5a63ab51-ff6e-40c0-be1a-6652dd3e28ce	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
e747ce19-5b69-41ad-b0e2-c7e7e955d67e	browser	browser based authentication	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
0576ad8a-9edc-41d8-8982-f62c4dcac62b	forms	Username, password, otp and other auth forms.	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
3a0655bb-08c9-4449-822c-213b7b2f4cb7	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
ecc625ce-9f43-4f58-94ea-1feaf19a1304	direct grant	OpenID Connect Resource Owner Grant	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
89120547-aaa6-4d34-b4ea-7b295c70e248	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
906eb68f-0099-4927-9efa-d476651aa0eb	registration	registration flow	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
ed1d8327-809c-461b-9a64-1a16c60b42d3	registration form	registration form	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	form-flow	f	t
d7f82324-2695-4c08-b571-751a9f613f01	reset credentials	Reset credentials for a user if they forgot their password or something	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
46d48a10-36dc-4a55-a988-bc4a6cf97452	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
5e85c13b-c819-43a9-a125-a1b1876e0b1a	clients	Base authentication for clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	client-flow	t	t
599b8e91-b4c3-4fd5-bfb3-8417c192c99a	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
05955d5b-3b04-4683-bef6-f2fec3ceae1c	User creation or linking	Flow for the existing/non-existing user alternatives	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
a3b2d2c9-7258-4b74-b550-63e7747b2372	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
d2eac9fd-6276-4b7a-8ec6-f51a918446c4	Account verification options	Method with which to verity the existing account	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
02444011-7f2a-4e3b-9f03-1b45c10424c5	Verify Existing Account by Re-authentication	Reauthentication of existing account	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
87544f2b-c297-49be-af5d-d64387d686f0	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	f	t
f977789e-dffd-4f7f-afac-0b4b4f918353	saml ecp	SAML ECP Profile Authentication Flow	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
31a56ade-ae4c-4a68-b705-88b9dbf9a293	docker auth	Used by Docker clients to authenticate against the IDP	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	basic-flow	t	t
f835643f-9a57-4c91-b271-748959f07b1a	browser	browser based authentication	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
f396c72f-c03e-4319-9e58-a0c984d57634	forms	Username, password, otp and other auth forms.	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
0670d71d-3062-4654-9588-0fb0d791e588	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
ec2f66f8-b31d-43ae-b83c-8931a681cc45	direct grant	OpenID Connect Resource Owner Grant	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
ea418592-c594-406d-a95d-cb7f4dd0ddf3	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
b040176f-c2e9-40d2-92f7-6c31a3f4a3bb	registration	registration flow	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
3e1655b0-a16a-4a6e-b518-6011deffccdb	registration form	registration form	5cadf19d-2afe-4405-a6f0-974df43fe807	form-flow	f	t
69297c8d-f075-465c-825a-492a85a1bdc5	reset credentials	Reset credentials for a user if they forgot their password or something	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
1789d4b7-603b-436d-8820-129de652a9df	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
6b0d0ab7-20da-445e-9415-4f254eae67a7	clients	Base authentication for clients	5cadf19d-2afe-4405-a6f0-974df43fe807	client-flow	t	t
ab8bf2be-9fb3-4198-bb6c-1ffbc139bb69	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
82a69e8e-a166-45d4-ac66-69798705e271	User creation or linking	Flow for the existing/non-existing user alternatives	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
197f62f7-6647-4f12-a684-e9ed74da6251	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
90099e07-cda0-4283-a790-33dbc2e29c13	Account verification options	Method with which to verity the existing account	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
dda8a637-4da7-4253-b677-dc20fb16aa55	Verify Existing Account by Re-authentication	Reauthentication of existing account	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
6fda358d-962e-45db-abe2-1c066bb15975	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	f	t
dde373ef-9c99-4aeb-90d3-f0b841d47dd4	saml ecp	SAML ECP Profile Authentication Flow	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
5a63ab51-ff6e-40c0-be1a-6652dd3e28ce	docker auth	Used by Docker clients to authenticate against the IDP	5cadf19d-2afe-4405-a6f0-974df43fe807	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
85d5d74c-b030-4142-a22c-c732e5499c77	review profile config	1c6a73e7-c19a-492a-9e6d-342c1427c7bf
64c65b0d-3783-4e35-80ac-5cc8b2ab8364	create unique user config	1c6a73e7-c19a-492a-9e6d-342c1427c7bf
cdc75508-2192-4c28-9b35-efefb06737bd	review profile config	5cadf19d-2afe-4405-a6f0-974df43fe807
a128e02c-9af4-4fe5-a19c-4c9b69be5d23	create unique user config	5cadf19d-2afe-4405-a6f0-974df43fe807
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
64c65b0d-3783-4e35-80ac-5cc8b2ab8364	false	require.password.update.after.registration
85d5d74c-b030-4142-a22c-c732e5499c77	missing	update.profile.on.first.login
a128e02c-9af4-4fe5-a19c-4c9b69be5d23	false	require.password.update.after.registration
cdc75508-2192-4c28-9b35-efefb06737bd	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	f	master-realm	0	f	\N	\N	t	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
58e593b1-7b8c-461f-8828-f58e0d6500ea	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f8ed3904-5228-49f7-8476-61d6a9149c74	t	f	broker	0	f	\N	\N	t	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
fe7a2040-a077-45e8-a894-bead4084e1f0	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
76fa483f-5f7e-447d-824a-763c2894caf0	t	f	admin-cli	0	t	\N	\N	f	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
23d91c98-3b52-4354-bb31-f1912906ae6d	t	f	FastAPI-realm	0	f	\N	\N	t	\N	f	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	0	f	f	FastAPI Realm	f	client-secret	\N	\N	\N	t	f	f	f
8998ed8a-1120-4ef6-a6f0-3482614dc465	t	f	realm-management	0	f	\N	\N	t	\N	f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
114c3613-863e-4c19-aadc-75140b710ed4	t	f	account	0	t	\N	/realms/FastAPI/account/	f	\N	f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	t	f	account-console	0	t	\N	/realms/FastAPI/account/	f	\N	f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
62a6367c-bbd4-4d73-a992-d9c8512549e5	t	f	broker	0	f	\N	\N	t	\N	f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
eda12de4-b981-437c-87f4-9c7574510322	t	f	security-admin-console	0	t	\N	/admin/FastAPI/console/	f	\N	f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	t	f	admin-cli	0	t	\N	\N	f	\N	f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
96a8277d-be93-4071-b9fb-afc685907e23	t	t	jobtinder-app	0	t	\N		f		f	5cadf19d-2afe-4405-a6f0-974df43fe807	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	post.logout.redirect.uris	+
58e593b1-7b8c-461f-8828-f58e0d6500ea	post.logout.redirect.uris	+
58e593b1-7b8c-461f-8828-f58e0d6500ea	pkce.code.challenge.method	S256
fe7a2040-a077-45e8-a894-bead4084e1f0	post.logout.redirect.uris	+
fe7a2040-a077-45e8-a894-bead4084e1f0	pkce.code.challenge.method	S256
114c3613-863e-4c19-aadc-75140b710ed4	post.logout.redirect.uris	+
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	post.logout.redirect.uris	+
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	pkce.code.challenge.method	S256
eda12de4-b981-437c-87f4-9c7574510322	post.logout.redirect.uris	+
eda12de4-b981-437c-87f4-9c7574510322	pkce.code.challenge.method	S256
96a8277d-be93-4071-b9fb-afc685907e23	oauth2.device.authorization.grant.enabled	false
96a8277d-be93-4071-b9fb-afc685907e23	oidc.ciba.grant.enabled	false
96a8277d-be93-4071-b9fb-afc685907e23	backchannel.logout.session.required	true
96a8277d-be93-4071-b9fb-afc685907e23	backchannel.logout.revoke.offline.tokens	false
96a8277d-be93-4071-b9fb-afc685907e23	display.on.consent.screen	false
96a8277d-be93-4071-b9fb-afc685907e23	post.logout.redirect.uris	https://jobtinder.local/*
96a8277d-be93-4071-b9fb-afc685907e23	use.refresh.tokens	true
96a8277d-be93-4071-b9fb-afc685907e23	client_credentials.use_refresh_token	false
96a8277d-be93-4071-b9fb-afc685907e23	token.response.type.bearer.lower-case	false
96a8277d-be93-4071-b9fb-afc685907e23	access.token.lifespan	300
96a8277d-be93-4071-b9fb-afc685907e23	client.session.idle.timeout	604800
96a8277d-be93-4071-b9fb-afc685907e23	client.session.max.lifespan	604800
96a8277d-be93-4071-b9fb-afc685907e23	tls.client.certificate.bound.access.tokens	false
96a8277d-be93-4071-b9fb-afc685907e23	require.pushed.authorization.requests	false
96a8277d-be93-4071-b9fb-afc685907e23	acr.loa.map	{}
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	offline_access	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect built-in scope: offline_access	openid-connect
1d081146-8a46-4fed-b31a-fb26dc5b6d2e	role_list	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	SAML role list	saml
2dc12c7b-2f25-43c7-ac0e-fe3b28212956	profile	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect built-in scope: profile	openid-connect
9a44bcfe-c082-4ee5-93ff-a217882b1fcc	email	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect built-in scope: email	openid-connect
7bf3a969-475f-4cdf-a7e6-f87997f84ab9	address	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect built-in scope: address	openid-connect
341aa450-d2c4-4067-9c68-436485bf2252	phone	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect built-in scope: phone	openid-connect
8d90ff51-fc45-45b4-aa96-565d98ff7a28	roles	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect scope for add user roles to the access token	openid-connect
456e0cca-046f-4a70-94a6-c35fa9e1cb2e	web-origins	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a4304444-bbb4-4e22-9caf-344f269f1b86	microprofile-jwt	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	Microprofile - JWT built-in scope	openid-connect
bf808da7-ce0d-4901-b75f-dd7c12079e16	acr	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	offline_access	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect built-in scope: offline_access	openid-connect
bf6f51c9-d932-4877-9185-f70551c752d1	role_list	5cadf19d-2afe-4405-a6f0-974df43fe807	SAML role list	saml
f4415f95-608b-4b03-aea4-4bb9e1944b97	profile	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect built-in scope: profile	openid-connect
32a9a3f0-4671-47ce-818b-e776133189e6	email	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect built-in scope: email	openid-connect
472a06e8-4381-40b4-9d3e-5150c7cbcb38	address	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect built-in scope: address	openid-connect
aaa033e3-16be-4417-b104-5b513e3143c9	phone	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect built-in scope: phone	openid-connect
c039e19e-a444-4ccb-a833-146c93c68086	roles	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect scope for add user roles to the access token	openid-connect
dafb2502-22c4-4623-a13f-a40d4c99c2b6	web-origins	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect scope for add allowed web origins to the access token	openid-connect
31e8b74a-20ef-4e7d-a264-e6585e4ebf71	microprofile-jwt	5cadf19d-2afe-4405-a6f0-974df43fe807	Microprofile - JWT built-in scope	openid-connect
5d0cbb3c-8877-42f9-bb1e-c02912314987	acr	5cadf19d-2afe-4405-a6f0-974df43fe807	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	true	display.on.consent.screen
d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	${offlineAccessScopeConsentText}	consent.screen.text
1d081146-8a46-4fed-b31a-fb26dc5b6d2e	true	display.on.consent.screen
1d081146-8a46-4fed-b31a-fb26dc5b6d2e	${samlRoleListScopeConsentText}	consent.screen.text
2dc12c7b-2f25-43c7-ac0e-fe3b28212956	true	display.on.consent.screen
2dc12c7b-2f25-43c7-ac0e-fe3b28212956	${profileScopeConsentText}	consent.screen.text
2dc12c7b-2f25-43c7-ac0e-fe3b28212956	true	include.in.token.scope
9a44bcfe-c082-4ee5-93ff-a217882b1fcc	true	display.on.consent.screen
9a44bcfe-c082-4ee5-93ff-a217882b1fcc	${emailScopeConsentText}	consent.screen.text
9a44bcfe-c082-4ee5-93ff-a217882b1fcc	true	include.in.token.scope
7bf3a969-475f-4cdf-a7e6-f87997f84ab9	true	display.on.consent.screen
7bf3a969-475f-4cdf-a7e6-f87997f84ab9	${addressScopeConsentText}	consent.screen.text
7bf3a969-475f-4cdf-a7e6-f87997f84ab9	true	include.in.token.scope
341aa450-d2c4-4067-9c68-436485bf2252	true	display.on.consent.screen
341aa450-d2c4-4067-9c68-436485bf2252	${phoneScopeConsentText}	consent.screen.text
341aa450-d2c4-4067-9c68-436485bf2252	true	include.in.token.scope
8d90ff51-fc45-45b4-aa96-565d98ff7a28	true	display.on.consent.screen
8d90ff51-fc45-45b4-aa96-565d98ff7a28	${rolesScopeConsentText}	consent.screen.text
8d90ff51-fc45-45b4-aa96-565d98ff7a28	false	include.in.token.scope
456e0cca-046f-4a70-94a6-c35fa9e1cb2e	false	display.on.consent.screen
456e0cca-046f-4a70-94a6-c35fa9e1cb2e		consent.screen.text
456e0cca-046f-4a70-94a6-c35fa9e1cb2e	false	include.in.token.scope
a4304444-bbb4-4e22-9caf-344f269f1b86	false	display.on.consent.screen
a4304444-bbb4-4e22-9caf-344f269f1b86	true	include.in.token.scope
bf808da7-ce0d-4901-b75f-dd7c12079e16	false	display.on.consent.screen
bf808da7-ce0d-4901-b75f-dd7c12079e16	false	include.in.token.scope
eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	true	display.on.consent.screen
eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	${offlineAccessScopeConsentText}	consent.screen.text
bf6f51c9-d932-4877-9185-f70551c752d1	true	display.on.consent.screen
bf6f51c9-d932-4877-9185-f70551c752d1	${samlRoleListScopeConsentText}	consent.screen.text
f4415f95-608b-4b03-aea4-4bb9e1944b97	true	display.on.consent.screen
f4415f95-608b-4b03-aea4-4bb9e1944b97	${profileScopeConsentText}	consent.screen.text
f4415f95-608b-4b03-aea4-4bb9e1944b97	true	include.in.token.scope
32a9a3f0-4671-47ce-818b-e776133189e6	true	display.on.consent.screen
32a9a3f0-4671-47ce-818b-e776133189e6	${emailScopeConsentText}	consent.screen.text
32a9a3f0-4671-47ce-818b-e776133189e6	true	include.in.token.scope
472a06e8-4381-40b4-9d3e-5150c7cbcb38	true	display.on.consent.screen
472a06e8-4381-40b4-9d3e-5150c7cbcb38	${addressScopeConsentText}	consent.screen.text
472a06e8-4381-40b4-9d3e-5150c7cbcb38	true	include.in.token.scope
aaa033e3-16be-4417-b104-5b513e3143c9	true	display.on.consent.screen
aaa033e3-16be-4417-b104-5b513e3143c9	${phoneScopeConsentText}	consent.screen.text
aaa033e3-16be-4417-b104-5b513e3143c9	true	include.in.token.scope
c039e19e-a444-4ccb-a833-146c93c68086	true	display.on.consent.screen
c039e19e-a444-4ccb-a833-146c93c68086	${rolesScopeConsentText}	consent.screen.text
c039e19e-a444-4ccb-a833-146c93c68086	false	include.in.token.scope
dafb2502-22c4-4623-a13f-a40d4c99c2b6	false	display.on.consent.screen
dafb2502-22c4-4623-a13f-a40d4c99c2b6		consent.screen.text
dafb2502-22c4-4623-a13f-a40d4c99c2b6	false	include.in.token.scope
31e8b74a-20ef-4e7d-a264-e6585e4ebf71	false	display.on.consent.screen
31e8b74a-20ef-4e7d-a264-e6585e4ebf71	true	include.in.token.scope
5d0cbb3c-8877-42f9-bb1e-c02912314987	false	display.on.consent.screen
5d0cbb3c-8877-42f9-bb1e-c02912314987	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	341aa450-d2c4-4067-9c68-436485bf2252	f
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	a4304444-bbb4-4e22-9caf-344f269f1b86	f
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
58e593b1-7b8c-461f-8828-f58e0d6500ea	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
58e593b1-7b8c-461f-8828-f58e0d6500ea	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
58e593b1-7b8c-461f-8828-f58e0d6500ea	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
58e593b1-7b8c-461f-8828-f58e0d6500ea	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
58e593b1-7b8c-461f-8828-f58e0d6500ea	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
58e593b1-7b8c-461f-8828-f58e0d6500ea	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
58e593b1-7b8c-461f-8828-f58e0d6500ea	341aa450-d2c4-4067-9c68-436485bf2252	f
58e593b1-7b8c-461f-8828-f58e0d6500ea	a4304444-bbb4-4e22-9caf-344f269f1b86	f
58e593b1-7b8c-461f-8828-f58e0d6500ea	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
76fa483f-5f7e-447d-824a-763c2894caf0	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
76fa483f-5f7e-447d-824a-763c2894caf0	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
76fa483f-5f7e-447d-824a-763c2894caf0	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
76fa483f-5f7e-447d-824a-763c2894caf0	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
76fa483f-5f7e-447d-824a-763c2894caf0	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
76fa483f-5f7e-447d-824a-763c2894caf0	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
76fa483f-5f7e-447d-824a-763c2894caf0	341aa450-d2c4-4067-9c68-436485bf2252	f
76fa483f-5f7e-447d-824a-763c2894caf0	a4304444-bbb4-4e22-9caf-344f269f1b86	f
76fa483f-5f7e-447d-824a-763c2894caf0	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
f8ed3904-5228-49f7-8476-61d6a9149c74	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
f8ed3904-5228-49f7-8476-61d6a9149c74	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
f8ed3904-5228-49f7-8476-61d6a9149c74	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
f8ed3904-5228-49f7-8476-61d6a9149c74	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
f8ed3904-5228-49f7-8476-61d6a9149c74	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
f8ed3904-5228-49f7-8476-61d6a9149c74	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
f8ed3904-5228-49f7-8476-61d6a9149c74	341aa450-d2c4-4067-9c68-436485bf2252	f
f8ed3904-5228-49f7-8476-61d6a9149c74	a4304444-bbb4-4e22-9caf-344f269f1b86	f
f8ed3904-5228-49f7-8476-61d6a9149c74	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
368bcfa9-a02a-46c6-8c18-3b4660c7971d	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
368bcfa9-a02a-46c6-8c18-3b4660c7971d	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
368bcfa9-a02a-46c6-8c18-3b4660c7971d	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
368bcfa9-a02a-46c6-8c18-3b4660c7971d	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
368bcfa9-a02a-46c6-8c18-3b4660c7971d	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
368bcfa9-a02a-46c6-8c18-3b4660c7971d	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
368bcfa9-a02a-46c6-8c18-3b4660c7971d	341aa450-d2c4-4067-9c68-436485bf2252	f
368bcfa9-a02a-46c6-8c18-3b4660c7971d	a4304444-bbb4-4e22-9caf-344f269f1b86	f
368bcfa9-a02a-46c6-8c18-3b4660c7971d	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
fe7a2040-a077-45e8-a894-bead4084e1f0	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
fe7a2040-a077-45e8-a894-bead4084e1f0	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
fe7a2040-a077-45e8-a894-bead4084e1f0	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
fe7a2040-a077-45e8-a894-bead4084e1f0	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
fe7a2040-a077-45e8-a894-bead4084e1f0	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
fe7a2040-a077-45e8-a894-bead4084e1f0	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
fe7a2040-a077-45e8-a894-bead4084e1f0	341aa450-d2c4-4067-9c68-436485bf2252	f
fe7a2040-a077-45e8-a894-bead4084e1f0	a4304444-bbb4-4e22-9caf-344f269f1b86	f
fe7a2040-a077-45e8-a894-bead4084e1f0	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
114c3613-863e-4c19-aadc-75140b710ed4	32a9a3f0-4671-47ce-818b-e776133189e6	t
114c3613-863e-4c19-aadc-75140b710ed4	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
114c3613-863e-4c19-aadc-75140b710ed4	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
114c3613-863e-4c19-aadc-75140b710ed4	c039e19e-a444-4ccb-a833-146c93c68086	t
114c3613-863e-4c19-aadc-75140b710ed4	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
114c3613-863e-4c19-aadc-75140b710ed4	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
114c3613-863e-4c19-aadc-75140b710ed4	aaa033e3-16be-4417-b104-5b513e3143c9	f
114c3613-863e-4c19-aadc-75140b710ed4	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
114c3613-863e-4c19-aadc-75140b710ed4	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	32a9a3f0-4671-47ce-818b-e776133189e6	t
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	c039e19e-a444-4ccb-a833-146c93c68086	t
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	aaa033e3-16be-4417-b104-5b513e3143c9	f
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	32a9a3f0-4671-47ce-818b-e776133189e6	t
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	c039e19e-a444-4ccb-a833-146c93c68086	t
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	aaa033e3-16be-4417-b104-5b513e3143c9	f
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
aa0d012e-978c-4dec-b8fa-bec747d1c7a8	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
62a6367c-bbd4-4d73-a992-d9c8512549e5	32a9a3f0-4671-47ce-818b-e776133189e6	t
62a6367c-bbd4-4d73-a992-d9c8512549e5	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
62a6367c-bbd4-4d73-a992-d9c8512549e5	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
62a6367c-bbd4-4d73-a992-d9c8512549e5	c039e19e-a444-4ccb-a833-146c93c68086	t
62a6367c-bbd4-4d73-a992-d9c8512549e5	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
62a6367c-bbd4-4d73-a992-d9c8512549e5	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
62a6367c-bbd4-4d73-a992-d9c8512549e5	aaa033e3-16be-4417-b104-5b513e3143c9	f
62a6367c-bbd4-4d73-a992-d9c8512549e5	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
62a6367c-bbd4-4d73-a992-d9c8512549e5	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
8998ed8a-1120-4ef6-a6f0-3482614dc465	32a9a3f0-4671-47ce-818b-e776133189e6	t
8998ed8a-1120-4ef6-a6f0-3482614dc465	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
8998ed8a-1120-4ef6-a6f0-3482614dc465	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
8998ed8a-1120-4ef6-a6f0-3482614dc465	c039e19e-a444-4ccb-a833-146c93c68086	t
8998ed8a-1120-4ef6-a6f0-3482614dc465	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
8998ed8a-1120-4ef6-a6f0-3482614dc465	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
8998ed8a-1120-4ef6-a6f0-3482614dc465	aaa033e3-16be-4417-b104-5b513e3143c9	f
8998ed8a-1120-4ef6-a6f0-3482614dc465	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
8998ed8a-1120-4ef6-a6f0-3482614dc465	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
eda12de4-b981-437c-87f4-9c7574510322	32a9a3f0-4671-47ce-818b-e776133189e6	t
eda12de4-b981-437c-87f4-9c7574510322	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
eda12de4-b981-437c-87f4-9c7574510322	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
eda12de4-b981-437c-87f4-9c7574510322	c039e19e-a444-4ccb-a833-146c93c68086	t
eda12de4-b981-437c-87f4-9c7574510322	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
eda12de4-b981-437c-87f4-9c7574510322	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
eda12de4-b981-437c-87f4-9c7574510322	aaa033e3-16be-4417-b104-5b513e3143c9	f
eda12de4-b981-437c-87f4-9c7574510322	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
eda12de4-b981-437c-87f4-9c7574510322	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
96a8277d-be93-4071-b9fb-afc685907e23	32a9a3f0-4671-47ce-818b-e776133189e6	t
96a8277d-be93-4071-b9fb-afc685907e23	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
96a8277d-be93-4071-b9fb-afc685907e23	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
96a8277d-be93-4071-b9fb-afc685907e23	c039e19e-a444-4ccb-a833-146c93c68086	t
96a8277d-be93-4071-b9fb-afc685907e23	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
96a8277d-be93-4071-b9fb-afc685907e23	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
96a8277d-be93-4071-b9fb-afc685907e23	aaa033e3-16be-4417-b104-5b513e3143c9	f
96a8277d-be93-4071-b9fb-afc685907e23	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
96a8277d-be93-4071-b9fb-afc685907e23	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	5ab93f1d-3d21-4e10-bca0-e186fd68516b
eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	d03169c2-84ff-4ec9-b7c9-deccff8d1043
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
90317e0f-d6de-4e98-88d2-00d723f360d8	Trusted Hosts	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	anonymous
22ea868f-e1a6-4865-90f9-4441515852aa	Consent Required	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	anonymous
37f4920f-aad6-4f3f-97a6-e37a13b48763	Full Scope Disabled	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	anonymous
1accd86a-7979-4da1-9d8b-5688db63fa6a	Max Clients Limit	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	anonymous
f0e0e6ce-0ee2-4215-b052-1759a9123b0f	Allowed Protocol Mapper Types	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	anonymous
4616c7e0-c1fd-4679-8692-2a88e181da50	Allowed Client Scopes	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	anonymous
0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	Allowed Protocol Mapper Types	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	authenticated
50107c94-a3f1-4b24-82da-1b905dca948b	Allowed Client Scopes	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	authenticated
6aef2829-933c-4f52-bd8a-08e49da2ff60	rsa-generated	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	rsa-generated	org.keycloak.keys.KeyProvider	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N
07852e69-c6fa-4e57-a925-9ce337e0a6fa	rsa-enc-generated	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	rsa-enc-generated	org.keycloak.keys.KeyProvider	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N
4442e6bc-26cb-4cdd-b947-380bb8bef320	hmac-generated	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	hmac-generated	org.keycloak.keys.KeyProvider	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N
6b61e1ce-8b6d-4e39-9950-ed23041ff206	aes-generated	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	aes-generated	org.keycloak.keys.KeyProvider	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N
4a37dfb5-f25c-467a-be24-5c5c8e454898	rsa-generated	5cadf19d-2afe-4405-a6f0-974df43fe807	rsa-generated	org.keycloak.keys.KeyProvider	5cadf19d-2afe-4405-a6f0-974df43fe807	\N
1bebc813-68bf-4c01-9fd9-05a937566c1f	rsa-enc-generated	5cadf19d-2afe-4405-a6f0-974df43fe807	rsa-enc-generated	org.keycloak.keys.KeyProvider	5cadf19d-2afe-4405-a6f0-974df43fe807	\N
0bf480c8-528b-4d04-921a-39910adff63e	hmac-generated	5cadf19d-2afe-4405-a6f0-974df43fe807	hmac-generated	org.keycloak.keys.KeyProvider	5cadf19d-2afe-4405-a6f0-974df43fe807	\N
34837231-8159-4737-a18a-36a3e941b8c3	aes-generated	5cadf19d-2afe-4405-a6f0-974df43fe807	aes-generated	org.keycloak.keys.KeyProvider	5cadf19d-2afe-4405-a6f0-974df43fe807	\N
dd7e9d1b-7598-43bf-8c98-d96d107edc05	Trusted Hosts	5cadf19d-2afe-4405-a6f0-974df43fe807	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	anonymous
451db1db-61e2-49cc-972b-e3a04309123e	Consent Required	5cadf19d-2afe-4405-a6f0-974df43fe807	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	anonymous
02ccd958-1272-4da0-919f-268cb6e0ba92	Full Scope Disabled	5cadf19d-2afe-4405-a6f0-974df43fe807	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	anonymous
12bdb014-0034-42f8-82bf-58a3574589ed	Max Clients Limit	5cadf19d-2afe-4405-a6f0-974df43fe807	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	anonymous
8af968d2-d714-4059-a437-513cd30f848c	Allowed Protocol Mapper Types	5cadf19d-2afe-4405-a6f0-974df43fe807	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	anonymous
a68a81cb-0f42-4ddf-b0e0-31c661a1b3a2	Allowed Client Scopes	5cadf19d-2afe-4405-a6f0-974df43fe807	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	anonymous
638efbcc-25ae-4ef5-99a3-5b4cfc569661	Allowed Protocol Mapper Types	5cadf19d-2afe-4405-a6f0-974df43fe807	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	authenticated
55903cbc-49a2-4a56-9c1c-41ebdb13e51d	Allowed Client Scopes	5cadf19d-2afe-4405-a6f0-974df43fe807	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	authenticated
2fee0f29-b4f4-4e3d-aad0-eab334c56d99	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	5cadf19d-2afe-4405-a6f0-974df43fe807	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
c2856f88-f320-4793-a511-73189f636f2b	1accd86a-7979-4da1-9d8b-5688db63fa6a	max-clients	200
115a41bc-5694-4c74-a9d2-e5a51935394e	50107c94-a3f1-4b24-82da-1b905dca948b	allow-default-scopes	true
6cb8e1e4-7b15-40d7-b484-2561624d7d25	4616c7e0-c1fd-4679-8692-2a88e181da50	allow-default-scopes	true
a77a2047-f2e7-4a98-bed7-301f90e0e971	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	oidc-address-mapper
99de5cab-e5bf-44eb-83bc-3b1354efa90e	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9cfca960-e0e1-4677-afa4-ee0357eaa9a9	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9be68a15-578b-40f3-9b92-c2231513c2ec	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	saml-user-property-mapper
7bd0099d-c872-4cef-9ea1-e370ca96bed0	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
269e5376-39c0-40ab-a2fa-72d22d860812	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	saml-user-attribute-mapper
97a9f063-2204-4294-9e7a-a594054d32ed	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	saml-role-list-mapper
c1538205-506e-4539-975f-6254ec275a8e	0cfc56be-cb86-4ccf-bc7e-e5e7f2ca36e9	allowed-protocol-mapper-types	oidc-full-name-mapper
91c545c6-beb1-4f9a-b621-13f8ff89181a	90317e0f-d6de-4e98-88d2-00d723f360d8	host-sending-registration-request-must-match	true
70dcb8ba-f78a-48ec-8aee-4fe3aae4495d	90317e0f-d6de-4e98-88d2-00d723f360d8	client-uris-must-match	true
1d05ac48-532a-4e9a-807a-a6eb570f0eb1	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	oidc-full-name-mapper
e59c0d1a-4b8d-486c-9d2b-5dde74e0f4eb	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	oidc-address-mapper
98707b92-96a3-44ff-800e-60958d2edb0d	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d4220125-3cab-40d6-8509-41e68d420621	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	saml-user-property-mapper
2a0537f4-20d3-4962-a0d4-e53ae9852a31	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3cb9d96c-3840-447c-9f41-cee5d292f728	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cbecd7c1-49a2-45ce-8827-57bbc0de0e45	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	saml-role-list-mapper
c90eb70e-fb68-4ffe-9f45-26859f3c1011	f0e0e6ce-0ee2-4215-b052-1759a9123b0f	allowed-protocol-mapper-types	saml-user-attribute-mapper
75416321-a4bf-4624-a67d-0ac294e262d2	6aef2829-933c-4f52-bd8a-08e49da2ff60	keyUse	SIG
b615769a-5045-4e6e-8fe4-f1586bfac986	6aef2829-933c-4f52-bd8a-08e49da2ff60	priority	100
7df8d513-6d60-4826-ab8b-7cb6bc2a9d4b	6aef2829-933c-4f52-bd8a-08e49da2ff60	privateKey	MIIEowIBAAKCAQEAxGE/Ljf/jJ+3vEJ60aEnzDa7YxSHzPapgeb25yjMEk4VUd8DZJlnawFjDHQu9eNfDT7ElVtJZktGtJu+tpIKM7FdO9MCpdmHuu3o2EcUqtg8Cyw9wz/cMveH9WrV5gBS0bVFqPGXdKCorMbUn6CwqJR2bZiSTz90ObPUY9S5Hvfwk1CJQeWtgLrHvdzGguNE93yfU8GxRvwSnTMExmJrDpgPlUp/LEzXkRXWs3jjz0YOZbFVULGwRccUbk/Sx6YMdQV/yaRriaAIX2Q+SCtZFnoEvtDynaQ24kUh+tyDfYWD1dHpRts8FanXnwlRyirO1Ig0lCkD7Uf8YqWVBwiylQIDAQABAoIBAADNpV3u8zU+owMFYkNmGBz/p/u+BgHajB4gqn0Ov5T0llA9LAz24VjV9YiDwicV129Hr4itNKs93sEW4QHArljV89EZP3RxDnB/Os8FrWnh1A8MpDJer2vS846ssZ7M/LRoZtZL1LLbWbfz4UNHkOluSrS55XanBmFFC8xJFA/HxzAiRtN+Eja8fy+iv5rRtBN5VOORCi+6U/H0KJsEC7+I2L7ZKOlXM9m9WFau1ezg08C5TlFR1rrzcJpvRQ96T58rJl3fa0SUy08X7qBmwvmOo82dMBobp+IC5SLTBpZTBbZIWWSNsMqBIvRwP8ZGXXYHN9x/jFORmjZGV3xQwnkCgYEA8+5xOBtWcMQMMvr8EPprAG2djSyfKTZ964TKuCvwDjMAILsSn+r4u6ShXv3PNUMgwbmLnZ4dIKcdT2FDhPD/KRKnvHdx7aWnAt6WoTxPErPjNMch+XATpr8EjlzmwhkJ8pwIUf1JpL26DpQNenn05RZCBYI5DXGbGwQinfgUG9kCgYEAzhiII3R78RVyu8li07U3Wml99V0Tpc85yjLOvPV/ZmjpZDOsheO3Zef4kho9wFPh2hyxamNAZnC+aHab8haYeCI005zi3BwYUhWKo1UtpDh2emsUOmMxPPqkJW6JYErVdHImNeXwHkeIiG8iyikBPxKI0OH1ip+2UhaaHLUeAx0CgYAr3jPKTVBMU1WGTZDLVN2tZAkzfFTbSot2sZjraitvwkhBmqMM02sMA91pgeejwoC/lii/ndHLL4Kb5fgIjna04j/8Ktb4UBQq9fDM6lWmHWe89BruCvPdxviAycBOI8agNONiK1T1JZGyUXnjDs+16zzQVM0B1+52+1VmZ1jmcQKBgBjj95UonUtphrjNQqVE7pF5yh+XBSdyVo1oA3XoxGEu7HkQkJZ/AQhKsseaabjPqKg57OdnY0C7/xMIuB7Nwc5Ie07PVMq2je1j8qF1SRTbSNvSENhYYHr33lky915sy0jL/Hdn9M8DXqbznSUDPMZMS7/Gemwqi89wMV6kNSK1AoGBANts5bq/lz63q7Xgg35CadOBGYtOFlExu9Ko+wGtGTjOiHM3Get3inMlUaIhsMLIIfskASdh45TlsoPf2EBVSG8DxT3vkIUCoQErk6eIaXqdp/fL3+OZQFr5OdgfVcbWaZmjVYAzVl4O2bCEF6nRxtpliG5Mf2Qs6M+6L21CnaIu
b9a815a4-cee2-41dd-a415-65abb72408a3	6aef2829-933c-4f52-bd8a-08e49da2ff60	certificate	MIICmzCCAYMCBgGY7MrU3jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODI3MTgyNzUyWhcNMzUwODI3MTgyOTMyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDEYT8uN/+Mn7e8QnrRoSfMNrtjFIfM9qmB5vbnKMwSThVR3wNkmWdrAWMMdC71418NPsSVW0lmS0a0m762kgozsV070wKl2Ye67ejYRxSq2DwLLD3DP9wy94f1atXmAFLRtUWo8Zd0oKisxtSfoLColHZtmJJPP3Q5s9Rj1Lke9/CTUIlB5a2Ause93MaC40T3fJ9TwbFG/BKdMwTGYmsOmA+VSn8sTNeRFdazeOPPRg5lsVVQsbBFxxRuT9LHpgx1BX/JpGuJoAhfZD5IK1kWegS+0PKdpDbiRSH63IN9hYPV0elG2zwVqdefCVHKKs7UiDSUKQPtR/xipZUHCLKVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGk9i7m6/4LxFvGD/qN5isrLxoaO90E/eJMz8vXJW6tElXcubsmPrMdnoRKSbluRNQwIpUvRKdwzn1WV6t1BiSwGBfLa0JCqqW+991IyzCoERKMu4LBbSa6hn0RKfRK0SiQbNhXDaMlsRUYYZ3WSzrkERLNBrBXEpUb0peC7xvk9un+oVKV3h2VnloF0rWUocdPBh1/HK2w+fAYOLNQFBlq0aZclRvXQlf+JeKSuk9vGms2mb/GhBEFhoD5uxfNCayL2EqCWPqvr25FeFRZZv4TrvqT5a05dKW3jEJrQUi4b/rgUqASeVJZzK0zx2S5rnBwqO7bHxhuN1641hJr+ees=
799cc567-380b-4172-b721-22566015f9fe	4442e6bc-26cb-4cdd-b947-380bb8bef320	secret	_zGR7TdOPY_avgRv8-lJMPR9wwN0Xu_cPfAnk6jF4vDJstSDvl3nJEwhyDkcoZmMDrO2uAFcZ8aF4fv5OohzIw
f349ae2d-775c-4896-8b97-e8f3dbac2805	4442e6bc-26cb-4cdd-b947-380bb8bef320	priority	100
842f8b50-5fd0-4dc3-a9c7-fc42f3fc055f	4442e6bc-26cb-4cdd-b947-380bb8bef320	kid	4cd7c08c-68a9-4387-876c-c2c6824b1aa8
e46cec69-f8dc-40a7-a9e4-258e669df07b	4442e6bc-26cb-4cdd-b947-380bb8bef320	algorithm	HS256
834ac208-c3db-4e24-94a2-91a871b0dd67	07852e69-c6fa-4e57-a925-9ce337e0a6fa	privateKey	MIIEpAIBAAKCAQEAzBSq7q0sBKbOy5J3rnfaufv1D3JseH7LrnklrwAlBIK8ujEzPNbQMZjYSdikzSm6SJPROH5qGqlnwyJBglu22I3dMqKYj5jLNUW3p8LbQqGhKC7nGezUvvtIPYysouuZgb/sRBSwwpHnxL5rY9PtfcFJanmawJxB7KuSnIZYmn3RMhd5q2kGtqzWNHZKX80jz0D4f/vJhGyKUJGsnwbU4r/+WNv2HeEot0K0b9HlVmNihlpHt7XJQ0iqahiUVKr1CgafFO435q4auLiBWvuB0qCw8nWVBAk3+MObQR5MSGUo4ziUaaoBByahvr3NhDDw02AlMCY/erqK2O27HlDUWwIDAQABAoIBAEMPoZG3nwjSRY74jNJseRf3dvJB/+nihIzLK3pjmkZurZSjeTpLPnOlzaEKizENvrR9ulkNlVE4jKu/FHbBK4biqyap7mb1ZwUU6UI70jAFi774FqHaxJgTW4w6LzqEH9fWmM1QXTs6lcX9aq2NpPNXcggGeLdFQZaDVLSRowj0q6KFDBUwf8XmjqKpnYIGEjfhhQg9KXcJGdy0j8ZmBimLWDCemP92lZ4Z0iFQ7ikpKrx5qZuWY5H84gaq74W0zRegfiaLlfeDRualIPUXrVOgm5loll9BJG5oz9vlr4Arn7e22VX+9/GOd/NFmROY8cZ7pTOqJuNS9rSRVmmtI4UCgYEA89Q+ZV23wgH3vTp7vt5fuKg2uIKyt6p2Z81h8FAxMYnIXkHVm8BEZ2kPpnA87BUkDcWKBNmcl/Ode701PL2KesKIrAaZyFCP8lqpBtOz1yBjFvNjlfV0cHD3EBw6yA/ZBKXPcPzYR6YXPrSomo7s03WNVruJSE5B3ynXi2bsY8UCgYEA1kSAgWWVxfzpxqLac/kREyOenfMqv6XmaLivtwrV2Grz6GOkLIoKUeCQKmC2dekUumBd4VEn9fWKE23O7GHx6U7WXT7GHtKUdKZDjMjnB5ADBJuc0cMYqVFyeEtR6+RlOUVBbBIMvVZbSZqB8Ly90aOV1wpal4W/Q2hhVR6oOZ8CgYEAvYhLJEJQN8eNypLuY/S5lXF0b8Jwp6IivheBPOspAifnD5W/NH2k7nlVR/xQ7vaT+vyFh7WcKuWckfYGrvtq7HfRA19yJKqy6iGc6Aih7+RmAg4ZaBTPeSPmeKho7OCcwicdc+enOzKZOQ33TYUyBEGJJ1VJpmHmhFEjEmJj+D0CgYEAg+oQo5mDKC2ZT62biKLinEHluaCnxO3CeN6bb7nABklyeLQ/sxwZVmdG2pBIRTeGh2gk5D8utwLAS03jgyyZ3uWmnCm1l+xVcaubEuXtNn63HPMhDRNr73IxY1YbzXsDxsqYiIxkQ30THrF9JlVNF+/6pDW/qGGzazCsG9eQAkkCgYBrDXKdCCa8wqMbBTXaBQE+ga2lUKRZj+DNRJ0Rt+VYspHW5c14jO6//uWrRw6QnzwCICl2KXe+NkiieqzfVL7r4rVecLrGdggyljTd0DRlEslq5kJ+snCgSTAy7jMo790HAs5lQRpT0no2LMrUOkpxkocw/+/Ngsng3gKVAQ2uiw==
0577c499-cf08-4f5b-bdee-b95a192534d5	07852e69-c6fa-4e57-a925-9ce337e0a6fa	keyUse	ENC
a392df1a-2833-4efc-acce-eae79da5c2ca	07852e69-c6fa-4e57-a925-9ce337e0a6fa	algorithm	RSA-OAEP
b94b94cd-7bf9-4b23-8bfb-4251cfa1ae5d	07852e69-c6fa-4e57-a925-9ce337e0a6fa	priority	100
8e2901dc-535c-4ea8-9e05-6d90aec5f318	07852e69-c6fa-4e57-a925-9ce337e0a6fa	certificate	MIICmzCCAYMCBgGY7MrVFDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwODI3MTgyNzUyWhcNMzUwODI3MTgyOTMyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMFKrurSwEps7Lkneud9q5+/UPcmx4fsuueSWvACUEgry6MTM81tAxmNhJ2KTNKbpIk9E4fmoaqWfDIkGCW7bYjd0yopiPmMs1RbenwttCoaEoLucZ7NS++0g9jKyi65mBv+xEFLDCkefEvmtj0+19wUlqeZrAnEHsq5KchliafdEyF3mraQa2rNY0dkpfzSPPQPh/+8mEbIpQkayfBtTiv/5Y2/Yd4Si3QrRv0eVWY2KGWke3tclDSKpqGJRUqvUKBp8U7jfmrhq4uIFa+4HSoLDydZUECTf4w5tBHkxIZSjjOJRpqgEHJqG+vc2EMPDTYCUwJj96uorY7bseUNRbAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALMMu+5G+vyhuALwKsVvfT281X0k/Ku+VRwzOtPXCJa6TWrzL4sAgVweKYSATDVTG+DDM/uDU0PSMIdV936CE4ejt6OmRll1XRwtyZNIsdh4pWqDBv1RwUlxf8Nkyq+vZeZJVzVdpNxjAOlb4KO/VWlR3qQKrbTqhWKMlgDwWoGJFKXL3+At1nN0BkpXba2eGY40C2xz/ctqqHn39ZU+Zj/mJ/4MFKOBWx3zh31ZKI2fbV3dlceu6Fr8ZeG8Q459B1RGqi+6RtF4ngoRlO1wagrbsit/vkJZoBCW/SfUO0QpN4mGUbypdcNkoOufmglCILzs58lJF3H2Gul5RX6FIZ8=
6b63a498-4e79-4c9c-b07e-58193c4e22d2	6b61e1ce-8b6d-4e39-9950-ed23041ff206	kid	583bb269-c879-4fcd-a6fd-2276d55f5815
17f20bd2-b92b-4b6d-b3ad-56ff8653e19b	6b61e1ce-8b6d-4e39-9950-ed23041ff206	secret	718Vgz4QqX4B32E1fRuzyw
623fae28-f88a-4399-ab37-93f6a15a6d89	6b61e1ce-8b6d-4e39-9950-ed23041ff206	priority	100
10fad3ed-1c7a-4168-882e-bddee27111f6	34837231-8159-4737-a18a-36a3e941b8c3	kid	7a38abf3-778b-4685-a9d8-97288e1e855d
baadf6cb-e675-4b07-8518-76fe6c473cf1	34837231-8159-4737-a18a-36a3e941b8c3	secret	6zQTUmdMqwZmKua0ThMGiw
9126fcb6-6804-48ab-bbb9-013f473bc600	34837231-8159-4737-a18a-36a3e941b8c3	priority	100
b0b1f142-b4f9-4cda-8bc2-c8006d0e3033	4a37dfb5-f25c-467a-be24-5c5c8e454898	privateKey	MIIEowIBAAKCAQEA8OMqN+X5/NsfXTxqF3uygcA3cOY4fURPEAn7uJJaskNXpnlgQzZlnS0O2cidg9i4qdxnfG8dMp3X2r7mK8ZlwOUCc4rsU/xGD1Hjrodnw9H5sPOm8Ur1SBfHWSNTBzx7bdBxOMMiBiviO5NviL6iLIg92+JcoSIQEM94l1ncjCt3zRFe4f2OMSD6igvyA6pZOVgwK86VscOWB7W309B1hKo2S2o+6VgyK0QjD3vQYQyeFNTXy0UQipXzq4V39pf1r3wx6TIthIQCjRnmXmQjW/PRaywxZuMtFuv3I2UvNd46qQNaPAjylB3/90upzrHShDVMqBLCbPh9zqNObhs13QIDAQABAoIBAB14FPagrlwGLIiZ9vqnedeQvdeUeo2smSWDqyVR1kGfpm3pxGKEmZrIY9w1xDtYfILfQVPCPiauk7UhjIQHcfROr+WVtcKyhpmiMYHs879LhUnmDOLRAj/PFOatQR+OASWWjftdN+DcZoFWUJtAgxOCmVq4jw9xXNjJoN2XMzl8bReR17oUM5AyB506UGBnt25R6WFCL/PnfXzCiLCGoPBihrWsTBOyHPJ2x5rMB9mtxTK95eeYJ8oDdpXaUGj5i2GCRWHO8KUkmHJsiJkpizukgFxSWUJYbRGtb0HXTP6GbTx2neFAWeqcnLRjUVqmb3gBFF1+U0te1uSzzU9mcDsCgYEA/FJLVy/Ax6kS4lHDIQv+i0GoGPb0HfRlrD9hVHphkyLpLFoh4hS3KhGwF7oTUKHq5BVAKNV0RRd6YCBT/Jl2Z99ZV1ECLeb/j54ud9pXt1MQb2KezUiiUHz57vAr8tcMGiMo0B+1TchRXXTaRNHRAXWmQYQRyu0u2l3AxZ2K6HMCgYEA9GYyV/idHsYTj4zzFJrAW1pjlGIYpRwKpJDh2zKACCu2oGgwufBrDJVpgtiCU2envcgdc5owqzHdydCc1rDWYQd/iN3hd7/2W15CvnZxFc0nxvhjk3LMaknAs7hWqirz6rEwBYJJzcurtGgJNvIPgrvwHYezGI58uesfjXQ+5G8CgYAYfYBUiQ0EFBQCJX90AK8HIytGqQmOsr7/lfNDeNFpr5TEOkdZozsX+TmHRAdF50FeO/XLQNSVNC8rj1e3h8mnUVVhlTpJ7EbX0Lmf5nBnGcfZl8/kCu2+NDMqDuOlIVxKWSlH8hvt3ciP8pyQ23CW3K1zZHc5pAXNKhZg1+a4owKBgQCflDs7BbJR7bPH/5iY05LWE2cB9CtzY6PvYEqY/ZhrvV85zc5DGqBLTyPds9Ek9IGqgYf5e6xbm+vdYsGFzWGtaV/01ivqLQWHEz0xb9TXD2XxnS4nkMW4gP+6WZr88Z7il19ruW7HWT18RpH9toA6NMzL+1cNqbv3CXdIvaZzMQKBgCPlFCMyyn855ShY1+lQWkXHbgevyZ/JQGoRnUyMGo/n8oqVGfYwzESZ0+3xFe/7nrP4cWukAc+945ARQsF0xzROTfti4XPwiBepSQWrpwn3G9V8umE09/bQdeDbYy/KWXKpEth6K1NqlquXxq0MRP8zvy0NrR0HSepjR1gwmZFA
e5c29e13-5285-4978-a065-fcc1c9c97dd6	4a37dfb5-f25c-467a-be24-5c5c8e454898	priority	100
66610058-8cc0-4e83-8c50-0cfbebe14247	4a37dfb5-f25c-467a-be24-5c5c8e454898	keyUse	SIG
fb2d4411-4929-43af-8c54-4a711712165f	4a37dfb5-f25c-467a-be24-5c5c8e454898	certificate	MIICnTCCAYUCBgGY7MtN3zANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdGYXN0QVBJMB4XDTI1MDgyNzE4MjgyM1oXDTM1MDgyNzE4MzAwM1owEjEQMA4GA1UEAwwHRmFzdEFQSTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAPDjKjfl+fzbH108ahd7soHAN3DmOH1ETxAJ+7iSWrJDV6Z5YEM2ZZ0tDtnInYPYuKncZ3xvHTKd19q+5ivGZcDlAnOK7FP8Rg9R466HZ8PR+bDzpvFK9UgXx1kjUwc8e23QcTjDIgYr4juTb4i+oiyIPdviXKEiEBDPeJdZ3Iwrd80RXuH9jjEg+ooL8gOqWTlYMCvOlbHDlge1t9PQdYSqNktqPulYMitEIw970GEMnhTU18tFEIqV86uFd/aX9a98MekyLYSEAo0Z5l5kI1vz0WssMWbjLRbr9yNlLzXeOqkDWjwI8pQd//dLqc6x0oQ1TKgSwmz4fc6jTm4bNd0CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAG4dOjeAVeI163d5rk8j7qkqQSmjOe4Z/pJOb621tVdqIdJyjwh8l/teJOe2QVb3l9ZRU+V+B+3kXhY+UbX9wluIRcCGsFBiKz8RaKBnovBEXVKrV72u5aru5XhNxMLPQM5tFrsLYmfsqaghoKESHJ7Fzc2Bb3xtUQBLJ/+1qz/Xtw058P3YLhEvNYXjPXL+Opt1kjHLlGaDLObDwCCxwiS8M/qxRcwPIG/alHBd9BVrbfjyeB7BOro5vq4nF8cHPBdst+EXm+2QCCPfKS+G1so/rBvrtDKK4PFJlKJjNhuD1v/fvDCyCZJiGjeoC8D+7V2IqPYkTDzEj/8Eg+IPUOQ==
e336114c-1d69-4aa4-bdfc-21de982fe4af	1bebc813-68bf-4c01-9fd9-05a937566c1f	priority	100
e465379e-3c0c-4ef6-b0ec-884985b433e7	1bebc813-68bf-4c01-9fd9-05a937566c1f	keyUse	ENC
cb299b44-40ce-4ebd-be15-7a88c0a8db13	1bebc813-68bf-4c01-9fd9-05a937566c1f	privateKey	MIIEowIBAAKCAQEA3bLA6IH/Pt5y3sOU2bgh1JvNxiV7BSD0bt01Xbbz9HMOA3im8bhw3/iidcYeRKrjyb78MQHGzeXgro/DYulqCLofqUpNROF3KDnB/eU+4WK1zn6uqcTdJ2lKDdRSWTmmN2k6u1P74qRn5fZaixqvfAMUJWylO03d+Fjn7QA4kveLiQqZD9IfWjLTus6Pd6hDe9ZKdeukDemiXVKEaD8BHkjMfmI/kj8ia9QS1pjytxA9vzni1RVU7Ic7ACliPfUelZR/1RgIVBhWzT6dbkS8jo4YDZCWzwezIYfsqHldk8naQzft4uV80XtoJUPdfNnDPiCPxIJhYPRA4nPxoremtQIDAQABAoIBAAHm1XfJHFmQ3+xgQh0cqBGiT9a6HemH2auVHdmSxwSa82JSknVdWdPaAU7AUc8l+3PmEv9lSVbHzjBrzvHAwyZAWSLYc9GPm42OnUbib10l6HL/1tthncIHnwPVBUB7BEgnu2y9m4SwrgF6JlcDdhY6vTKq/BSGUPf0j0doVT6ReUZjJyeeY+Wp93axlr+pErz4ICL2BhbLM30Buov1lw+tIo2R3Ef4RoZS4SHLAZvKDoFZGVJqcxwkDrtvg4vf4wsVsegB6yFGybw8Q3nCNDjUUVkIgF5GEDrCZcU/q0a648B/+YF6LKVKOTwdBUcXrazbol4U8+PBbDCHN39bhoECgYEA93JA/2lGi67KHqFewtBtMIFEUuJTup0g/7YHkfM4HMp1Dy8ZpXlzUyTZtrjaS+Gn9noo9LDOoFRoosbFblssWpLi+ZLkE+/rNPNSkT3+soS4grKjkMayWOgRlhD0/y5x46hLnLSiaRami0TL2Pprb6uyIR4s1JzGe6N77wAC58ECgYEA5VylOfkGS3eOv+EsWnd/MyPEsaLZ/sZW0D+rsPLNM3FC+cg6BZFyQQBclylLQeh1RkApSqc58WwZVvS+WqAGgddmUJVQWnWrfr0BgZdCexwIDM8KcMUetIvnfKAe9Y1q3qwMazw4jB5Q3fAQKhpSC/wXMzM0ZVtf9pnvkvUem/UCgYEAkL6ExuMOISddlA1RISRKutTi4pkB4WeIpgwU4Yskh7LmRruGhQVGMJydvgTjrP+TANr0mi3SsHavvogHdUZf65uAqf0C7aaqL48l/VAGbOa2B733b/jK2rblkqLYrWy9si4ADOqdFlvpkA3uMD5MGkaVLEo6byRF9ozrMiMPkAECgYB3QcC3cAAR5UxYAKCrOU7uLD7tjhuDGWWySijfjJ+di9qjPbTNiF675ZA/GL2Eu3We3WWa53B9UxOp3v/K50H66SDN7ZUmM+DDuUq7MwbiNCULY+utzxC0F7p5VlhCnRFgTlz2tQ1B7dFmVJhTC/R1PtJhUNKBkQ1Ij6m9463SsQKBgF36zyjgZCiB7m+HtYI2kHV+TD6GlNF33qDrDCfXL1Rhf/ObmIt2kG4h5ZlDvghF5k0pXBx5g81MQEBrlEWqZsrvt7moWq1RXAgQKoyE1YPP6VEBpSIv5AF3p9AZlN9jq61u/UiDsCtLy/qUqUsKGCjqRJG/DXoflr6gI74teQWB
87c5369a-c51a-4ce3-8066-526d402915ed	1bebc813-68bf-4c01-9fd9-05a937566c1f	certificate	MIICnTCCAYUCBgGY7MtOKzANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdGYXN0QVBJMB4XDTI1MDgyNzE4MjgyM1oXDTM1MDgyNzE4MzAwM1owEjEQMA4GA1UEAwwHRmFzdEFQSTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAN2ywOiB/z7ect7DlNm4IdSbzcYlewUg9G7dNV228/RzDgN4pvG4cN/4onXGHkSq48m+/DEBxs3l4K6Pw2Lpagi6H6lKTUThdyg5wf3lPuFitc5+rqnE3SdpSg3UUlk5pjdpOrtT++KkZ+X2Wosar3wDFCVspTtN3fhY5+0AOJL3i4kKmQ/SH1oy07rOj3eoQ3vWSnXrpA3pol1ShGg/AR5IzH5iP5I/ImvUEtaY8rcQPb854tUVVOyHOwApYj31HpWUf9UYCFQYVs0+nW5EvI6OGA2Qls8HsyGH7Kh5XZPJ2kM37eLlfNF7aCVD3XzZwz4gj8SCYWD0QOJz8aK3prUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAYk+1KOd9PmGVtEGcozUIg7XBuInLntJu+zfZsdt5Q3CXW0Sv49H3ZYwd1cpsvjx3uOWXqmXkakEl3nConJlc6Xc3tJgcrUBgjfvPpPrJnVZTS6DIP+V+2dt11/TfYj1hGWn1FSNAlJBUcVbHJn06YE72o0o2o9Nt2yvv4COM0jmqlIDVzir5YvIfWP/TMReLFU50/cO9hHznlTjM0Mh9uhsDD15+Ju4Yf0sdlKhRvaLSss8fLqK/ZD7mxLUVawfVIUT3orT5drF9AiCsRwByhsOOUYQTeB2zlBRkoufNSIv3dohxh03ryfpBnB1A7XgXFvcsu/BHSAk8lJnBN9sElQ==
548371b3-c565-4ccf-b002-144dffe31a81	1bebc813-68bf-4c01-9fd9-05a937566c1f	algorithm	RSA-OAEP
37fb51b5-2d58-4abf-ae08-353bb3761cc7	0bf480c8-528b-4d04-921a-39910adff63e	kid	82330914-0f8c-4f91-8392-fa35b71f7afc
7730b7c9-dfba-4b09-b091-502ea034aabd	0bf480c8-528b-4d04-921a-39910adff63e	priority	100
54c1e18b-617a-456f-8017-284abb1ab411	0bf480c8-528b-4d04-921a-39910adff63e	secret	qgRkxhDv2D8hzTKs8yt4pt9VgPhTDgkrgk1O5YFtnKOovpQ1xVTdBcyIqIzVwfEI4wtHRPzOU_N1SJEIoAGPjg
7ce751e2-0928-4617-985d-2a3cfc91c5a3	0bf480c8-528b-4d04-921a-39910adff63e	algorithm	HS256
aa0bbda1-9ccd-4035-8258-a026d73d6273	55903cbc-49a2-4a56-9c1c-41ebdb13e51d	allow-default-scopes	true
e933051f-b901-477a-8c8a-c32b224c7799	a68a81cb-0f42-4ddf-b0e0-31c661a1b3a2	allow-default-scopes	true
e33295ef-d8ef-4d81-b49f-18aa9dde660e	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	saml-user-attribute-mapper
854aa516-4ee7-4a2f-bed2-246d2faeba41	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	oidc-full-name-mapper
9f317406-2324-42db-81b4-c4a0228c0f4b	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	oidc-address-mapper
85c1f095-9672-46f5-9c7c-449c61163eb6	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	saml-user-property-mapper
2d5a6db2-82b5-4ae4-9d65-abef7b846546	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dbf31fca-39c8-41c2-889c-0868d660529c	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
700522ee-a546-4b01-b4b5-983a7c799f5d	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	saml-role-list-mapper
a761aa83-6e65-4e5f-8c92-173e663b4304	638efbcc-25ae-4ef5-99a3-5b4cfc569661	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
aed34f10-1091-4615-966a-aac0b3fe07cd	dd7e9d1b-7598-43bf-8c98-d96d107edc05	client-uris-must-match	true
b90b31c7-5a43-49bd-b088-caafc7d0e5e8	dd7e9d1b-7598-43bf-8c98-d96d107edc05	host-sending-registration-request-must-match	true
d3e756ac-2d25-48f1-9374-530dcb6570e8	12bdb014-0034-42f8-82bf-58a3574589ed	max-clients	200
e236c5cc-0bac-459c-ab83-f74698de39e3	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	saml-user-attribute-mapper
7c9492a0-1b53-42a0-ad37-431236cd4ea5	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	oidc-address-mapper
dfd5270b-7723-4615-a22a-1cb4fb645546	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
214aa645-746a-461b-8898-d7bf2a8beba6	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	oidc-full-name-mapper
26dd5a8f-dfca-49aa-8545-f88b9f92747c	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f7ecfc1f-19c6-46ea-9345-2c1404b8d0ac	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	saml-user-property-mapper
02109cf5-3690-4f4d-8aa4-01be2f48f8dc	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
de2a36b7-d708-446b-a647-44a72a758f95	8af968d2-d714-4059-a437-513cd30f848c	allowed-protocol-mapper-types	saml-role-list-mapper
e87a1864-9c96-461b-856a-71d8ca24f0df	2fee0f29-b4f4-4e3d-aad0-eab334c56d99	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]}},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]}},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]}},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]}},{"name":"accountType","displayName":"${role}","required":{"roles":["admin","user"]},"permissions":{"edit":["admin","user"],"view":["user","admin"]},"annotations":{"inputType":"select"},"validations":{"options":{"options":["seeker","employer"]}}}],"groups":[]}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
7bb9899f-bebe-4b43-ad34-9794f69212a4	75b26363-5351-4177-9fe6-b297841687e3
7bb9899f-bebe-4b43-ad34-9794f69212a4	94cc9f90-c24b-4d31-a35d-e7bcdbfb2351
7bb9899f-bebe-4b43-ad34-9794f69212a4	1205c1a2-9565-49f4-a8ed-264c4b9af8c9
7bb9899f-bebe-4b43-ad34-9794f69212a4	5e96d846-9135-44b3-bdee-47c4afedcb77
7bb9899f-bebe-4b43-ad34-9794f69212a4	4349d0b6-6e60-4737-a51b-be6d0463b581
7bb9899f-bebe-4b43-ad34-9794f69212a4	57f443a3-41c9-4651-8500-816c8ee56c14
7bb9899f-bebe-4b43-ad34-9794f69212a4	0ca589ea-f207-460f-bdda-9b65539668b9
7bb9899f-bebe-4b43-ad34-9794f69212a4	a07f1fbb-9216-4ad0-b9b7-b10fd9e80598
7bb9899f-bebe-4b43-ad34-9794f69212a4	199d18e4-4873-42c8-aa16-b90d5400751c
7bb9899f-bebe-4b43-ad34-9794f69212a4	856ba527-7c5e-40f7-9a83-7620d9bbe618
7bb9899f-bebe-4b43-ad34-9794f69212a4	7a036b2e-a3ce-484c-b606-c472be6e5f57
7bb9899f-bebe-4b43-ad34-9794f69212a4	d18e0740-de0d-4dcc-ac72-f7890d508784
7bb9899f-bebe-4b43-ad34-9794f69212a4	912b5870-2ede-4767-94d3-b7ed6a04a364
7bb9899f-bebe-4b43-ad34-9794f69212a4	5222c460-4b99-4d53-8346-b722d6f41a16
7bb9899f-bebe-4b43-ad34-9794f69212a4	b3c82476-c7b0-400f-a85d-49963a8f9484
7bb9899f-bebe-4b43-ad34-9794f69212a4	65072a30-4b06-4cf3-bdd2-1dd1d68c61c0
7bb9899f-bebe-4b43-ad34-9794f69212a4	27da41cd-fbe6-49c1-adb1-79c9e26c77ea
7bb9899f-bebe-4b43-ad34-9794f69212a4	d8419a34-7fc5-46d5-8664-29ac7efb5854
4349d0b6-6e60-4737-a51b-be6d0463b581	65072a30-4b06-4cf3-bdd2-1dd1d68c61c0
5e96d846-9135-44b3-bdee-47c4afedcb77	d8419a34-7fc5-46d5-8664-29ac7efb5854
5e96d846-9135-44b3-bdee-47c4afedcb77	b3c82476-c7b0-400f-a85d-49963a8f9484
70d202d0-7d22-4010-a5cb-5201954f28f8	d883d142-471b-4347-9651-02ad21dd63aa
70d202d0-7d22-4010-a5cb-5201954f28f8	7b98f83b-4c08-497a-8da9-e3807802f167
7b98f83b-4c08-497a-8da9-e3807802f167	8f9dc931-647b-4998-9201-c6e945c3033b
aaec6c0b-cf46-4e65-a318-80b756bbd6e3	d8151883-32d1-4ae1-856d-9ad6919d0fa2
7bb9899f-bebe-4b43-ad34-9794f69212a4	a1d4918c-ce57-4efb-bf00-01a6544746fe
70d202d0-7d22-4010-a5cb-5201954f28f8	5ab93f1d-3d21-4e10-bca0-e186fd68516b
70d202d0-7d22-4010-a5cb-5201954f28f8	48cf831e-92eb-44b1-8141-7fa993bb8b00
7bb9899f-bebe-4b43-ad34-9794f69212a4	4c70a9a0-99b3-439f-8986-996760430831
7bb9899f-bebe-4b43-ad34-9794f69212a4	791a801d-6db8-4df2-85de-4b62ca9ae3db
7bb9899f-bebe-4b43-ad34-9794f69212a4	04692ade-aff9-441a-bc8b-c4076844b844
7bb9899f-bebe-4b43-ad34-9794f69212a4	65ed96cd-175a-4a61-add1-7f59ed53b5f4
7bb9899f-bebe-4b43-ad34-9794f69212a4	910846c7-109b-4942-a78f-3d1ca2916a37
7bb9899f-bebe-4b43-ad34-9794f69212a4	1e600c30-49d8-44b2-89e5-cf7c6882265f
7bb9899f-bebe-4b43-ad34-9794f69212a4	64debf19-437e-492a-83a8-716b59c308d0
7bb9899f-bebe-4b43-ad34-9794f69212a4	1c69bf54-1e06-4cda-a0b9-372c66762294
7bb9899f-bebe-4b43-ad34-9794f69212a4	ae073094-9c1c-4c87-9cdf-9cb1015b8dff
7bb9899f-bebe-4b43-ad34-9794f69212a4	7aafad26-592d-4e5e-81ae-16f0a9e2a309
7bb9899f-bebe-4b43-ad34-9794f69212a4	4d203cc1-50f8-490f-b091-717c1ec72af4
7bb9899f-bebe-4b43-ad34-9794f69212a4	a2f4617f-3630-4dfd-bbb6-d8e5f696b372
7bb9899f-bebe-4b43-ad34-9794f69212a4	41106e77-d0b4-4e43-8db1-31cee87f266c
7bb9899f-bebe-4b43-ad34-9794f69212a4	77f0e85c-e7a6-41c4-886b-1c069c785979
7bb9899f-bebe-4b43-ad34-9794f69212a4	c48c1a18-5e70-4277-b343-23ba41aac153
7bb9899f-bebe-4b43-ad34-9794f69212a4	5149f4af-e5fd-4a31-802e-840bb41537d3
7bb9899f-bebe-4b43-ad34-9794f69212a4	8358d9b9-6371-4824-90b9-c7d563816118
04692ade-aff9-441a-bc8b-c4076844b844	8358d9b9-6371-4824-90b9-c7d563816118
04692ade-aff9-441a-bc8b-c4076844b844	77f0e85c-e7a6-41c4-886b-1c069c785979
65ed96cd-175a-4a61-add1-7f59ed53b5f4	c48c1a18-5e70-4277-b343-23ba41aac153
5239c412-edd3-4421-bb5b-0b9386302ba1	4edaad91-fddf-489a-a4b8-2fad24044757
5239c412-edd3-4421-bb5b-0b9386302ba1	cd9f30b4-06a9-4e11-b7d5-a3e286bd494c
5239c412-edd3-4421-bb5b-0b9386302ba1	5c34e05c-49d1-490c-b38d-8f1af6142783
5239c412-edd3-4421-bb5b-0b9386302ba1	e4bc5a30-f69c-4fb1-8540-fa6b5e549f33
5239c412-edd3-4421-bb5b-0b9386302ba1	eb28e9dd-f9dc-4111-aa98-b082a0ae96ac
5239c412-edd3-4421-bb5b-0b9386302ba1	46402ee1-ecea-4822-8bd0-fee77b6c0df8
5239c412-edd3-4421-bb5b-0b9386302ba1	83ea8ac9-1c4c-4ea5-aa92-40122ecc0349
5239c412-edd3-4421-bb5b-0b9386302ba1	83a2457d-ee52-4dd9-a991-1ee05822dc66
5239c412-edd3-4421-bb5b-0b9386302ba1	f53fdf2f-c932-4158-972e-9064f6b33372
5239c412-edd3-4421-bb5b-0b9386302ba1	41e849f4-cd88-4d15-9d33-0adfd5d7b288
5239c412-edd3-4421-bb5b-0b9386302ba1	d6b0c627-7196-4a7f-bd0b-601a5e0fc4be
5239c412-edd3-4421-bb5b-0b9386302ba1	65390d83-08b5-41ac-b3bf-9956b24dbca5
5239c412-edd3-4421-bb5b-0b9386302ba1	bf5d3e11-51a5-46eb-9258-caa6356811a6
5239c412-edd3-4421-bb5b-0b9386302ba1	8dce1f5c-15c3-4710-a2db-7172d5e49414
5239c412-edd3-4421-bb5b-0b9386302ba1	79f34507-44c7-4915-a0b5-c099968a0632
5239c412-edd3-4421-bb5b-0b9386302ba1	05e90f07-5e73-45f7-b2d1-e4b02555a705
5239c412-edd3-4421-bb5b-0b9386302ba1	ecf953c4-11ee-48b0-9742-cf46059c7f16
5c34e05c-49d1-490c-b38d-8f1af6142783	8dce1f5c-15c3-4710-a2db-7172d5e49414
5c34e05c-49d1-490c-b38d-8f1af6142783	ecf953c4-11ee-48b0-9742-cf46059c7f16
6558cec1-c2ff-47ec-a1c3-4548c02996e3	8fa00363-93c2-4e9c-a2c5-51ffc0e07aef
e4bc5a30-f69c-4fb1-8540-fa6b5e549f33	79f34507-44c7-4915-a0b5-c099968a0632
6558cec1-c2ff-47ec-a1c3-4548c02996e3	ddcc02db-9816-405f-b98c-f2a4881b8750
ddcc02db-9816-405f-b98c-f2a4881b8750	70c76273-7230-41a2-b99a-f78691f7531d
1f1b31d8-14f9-442a-a99b-6e201c37eedc	11a536a0-6bfb-4c9f-b5c8-80ccf70ba715
7bb9899f-bebe-4b43-ad34-9794f69212a4	d6ee37f8-aa88-4e50-b92b-e0755a307185
5239c412-edd3-4421-bb5b-0b9386302ba1	7641cf51-cd6e-4cda-a5e1-a04c4739c71e
6558cec1-c2ff-47ec-a1c3-4548c02996e3	d03169c2-84ff-4ec9-b7c9-deccff8d1043
6558cec1-c2ff-47ec-a1c3-4548c02996e3	bf562775-7962-46a1-b959-70eb8f7a4570
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
93c3c521-49f0-4f4d-951a-e31f16e22a66	\N	password	e4595cfa-7dab-4fca-834b-1cbf8dda3b75	1756319372802	\N	{"value":"1jDi6Z/jO2q5NBlQllBEH9pQki8CGhVWNdpNTRrUUTE=","salt":"LJ3a8pyWNfp9/eziqisSFA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
272c5974-9900-41c0-a325-477ecdb4d966	\N	password	d0c56433-37ec-4812-8e45-76fb7f0e696f	1756319678985	My password	{"value":"iRC9pUUxvQafS+iGP9OejpZnKLtc6pG5GuYxJDpluuI=","salt":"mtvzmYpT2mouNDyy5BoaRQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
94cf2bc5-59e3-41a2-b1f0-46ed91c52c19	\N	password	238e2985-b3ec-4b41-a98b-275492f9bac4	1756396370692	My password	{"value":"OVc6RGmhwo2n6XQlWmBUxL5FsXHiq7zRqZXchxekik0=","salt":"cMSTPjYvBzBjTlDu8KnDmg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-08-27 18:29:30.610162	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	6319370267
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-08-27 18:29:30.628316	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	6319370267
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-08-27 18:29:30.656413	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	6319370267
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-08-27 18:29:30.659609	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	6319370267
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-08-27 18:29:30.720662	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	6319370267
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-08-27 18:29:30.728527	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	6319370267
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-08-27 18:29:30.788081	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	6319370267
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-08-27 18:29:30.797115	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	6319370267
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-08-27 18:29:30.800949	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	6319370267
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-08-27 18:29:30.863638	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	6319370267
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-08-27 18:29:30.896704	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	6319370267
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-08-27 18:29:30.901313	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	6319370267
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-08-27 18:29:30.910427	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	6319370267
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-27 18:29:30.924299	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	6319370267
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-27 18:29:30.925663	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	6319370267
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-27 18:29:30.928293	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	6319370267
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-08-27 18:29:30.92994	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	6319370267
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-08-27 18:29:30.957477	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	6319370267
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-08-27 18:29:30.986675	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	6319370267
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-08-27 18:29:30.989649	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	6319370267
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-27 18:29:30.994132	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	6319370267
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-08-27 18:29:30.996193	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	6319370267
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-08-27 18:29:31.006433	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	6319370267
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-08-27 18:29:31.01066	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	6319370267
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-08-27 18:29:31.011723	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	6319370267
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-08-27 18:29:31.042633	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	6319370267
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-08-27 18:29:31.104494	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	6319370267
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-08-27 18:29:31.106994	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	6319370267
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-08-27 18:29:31.15544	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	6319370267
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-08-27 18:29:31.165475	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	6319370267
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-08-27 18:29:31.177313	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	6319370267
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-08-27 18:29:31.180096	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	6319370267
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-27 18:29:31.183493	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	6319370267
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-27 18:29:31.185477	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	6319370267
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-27 18:29:31.20705	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	6319370267
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-08-27 18:29:31.210727	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	6319370267
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-08-27 18:29:31.216368	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	6319370267
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-08-27 18:29:31.21896	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	6319370267
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-08-27 18:29:31.221532	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	6319370267
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-27 18:29:31.223011	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	6319370267
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-27 18:29:31.224502	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	6319370267
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-08-27 18:29:31.227501	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	6319370267
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-08-27 18:29:31.337355	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	6319370267
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-08-27 18:29:31.340576	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	6319370267
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-27 18:29:31.343276	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	6319370267
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-27 18:29:31.345801	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	6319370267
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-27 18:29:31.347021	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	6319370267
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-27 18:29:31.371515	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	6319370267
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-08-27 18:29:31.374493	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	6319370267
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-08-27 18:29:31.407073	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	6319370267
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-08-27 18:29:31.441072	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	6319370267
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-08-27 18:29:31.443755	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	6319370267
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-08-27 18:29:31.445526	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	6319370267
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-08-27 18:29:31.447078	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	6319370267
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-27 18:29:31.452724	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	6319370267
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-27 18:29:31.456017	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	6319370267
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-27 18:29:31.470868	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	6319370267
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-08-27 18:29:31.531365	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	6319370267
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-08-27 18:29:31.553693	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	6319370267
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-08-27 18:29:31.557642	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	6319370267
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-27 18:29:31.563137	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	6319370267
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-08-27 18:29:31.568088	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	6319370267
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-08-27 18:29:31.570683	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	6319370267
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-08-27 18:29:31.572358	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	6319370267
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-27 18:29:31.574202	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	6319370267
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-08-27 18:29:31.584643	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	6319370267
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-08-27 18:29:31.590538	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	6319370267
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-08-27 18:29:31.593888	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	6319370267
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-08-27 18:29:31.600784	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	6319370267
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-08-27 18:29:31.603905	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	6319370267
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-08-27 18:29:31.606589	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	6319370267
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-27 18:29:31.609813	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	6319370267
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-27 18:29:31.614799	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	6319370267
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-27 18:29:31.616277	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	6319370267
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-27 18:29:31.624383	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	6319370267
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-08-27 18:29:31.630283	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	6319370267
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-27 18:29:31.633004	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	6319370267
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-27 18:29:31.634442	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	6319370267
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-27 18:29:31.645433	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	6319370267
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-08-27 18:29:31.647776	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	6319370267
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-27 18:29:31.652706	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	6319370267
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-27 18:29:31.654224	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	6319370267
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-27 18:29:31.656875	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	6319370267
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-27 18:29:31.658102	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	6319370267
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-08-27 18:29:31.66239	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	6319370267
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-08-27 18:29:31.665363	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	6319370267
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-27 18:29:31.669973	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	6319370267
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-08-27 18:29:31.677701	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	6319370267
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.680957	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	6319370267
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.684407	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	6319370267
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.689065	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	6319370267
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.693254	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	6319370267
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.694968	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	6319370267
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.703452	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	6319370267
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.705251	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	6319370267
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-08-27 18:29:31.70899	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	6319370267
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.717353	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	6319370267
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.718695	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	6319370267
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.722599	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	6319370267
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.727833	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	6319370267
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.72921	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	6319370267
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.7334	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	6319370267
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-08-27 18:29:31.735726	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	6319370267
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-08-27 18:29:31.739441	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	6319370267
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-08-27 18:29:31.744064	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	6319370267
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-08-27 18:29:31.748053	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	6319370267
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-08-27 18:29:31.750317	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	6319370267
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-27 18:29:31.755686	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	6319370267
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-27 18:29:31.756942	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	6319370267
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-08-27 18:29:31.760399	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	6319370267
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-08-27 18:29:31.762597	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	6319370267
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-27 18:29:31.789402	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	6319370267
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-08-27 18:29:31.791528	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	6319370267
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-27 18:29:31.794115	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	6319370267
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-08-27 18:29:31.795486	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	6319370267
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-27 18:29:31.799238	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	6319370267
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-08-27 18:29:31.801693	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	6319370267
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	d8b193a9-f2c2-4a27-a35c-332cc29f7bdf	f
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	1d081146-8a46-4fed-b31a-fb26dc5b6d2e	t
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	2dc12c7b-2f25-43c7-ac0e-fe3b28212956	t
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	9a44bcfe-c082-4ee5-93ff-a217882b1fcc	t
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	7bf3a969-475f-4cdf-a7e6-f87997f84ab9	f
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	341aa450-d2c4-4067-9c68-436485bf2252	f
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	8d90ff51-fc45-45b4-aa96-565d98ff7a28	t
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	456e0cca-046f-4a70-94a6-c35fa9e1cb2e	t
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	a4304444-bbb4-4e22-9caf-344f269f1b86	f
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	bf808da7-ce0d-4901-b75f-dd7c12079e16	t
5cadf19d-2afe-4405-a6f0-974df43fe807	eadd0c03-38d5-4d18-8e59-9fedb39fa3e7	f
5cadf19d-2afe-4405-a6f0-974df43fe807	bf6f51c9-d932-4877-9185-f70551c752d1	t
5cadf19d-2afe-4405-a6f0-974df43fe807	f4415f95-608b-4b03-aea4-4bb9e1944b97	t
5cadf19d-2afe-4405-a6f0-974df43fe807	32a9a3f0-4671-47ce-818b-e776133189e6	t
5cadf19d-2afe-4405-a6f0-974df43fe807	472a06e8-4381-40b4-9d3e-5150c7cbcb38	f
5cadf19d-2afe-4405-a6f0-974df43fe807	aaa033e3-16be-4417-b104-5b513e3143c9	f
5cadf19d-2afe-4405-a6f0-974df43fe807	c039e19e-a444-4ccb-a833-146c93c68086	t
5cadf19d-2afe-4405-a6f0-974df43fe807	dafb2502-22c4-4623-a13f-a40d4c99c2b6	t
5cadf19d-2afe-4405-a6f0-974df43fe807	31e8b74a-20ef-4e7d-a264-e6585e4ebf71	f
5cadf19d-2afe-4405-a6f0-974df43fe807	5d0cbb3c-8877-42f9-bb1e-c02912314987	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
70d202d0-7d22-4010-a5cb-5201954f28f8	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	${role_default-roles}	default-roles-master	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	\N
75b26363-5351-4177-9fe6-b297841687e3	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	${role_create-realm}	create-realm	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	\N
7bb9899f-bebe-4b43-ad34-9794f69212a4	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	${role_admin}	admin	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	\N
94cc9f90-c24b-4d31-a35d-e7bcdbfb2351	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_create-client}	create-client	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
1205c1a2-9565-49f4-a8ed-264c4b9af8c9	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_view-realm}	view-realm	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
5e96d846-9135-44b3-bdee-47c4afedcb77	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_view-users}	view-users	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
4349d0b6-6e60-4737-a51b-be6d0463b581	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_view-clients}	view-clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
57f443a3-41c9-4651-8500-816c8ee56c14	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_view-events}	view-events	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
0ca589ea-f207-460f-bdda-9b65539668b9	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_view-identity-providers}	view-identity-providers	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
a07f1fbb-9216-4ad0-b9b7-b10fd9e80598	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_view-authorization}	view-authorization	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
199d18e4-4873-42c8-aa16-b90d5400751c	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_manage-realm}	manage-realm	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
856ba527-7c5e-40f7-9a83-7620d9bbe618	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_manage-users}	manage-users	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
7a036b2e-a3ce-484c-b606-c472be6e5f57	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_manage-clients}	manage-clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
d18e0740-de0d-4dcc-ac72-f7890d508784	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_manage-events}	manage-events	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
912b5870-2ede-4767-94d3-b7ed6a04a364	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_manage-identity-providers}	manage-identity-providers	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
5222c460-4b99-4d53-8346-b722d6f41a16	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_manage-authorization}	manage-authorization	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
b3c82476-c7b0-400f-a85d-49963a8f9484	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_query-users}	query-users	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
65072a30-4b06-4cf3-bdd2-1dd1d68c61c0	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_query-clients}	query-clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
27da41cd-fbe6-49c1-adb1-79c9e26c77ea	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_query-realms}	query-realms	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
d8419a34-7fc5-46d5-8664-29ac7efb5854	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_query-groups}	query-groups	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
d883d142-471b-4347-9651-02ad21dd63aa	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_view-profile}	view-profile	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
7b98f83b-4c08-497a-8da9-e3807802f167	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_manage-account}	manage-account	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
8f9dc931-647b-4998-9201-c6e945c3033b	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_manage-account-links}	manage-account-links	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
d3bbb6f3-a5b3-4072-83f1-dc29da32a573	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_view-applications}	view-applications	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
d8151883-32d1-4ae1-856d-9ad6919d0fa2	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_view-consent}	view-consent	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
aaec6c0b-cf46-4e65-a318-80b756bbd6e3	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_manage-consent}	manage-consent	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
c047215a-7395-4d92-8132-dd753c2c0292	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_view-groups}	view-groups	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
f50737c9-2aa0-400a-84ea-476f1b0aa13a	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	t	${role_delete-account}	delete-account	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	\N
e051fd28-acaf-41b2-96f0-489b69f5a84f	f8ed3904-5228-49f7-8476-61d6a9149c74	t	${role_read-token}	read-token	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f8ed3904-5228-49f7-8476-61d6a9149c74	\N
a1d4918c-ce57-4efb-bf00-01a6544746fe	368bcfa9-a02a-46c6-8c18-3b4660c7971d	t	${role_impersonation}	impersonation	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	368bcfa9-a02a-46c6-8c18-3b4660c7971d	\N
5ab93f1d-3d21-4e10-bca0-e186fd68516b	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	${role_offline-access}	offline_access	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	\N
48cf831e-92eb-44b1-8141-7fa993bb8b00	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	${role_uma_authorization}	uma_authorization	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	\N	\N
6558cec1-c2ff-47ec-a1c3-4548c02996e3	5cadf19d-2afe-4405-a6f0-974df43fe807	f	${role_default-roles}	default-roles-fastapi	5cadf19d-2afe-4405-a6f0-974df43fe807	\N	\N
4c70a9a0-99b3-439f-8986-996760430831	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_create-client}	create-client	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
791a801d-6db8-4df2-85de-4b62ca9ae3db	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_view-realm}	view-realm	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
04692ade-aff9-441a-bc8b-c4076844b844	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_view-users}	view-users	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
65ed96cd-175a-4a61-add1-7f59ed53b5f4	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_view-clients}	view-clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
910846c7-109b-4942-a78f-3d1ca2916a37	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_view-events}	view-events	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
1e600c30-49d8-44b2-89e5-cf7c6882265f	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_view-identity-providers}	view-identity-providers	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
64debf19-437e-492a-83a8-716b59c308d0	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_view-authorization}	view-authorization	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
1c69bf54-1e06-4cda-a0b9-372c66762294	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_manage-realm}	manage-realm	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
ae073094-9c1c-4c87-9cdf-9cb1015b8dff	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_manage-users}	manage-users	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
7aafad26-592d-4e5e-81ae-16f0a9e2a309	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_manage-clients}	manage-clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
4d203cc1-50f8-490f-b091-717c1ec72af4	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_manage-events}	manage-events	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
a2f4617f-3630-4dfd-bbb6-d8e5f696b372	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_manage-identity-providers}	manage-identity-providers	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
41106e77-d0b4-4e43-8db1-31cee87f266c	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_manage-authorization}	manage-authorization	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
77f0e85c-e7a6-41c4-886b-1c069c785979	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_query-users}	query-users	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
c48c1a18-5e70-4277-b343-23ba41aac153	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_query-clients}	query-clients	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
5149f4af-e5fd-4a31-802e-840bb41537d3	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_query-realms}	query-realms	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
8358d9b9-6371-4824-90b9-c7d563816118	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_query-groups}	query-groups	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
5239c412-edd3-4421-bb5b-0b9386302ba1	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_realm-admin}	realm-admin	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
4edaad91-fddf-489a-a4b8-2fad24044757	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_create-client}	create-client	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
cd9f30b4-06a9-4e11-b7d5-a3e286bd494c	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_view-realm}	view-realm	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
5c34e05c-49d1-490c-b38d-8f1af6142783	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_view-users}	view-users	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
e4bc5a30-f69c-4fb1-8540-fa6b5e549f33	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_view-clients}	view-clients	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
eb28e9dd-f9dc-4111-aa98-b082a0ae96ac	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_view-events}	view-events	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
46402ee1-ecea-4822-8bd0-fee77b6c0df8	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_view-identity-providers}	view-identity-providers	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
83ea8ac9-1c4c-4ea5-aa92-40122ecc0349	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_view-authorization}	view-authorization	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
83a2457d-ee52-4dd9-a991-1ee05822dc66	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_manage-realm}	manage-realm	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
f53fdf2f-c932-4158-972e-9064f6b33372	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_manage-users}	manage-users	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
41e849f4-cd88-4d15-9d33-0adfd5d7b288	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_manage-clients}	manage-clients	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
d6b0c627-7196-4a7f-bd0b-601a5e0fc4be	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_manage-events}	manage-events	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
65390d83-08b5-41ac-b3bf-9956b24dbca5	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_manage-identity-providers}	manage-identity-providers	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
bf5d3e11-51a5-46eb-9258-caa6356811a6	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_manage-authorization}	manage-authorization	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
8dce1f5c-15c3-4710-a2db-7172d5e49414	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_query-users}	query-users	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
79f34507-44c7-4915-a0b5-c099968a0632	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_query-clients}	query-clients	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
05e90f07-5e73-45f7-b2d1-e4b02555a705	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_query-realms}	query-realms	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
ecf953c4-11ee-48b0-9742-cf46059c7f16	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_query-groups}	query-groups	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
8fa00363-93c2-4e9c-a2c5-51ffc0e07aef	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_view-profile}	view-profile	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
ddcc02db-9816-405f-b98c-f2a4881b8750	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_manage-account}	manage-account	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
70c76273-7230-41a2-b99a-f78691f7531d	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_manage-account-links}	manage-account-links	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
e218e5a9-ef6f-4266-a431-3c665d77d7f7	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_view-applications}	view-applications	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
11a536a0-6bfb-4c9f-b5c8-80ccf70ba715	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_view-consent}	view-consent	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
1f1b31d8-14f9-442a-a99b-6e201c37eedc	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_manage-consent}	manage-consent	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
16e0fc58-0f9a-41d8-b22b-79edc4032c97	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_view-groups}	view-groups	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
ebdc73ab-cf0f-479a-9592-c7b8aa0926e4	114c3613-863e-4c19-aadc-75140b710ed4	t	${role_delete-account}	delete-account	5cadf19d-2afe-4405-a6f0-974df43fe807	114c3613-863e-4c19-aadc-75140b710ed4	\N
d6ee37f8-aa88-4e50-b92b-e0755a307185	23d91c98-3b52-4354-bb31-f1912906ae6d	t	${role_impersonation}	impersonation	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	23d91c98-3b52-4354-bb31-f1912906ae6d	\N
7641cf51-cd6e-4cda-a5e1-a04c4739c71e	8998ed8a-1120-4ef6-a6f0-3482614dc465	t	${role_impersonation}	impersonation	5cadf19d-2afe-4405-a6f0-974df43fe807	8998ed8a-1120-4ef6-a6f0-3482614dc465	\N
b05068c7-384b-46ac-bbce-3a9452dac23a	62a6367c-bbd4-4d73-a992-d9c8512549e5	t	${role_read-token}	read-token	5cadf19d-2afe-4405-a6f0-974df43fe807	62a6367c-bbd4-4d73-a992-d9c8512549e5	\N
d03169c2-84ff-4ec9-b7c9-deccff8d1043	5cadf19d-2afe-4405-a6f0-974df43fe807	f	${role_offline-access}	offline_access	5cadf19d-2afe-4405-a6f0-974df43fe807	\N	\N
bf562775-7962-46a1-b959-70eb8f7a4570	5cadf19d-2afe-4405-a6f0-974df43fe807	f	${role_uma_authorization}	uma_authorization	5cadf19d-2afe-4405-a6f0-974df43fe807	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
eshno	23.0.7	1756319371
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
b5e5fb76-bfd6-411c-99c8-f1b9bdd0d7dc	audience resolve	openid-connect	oidc-audience-resolve-mapper	58e593b1-7b8c-461f-8828-f58e0d6500ea	\N
c1210b20-3ae4-4e44-88c8-1d5acac9f667	locale	openid-connect	oidc-usermodel-attribute-mapper	fe7a2040-a077-45e8-a894-bead4084e1f0	\N
da0e3131-7bae-4cf4-bd89-89ff2ba9590f	role list	saml	saml-role-list-mapper	\N	1d081146-8a46-4fed-b31a-fb26dc5b6d2e
d19fddf5-1cf5-47cd-955b-ca19e13d51b7	full name	openid-connect	oidc-full-name-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
a89071dd-bfc1-4358-a8e5-d48700647d6a	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
d3c94780-4296-47f9-bedf-357063953e5c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
a74b0828-c1f9-4888-a053-5a4f0196a88f	username	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
2af90282-cebd-4804-b7a1-ce1c79a625cd	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
75e1f935-6be2-458f-8b05-468ec2615c3e	website	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
ea065578-58af-412b-8419-dea8a834483c	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
948745ae-da76-4c34-92ba-da166d5d4963	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
9296a424-293d-43d4-a781-73cfc34fc13a	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	2dc12c7b-2f25-43c7-ac0e-fe3b28212956
a337c0d8-b0bf-4adb-9222-342266b1f8f1	email	openid-connect	oidc-usermodel-attribute-mapper	\N	9a44bcfe-c082-4ee5-93ff-a217882b1fcc
390eb42a-27be-482b-bfe9-1e94a145a909	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9a44bcfe-c082-4ee5-93ff-a217882b1fcc
1ab16178-842a-429a-b041-42003b15ccd3	address	openid-connect	oidc-address-mapper	\N	7bf3a969-475f-4cdf-a7e6-f87997f84ab9
37d1e086-c4d6-4320-b156-dd38f39f9ddb	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	341aa450-d2c4-4067-9c68-436485bf2252
eb799828-0859-4327-84ff-36f4350f3799	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	341aa450-d2c4-4067-9c68-436485bf2252
77114f57-f6ca-439f-a74d-a6d324b520d6	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	8d90ff51-fc45-45b4-aa96-565d98ff7a28
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	8d90ff51-fc45-45b4-aa96-565d98ff7a28
de4025eb-e192-429c-a9b0-c08b06866fbd	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	8d90ff51-fc45-45b4-aa96-565d98ff7a28
3735b140-8fa8-4fe1-b3ea-58c39b3df256	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	456e0cca-046f-4a70-94a6-c35fa9e1cb2e
6b5f3856-d146-4438-927e-d05a06da11bb	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	a4304444-bbb4-4e22-9caf-344f269f1b86
96e715bd-c4ce-4169-8457-5890c41e2c4e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a4304444-bbb4-4e22-9caf-344f269f1b86
b2f71be2-9b88-488b-8965-98159c5f27ea	acr loa level	openid-connect	oidc-acr-mapper	\N	bf808da7-ce0d-4901-b75f-dd7c12079e16
f9cc2738-d162-466f-8706-b876edcc3934	audience resolve	openid-connect	oidc-audience-resolve-mapper	a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	\N
06bb3419-2f01-403b-8f6e-6b09eb874bb7	role list	saml	saml-role-list-mapper	\N	bf6f51c9-d932-4877-9185-f70551c752d1
6d46295f-e669-4b4a-b6a8-059be80bbbdb	full name	openid-connect	oidc-full-name-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
6af66197-1d84-49d9-b5c5-ea7676a24754	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
a85230c1-a966-4da9-949d-2df718fa2dcc	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
5acd6214-5564-485c-b71c-7a584723e732	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
06bef3f7-7714-416d-b593-f5123661f068	username	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
966f344c-b907-4426-b38d-b1385c9c401b	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
f20df5ba-bbfe-41b4-9c61-da2b124092b2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
93b1a44b-517b-4e17-93b5-c22213034815	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
478d2900-3c31-4ce2-850e-84001468eb9f	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
e56877aa-c93c-4d53-a299-5738468eebfc	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
913bc9d7-7114-4913-bd3d-6064e8d50798	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f4415f95-608b-4b03-aea4-4bb9e1944b97
73ebd788-5f32-4156-b5e2-2a6800c1642a	email	openid-connect	oidc-usermodel-attribute-mapper	\N	32a9a3f0-4671-47ce-818b-e776133189e6
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	email verified	openid-connect	oidc-usermodel-property-mapper	\N	32a9a3f0-4671-47ce-818b-e776133189e6
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	address	openid-connect	oidc-address-mapper	\N	472a06e8-4381-40b4-9d3e-5150c7cbcb38
aea5e0c3-842f-46cc-8928-3df7dc35a09b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	aaa033e3-16be-4417-b104-5b513e3143c9
c06fc5b6-6501-411d-8d35-96b3b51c1d04	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	aaa033e3-16be-4417-b104-5b513e3143c9
eb97a12f-adc0-4071-9290-75a1e41c4d3b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	c039e19e-a444-4ccb-a833-146c93c68086
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	c039e19e-a444-4ccb-a833-146c93c68086
89580944-558c-4d13-8cd7-90fa5944ecd8	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	c039e19e-a444-4ccb-a833-146c93c68086
10786386-8dda-4dca-a03c-17cee7fc5f3c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	dafb2502-22c4-4623-a13f-a40d4c99c2b6
80935f89-e58c-4a90-b43b-972584a17639	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	31e8b74a-20ef-4e7d-a264-e6585e4ebf71
6a53d421-0435-4b79-8f9c-c3cdd04217fa	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	31e8b74a-20ef-4e7d-a264-e6585e4ebf71
309921c7-a01f-4675-89b7-ce78efac9fc9	acr loa level	openid-connect	oidc-acr-mapper	\N	5d0cbb3c-8877-42f9-bb1e-c02912314987
775cd405-80df-4004-991f-1028e3c4e799	locale	openid-connect	oidc-usermodel-attribute-mapper	eda12de4-b981-437c-87f4-9c7574510322	\N
af46e072-af49-40a4-8198-ff210fb1dad4	role_mapper	openid-connect	oidc-usermodel-attribute-mapper	96a8277d-be93-4071-b9fb-afc685907e23	\N
e7e5bb67-c120-4b8d-80d8-64e4aa57d276	audience_fix	openid-connect	oidc-audience-mapper	96a8277d-be93-4071-b9fb-afc685907e23	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
c1210b20-3ae4-4e44-88c8-1d5acac9f667	true	introspection.token.claim
c1210b20-3ae4-4e44-88c8-1d5acac9f667	true	userinfo.token.claim
c1210b20-3ae4-4e44-88c8-1d5acac9f667	locale	user.attribute
c1210b20-3ae4-4e44-88c8-1d5acac9f667	true	id.token.claim
c1210b20-3ae4-4e44-88c8-1d5acac9f667	true	access.token.claim
c1210b20-3ae4-4e44-88c8-1d5acac9f667	locale	claim.name
c1210b20-3ae4-4e44-88c8-1d5acac9f667	String	jsonType.label
da0e3131-7bae-4cf4-bd89-89ff2ba9590f	false	single
da0e3131-7bae-4cf4-bd89-89ff2ba9590f	Basic	attribute.nameformat
da0e3131-7bae-4cf4-bd89-89ff2ba9590f	Role	attribute.name
2af90282-cebd-4804-b7a1-ce1c79a625cd	true	introspection.token.claim
2af90282-cebd-4804-b7a1-ce1c79a625cd	true	userinfo.token.claim
2af90282-cebd-4804-b7a1-ce1c79a625cd	picture	user.attribute
2af90282-cebd-4804-b7a1-ce1c79a625cd	true	id.token.claim
2af90282-cebd-4804-b7a1-ce1c79a625cd	true	access.token.claim
2af90282-cebd-4804-b7a1-ce1c79a625cd	picture	claim.name
2af90282-cebd-4804-b7a1-ce1c79a625cd	String	jsonType.label
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	true	introspection.token.claim
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	true	userinfo.token.claim
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	firstName	user.attribute
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	true	id.token.claim
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	true	access.token.claim
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	given_name	claim.name
3d9a4a9e-9a86-4e7d-b2e7-6e0cfcb5da85	String	jsonType.label
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	true	introspection.token.claim
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	true	userinfo.token.claim
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	zoneinfo	user.attribute
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	true	id.token.claim
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	true	access.token.claim
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	zoneinfo	claim.name
7337e9c5-3f11-485b-a8f9-9dbc52681e3a	String	jsonType.label
75e1f935-6be2-458f-8b05-468ec2615c3e	true	introspection.token.claim
75e1f935-6be2-458f-8b05-468ec2615c3e	true	userinfo.token.claim
75e1f935-6be2-458f-8b05-468ec2615c3e	website	user.attribute
75e1f935-6be2-458f-8b05-468ec2615c3e	true	id.token.claim
75e1f935-6be2-458f-8b05-468ec2615c3e	true	access.token.claim
75e1f935-6be2-458f-8b05-468ec2615c3e	website	claim.name
75e1f935-6be2-458f-8b05-468ec2615c3e	String	jsonType.label
9296a424-293d-43d4-a781-73cfc34fc13a	true	introspection.token.claim
9296a424-293d-43d4-a781-73cfc34fc13a	true	userinfo.token.claim
9296a424-293d-43d4-a781-73cfc34fc13a	updatedAt	user.attribute
9296a424-293d-43d4-a781-73cfc34fc13a	true	id.token.claim
9296a424-293d-43d4-a781-73cfc34fc13a	true	access.token.claim
9296a424-293d-43d4-a781-73cfc34fc13a	updated_at	claim.name
9296a424-293d-43d4-a781-73cfc34fc13a	long	jsonType.label
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	true	introspection.token.claim
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	true	userinfo.token.claim
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	gender	user.attribute
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	true	id.token.claim
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	true	access.token.claim
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	gender	claim.name
9480c6d9-f6e8-4ee0-9a9a-76070319cbdc	String	jsonType.label
948745ae-da76-4c34-92ba-da166d5d4963	true	introspection.token.claim
948745ae-da76-4c34-92ba-da166d5d4963	true	userinfo.token.claim
948745ae-da76-4c34-92ba-da166d5d4963	locale	user.attribute
948745ae-da76-4c34-92ba-da166d5d4963	true	id.token.claim
948745ae-da76-4c34-92ba-da166d5d4963	true	access.token.claim
948745ae-da76-4c34-92ba-da166d5d4963	locale	claim.name
948745ae-da76-4c34-92ba-da166d5d4963	String	jsonType.label
a74b0828-c1f9-4888-a053-5a4f0196a88f	true	introspection.token.claim
a74b0828-c1f9-4888-a053-5a4f0196a88f	true	userinfo.token.claim
a74b0828-c1f9-4888-a053-5a4f0196a88f	username	user.attribute
a74b0828-c1f9-4888-a053-5a4f0196a88f	true	id.token.claim
a74b0828-c1f9-4888-a053-5a4f0196a88f	true	access.token.claim
a74b0828-c1f9-4888-a053-5a4f0196a88f	preferred_username	claim.name
a74b0828-c1f9-4888-a053-5a4f0196a88f	String	jsonType.label
a89071dd-bfc1-4358-a8e5-d48700647d6a	true	introspection.token.claim
a89071dd-bfc1-4358-a8e5-d48700647d6a	true	userinfo.token.claim
a89071dd-bfc1-4358-a8e5-d48700647d6a	middleName	user.attribute
a89071dd-bfc1-4358-a8e5-d48700647d6a	true	id.token.claim
a89071dd-bfc1-4358-a8e5-d48700647d6a	true	access.token.claim
a89071dd-bfc1-4358-a8e5-d48700647d6a	middle_name	claim.name
a89071dd-bfc1-4358-a8e5-d48700647d6a	String	jsonType.label
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	true	introspection.token.claim
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	true	userinfo.token.claim
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	profile	user.attribute
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	true	id.token.claim
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	true	access.token.claim
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	profile	claim.name
b7b5f09e-bde9-47d8-85da-63e9bb20e97f	String	jsonType.label
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	true	introspection.token.claim
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	true	userinfo.token.claim
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	lastName	user.attribute
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	true	id.token.claim
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	true	access.token.claim
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	family_name	claim.name
b9097e10-f63f-48b5-b9a1-a63c5e50ec8f	String	jsonType.label
d19fddf5-1cf5-47cd-955b-ca19e13d51b7	true	introspection.token.claim
d19fddf5-1cf5-47cd-955b-ca19e13d51b7	true	userinfo.token.claim
d19fddf5-1cf5-47cd-955b-ca19e13d51b7	true	id.token.claim
d19fddf5-1cf5-47cd-955b-ca19e13d51b7	true	access.token.claim
d3c94780-4296-47f9-bedf-357063953e5c	true	introspection.token.claim
d3c94780-4296-47f9-bedf-357063953e5c	true	userinfo.token.claim
d3c94780-4296-47f9-bedf-357063953e5c	nickname	user.attribute
d3c94780-4296-47f9-bedf-357063953e5c	true	id.token.claim
d3c94780-4296-47f9-bedf-357063953e5c	true	access.token.claim
d3c94780-4296-47f9-bedf-357063953e5c	nickname	claim.name
d3c94780-4296-47f9-bedf-357063953e5c	String	jsonType.label
ea065578-58af-412b-8419-dea8a834483c	true	introspection.token.claim
ea065578-58af-412b-8419-dea8a834483c	true	userinfo.token.claim
ea065578-58af-412b-8419-dea8a834483c	birthdate	user.attribute
ea065578-58af-412b-8419-dea8a834483c	true	id.token.claim
ea065578-58af-412b-8419-dea8a834483c	true	access.token.claim
ea065578-58af-412b-8419-dea8a834483c	birthdate	claim.name
ea065578-58af-412b-8419-dea8a834483c	String	jsonType.label
390eb42a-27be-482b-bfe9-1e94a145a909	true	introspection.token.claim
390eb42a-27be-482b-bfe9-1e94a145a909	true	userinfo.token.claim
390eb42a-27be-482b-bfe9-1e94a145a909	emailVerified	user.attribute
390eb42a-27be-482b-bfe9-1e94a145a909	true	id.token.claim
390eb42a-27be-482b-bfe9-1e94a145a909	true	access.token.claim
390eb42a-27be-482b-bfe9-1e94a145a909	email_verified	claim.name
390eb42a-27be-482b-bfe9-1e94a145a909	boolean	jsonType.label
a337c0d8-b0bf-4adb-9222-342266b1f8f1	true	introspection.token.claim
a337c0d8-b0bf-4adb-9222-342266b1f8f1	true	userinfo.token.claim
a337c0d8-b0bf-4adb-9222-342266b1f8f1	email	user.attribute
a337c0d8-b0bf-4adb-9222-342266b1f8f1	true	id.token.claim
a337c0d8-b0bf-4adb-9222-342266b1f8f1	true	access.token.claim
a337c0d8-b0bf-4adb-9222-342266b1f8f1	email	claim.name
a337c0d8-b0bf-4adb-9222-342266b1f8f1	String	jsonType.label
1ab16178-842a-429a-b041-42003b15ccd3	formatted	user.attribute.formatted
1ab16178-842a-429a-b041-42003b15ccd3	country	user.attribute.country
1ab16178-842a-429a-b041-42003b15ccd3	true	introspection.token.claim
1ab16178-842a-429a-b041-42003b15ccd3	postal_code	user.attribute.postal_code
1ab16178-842a-429a-b041-42003b15ccd3	true	userinfo.token.claim
1ab16178-842a-429a-b041-42003b15ccd3	street	user.attribute.street
1ab16178-842a-429a-b041-42003b15ccd3	true	id.token.claim
1ab16178-842a-429a-b041-42003b15ccd3	region	user.attribute.region
1ab16178-842a-429a-b041-42003b15ccd3	true	access.token.claim
1ab16178-842a-429a-b041-42003b15ccd3	locality	user.attribute.locality
37d1e086-c4d6-4320-b156-dd38f39f9ddb	true	introspection.token.claim
37d1e086-c4d6-4320-b156-dd38f39f9ddb	true	userinfo.token.claim
37d1e086-c4d6-4320-b156-dd38f39f9ddb	phoneNumber	user.attribute
37d1e086-c4d6-4320-b156-dd38f39f9ddb	true	id.token.claim
37d1e086-c4d6-4320-b156-dd38f39f9ddb	true	access.token.claim
37d1e086-c4d6-4320-b156-dd38f39f9ddb	phone_number	claim.name
37d1e086-c4d6-4320-b156-dd38f39f9ddb	String	jsonType.label
eb799828-0859-4327-84ff-36f4350f3799	true	introspection.token.claim
eb799828-0859-4327-84ff-36f4350f3799	true	userinfo.token.claim
eb799828-0859-4327-84ff-36f4350f3799	phoneNumberVerified	user.attribute
eb799828-0859-4327-84ff-36f4350f3799	true	id.token.claim
eb799828-0859-4327-84ff-36f4350f3799	true	access.token.claim
eb799828-0859-4327-84ff-36f4350f3799	phone_number_verified	claim.name
eb799828-0859-4327-84ff-36f4350f3799	boolean	jsonType.label
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	true	introspection.token.claim
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	true	multivalued
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	foo	user.attribute
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	true	access.token.claim
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	resource_access.${client_id}.roles	claim.name
09a7ea71-b223-4ca7-8733-0d97d6b6cd4c	String	jsonType.label
77114f57-f6ca-439f-a74d-a6d324b520d6	true	introspection.token.claim
77114f57-f6ca-439f-a74d-a6d324b520d6	true	multivalued
77114f57-f6ca-439f-a74d-a6d324b520d6	foo	user.attribute
77114f57-f6ca-439f-a74d-a6d324b520d6	true	access.token.claim
77114f57-f6ca-439f-a74d-a6d324b520d6	realm_access.roles	claim.name
77114f57-f6ca-439f-a74d-a6d324b520d6	String	jsonType.label
de4025eb-e192-429c-a9b0-c08b06866fbd	true	introspection.token.claim
de4025eb-e192-429c-a9b0-c08b06866fbd	true	access.token.claim
3735b140-8fa8-4fe1-b3ea-58c39b3df256	true	introspection.token.claim
3735b140-8fa8-4fe1-b3ea-58c39b3df256	true	access.token.claim
6b5f3856-d146-4438-927e-d05a06da11bb	true	introspection.token.claim
6b5f3856-d146-4438-927e-d05a06da11bb	true	userinfo.token.claim
6b5f3856-d146-4438-927e-d05a06da11bb	username	user.attribute
6b5f3856-d146-4438-927e-d05a06da11bb	true	id.token.claim
6b5f3856-d146-4438-927e-d05a06da11bb	true	access.token.claim
6b5f3856-d146-4438-927e-d05a06da11bb	upn	claim.name
6b5f3856-d146-4438-927e-d05a06da11bb	String	jsonType.label
96e715bd-c4ce-4169-8457-5890c41e2c4e	true	introspection.token.claim
96e715bd-c4ce-4169-8457-5890c41e2c4e	true	multivalued
96e715bd-c4ce-4169-8457-5890c41e2c4e	foo	user.attribute
96e715bd-c4ce-4169-8457-5890c41e2c4e	true	id.token.claim
96e715bd-c4ce-4169-8457-5890c41e2c4e	true	access.token.claim
96e715bd-c4ce-4169-8457-5890c41e2c4e	groups	claim.name
96e715bd-c4ce-4169-8457-5890c41e2c4e	String	jsonType.label
b2f71be2-9b88-488b-8965-98159c5f27ea	true	introspection.token.claim
b2f71be2-9b88-488b-8965-98159c5f27ea	true	id.token.claim
b2f71be2-9b88-488b-8965-98159c5f27ea	true	access.token.claim
06bb3419-2f01-403b-8f6e-6b09eb874bb7	false	single
06bb3419-2f01-403b-8f6e-6b09eb874bb7	Basic	attribute.nameformat
06bb3419-2f01-403b-8f6e-6b09eb874bb7	Role	attribute.name
06bef3f7-7714-416d-b593-f5123661f068	true	introspection.token.claim
06bef3f7-7714-416d-b593-f5123661f068	true	userinfo.token.claim
06bef3f7-7714-416d-b593-f5123661f068	username	user.attribute
06bef3f7-7714-416d-b593-f5123661f068	true	id.token.claim
06bef3f7-7714-416d-b593-f5123661f068	true	access.token.claim
06bef3f7-7714-416d-b593-f5123661f068	preferred_username	claim.name
06bef3f7-7714-416d-b593-f5123661f068	String	jsonType.label
478d2900-3c31-4ce2-850e-84001468eb9f	true	introspection.token.claim
478d2900-3c31-4ce2-850e-84001468eb9f	true	userinfo.token.claim
478d2900-3c31-4ce2-850e-84001468eb9f	birthdate	user.attribute
478d2900-3c31-4ce2-850e-84001468eb9f	true	id.token.claim
478d2900-3c31-4ce2-850e-84001468eb9f	true	access.token.claim
478d2900-3c31-4ce2-850e-84001468eb9f	birthdate	claim.name
478d2900-3c31-4ce2-850e-84001468eb9f	String	jsonType.label
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	true	introspection.token.claim
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	true	userinfo.token.claim
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	updatedAt	user.attribute
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	true	id.token.claim
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	true	access.token.claim
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	updated_at	claim.name
5931cf0b-d089-46a6-8c18-a28ebf9a2a12	long	jsonType.label
5acd6214-5564-485c-b71c-7a584723e732	true	introspection.token.claim
5acd6214-5564-485c-b71c-7a584723e732	true	userinfo.token.claim
5acd6214-5564-485c-b71c-7a584723e732	nickname	user.attribute
5acd6214-5564-485c-b71c-7a584723e732	true	id.token.claim
5acd6214-5564-485c-b71c-7a584723e732	true	access.token.claim
5acd6214-5564-485c-b71c-7a584723e732	nickname	claim.name
5acd6214-5564-485c-b71c-7a584723e732	String	jsonType.label
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	true	introspection.token.claim
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	true	userinfo.token.claim
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	website	user.attribute
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	true	id.token.claim
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	true	access.token.claim
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	website	claim.name
5c2c66a1-d82f-4e6c-ac05-29149ff2944d	String	jsonType.label
6af66197-1d84-49d9-b5c5-ea7676a24754	true	introspection.token.claim
6af66197-1d84-49d9-b5c5-ea7676a24754	true	userinfo.token.claim
6af66197-1d84-49d9-b5c5-ea7676a24754	firstName	user.attribute
6af66197-1d84-49d9-b5c5-ea7676a24754	true	id.token.claim
6af66197-1d84-49d9-b5c5-ea7676a24754	true	access.token.claim
6af66197-1d84-49d9-b5c5-ea7676a24754	given_name	claim.name
6af66197-1d84-49d9-b5c5-ea7676a24754	String	jsonType.label
6d46295f-e669-4b4a-b6a8-059be80bbbdb	true	introspection.token.claim
6d46295f-e669-4b4a-b6a8-059be80bbbdb	true	userinfo.token.claim
6d46295f-e669-4b4a-b6a8-059be80bbbdb	true	id.token.claim
6d46295f-e669-4b4a-b6a8-059be80bbbdb	true	access.token.claim
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	true	introspection.token.claim
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	true	userinfo.token.claim
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	lastName	user.attribute
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	true	id.token.claim
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	true	access.token.claim
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	family_name	claim.name
896ab722-f8ef-4a6f-b8d1-a1d33ae00889	String	jsonType.label
913bc9d7-7114-4913-bd3d-6064e8d50798	true	introspection.token.claim
913bc9d7-7114-4913-bd3d-6064e8d50798	true	userinfo.token.claim
913bc9d7-7114-4913-bd3d-6064e8d50798	locale	user.attribute
913bc9d7-7114-4913-bd3d-6064e8d50798	true	id.token.claim
913bc9d7-7114-4913-bd3d-6064e8d50798	true	access.token.claim
913bc9d7-7114-4913-bd3d-6064e8d50798	locale	claim.name
913bc9d7-7114-4913-bd3d-6064e8d50798	String	jsonType.label
93b1a44b-517b-4e17-93b5-c22213034815	true	introspection.token.claim
93b1a44b-517b-4e17-93b5-c22213034815	true	userinfo.token.claim
93b1a44b-517b-4e17-93b5-c22213034815	gender	user.attribute
93b1a44b-517b-4e17-93b5-c22213034815	true	id.token.claim
93b1a44b-517b-4e17-93b5-c22213034815	true	access.token.claim
93b1a44b-517b-4e17-93b5-c22213034815	gender	claim.name
93b1a44b-517b-4e17-93b5-c22213034815	String	jsonType.label
966f344c-b907-4426-b38d-b1385c9c401b	true	introspection.token.claim
966f344c-b907-4426-b38d-b1385c9c401b	true	userinfo.token.claim
966f344c-b907-4426-b38d-b1385c9c401b	profile	user.attribute
966f344c-b907-4426-b38d-b1385c9c401b	true	id.token.claim
966f344c-b907-4426-b38d-b1385c9c401b	true	access.token.claim
966f344c-b907-4426-b38d-b1385c9c401b	profile	claim.name
966f344c-b907-4426-b38d-b1385c9c401b	String	jsonType.label
a85230c1-a966-4da9-949d-2df718fa2dcc	true	introspection.token.claim
a85230c1-a966-4da9-949d-2df718fa2dcc	true	userinfo.token.claim
a85230c1-a966-4da9-949d-2df718fa2dcc	middleName	user.attribute
a85230c1-a966-4da9-949d-2df718fa2dcc	true	id.token.claim
a85230c1-a966-4da9-949d-2df718fa2dcc	true	access.token.claim
a85230c1-a966-4da9-949d-2df718fa2dcc	middle_name	claim.name
a85230c1-a966-4da9-949d-2df718fa2dcc	String	jsonType.label
e56877aa-c93c-4d53-a299-5738468eebfc	true	introspection.token.claim
e56877aa-c93c-4d53-a299-5738468eebfc	true	userinfo.token.claim
e56877aa-c93c-4d53-a299-5738468eebfc	zoneinfo	user.attribute
e56877aa-c93c-4d53-a299-5738468eebfc	true	id.token.claim
e56877aa-c93c-4d53-a299-5738468eebfc	true	access.token.claim
e56877aa-c93c-4d53-a299-5738468eebfc	zoneinfo	claim.name
e56877aa-c93c-4d53-a299-5738468eebfc	String	jsonType.label
f20df5ba-bbfe-41b4-9c61-da2b124092b2	true	introspection.token.claim
f20df5ba-bbfe-41b4-9c61-da2b124092b2	true	userinfo.token.claim
f20df5ba-bbfe-41b4-9c61-da2b124092b2	picture	user.attribute
f20df5ba-bbfe-41b4-9c61-da2b124092b2	true	id.token.claim
f20df5ba-bbfe-41b4-9c61-da2b124092b2	true	access.token.claim
f20df5ba-bbfe-41b4-9c61-da2b124092b2	picture	claim.name
f20df5ba-bbfe-41b4-9c61-da2b124092b2	String	jsonType.label
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	true	introspection.token.claim
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	true	userinfo.token.claim
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	emailVerified	user.attribute
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	true	id.token.claim
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	true	access.token.claim
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	email_verified	claim.name
2dbfa345-0ec9-42c8-83ef-ed262c579ec8	boolean	jsonType.label
73ebd788-5f32-4156-b5e2-2a6800c1642a	true	introspection.token.claim
73ebd788-5f32-4156-b5e2-2a6800c1642a	true	userinfo.token.claim
73ebd788-5f32-4156-b5e2-2a6800c1642a	email	user.attribute
73ebd788-5f32-4156-b5e2-2a6800c1642a	true	id.token.claim
73ebd788-5f32-4156-b5e2-2a6800c1642a	true	access.token.claim
73ebd788-5f32-4156-b5e2-2a6800c1642a	email	claim.name
73ebd788-5f32-4156-b5e2-2a6800c1642a	String	jsonType.label
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	formatted	user.attribute.formatted
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	country	user.attribute.country
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	true	introspection.token.claim
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	postal_code	user.attribute.postal_code
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	true	userinfo.token.claim
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	street	user.attribute.street
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	true	id.token.claim
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	region	user.attribute.region
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	true	access.token.claim
03eeecca-5d3d-49e7-b55a-f8e4b11446a5	locality	user.attribute.locality
aea5e0c3-842f-46cc-8928-3df7dc35a09b	true	introspection.token.claim
aea5e0c3-842f-46cc-8928-3df7dc35a09b	true	userinfo.token.claim
aea5e0c3-842f-46cc-8928-3df7dc35a09b	phoneNumber	user.attribute
aea5e0c3-842f-46cc-8928-3df7dc35a09b	true	id.token.claim
aea5e0c3-842f-46cc-8928-3df7dc35a09b	true	access.token.claim
aea5e0c3-842f-46cc-8928-3df7dc35a09b	phone_number	claim.name
aea5e0c3-842f-46cc-8928-3df7dc35a09b	String	jsonType.label
c06fc5b6-6501-411d-8d35-96b3b51c1d04	true	introspection.token.claim
c06fc5b6-6501-411d-8d35-96b3b51c1d04	true	userinfo.token.claim
c06fc5b6-6501-411d-8d35-96b3b51c1d04	phoneNumberVerified	user.attribute
c06fc5b6-6501-411d-8d35-96b3b51c1d04	true	id.token.claim
c06fc5b6-6501-411d-8d35-96b3b51c1d04	true	access.token.claim
c06fc5b6-6501-411d-8d35-96b3b51c1d04	phone_number_verified	claim.name
c06fc5b6-6501-411d-8d35-96b3b51c1d04	boolean	jsonType.label
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	true	introspection.token.claim
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	true	multivalued
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	foo	user.attribute
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	true	access.token.claim
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	resource_access.${client_id}.roles	claim.name
28cc3eed-faa4-4fc3-905f-df7bdbf29a97	String	jsonType.label
89580944-558c-4d13-8cd7-90fa5944ecd8	true	introspection.token.claim
89580944-558c-4d13-8cd7-90fa5944ecd8	true	access.token.claim
eb97a12f-adc0-4071-9290-75a1e41c4d3b	true	introspection.token.claim
eb97a12f-adc0-4071-9290-75a1e41c4d3b	true	multivalued
eb97a12f-adc0-4071-9290-75a1e41c4d3b	foo	user.attribute
eb97a12f-adc0-4071-9290-75a1e41c4d3b	true	access.token.claim
eb97a12f-adc0-4071-9290-75a1e41c4d3b	realm_access.roles	claim.name
eb97a12f-adc0-4071-9290-75a1e41c4d3b	String	jsonType.label
10786386-8dda-4dca-a03c-17cee7fc5f3c	true	introspection.token.claim
10786386-8dda-4dca-a03c-17cee7fc5f3c	true	access.token.claim
6a53d421-0435-4b79-8f9c-c3cdd04217fa	true	introspection.token.claim
6a53d421-0435-4b79-8f9c-c3cdd04217fa	true	multivalued
6a53d421-0435-4b79-8f9c-c3cdd04217fa	foo	user.attribute
6a53d421-0435-4b79-8f9c-c3cdd04217fa	true	id.token.claim
6a53d421-0435-4b79-8f9c-c3cdd04217fa	true	access.token.claim
6a53d421-0435-4b79-8f9c-c3cdd04217fa	groups	claim.name
6a53d421-0435-4b79-8f9c-c3cdd04217fa	String	jsonType.label
80935f89-e58c-4a90-b43b-972584a17639	true	introspection.token.claim
80935f89-e58c-4a90-b43b-972584a17639	true	userinfo.token.claim
80935f89-e58c-4a90-b43b-972584a17639	username	user.attribute
80935f89-e58c-4a90-b43b-972584a17639	true	id.token.claim
80935f89-e58c-4a90-b43b-972584a17639	true	access.token.claim
80935f89-e58c-4a90-b43b-972584a17639	upn	claim.name
80935f89-e58c-4a90-b43b-972584a17639	String	jsonType.label
309921c7-a01f-4675-89b7-ce78efac9fc9	true	introspection.token.claim
309921c7-a01f-4675-89b7-ce78efac9fc9	true	id.token.claim
309921c7-a01f-4675-89b7-ce78efac9fc9	true	access.token.claim
775cd405-80df-4004-991f-1028e3c4e799	true	introspection.token.claim
775cd405-80df-4004-991f-1028e3c4e799	true	userinfo.token.claim
775cd405-80df-4004-991f-1028e3c4e799	locale	user.attribute
775cd405-80df-4004-991f-1028e3c4e799	true	id.token.claim
775cd405-80df-4004-991f-1028e3c4e799	true	access.token.claim
775cd405-80df-4004-991f-1028e3c4e799	locale	claim.name
775cd405-80df-4004-991f-1028e3c4e799	String	jsonType.label
af46e072-af49-40a4-8198-ff210fb1dad4	true	introspection.token.claim
af46e072-af49-40a4-8198-ff210fb1dad4	true	userinfo.token.claim
af46e072-af49-40a4-8198-ff210fb1dad4	accountType	user.attribute
af46e072-af49-40a4-8198-ff210fb1dad4	true	id.token.claim
af46e072-af49-40a4-8198-ff210fb1dad4	true	access.token.claim
af46e072-af49-40a4-8198-ff210fb1dad4	role	claim.name
af46e072-af49-40a4-8198-ff210fb1dad4	String	jsonType.label
e7e5bb67-c120-4b8d-80d8-64e4aa57d276	jobtinder-app	included.client.audience
e7e5bb67-c120-4b8d-80d8-64e4aa57d276	false	id.token.claim
e7e5bb67-c120-4b8d-80d8-64e4aa57d276	true	access.token.claim
e7e5bb67-c120-4b8d-80d8-64e4aa57d276	true	introspection.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
5cadf19d-2afe-4405-a6f0-974df43fe807	60	300	300	\N	\N	\N	t	f	0	\N	FastAPI	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	23d91c98-3b52-4354-bb31-f1912906ae6d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f835643f-9a57-4c91-b271-748959f07b1a	b040176f-c2e9-40d2-92f7-6c31a3f4a3bb	ec2f66f8-b31d-43ae-b83c-8931a681cc45	69297c8d-f075-465c-825a-492a85a1bdc5	6b0d0ab7-20da-445e-9415-4f254eae67a7	2592000	f	900	t	f	5a63ab51-ff6e-40c0-be1a-6652dd3e28ce	0	f	0	0	6558cec1-c2ff-47ec-a1c3-4548c02996e3
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	368bcfa9-a02a-46c6-8c18-3b4660c7971d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	e747ce19-5b69-41ad-b0e2-c7e7e955d67e	906eb68f-0099-4927-9efa-d476651aa0eb	ecc625ce-9f43-4f58-94ea-1feaf19a1304	d7f82324-2695-4c08-b571-751a9f613f01	5e85c13b-c819-43a9-a125-a1b1876e0b1a	2592000	f	900	t	f	31a56ade-ae4c-4a68-b705-88b9dbf9a293	0	f	0	0	70d202d0-7d22-4010-a5cb-5201954f28f8
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	
_browser_header.xContentTypeOptions	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	nosniff
_browser_header.referrerPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	no-referrer
_browser_header.xRobotsTag	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	none
_browser_header.xFrameOptions	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	SAMEORIGIN
_browser_header.contentSecurityPolicy	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	1; mode=block
_browser_header.strictTransportSecurity	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	max-age=31536000; includeSubDomains
bruteForceProtected	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	false
permanentLockout	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	false
maxFailureWaitSeconds	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	900
minimumQuickLoginWaitSeconds	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	60
waitIncrementSeconds	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	60
quickLoginCheckMilliSeconds	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	1000
maxDeltaTimeSeconds	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	43200
failureFactor	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	30
realmReusableOtpCode	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	false
displayName	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	Keycloak
displayNameHtml	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	RS256
offlineSessionMaxLifespanEnabled	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	false
offlineSessionMaxLifespan	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	5184000
displayName	5cadf19d-2afe-4405-a6f0-974df43fe807	
displayNameHtml	5cadf19d-2afe-4405-a6f0-974df43fe807	
bruteForceProtected	5cadf19d-2afe-4405-a6f0-974df43fe807	false
permanentLockout	5cadf19d-2afe-4405-a6f0-974df43fe807	false
maxFailureWaitSeconds	5cadf19d-2afe-4405-a6f0-974df43fe807	900
minimumQuickLoginWaitSeconds	5cadf19d-2afe-4405-a6f0-974df43fe807	60
waitIncrementSeconds	5cadf19d-2afe-4405-a6f0-974df43fe807	60
quickLoginCheckMilliSeconds	5cadf19d-2afe-4405-a6f0-974df43fe807	1000
maxDeltaTimeSeconds	5cadf19d-2afe-4405-a6f0-974df43fe807	43200
failureFactor	5cadf19d-2afe-4405-a6f0-974df43fe807	30
actionTokenGeneratedByAdminLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	43200
actionTokenGeneratedByUserLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	300
defaultSignatureAlgorithm	5cadf19d-2afe-4405-a6f0-974df43fe807	RS256
offlineSessionMaxLifespanEnabled	5cadf19d-2afe-4405-a6f0-974df43fe807	false
offlineSessionMaxLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	5184000
webAuthnPolicyRpEntityName	5cadf19d-2afe-4405-a6f0-974df43fe807	keycloak
realmReusableOtpCode	5cadf19d-2afe-4405-a6f0-974df43fe807	false
webAuthnPolicySignatureAlgorithms	5cadf19d-2afe-4405-a6f0-974df43fe807	ES256
webAuthnPolicyRpId	5cadf19d-2afe-4405-a6f0-974df43fe807	
webAuthnPolicyAttestationConveyancePreference	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyAuthenticatorAttachment	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyRequireResidentKey	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
oauth2DeviceCodeLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	600
oauth2DevicePollingInterval	5cadf19d-2afe-4405-a6f0-974df43fe807	5
webAuthnPolicyUserVerificationRequirement	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyCreateTimeout	5cadf19d-2afe-4405-a6f0-974df43fe807	0
webAuthnPolicyAvoidSameAuthenticatorRegister	5cadf19d-2afe-4405-a6f0-974df43fe807	false
webAuthnPolicyRpEntityNamePasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	ES256
webAuthnPolicyRpIdPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	
webAuthnPolicyAttestationConveyancePreferencePasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyRequireResidentKeyPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	not specified
webAuthnPolicyCreateTimeoutPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	5cadf19d-2afe-4405-a6f0-974df43fe807	false
client-policies.profiles	5cadf19d-2afe-4405-a6f0-974df43fe807	{"profiles":[]}
client-policies.policies	5cadf19d-2afe-4405-a6f0-974df43fe807	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	5cadf19d-2afe-4405-a6f0-974df43fe807	
_browser_header.xContentTypeOptions	5cadf19d-2afe-4405-a6f0-974df43fe807	nosniff
_browser_header.referrerPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	no-referrer
_browser_header.xRobotsTag	5cadf19d-2afe-4405-a6f0-974df43fe807	none
cibaBackchannelTokenDeliveryMode	5cadf19d-2afe-4405-a6f0-974df43fe807	poll
cibaExpiresIn	5cadf19d-2afe-4405-a6f0-974df43fe807	120
cibaInterval	5cadf19d-2afe-4405-a6f0-974df43fe807	5
cibaAuthRequestedUserHint	5cadf19d-2afe-4405-a6f0-974df43fe807	login_hint
parRequestUriLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	60
frontendUrl	5cadf19d-2afe-4405-a6f0-974df43fe807	
userProfileEnabled	5cadf19d-2afe-4405-a6f0-974df43fe807	true
acr.loa.map	5cadf19d-2afe-4405-a6f0-974df43fe807	{}
_browser_header.xFrameOptions	5cadf19d-2afe-4405-a6f0-974df43fe807	SAMEORIGIN
_browser_header.contentSecurityPolicy	5cadf19d-2afe-4405-a6f0-974df43fe807	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	5cadf19d-2afe-4405-a6f0-974df43fe807	1; mode=block
_browser_header.strictTransportSecurity	5cadf19d-2afe-4405-a6f0-974df43fe807	max-age=31536000; includeSubDomains
clientSessionIdleTimeout	5cadf19d-2afe-4405-a6f0-974df43fe807	0
clientSessionMaxLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	0
clientOfflineSessionIdleTimeout	5cadf19d-2afe-4405-a6f0-974df43fe807	0
clientOfflineSessionMaxLifespan	5cadf19d-2afe-4405-a6f0-974df43fe807	0
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
1c6a73e7-c19a-492a-9e6d-342c1427c7bf	jboss-logging
5cadf19d-2afe-4405-a6f0-974df43fe807	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	1c6a73e7-c19a-492a-9e6d-342c1427c7bf
password	password	t	t	5cadf19d-2afe-4405-a6f0-974df43fe807
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
be1c5c5a-496e-4725-84fb-3b2bdf77d5d2	/realms/master/account/*
58e593b1-7b8c-461f-8828-f58e0d6500ea	/realms/master/account/*
fe7a2040-a077-45e8-a894-bead4084e1f0	/admin/master/console/*
114c3613-863e-4c19-aadc-75140b710ed4	/realms/FastAPI/account/*
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	/realms/FastAPI/account/*
eda12de4-b981-437c-87f4-9c7574510322	/admin/FastAPI/console/*
96a8277d-be93-4071-b9fb-afc685907e23	https://jobtinder.local/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
1eee8164-30f9-4403-a364-181b7afe58a4	VERIFY_EMAIL	Verify Email	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	VERIFY_EMAIL	50
777997d8-2d88-4792-ad6c-9cbda244e8a0	UPDATE_PROFILE	Update Profile	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	UPDATE_PROFILE	40
26a50916-3c76-475c-bb06-ec7c1995c12e	CONFIGURE_TOTP	Configure OTP	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	CONFIGURE_TOTP	10
7344956f-f719-4ef4-9324-310dabd8cdaa	UPDATE_PASSWORD	Update Password	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	UPDATE_PASSWORD	30
006feeb2-62a9-4030-a9df-68f4363871ff	TERMS_AND_CONDITIONS	Terms and Conditions	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	f	TERMS_AND_CONDITIONS	20
1d9fbdc5-1fb0-4ba1-a26c-6fa83dbeb175	delete_account	Delete Account	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	f	f	delete_account	60
5e1a5b29-0c50-49da-9419-e5748e6db417	update_user_locale	Update User Locale	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	update_user_locale	1000
1bcaef00-83f4-4b8b-8636-4a75f8e159fd	webauthn-register	Webauthn Register	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	webauthn-register	70
7e926de7-9c07-47e0-979f-b400a78786ba	webauthn-register-passwordless	Webauthn Register Passwordless	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	t	f	webauthn-register-passwordless	80
43abda68-c205-499a-a5df-745b98679051	VERIFY_EMAIL	Verify Email	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	VERIFY_EMAIL	50
46ad549c-7dad-4d95-9592-392e24d4ad34	UPDATE_PROFILE	Update Profile	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	UPDATE_PROFILE	40
39d406dd-7fbb-4900-a79c-4c6f422edf32	CONFIGURE_TOTP	Configure OTP	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	CONFIGURE_TOTP	10
463dbcd9-e6c6-4691-8813-85f347312b89	UPDATE_PASSWORD	Update Password	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	UPDATE_PASSWORD	30
c08e338c-9e3b-4de9-bcca-ae2196a7cca8	TERMS_AND_CONDITIONS	Terms and Conditions	5cadf19d-2afe-4405-a6f0-974df43fe807	f	f	TERMS_AND_CONDITIONS	20
77360040-89c0-466d-86fd-a8572b094de7	delete_account	Delete Account	5cadf19d-2afe-4405-a6f0-974df43fe807	f	f	delete_account	60
e869dd25-d286-46f6-aac4-96ea35b4776e	update_user_locale	Update User Locale	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	update_user_locale	1000
78871397-341b-4bef-9c67-9992031edcdb	webauthn-register	Webauthn Register	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	webauthn-register	70
167033a1-c561-48a0-b6fd-bdfc5b9519c7	webauthn-register-passwordless	Webauthn Register Passwordless	5cadf19d-2afe-4405-a6f0-974df43fe807	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
58e593b1-7b8c-461f-8828-f58e0d6500ea	7b98f83b-4c08-497a-8da9-e3807802f167
58e593b1-7b8c-461f-8828-f58e0d6500ea	c047215a-7395-4d92-8132-dd753c2c0292
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	16e0fc58-0f9a-41d8-b22b-79edc4032c97
a2b6ed1e-9a61-43e3-91fe-9434be3ae6d4	ddcc02db-9816-405f-b98c-f2a4881b8750
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
accountType	employer	d0c56433-37ec-4812-8e45-76fb7f0e696f	119349a0-b09c-4406-8852-4dbc5c233d3e
accountType	seeker	238e2985-b3ec-4b41-a98b-275492f9bac4	fa51e416-03bd-4021-a236-f4bbfb1fcfd5
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
e4595cfa-7dab-4fca-834b-1cbf8dda3b75	\N	6a40a147-a250-4007-a11f-75dad75df756	f	t	\N	\N	\N	1c6a73e7-c19a-492a-9e6d-342c1427c7bf	admin	1756319372748	\N	0
d0c56433-37ec-4812-8e45-76fb7f0e696f	emp@gmail.com	emp@gmail.com	t	t	\N	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	employer	1756319664809	\N	0
238e2985-b3ec-4b41-a98b-275492f9bac4	see@gmail.com	see@gmail.com	t	t	\N	\N	\N	5cadf19d-2afe-4405-a6f0-974df43fe807	seeker	1756396353487	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
70d202d0-7d22-4010-a5cb-5201954f28f8	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
7bb9899f-bebe-4b43-ad34-9794f69212a4	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
4c70a9a0-99b3-439f-8986-996760430831	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
791a801d-6db8-4df2-85de-4b62ca9ae3db	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
04692ade-aff9-441a-bc8b-c4076844b844	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
65ed96cd-175a-4a61-add1-7f59ed53b5f4	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
910846c7-109b-4942-a78f-3d1ca2916a37	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
1e600c30-49d8-44b2-89e5-cf7c6882265f	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
64debf19-437e-492a-83a8-716b59c308d0	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
1c69bf54-1e06-4cda-a0b9-372c66762294	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
ae073094-9c1c-4c87-9cdf-9cb1015b8dff	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
7aafad26-592d-4e5e-81ae-16f0a9e2a309	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
4d203cc1-50f8-490f-b091-717c1ec72af4	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
a2f4617f-3630-4dfd-bbb6-d8e5f696b372	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
41106e77-d0b4-4e43-8db1-31cee87f266c	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
77f0e85c-e7a6-41c4-886b-1c069c785979	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
c48c1a18-5e70-4277-b343-23ba41aac153	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
5149f4af-e5fd-4a31-802e-840bb41537d3	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
8358d9b9-6371-4824-90b9-c7d563816118	e4595cfa-7dab-4fca-834b-1cbf8dda3b75
6558cec1-c2ff-47ec-a1c3-4548c02996e3	d0c56433-37ec-4812-8e45-76fb7f0e696f
6558cec1-c2ff-47ec-a1c3-4548c02996e3	238e2985-b3ec-4b41-a98b-275492f9bac4
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
fe7a2040-a077-45e8-a894-bead4084e1f0	+
eda12de4-b981-437c-87f4-9c7574510322	+
96a8277d-be93-4071-b9fb-afc685907e23	https://jobtinder.local
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict eTIin1ShxEpES2nB32fCZxwEo3Kjn1cLIpCq1a8JYVkfWKIIu9yJXezhLs94Eav

