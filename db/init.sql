--
-- PostgreSQL database dump
--

\restrict SYvgGXGCarzlbtWiGIXRxygvrhXcis9nbu4LKFdC5FfOQ04GCutTdpTkddmjlMb

-- Dumped from database version 16.10 (Debian 16.10-1.pgdg13+1)
-- Dumped by pg_dump version 16.10 (Debian 16.10-1.pgdg13+1)

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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    description text,
    name character varying(255)
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO postgres;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO postgres;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO postgres;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO postgres;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO postgres;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO postgres;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text,
    searchable boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_fields OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO postgres;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO postgres;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO postgres;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO postgres;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO postgres;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO postgres;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO postgres;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO postgres;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO postgres;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO postgres;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO postgres;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO postgres;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO postgres;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO postgres;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO postgres;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text,
    project_owner character varying(255),
    project_usage character varying(255),
    org_name character varying(255),
    product_updates boolean,
    project_status character varying(255),
    ai_openai_api_key text,
    ai_anthropic_api_key text,
    ai_system_prompt text
);


ALTER TABLE public.directus_settings OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO postgres;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO postgres;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO postgres;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO postgres;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO postgres;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO postgres;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    name character varying(255),
    price numeric(10,5),
    status character varying(255) DEFAULT 'active'::character varying,
    category integer,
    suppliers integer,
    stock integer DEFAULT 0
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    name character varying(255),
    email character varying(255),
    status character varying(255) DEFAULT 'active'::character varying
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_id_seq OWNER TO postgres;

--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_id_seq OWNED BY public.suppliers.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: suppliers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN id SET DEFAULT nextval('public.suppliers_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, date_created, date_updated, description, name) FROM stdin;
1	2026-01-02 12:01:21.096+00	\N	Electronic devices	Electronics
2	2026-01-02 12:03:57.386+00	\N	Home furniture	Furniture
3	2026-01-02 12:03:57.39+00	\N	Books and documents	Books
4	2026-01-02 12:03:57.392+00	\N	Office supplies	Office
5	2026-01-02 12:03:57.394+00	\N	Gaming products	Gaming
6	2026-01-02 12:03:57.396+00	\N	Education materials	Education
7	2026-01-02 12:03:57.397+00	\N	Clothes and fashion	Clothing
8	2026-01-02 12:03:57.399+00	\N	Accessories	Accessories
9	2026-01-02 12:03:57.401+00	\N	Appliances	Home Appliances
10	2026-01-02 12:03:57.404+00	\N	Hardware tools	Tools
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
c62a3554-4d24-4083-b9ff-7d2b7658d917	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
f7f78a32-0012-4705-856f-27bc7fcd608d	c4279ea7-e10e-424e-a4e2-d7ed4163e0bf	\N	7f1dcb5a-3d2b-406a-8d40-c7d0f82ae3bf	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:02:41.004+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	http://localhost:8055
2	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:02:55.404+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
3	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:02:55.409+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
4	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:02:55.412+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
5	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:02:55.416+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_collections	products	http://localhost:8055
6	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:03:03.978+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
7	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:03:11.226+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
8	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:03:17.295+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
11	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.007+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_collections	products	http://localhost:8055
12	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.011+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
13	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
14	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.012+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
15	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.013+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
16	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.014+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
17	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 11:38:57.018+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
18	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:27.242+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
19	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:27.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
20	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:27.251+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
21	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:27.255+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_collections	categories	http://localhost:8055
22	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:41.382+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
23	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:55.046+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
24	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:56.306+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
25	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:56.314+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
26	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:56.32+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
27	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:56.325+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
28	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:00:56.33+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
29	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:01:21.097+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	1	http://localhost:8055
30	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.388+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	2	http://localhost:8055
31	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.391+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	3	http://localhost:8055
32	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.393+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	4	http://localhost:8055
33	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.395+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	5	http://localhost:8055
34	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.396+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	6	http://localhost:8055
35	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.398+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	7	http://localhost:8055
36	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.4+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	8	http://localhost:8055
37	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.401+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	9	http://localhost:8055
38	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:03:57.404+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	categories	10	http://localhost:8055
39	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:18.657+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
40	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:18.664+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
41	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:18.669+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
42	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:18.674+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
43	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:18.679+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
44	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:19.75+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
45	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:19.757+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
46	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:19.761+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
47	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:19.766+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
48	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:04:19.769+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
49	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:30.659+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
50	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:30.662+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	13	http://localhost:8055
51	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:30.665+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	14	http://localhost:8055
52	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:30.667+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_collections	suppliers	http://localhost:8055
53	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:42.573+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	15	http://localhost:8055
54	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:49.005+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	16	http://localhost:8055
55	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:06:58.685+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	17	http://localhost:8055
56	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.767+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	1	http://localhost:8055
57	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.769+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	2	http://localhost:8055
58	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.771+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	3	http://localhost:8055
59	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.773+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	4	http://localhost:8055
60	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.774+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	5	http://localhost:8055
61	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.776+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	6	http://localhost:8055
62	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.777+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	7	http://localhost:8055
63	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.778+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	8	http://localhost:8055
64	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.78+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	9	http://localhost:8055
65	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:07:22.781+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	suppliers	10	http://localhost:8055
66	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:08:41.502+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	18	http://localhost:8055
67	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:08:41.504+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	19	http://localhost:8055
68	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:08:41.507+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	20	http://localhost:8055
163	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:30:06.611+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
69	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:08:41.51+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_collections	products	http://localhost:8055
70	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:08:51.806+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	21	http://localhost:8055
71	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:01.35+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
72	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:13.144+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	23	http://localhost:8055
73	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.358+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	1	http://localhost:8055
74	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.36+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	2	http://localhost:8055
75	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.362+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	3	http://localhost:8055
76	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.364+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	4	http://localhost:8055
77	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.366+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	5	http://localhost:8055
78	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.368+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	6	http://localhost:8055
79	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.37+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	7	http://localhost:8055
80	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.372+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	8	http://localhost:8055
81	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.374+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	9	http://localhost:8055
82	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:09:46.376+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	10	http://localhost:8055
83	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:12:44.695+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	24	http://localhost:8055
84	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:13:18.061+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	1	http://localhost:8055
85	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:13:37.399+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	2	http://localhost:8055
86	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:13:47.033+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	2	http://localhost:8055
87	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:14:08.585+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	3	http://localhost:8055
88	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:14:15.589+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	9	http://localhost:8055
89	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:15:11.322+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	25	http://localhost:8055
90	delete	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:15:52.388+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	25	http://localhost:8055
91	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:16:22.214+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	26	http://localhost:8055
92	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:16:54.19+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	7	http://localhost:8055
93	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:17:20.076+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	4	http://localhost:8055
94	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:17:27.127+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	6	http://localhost:8055
95	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-02 12:20:00.78+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
96	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 08:12:19.184+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
97	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:34:25.655+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
98	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:35:37.053+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
99	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:36:15.238+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
100	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:44:45.16+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
101	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:50:45.113+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
102	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:50:45.122+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
103	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:50:58.856+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
104	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:51:15.581+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
105	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:51:15.587+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
106	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:38.118+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
164	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:30:18.656+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
107	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.259+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	18	http://localhost:8055
108	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.266+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	19	http://localhost:8055
109	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.271+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	20	http://localhost:8055
110	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.276+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	21	http://localhost:8055
111	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.282+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
112	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.287+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	23	http://localhost:8055
113	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.293+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	27	http://localhost:8055
114	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.299+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	24	http://localhost:8055
115	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:41.304+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_fields	26	http://localhost:8055
116	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:42.9+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
117	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:42.906+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
118	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:50.411+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
119	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:50.417+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
120	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:51.859+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
121	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:52:51.863+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
122	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:53:24.194+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
123	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:53:24.204+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
124	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:53:30.606+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
125	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:53:35.245+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
126	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 09:53:35.254+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
127	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 12:43:58.069+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
128	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:14:57.525+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
129	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:28.089+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
130	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:28.099+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
131	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:40.852+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
132	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:40.859+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
133	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:41.894+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
134	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:41.902+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
135	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:42.644+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
136	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:42.651+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
137	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:43.623+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
138	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:43.628+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
139	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:56.825+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
140	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:56.83+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
141	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:57.801+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
142	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:57.807+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
143	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:58.712+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
144	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:58.719+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
145	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:59.959+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
146	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:15:59.965+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
147	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:00.7+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
148	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:00.707+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
149	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:10.559+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
150	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:10.574+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
151	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:11.616+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
152	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:11.622+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
153	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:15.071+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
154	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:15.076+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
155	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:15.87+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
156	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:15.875+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
157	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:18.902+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
158	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:18.908+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
159	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:16:57.331+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
160	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:23:21.619+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
161	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:29:36.83+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
162	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:29:39.009+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
165	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:30:24.914+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
166	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:30:25.667+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
167	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:30:59.544+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
168	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:31:00.626+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
169	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:31:57.544+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
170	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:32:10.48+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
171	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:42:14.447+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
172	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:46:38.541+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
173	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:15.878+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
174	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:15.885+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
175	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:32.133+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
176	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:32.142+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
177	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:40.112+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
178	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:40.118+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
179	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:50.115+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
180	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:50.129+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
181	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:50.139+00	172.18.0.1	PostmanRuntime/7.51.0	products	3	\N
182	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:58.891+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
183	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:47:58.9+00	172.18.0.1	PostmanRuntime/7.51.0	products	3	\N
184	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:49:42.497+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
185	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:49:42.509+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
186	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 13:49:42.518+00	172.18.0.1	PostmanRuntime/7.51.0	products	3	\N
187	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:12.544+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	1	http://localhost:8055
188	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:12.545+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	2	http://localhost:8055
189	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:12.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	3	http://localhost:8055
190	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:12.546+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	4	http://localhost:8055
191	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:29.855+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	1	http://localhost:8055
192	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:29.856+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	2	http://localhost:8055
193	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:29.856+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	3	http://localhost:8055
194	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:29.857+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	4	http://localhost:8055
195	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:01:44.168+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
196	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.507+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	11	http://localhost:8055
197	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.51+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	12	http://localhost:8055
198	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.512+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	13	http://localhost:8055
199	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.516+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	14	http://localhost:8055
200	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.518+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	15	http://localhost:8055
201	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.52+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	16	http://localhost:8055
202	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.521+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	17	http://localhost:8055
203	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:46.523+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	18	http://localhost:8055
204	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:47.517+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	19	http://localhost:8055
205	create	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:15:47.519+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	20	http://localhost:8055
206	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:36:22.747+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	products	1	http://localhost:8055
207	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:44:27.29+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
208	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:46:44.777+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
209	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:46:53.79+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
210	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:46:53.801+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
211	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:46:53.81+00	172.18.0.1	PostmanRuntime/7.51.0	products	3	\N
212	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:47:09.001+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
213	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-03 14:47:09.009+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
214	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:19:15.811+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
215	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.363+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
216	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.372+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
217	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.377+00	172.18.0.1	PostmanRuntime/7.51.0	products	3	\N
218	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.384+00	172.18.0.1	PostmanRuntime/7.51.0	products	4	\N
219	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.389+00	172.18.0.1	PostmanRuntime/7.51.0	products	5	\N
220	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.393+00	172.18.0.1	PostmanRuntime/7.51.0	products	6	\N
221	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.398+00	172.18.0.1	PostmanRuntime/7.51.0	products	7	\N
222	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.403+00	172.18.0.1	PostmanRuntime/7.51.0	products	8	\N
223	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.407+00	172.18.0.1	PostmanRuntime/7.51.0	products	10	\N
224	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.412+00	172.18.0.1	PostmanRuntime/7.51.0	products	11	\N
225	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.416+00	172.18.0.1	PostmanRuntime/7.51.0	products	12	\N
226	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.422+00	172.18.0.1	PostmanRuntime/7.51.0	products	13	\N
227	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.426+00	172.18.0.1	PostmanRuntime/7.51.0	products	14	\N
228	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.43+00	172.18.0.1	PostmanRuntime/7.51.0	products	15	\N
229	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.433+00	172.18.0.1	PostmanRuntime/7.51.0	products	16	\N
230	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.437+00	172.18.0.1	PostmanRuntime/7.51.0	products	17	\N
231	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.441+00	172.18.0.1	PostmanRuntime/7.51.0	products	18	\N
232	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.447+00	172.18.0.1	PostmanRuntime/7.51.0	products	19	\N
233	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:08.45+00	172.18.0.1	PostmanRuntime/7.51.0	products	20	\N
234	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:29:47.48+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	http://localhost:8055
235	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:32:16.524+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
236	login	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:18.54+00	172.18.0.1	PostmanRuntime/7.51.0	directus_users	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N
237	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.958+00	172.18.0.1	PostmanRuntime/7.51.0	products	1	\N
238	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.968+00	172.18.0.1	PostmanRuntime/7.51.0	products	2	\N
239	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.973+00	172.18.0.1	PostmanRuntime/7.51.0	products	3	\N
240	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.979+00	172.18.0.1	PostmanRuntime/7.51.0	products	4	\N
241	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.985+00	172.18.0.1	PostmanRuntime/7.51.0	products	5	\N
242	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.989+00	172.18.0.1	PostmanRuntime/7.51.0	products	6	\N
243	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.994+00	172.18.0.1	PostmanRuntime/7.51.0	products	7	\N
244	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:33.999+00	172.18.0.1	PostmanRuntime/7.51.0	products	8	\N
245	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.004+00	172.18.0.1	PostmanRuntime/7.51.0	products	10	\N
246	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.009+00	172.18.0.1	PostmanRuntime/7.51.0	products	11	\N
247	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.014+00	172.18.0.1	PostmanRuntime/7.51.0	products	12	\N
248	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.017+00	172.18.0.1	PostmanRuntime/7.51.0	products	13	\N
249	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.022+00	172.18.0.1	PostmanRuntime/7.51.0	products	14	\N
250	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.027+00	172.18.0.1	PostmanRuntime/7.51.0	products	15	\N
251	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.031+00	172.18.0.1	PostmanRuntime/7.51.0	products	16	\N
252	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.035+00	172.18.0.1	PostmanRuntime/7.51.0	products	17	\N
253	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.04+00	172.18.0.1	PostmanRuntime/7.51.0	products	18	\N
254	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.045+00	172.18.0.1	PostmanRuntime/7.51.0	products	19	\N
255	update	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-05 12:36:34.05+00	172.18.0.1	PostmanRuntime/7.51.0	products	20	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
categories	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
suppliers	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
products	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
t	e2a0b265-a60e-4e05-a1d7-d421a8de3718	directus-extension-bulk-update	local	\N
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message, searchable) FROM stdin;
7	categories	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
11	categories	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N	t
10	categories	description	\N	input	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N	t
8	categories	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N	t
9	categories	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N	t
12	suppliers	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
13	suppliers	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N	t
14	suppliers	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N	t
15	suppliers	name	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	t	\N	\N	\N	t
16	suppliers	email	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	f	\N	\N	\N	t
17	suppliers	status	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N	t
18	products	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
19	products	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N	t
20	products	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N	t
21	products	name	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	t	\N	\N	\N	t
22	products	price	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N	t
23	products	status	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N	t
27	products	stock	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N	t
24	products	category	m2o	select-dropdown-m2o	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N	t
26	products	suppliers	m2o	select-dropdown-m2o	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N	t
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2026-01-02 11:01:06.854592+00
20201029A	Remove System Relations	2026-01-02 11:01:06.862029+00
20201029B	Remove System Collections	2026-01-02 11:01:06.866439+00
20201029C	Remove System Fields	2026-01-02 11:01:06.875892+00
20201105A	Add Cascade System Relations	2026-01-02 11:01:06.90143+00
20201105B	Change Webhook URL Type	2026-01-02 11:01:06.907309+00
20210225A	Add Relations Sort Field	2026-01-02 11:01:06.913122+00
20210304A	Remove Locked Fields	2026-01-02 11:01:06.916901+00
20210312A	Webhooks Collections Text	2026-01-02 11:01:06.925695+00
20210331A	Add Refresh Interval	2026-01-02 11:01:06.929182+00
20210415A	Make Filesize Nullable	2026-01-02 11:01:06.934231+00
20210416A	Add Collections Accountability	2026-01-02 11:01:06.937102+00
20210422A	Remove Files Interface	2026-01-02 11:01:06.938998+00
20210506A	Rename Interfaces	2026-01-02 11:01:06.973064+00
20210510A	Restructure Relations	2026-01-02 11:01:06.983602+00
20210518A	Add Foreign Key Constraints	2026-01-02 11:01:06.988978+00
20210519A	Add System Fk Triggers	2026-01-02 11:01:07.008196+00
20210521A	Add Collections Icon Color	2026-01-02 11:01:07.010186+00
20210525A	Add Insights	2026-01-02 11:01:07.023345+00
20210608A	Add Deep Clone Config	2026-01-02 11:01:07.025825+00
20210626A	Change Filesize Bigint	2026-01-02 11:01:07.035879+00
20210716A	Add Conditions to Fields	2026-01-02 11:01:07.039032+00
20210721A	Add Default Folder	2026-01-02 11:01:07.044313+00
20210802A	Replace Groups	2026-01-02 11:01:07.048658+00
20210803A	Add Required to Fields	2026-01-02 11:01:07.050703+00
20210805A	Update Groups	2026-01-02 11:01:07.053547+00
20210805B	Change Image Metadata Structure	2026-01-02 11:01:07.056759+00
20210811A	Add Geometry Config	2026-01-02 11:01:07.060521+00
20210831A	Remove Limit Column	2026-01-02 11:01:07.062896+00
20210903A	Add Auth Provider	2026-01-02 11:01:07.074682+00
20210907A	Webhooks Collections Not Null	2026-01-02 11:01:07.080599+00
20210910A	Move Module Setup	2026-01-02 11:01:07.083925+00
20210920A	Webhooks URL Not Null	2026-01-02 11:01:07.089944+00
20210924A	Add Collection Organization	2026-01-02 11:01:07.094432+00
20210927A	Replace Fields Group	2026-01-02 11:01:07.101261+00
20210927B	Replace M2M Interface	2026-01-02 11:01:07.10286+00
20210929A	Rename Login Action	2026-01-02 11:01:07.104455+00
20211007A	Update Presets	2026-01-02 11:01:07.108517+00
20211009A	Add Auth Data	2026-01-02 11:01:07.111572+00
20211016A	Add Webhook Headers	2026-01-02 11:01:07.113536+00
20211103A	Set Unique to User Token	2026-01-02 11:01:07.116727+00
20211103B	Update Special Geometry	2026-01-02 11:01:07.118462+00
20211104A	Remove Collections Listing	2026-01-02 11:01:07.12172+00
20211118A	Add Notifications	2026-01-02 11:01:07.13304+00
20211211A	Add Shares	2026-01-02 11:01:07.147158+00
20211230A	Add Project Descriptor	2026-01-02 11:01:07.149182+00
20220303A	Remove Default Project Color	2026-01-02 11:01:07.157025+00
20220308A	Add Bookmark Icon and Color	2026-01-02 11:01:07.159315+00
20220314A	Add Translation Strings	2026-01-02 11:01:07.162297+00
20220322A	Rename Field Typecast Flags	2026-01-02 11:01:07.166177+00
20220323A	Add Field Validation	2026-01-02 11:01:07.168908+00
20220325A	Fix Typecast Flags	2026-01-02 11:01:07.174677+00
20220325B	Add Default Language	2026-01-02 11:01:07.182118+00
20220402A	Remove Default Value Panel Icon	2026-01-02 11:01:07.188853+00
20220429A	Add Flows	2026-01-02 11:01:07.215012+00
20220429B	Add Color to Insights Icon	2026-01-02 11:01:07.21771+00
20220429C	Drop Non Null From IP of Activity	2026-01-02 11:01:07.21981+00
20220429D	Drop Non Null From Sender of Notifications	2026-01-02 11:01:07.222388+00
20220614A	Rename Hook Trigger to Event	2026-01-02 11:01:07.22447+00
20220801A	Update Notifications Timestamp Column	2026-01-02 11:01:07.230432+00
20220802A	Add Custom Aspect Ratios	2026-01-02 11:01:07.232779+00
20220826A	Add Origin to Accountability	2026-01-02 11:01:07.235345+00
20230401A	Update Material Icons	2026-01-02 11:01:07.240694+00
20230525A	Add Preview Settings	2026-01-02 11:01:07.242956+00
20230526A	Migrate Translation Strings	2026-01-02 11:01:07.249568+00
20230721A	Require Shares Fields	2026-01-02 11:01:07.2539+00
20230823A	Add Content Versioning	2026-01-02 11:01:07.266066+00
20230927A	Themes	2026-01-02 11:01:07.277097+00
20231009A	Update CSV Fields to Text	2026-01-02 11:01:07.280321+00
20231009B	Update Panel Options	2026-01-02 11:01:07.281973+00
20231010A	Add Extensions	2026-01-02 11:01:07.28526+00
20231215A	Add Focalpoints	2026-01-02 11:01:07.287388+00
20240122A	Add Report URL Fields	2026-01-02 11:01:07.28941+00
20240204A	Marketplace	2026-01-02 11:01:07.304111+00
20240305A	Change Useragent Type	2026-01-02 11:01:07.310374+00
20240311A	Deprecate Webhooks	2026-01-02 11:01:07.316004+00
20240422A	Public Registration	2026-01-02 11:01:07.319282+00
20240515A	Add Session Window	2026-01-02 11:01:07.321096+00
20240701A	Add Tus Data	2026-01-02 11:01:07.32292+00
20240716A	Update Files Date Fields	2026-01-02 11:01:07.327017+00
20240806A	Permissions Policies	2026-01-02 11:01:07.350979+00
20240817A	Update Icon Fields Length	2026-01-02 11:01:07.36756+00
20240909A	Separate Comments	2026-01-02 11:01:07.380083+00
20240909B	Consolidate Content Versioning	2026-01-02 11:01:07.382057+00
20240924A	Migrate Legacy Comments	2026-01-02 11:01:07.386748+00
20240924B	Populate Versioning Deltas	2026-01-02 11:01:07.391912+00
20250224A	Visual Editor	2026-01-02 11:01:07.401976+00
20250609A	License Banner	2026-01-02 11:01:07.408378+00
20250613A	Add Project ID	2026-01-02 11:01:07.424441+00
20250718A	Add Direction	2026-01-02 11:01:07.427644+00
20250813A	Add MCP	2026-01-02 11:01:07.432512+00
20251012A	Add Field Searchable	2026-01-02 11:01:07.435253+00
20251014A	Add Project Owner	2026-01-02 11:01:07.467567+00
20251028A	Add Retention Indexes	2026-01-02 11:01:07.510682+00
20251103A	Add AI Settings	2026-01-02 11:01:07.513092+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
7f1dcb5a-3d2b-406a-8d40-c7d0f82ae3bf	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
2	\N	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N	categories	\N	tabular	{"tabular":{"fields":["name","description"]}}	{"tabular":{"widths":{"name":160,"description":160}}}	10	\N	bookmark	\N
4	\N	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N	suppliers	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
3	\N	0a6d638d-bfab-4807-9eda-f66b2f263a04	\N	products	\N	\N	{"tabular":{"page":1}}	\N	10	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	products	category	categories	\N	\N	\N	\N	\N	nullify
3	products	suppliers	suppliers	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_fields	1	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"products"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"products"}	\N	\N
2	3	directus_fields	2	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"products"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"products"}	\N	\N
3	4	directus_fields	3	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"products"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"products"}	\N	\N
4	5	directus_collections	products	{"singleton":false,"collection":"products"}	{"singleton":false,"collection":"products"}	\N	\N
5	6	directus_fields	4	{"sort":4,"interface":"input","special":null,"required":true,"collection":"products","field":"name"}	{"sort":4,"interface":"input","special":null,"required":true,"collection":"products","field":"name"}	\N	\N
6	7	directus_fields	5	{"sort":5,"interface":"input","special":null,"collection":"products","field":"price"}	{"sort":5,"interface":"input","special":null,"collection":"products","field":"price"}	\N	\N
7	8	directus_fields	6	{"sort":6,"interface":"input","special":null,"collection":"products","field":"status"}	{"sort":6,"interface":"input","special":null,"collection":"products","field":"status"}	\N	\N
10	18	directus_fields	7	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"categories"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"categories"}	\N	\N
11	19	directus_fields	8	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"categories"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"categories"}	\N	\N
12	20	directus_fields	9	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"categories"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"categories"}	\N	\N
13	21	directus_collections	categories	{"singleton":false,"collection":"categories"}	{"singleton":false,"collection":"categories"}	\N	\N
14	22	directus_fields	10	{"sort":4,"interface":"input","special":null,"collection":"categories","field":"description"}	{"sort":4,"interface":"input","special":null,"collection":"categories","field":"description"}	\N	\N
15	23	directus_fields	11	{"sort":5,"interface":"input","special":null,"required":true,"collection":"categories","field":"name"}	{"sort":5,"interface":"input","special":null,"required":true,"collection":"categories","field":"name"}	\N	\N
16	24	directus_fields	7	{"id":7,"collection":"categories","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"id","sort":1,"group":null}	\N	\N
17	25	directus_fields	8	{"id":8,"collection":"categories","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"date_created","sort":2,"group":null}	\N	\N
18	26	directus_fields	9	{"id":9,"collection":"categories","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"date_updated","sort":3,"group":null}	\N	\N
19	27	directus_fields	11	{"id":11,"collection":"categories","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"name","sort":4,"group":null}	\N	\N
20	28	directus_fields	10	{"id":10,"collection":"categories","field":"description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"description","sort":5,"group":null}	\N	\N
21	29	categories	1	{"name":"Electronics","description":"Electronic devices"}	{"name":"Electronics","description":"Electronic devices"}	\N	\N
22	30	categories	2	{"name":"Furniture","description":"Home furniture"}	{"name":"Furniture","description":"Home furniture"}	\N	\N
23	31	categories	3	{"name":"Books","description":"Books and documents"}	{"name":"Books","description":"Books and documents"}	\N	\N
24	32	categories	4	{"name":"Office","description":"Office supplies"}	{"name":"Office","description":"Office supplies"}	\N	\N
25	33	categories	5	{"name":"Gaming","description":"Gaming products"}	{"name":"Gaming","description":"Gaming products"}	\N	\N
26	34	categories	6	{"name":"Education","description":"Education materials"}	{"name":"Education","description":"Education materials"}	\N	\N
27	35	categories	7	{"name":"Clothing","description":"Clothes and fashion"}	{"name":"Clothing","description":"Clothes and fashion"}	\N	\N
28	36	categories	8	{"name":"Accessories","description":"Accessories"}	{"name":"Accessories","description":"Accessories"}	\N	\N
29	37	categories	9	{"name":"Home Appliances","description":"Appliances"}	{"name":"Home Appliances","description":"Appliances"}	\N	\N
30	38	categories	10	{"name":"Tools","description":"Hardware tools"}	{"name":"Tools","description":"Hardware tools"}	\N	\N
31	39	directus_fields	7	{"id":7,"collection":"categories","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"id","sort":1,"group":null}	\N	\N
32	40	directus_fields	11	{"id":11,"collection":"categories","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"name","sort":2,"group":null}	\N	\N
33	41	directus_fields	8	{"id":8,"collection":"categories","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"date_created","sort":3,"group":null}	\N	\N
34	42	directus_fields	9	{"id":9,"collection":"categories","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"date_updated","sort":4,"group":null}	\N	\N
35	43	directus_fields	10	{"id":10,"collection":"categories","field":"description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"description","sort":5,"group":null}	\N	\N
36	44	directus_fields	7	{"id":7,"collection":"categories","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"id","sort":1,"group":null}	\N	\N
37	45	directus_fields	11	{"id":11,"collection":"categories","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"name","sort":2,"group":null}	\N	\N
38	46	directus_fields	10	{"id":10,"collection":"categories","field":"description","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"description","sort":3,"group":null}	\N	\N
39	47	directus_fields	8	{"id":8,"collection":"categories","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"date_created","sort":4,"group":null}	\N	\N
40	48	directus_fields	9	{"id":9,"collection":"categories","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":5,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"categories","field":"date_updated","sort":5,"group":null}	\N	\N
41	49	directus_fields	12	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"suppliers"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"suppliers"}	\N	\N
42	50	directus_fields	13	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"suppliers"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"suppliers"}	\N	\N
43	51	directus_fields	14	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"suppliers"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"suppliers"}	\N	\N
44	52	directus_collections	suppliers	{"singleton":false,"collection":"suppliers"}	{"singleton":false,"collection":"suppliers"}	\N	\N
45	53	directus_fields	15	{"sort":4,"interface":"input","special":null,"required":true,"collection":"suppliers","field":"name"}	{"sort":4,"interface":"input","special":null,"required":true,"collection":"suppliers","field":"name"}	\N	\N
46	54	directus_fields	16	{"sort":5,"interface":"input","special":null,"collection":"suppliers","field":"email"}	{"sort":5,"interface":"input","special":null,"collection":"suppliers","field":"email"}	\N	\N
47	55	directus_fields	17	{"sort":6,"interface":"input","special":null,"required":false,"collection":"suppliers","field":"status"}	{"sort":6,"interface":"input","special":null,"required":false,"collection":"suppliers","field":"status"}	\N	\N
48	56	suppliers	1	{"name":"Supplier A","email":"a@supplier.com","status":"active"}	{"name":"Supplier A","email":"a@supplier.com","status":"active"}	\N	\N
49	57	suppliers	2	{"name":"Supplier B","email":"b@supplier.com","status":"active"}	{"name":"Supplier B","email":"b@supplier.com","status":"active"}	\N	\N
50	58	suppliers	3	{"name":"Supplier C","email":"c@supplier.com","status":"active"}	{"name":"Supplier C","email":"c@supplier.com","status":"active"}	\N	\N
51	59	suppliers	4	{"name":"Supplier D","email":"d@supplier.com","status":"active"}	{"name":"Supplier D","email":"d@supplier.com","status":"active"}	\N	\N
52	60	suppliers	5	{"name":"Supplier E","email":"e@supplier.com","status":"active"}	{"name":"Supplier E","email":"e@supplier.com","status":"active"}	\N	\N
53	61	suppliers	6	{"name":"Supplier F","email":"f@supplier.com","status":"active"}	{"name":"Supplier F","email":"f@supplier.com","status":"active"}	\N	\N
54	62	suppliers	7	{"name":"Supplier G","email":"g@supplier.com","status":"active"}	{"name":"Supplier G","email":"g@supplier.com","status":"active"}	\N	\N
55	63	suppliers	8	{"name":"Supplier H","email":"h@supplier.com","status":"active"}	{"name":"Supplier H","email":"h@supplier.com","status":"active"}	\N	\N
56	64	suppliers	9	{"name":"Supplier I","email":"i@supplier.com","status":"active"}	{"name":"Supplier I","email":"i@supplier.com","status":"active"}	\N	\N
57	65	suppliers	10	{"name":"Supplier J","email":"j@supplier.com","status":"active"}	{"name":"Supplier J","email":"j@supplier.com","status":"active"}	\N	\N
58	66	directus_fields	18	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"products"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"products"}	\N	\N
59	67	directus_fields	19	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"products"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"products"}	\N	\N
60	68	directus_fields	20	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"products"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"products"}	\N	\N
61	69	directus_collections	products	{"singleton":false,"collection":"products"}	{"singleton":false,"collection":"products"}	\N	\N
62	70	directus_fields	21	{"sort":4,"interface":"input","special":null,"required":true,"collection":"products","field":"name"}	{"sort":4,"interface":"input","special":null,"required":true,"collection":"products","field":"name"}	\N	\N
63	71	directus_fields	22	{"sort":5,"interface":"input","special":null,"required":true,"collection":"products","field":"price"}	{"sort":5,"interface":"input","special":null,"required":true,"collection":"products","field":"price"}	\N	\N
64	72	directus_fields	23	{"sort":6,"interface":"input","special":null,"required":true,"collection":"products","field":"status"}	{"sort":6,"interface":"input","special":null,"required":true,"collection":"products","field":"status"}	\N	\N
65	73	products	1	{"name":"Laptop","price":1200,"stock":10}	{"name":"Laptop","price":1200,"stock":10}	\N	\N
66	74	products	2	{"name":"Desktop","price":800,"stock":5}	{"name":"Desktop","price":800,"stock":5}	\N	\N
67	75	products	3	{"name":"Tablet","price":500,"stock":15}	{"name":"Tablet","price":500,"stock":15}	\N	\N
68	76	products	4	{"name":"Smartphone","price":300,"stock":20}	{"name":"Smartphone","price":300,"stock":20}	\N	\N
69	77	products	5	{"name":"Monitor","price":200,"stock":10}	{"name":"Monitor","price":200,"stock":10}	\N	\N
70	78	products	6	{"name":"Keyboard","price":50,"stock":50}	{"name":"Keyboard","price":50,"stock":50}	\N	\N
71	79	products	7	{"name":"Mouse","price":30,"stock":30}	{"name":"Mouse","price":30,"stock":30}	\N	\N
72	80	products	8	{"name":"Speaker","price":100,"stock":20}	{"name":"Speaker","price":100,"stock":20}	\N	\N
73	81	products	9	{"name":"Headphones","price":80,"stock":15}	{"name":"Headphones","price":80,"stock":15}	\N	\N
74	82	products	10	{"name":"Broken Product","price":-100,"stock":-5}	{"name":"Broken Product","price":-100,"stock":-5}	\N	\N
75	83	directus_fields	24	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"products","field":"category"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"products","field":"category"}	\N	\N
76	84	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-02T12:13:18.060Z","name":"Laptop","price":"1200.00000","status":"active","category":1}	{"category":1,"date_updated":"2026-01-02T12:13:18.060Z"}	\N	\N
77	85	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-02T12:13:37.398Z","name":"Desktop","price":"800.00000","status":"active","category":1}	{"category":1,"date_updated":"2026-01-02T12:13:37.398Z"}	\N	\N
78	86	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-02T12:13:47.032Z","name":"Desktop","price":"800.00000","status":"active","category":6}	{"category":6,"date_updated":"2026-01-02T12:13:47.032Z"}	\N	\N
79	87	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-02T12:14:08.585Z","name":"Tablet","price":"500.00000","status":"active","category":1}	{"category":1,"date_updated":"2026-01-02T12:14:08.585Z"}	\N	\N
80	88	products	9	{"id":9,"date_created":"2026-01-02T12:09:46.374Z","date_updated":"2026-01-02T12:14:15.588Z","name":"Headphones","price":"80.00000","status":"active","category":5}	{"category":5,"date_updated":"2026-01-02T12:14:15.588Z"}	\N	\N
81	89	directus_fields	25	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"required":false,"collection":"products","field":"suppliers"}	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"required":false,"collection":"products","field":"suppliers"}	\N	\N
82	91	directus_fields	26	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"products","field":"suppliers"}	{"sort":8,"interface":"select-dropdown-m2o","special":["m2o"],"collection":"products","field":"suppliers"}	\N	\N
83	92	products	7	{"id":7,"date_created":"2026-01-02T12:09:46.369Z","date_updated":"2026-01-02T12:16:54.189Z","name":"Mouse","price":"30.00000","status":"active","category":null,"suppliers":9}	{"suppliers":9,"date_updated":"2026-01-02T12:16:54.189Z"}	\N	\N
84	93	products	4	{"id":4,"date_created":"2026-01-02T12:09:46.364Z","date_updated":"2026-01-02T12:17:20.075Z","name":"Smartphone","price":"300.00000","status":"active","category":2,"suppliers":6}	{"category":2,"suppliers":6,"date_updated":"2026-01-02T12:17:20.075Z"}	\N	\N
85	94	products	6	{"id":6,"date_created":"2026-01-02T12:09:46.368Z","date_updated":"2026-01-02T12:17:27.126Z","name":"Keyboard","price":"50.00000","status":"active","category":8,"suppliers":9}	{"category":8,"suppliers":9,"date_updated":"2026-01-02T12:17:27.126Z"}	\N	\N
86	99	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:36:15.236Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null}	{"price":29.99,"date_updated":"2026-01-03T09:36:15.236Z"}	\N	\N
87	101	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:50:45.110Z","name":"Laptop","price":"1200.00000","status":"active","category":1,"suppliers":null}	{"price":1200,"status":"active","date_updated":"2026-01-03T09:50:45.110Z"}	\N	\N
88	102	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:50:45.121Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:50:45.121Z"}	\N	\N
89	103	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:50:58.855Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:50:58.855Z"}	\N	\N
90	104	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:51:15.580Z","name":"Laptop","price":"1200.00000","status":"active","category":1,"suppliers":null}	{"price":1200,"status":"active","date_updated":"2026-01-03T09:51:15.580Z"}	\N	\N
91	105	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:51:15.587Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:51:15.587Z"}	\N	\N
92	106	directus_fields	27	{"sort":9,"interface":"input","special":null,"required":true,"collection":"products","field":"stock"}	{"sort":9,"interface":"input","special":null,"required":true,"collection":"products","field":"stock"}	\N	\N
93	107	directus_fields	18	{"id":18,"collection":"products","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
94	108	directus_fields	19	{"id":19,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"date_created","sort":2,"group":null}	\N	\N
95	109	directus_fields	20	{"id":20,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"date_updated","sort":3,"group":null}	\N	\N
96	110	directus_fields	21	{"id":21,"collection":"products","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"name","sort":4,"group":null}	\N	\N
97	111	directus_fields	22	{"id":22,"collection":"products","field":"price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"price","sort":5,"group":null}	\N	\N
98	112	directus_fields	23	{"id":23,"collection":"products","field":"status","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"status","sort":6,"group":null}	\N	\N
99	113	directus_fields	27	{"id":27,"collection":"products","field":"stock","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"stock","sort":7,"group":null}	\N	\N
100	114	directus_fields	24	{"id":24,"collection":"products","field":"category","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"category","sort":8,"group":null}	\N	\N
101	115	directus_fields	26	{"id":26,"collection":"products","field":"suppliers","special":["m2o"],"interface":"select-dropdown-m2o","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"suppliers","sort":9,"group":null}	\N	\N
102	116	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:52:42.899Z","name":"Laptop","price":"1200.00000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":1200,"status":"active","stock":0,"date_updated":"2026-01-03T09:52:42.899Z"}	\N	\N
103	117	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:52:42.905Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:52:42.905Z"}	\N	\N
104	118	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:52:50.410Z","name":"Laptop","price":"1200.00000","status":"active","category":1,"suppliers":null,"stock":1}	{"price":1200,"status":"active","stock":1,"date_updated":"2026-01-03T09:52:50.410Z"}	\N	\N
105	119	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:52:50.416Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:52:50.416Z"}	\N	\N
106	120	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:52:51.858Z","name":"Laptop","price":"1200.00000","status":"active","category":1,"suppliers":null,"stock":1}	{"price":1200,"status":"active","stock":1,"date_updated":"2026-01-03T09:52:51.858Z"}	\N	\N
107	121	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:52:51.863Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:52:51.863Z"}	\N	\N
108	122	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:53:24.193Z","name":"Laptop","price":"1200.00000","status":"inactive","category":1,"suppliers":null,"stock":1}	{"price":1200,"status":"inactive","stock":1,"date_updated":"2026-01-03T09:53:24.193Z"}	\N	\N
109	123	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:53:24.203Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:53:24.203Z"}	\N	\N
110	124	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:53:30.605Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:53:30.605Z"}	\N	\N
111	125	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T09:53:35.244Z","name":"Laptop","price":"1200.00000","status":"active","category":1,"suppliers":null,"stock":1}	{"price":1200,"status":"active","stock":1,"date_updated":"2026-01-03T09:53:35.244Z"}	\N	\N
112	126	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T09:53:35.252Z","name":"Updated Product Name","price":"800.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":800,"date_updated":"2026-01-03T09:53:35.252Z"}	\N	\N
113	129	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:28.087Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:28.087Z"}	\N	\N
114	130	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:28.098Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:15:28.098Z"}	\N	\N
115	131	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:40.850Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:40.850Z"}	\N	\N
116	132	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:40.858Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:15:40.858Z"}	\N	\N
117	133	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:41.893Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:41.893Z"}	\N	\N
118	134	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:41.901Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:15:41.901Z"}	\N	\N
119	135	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:42.643Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:42.643Z"}	\N	\N
120	136	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:42.650Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:15:42.650Z"}	\N	\N
121	137	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:43.622Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:43.622Z"}	\N	\N
122	138	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:43.627Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:15:43.627Z"}	\N	\N
123	139	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:56.825Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:56.825Z"}	\N	\N
124	140	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:56.830Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","date_updated":"2026-01-03T13:15:56.830Z"}	\N	\N
125	141	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:57.801Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:57.801Z"}	\N	\N
126	142	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:57.806Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","date_updated":"2026-01-03T13:15:57.806Z"}	\N	\N
127	143	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:58.711Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:58.711Z"}	\N	\N
128	144	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:58.718Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","date_updated":"2026-01-03T13:15:58.718Z"}	\N	\N
129	145	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:15:59.958Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:15:59.958Z"}	\N	\N
130	146	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:15:59.964Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","date_updated":"2026-01-03T13:15:59.964Z"}	\N	\N
131	147	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:16:00.699Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:16:00.699Z"}	\N	\N
190	211	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-03T14:46:53.809Z","name":null,"price":"49.99000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":49.99,"date_updated":"2026-01-03T14:46:53.809Z"}	\N	\N
132	148	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:00.706Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","date_updated":"2026-01-03T13:16:00.706Z"}	\N	\N
133	149	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:16:10.558Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"stock":100,"date_updated":"2026-01-03T13:16:10.558Z"}	\N	\N
134	150	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:10.572Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:16:10.572Z"}	\N	\N
135	151	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:16:11.615Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"stock":100,"date_updated":"2026-01-03T13:16:11.615Z"}	\N	\N
136	152	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:11.621Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:16:11.621Z"}	\N	\N
137	153	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:16:15.070Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"stock":100,"date_updated":"2026-01-03T13:16:15.070Z"}	\N	\N
138	154	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:15.075Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:16:15.075Z"}	\N	\N
139	155	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:16:15.869Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"stock":100,"date_updated":"2026-01-03T13:16:15.869Z"}	\N	\N
140	156	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:15.874Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:16:15.874Z"}	\N	\N
141	157	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:16:18.901Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"stock":100,"date_updated":"2026-01-03T13:16:18.901Z"}	\N	\N
142	158	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:18.908Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:16:18.908Z"}	\N	\N
143	159	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:16:57.330Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Product Name","price":49.99,"date_updated":"2026-01-03T13:16:57.330Z"}	\N	\N
144	160	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:23:21.615Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:23:21.615Z"}	\N	\N
145	161	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:29:36.829Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:29:36.829Z"}	\N	\N
146	162	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:29:39.008Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:29:39.008Z"}	\N	\N
147	164	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:30:18.653Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:30:18.653Z"}	\N	\N
148	165	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:30:24.913Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:30:24.913Z"}	\N	\N
149	166	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:30:25.666Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:30:25.666Z"}	\N	\N
150	167	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:30:59.543Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:30:59.543Z"}	\N	\N
151	168	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:31:00.624Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:31:00.624Z"}	\N	\N
152	169	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:31:57.539Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:31:57.539Z"}	\N	\N
153	170	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:32:10.479Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:32:10.479Z"}	\N	\N
154	172	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:46:38.540Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:46:38.540Z"}	\N	\N
155	173	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:47:15.877Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:47:15.877Z"}	\N	\N
156	174	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:47:15.884Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":49.99,"date_updated":"2026-01-03T13:47:15.884Z"}	\N	\N
157	175	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:47:32.131Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:47:32.131Z"}	\N	\N
158	176	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:47:32.141Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":49.99,"date_updated":"2026-01-03T13:47:32.141Z"}	\N	\N
159	177	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:47:40.112Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:47:40.112Z"}	\N	\N
160	178	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:47:40.117Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":49.99,"date_updated":"2026-01-03T13:47:40.117Z"}	\N	\N
161	179	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:47:50.114Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:47:50.114Z"}	\N	\N
162	180	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:47:50.128Z","name":"Updated Product Name","price":"49.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":49.99,"date_updated":"2026-01-03T13:47:50.128Z"}	\N	\N
163	181	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-03T13:47:50.138Z","name":"Tablet","price":"19.99000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":19.99,"date_updated":"2026-01-03T13:47:50.138Z"}	\N	\N
164	182	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:47:58.891Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:47:58.891Z"}	\N	\N
165	183	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-03T13:47:58.899Z","name":"Tablet","price":"19.99000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":19.99,"date_updated":"2026-01-03T13:47:58.899Z"}	\N	\N
166	184	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T13:49:42.495Z","name":"Laptop","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T13:49:42.495Z"}	\N	\N
167	185	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T13:49:42.506Z","name":"Updated Product Name","price":"29.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":29.99,"date_updated":"2026-01-03T13:49:42.506Z"}	\N	\N
168	186	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-03T13:49:42.517Z","name":"Tablet","price":"19.99000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":19.99,"date_updated":"2026-01-03T13:49:42.517Z"}	\N	\N
169	187	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T14:01:12.542Z","name":"a","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"name":"a","date_updated":"2026-01-03T14:01:12.542Z"}	\N	\N
170	188	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T14:01:12.542Z","name":"a","price":"29.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"a","date_updated":"2026-01-03T14:01:12.542Z"}	\N	\N
171	189	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-03T14:01:12.542Z","name":"a","price":"19.99000","status":"active","category":1,"suppliers":null,"stock":0}	{"name":"a","date_updated":"2026-01-03T14:01:12.542Z"}	\N	\N
172	190	products	4	{"id":4,"date_created":"2026-01-02T12:09:46.364Z","date_updated":"2026-01-03T14:01:12.542Z","name":"a","price":"300.00000","status":"active","category":2,"suppliers":6,"stock":0}	{"name":"a","date_updated":"2026-01-03T14:01:12.542Z"}	\N	\N
173	191	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T14:01:29.854Z","name":null,"price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"name":null,"date_updated":"2026-01-03T14:01:29.854Z"}	\N	\N
174	192	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T14:01:29.854Z","name":null,"price":"29.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":null,"date_updated":"2026-01-03T14:01:29.854Z"}	\N	\N
175	193	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-03T14:01:29.854Z","name":null,"price":"19.99000","status":"active","category":1,"suppliers":null,"stock":0}	{"name":null,"date_updated":"2026-01-03T14:01:29.854Z"}	\N	\N
176	194	products	4	{"id":4,"date_created":"2026-01-02T12:09:46.364Z","date_updated":"2026-01-03T14:01:29.854Z","name":null,"price":"300.00000","status":"active","category":2,"suppliers":6,"stock":0}	{"name":null,"date_updated":"2026-01-03T14:01:29.854Z"}	\N	\N
177	196	products	11	{"name":"Laptop","price":1200,"stock":10}	{"name":"Laptop","price":1200,"stock":10}	\N	\N
178	197	products	12	{"name":"Desktop","price":800,"stock":5}	{"name":"Desktop","price":800,"stock":5}	\N	\N
179	198	products	13	{"name":"Tablet","price":500,"stock":15}	{"name":"Tablet","price":500,"stock":15}	\N	\N
180	199	products	14	{"name":"Smartphone","price":300,"stock":20}	{"name":"Smartphone","price":300,"stock":20}	\N	\N
181	200	products	15	{"name":"Monitor","price":200,"stock":10}	{"name":"Monitor","price":200,"stock":10}	\N	\N
182	201	products	16	{"name":"Keyboard","price":50,"stock":50}	{"name":"Keyboard","price":50,"stock":50}	\N	\N
183	202	products	17	{"name":"Mouse","price":30,"stock":30}	{"name":"Mouse","price":30,"stock":30}	\N	\N
184	203	products	18	{"name":"Speaker","price":100,"stock":20}	{"name":"Speaker","price":100,"stock":20}	\N	\N
185	204	products	19	{"name":"Headphones","price":80,"stock":15}	{"name":"Headphones","price":80,"stock":15}	\N	\N
186	205	products	20	{"name":"Broken Product","price":-100,"stock":-5}	{"name":"Broken Product","price":-100,"stock":-5}	\N	\N
187	206	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T14:36:22.744Z","name":"1","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"name":"1","date_updated":"2026-01-03T14:36:22.744Z"}	\N	\N
188	209	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T14:46:53.786Z","name":"1","price":"29.99000","status":"active","category":1,"suppliers":null,"stock":100}	{"price":29.99,"date_updated":"2026-01-03T14:46:53.786Z"}	\N	\N
189	210	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T14:46:53.800Z","name":null,"price":"39.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":39.99,"date_updated":"2026-01-03T14:46:53.800Z"}	\N	\N
191	212	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-03T14:47:09.000Z","name":"1","price":"1000.00000","status":"active","category":1,"suppliers":null,"stock":20}	{"price":1000,"stock":20,"date_updated":"2026-01-03T14:47:09.000Z"}	\N	\N
192	213	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-03T14:47:09.008Z","name":"Updated Name","price":"39.99000","status":"active","category":6,"suppliers":null,"stock":0}	{"name":"Updated Name","date_updated":"2026-01-03T14:47:09.008Z"}	\N	\N
193	215	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-05T12:29:08.356Z","name":"1","price":"299.00000","status":"active","category":1,"suppliers":null,"stock":20}	{"price":299,"date_updated":"2026-01-05T12:29:08.356Z"}	\N	\N
194	216	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-05T12:29:08.371Z","name":"Updated Name","price":"299.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.371Z"}	\N	\N
195	217	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-05T12:29:08.376Z","name":null,"price":"299.00000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.376Z"}	\N	\N
196	218	products	4	{"id":4,"date_created":"2026-01-02T12:09:46.364Z","date_updated":"2026-01-05T12:29:08.382Z","name":null,"price":"299.00000","status":"active","category":2,"suppliers":6,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.382Z"}	\N	\N
197	219	products	5	{"id":5,"date_created":"2026-01-02T12:09:46.365Z","date_updated":"2026-01-05T12:29:08.388Z","name":"Monitor","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.388Z"}	\N	\N
198	220	products	6	{"id":6,"date_created":"2026-01-02T12:09:46.368Z","date_updated":"2026-01-05T12:29:08.392Z","name":"Keyboard","price":"299.00000","status":"active","category":8,"suppliers":9,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.392Z"}	\N	\N
199	221	products	7	{"id":7,"date_created":"2026-01-02T12:09:46.369Z","date_updated":"2026-01-05T12:29:08.397Z","name":"Mouse","price":"299.00000","status":"active","category":null,"suppliers":9,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.397Z"}	\N	\N
200	222	products	8	{"id":8,"date_created":"2026-01-02T12:09:46.371Z","date_updated":"2026-01-05T12:29:08.402Z","name":"Speaker","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.402Z"}	\N	\N
201	223	products	10	{"id":10,"date_created":"2026-01-02T12:09:46.375Z","date_updated":"2026-01-05T12:29:08.407Z","name":"Broken Product","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:29:08.407Z"}	\N	\N
202	224	products	11	{"id":11,"date_created":"2026-01-03T14:15:46.505Z","date_updated":"2026-01-05T12:29:08.412Z","name":"Laptop","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":10}	{"price":299,"date_updated":"2026-01-05T12:29:08.412Z"}	\N	\N
203	225	products	12	{"id":12,"date_created":"2026-01-03T14:15:46.510Z","date_updated":"2026-01-05T12:29:08.416Z","name":"Desktop","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":5}	{"price":299,"date_updated":"2026-01-05T12:29:08.416Z"}	\N	\N
204	226	products	13	{"id":13,"date_created":"2026-01-03T14:15:46.511Z","date_updated":"2026-01-05T12:29:08.421Z","name":"Tablet","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":15}	{"price":299,"date_updated":"2026-01-05T12:29:08.421Z"}	\N	\N
205	227	products	14	{"id":14,"date_created":"2026-01-03T14:15:46.515Z","date_updated":"2026-01-05T12:29:08.425Z","name":"Smartphone","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":20}	{"price":299,"date_updated":"2026-01-05T12:29:08.425Z"}	\N	\N
206	228	products	15	{"id":15,"date_created":"2026-01-03T14:15:46.517Z","date_updated":"2026-01-05T12:29:08.429Z","name":"Monitor","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":10}	{"price":299,"date_updated":"2026-01-05T12:29:08.429Z"}	\N	\N
207	229	products	16	{"id":16,"date_created":"2026-01-03T14:15:46.519Z","date_updated":"2026-01-05T12:29:08.433Z","name":"Keyboard","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":50}	{"price":299,"date_updated":"2026-01-05T12:29:08.433Z"}	\N	\N
208	230	products	17	{"id":17,"date_created":"2026-01-03T14:15:46.521Z","date_updated":"2026-01-05T12:29:08.437Z","name":"Mouse","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":30}	{"price":299,"date_updated":"2026-01-05T12:29:08.437Z"}	\N	\N
209	231	products	18	{"id":18,"date_created":"2026-01-03T14:15:46.522Z","date_updated":"2026-01-05T12:29:08.441Z","name":"Speaker","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":20}	{"price":299,"date_updated":"2026-01-05T12:29:08.441Z"}	\N	\N
210	232	products	19	{"id":19,"date_created":"2026-01-03T14:15:47.517Z","date_updated":"2026-01-05T12:29:08.446Z","name":"Headphones","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":15}	{"price":299,"date_updated":"2026-01-05T12:29:08.446Z"}	\N	\N
211	233	products	20	{"id":20,"date_created":"2026-01-03T14:15:47.518Z","date_updated":"2026-01-05T12:29:08.450Z","name":"Broken Product","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":-5}	{"price":299,"date_updated":"2026-01-05T12:29:08.450Z"}	\N	\N
212	237	products	1	{"id":1,"date_created":"2026-01-02T12:09:46.357Z","date_updated":"2026-01-05T12:36:33.955Z","name":"1","price":"299.00000","status":"active","category":1,"suppliers":null,"stock":20}	{"price":299,"date_updated":"2026-01-05T12:36:33.955Z"}	\N	\N
213	238	products	2	{"id":2,"date_created":"2026-01-02T12:09:46.360Z","date_updated":"2026-01-05T12:36:33.967Z","name":"Updated Name","price":"299.00000","status":"active","category":6,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.967Z"}	\N	\N
214	239	products	3	{"id":3,"date_created":"2026-01-02T12:09:46.362Z","date_updated":"2026-01-05T12:36:33.972Z","name":null,"price":"299.00000","status":"active","category":1,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.972Z"}	\N	\N
215	240	products	4	{"id":4,"date_created":"2026-01-02T12:09:46.364Z","date_updated":"2026-01-05T12:36:33.978Z","name":null,"price":"299.00000","status":"active","category":2,"suppliers":6,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.978Z"}	\N	\N
216	241	products	5	{"id":5,"date_created":"2026-01-02T12:09:46.365Z","date_updated":"2026-01-05T12:36:33.984Z","name":"Monitor","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.984Z"}	\N	\N
217	242	products	6	{"id":6,"date_created":"2026-01-02T12:09:46.368Z","date_updated":"2026-01-05T12:36:33.988Z","name":"Keyboard","price":"299.00000","status":"active","category":8,"suppliers":9,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.988Z"}	\N	\N
218	243	products	7	{"id":7,"date_created":"2026-01-02T12:09:46.369Z","date_updated":"2026-01-05T12:36:33.993Z","name":"Mouse","price":"299.00000","status":"active","category":null,"suppliers":9,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.993Z"}	\N	\N
219	244	products	8	{"id":8,"date_created":"2026-01-02T12:09:46.371Z","date_updated":"2026-01-05T12:36:33.998Z","name":"Speaker","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:33.998Z"}	\N	\N
220	245	products	10	{"id":10,"date_created":"2026-01-02T12:09:46.375Z","date_updated":"2026-01-05T12:36:34.003Z","name":"Broken Product","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":0}	{"price":299,"date_updated":"2026-01-05T12:36:34.003Z"}	\N	\N
221	246	products	11	{"id":11,"date_created":"2026-01-03T14:15:46.505Z","date_updated":"2026-01-05T12:36:34.008Z","name":"Laptop","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":10}	{"price":299,"date_updated":"2026-01-05T12:36:34.008Z"}	\N	\N
222	247	products	12	{"id":12,"date_created":"2026-01-03T14:15:46.510Z","date_updated":"2026-01-05T12:36:34.013Z","name":"Desktop","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":5}	{"price":299,"date_updated":"2026-01-05T12:36:34.013Z"}	\N	\N
223	248	products	13	{"id":13,"date_created":"2026-01-03T14:15:46.511Z","date_updated":"2026-01-05T12:36:34.017Z","name":"Tablet","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":15}	{"price":299,"date_updated":"2026-01-05T12:36:34.017Z"}	\N	\N
224	249	products	14	{"id":14,"date_created":"2026-01-03T14:15:46.515Z","date_updated":"2026-01-05T12:36:34.021Z","name":"Smartphone","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":20}	{"price":299,"date_updated":"2026-01-05T12:36:34.021Z"}	\N	\N
225	250	products	15	{"id":15,"date_created":"2026-01-03T14:15:46.517Z","date_updated":"2026-01-05T12:36:34.026Z","name":"Monitor","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":10}	{"price":299,"date_updated":"2026-01-05T12:36:34.026Z"}	\N	\N
226	251	products	16	{"id":16,"date_created":"2026-01-03T14:15:46.519Z","date_updated":"2026-01-05T12:36:34.030Z","name":"Keyboard","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":50}	{"price":299,"date_updated":"2026-01-05T12:36:34.030Z"}	\N	\N
227	252	products	17	{"id":17,"date_created":"2026-01-03T14:15:46.521Z","date_updated":"2026-01-05T12:36:34.035Z","name":"Mouse","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":30}	{"price":299,"date_updated":"2026-01-05T12:36:34.035Z"}	\N	\N
228	253	products	18	{"id":18,"date_created":"2026-01-03T14:15:46.522Z","date_updated":"2026-01-05T12:36:34.039Z","name":"Speaker","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":20}	{"price":299,"date_updated":"2026-01-05T12:36:34.039Z"}	\N	\N
229	254	products	19	{"id":19,"date_created":"2026-01-03T14:15:47.517Z","date_updated":"2026-01-05T12:36:34.045Z","name":"Headphones","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":15}	{"price":299,"date_updated":"2026-01-05T12:36:34.045Z"}	\N	\N
230	255	products	20	{"id":20,"date_created":"2026-01-03T14:15:47.518Z","date_updated":"2026-01-05T12:36:34.049Z","name":"Broken Product","price":"299.00000","status":"active","category":null,"suppliers":null,"stock":-5}	{"price":299,"date_updated":"2026-01-05T12:36:34.049Z"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
c4279ea7-e10e-424e-a4e2-d7ed4163e0bf	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
BMyaH0oGlzAmqkDIwjPPp3V88h21dHppLs73t2jRHy4uKpIOVU-LmCkdD8X4nUGc	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-09 12:20:00.775+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
wKDztdE0Yxxvw0aQCA3r6dhPvBZltsFI9WfE6nK6a6Io7QLfuJydyRgR7mQRALFd	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 08:12:19.174+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
RzNVOCZ4PvrblKNfWcSCJVYlN1heflmZlhOct_tFYreLfrwx1HB6-QX_askJ0uge	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 09:34:25.643+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
cVcvh7wA_K8p2D5qaaSp6f_vPHxOTcwZeF4c1WcptdiVR2dlV-qpSCFoaqQ2-zXo	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 09:35:37.045+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
uDjTmZrPRRoHZrbR7ZHC9PPLDF6UJ11TMVqy78fFe3jN7Vko0IbXbeBVckEjyLYo	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 09:44:45.149+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
OLYbnRDr2RRgCJiRni4g0S5GUz5JxkONBB3pW82GdryVqyKuLzAHI_RGtT0nlPKV	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-12 12:19:15.726+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
YT7R18Hw_mYcAcnaaONDJM27laOog_VapumfX_7O9BisFmOT1Ga94S2SB5tM87ha	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 12:43:58.057+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
y-63FTU_ivDw8hjSXiKKNXXuDKC0XJljN5UA4mokJGKBbX8RUg3egCrWLlK05XtM	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 13:14:57.519+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
vTKJ9t9zHXSEbKmWzLKBG6cUVMXmZ8twLhBPvZDhuLpwP41GR5mM5K4xZh6-Mhn1	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 13:30:06.603+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
WZ-RPphmry5hquxRuEAQwLDl8xqUUsmzBcqf0lRHykypoxQZc3TrAndrtLlo_ZG0	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 13:42:14.442+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
0fom8biD_5Ywa2fPnD1__N79RRPpEpDPkR5PG544cs-duU0XhBU3JYGv-6mGyEaL	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 14:01:44.163+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
7o_ukk6D-iHMnxOFDs8KwH6R7KJrJLaciapeMFEef2nNm69kyTVMZ8SvDZFsRRat	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-06 12:29:58.248+00	172.18.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
3jZt9f6LZ7XmyaDsj_6us6Q4P5wnTqTjrqF8zdHlNYev6ki37WC8bQA1Xb-eXBDU	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-12 12:32:16.52+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
v_RC4S8t16-hPlIKBxNDwnENsIpDSWPBEoWlUidB4WeWlfBlrM5rQOPqibyctLE_	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-12 12:36:18.532+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
djZUD3Y9s34Y7eYxWITCLb4xX-vVcce_YBPqkGcxO_HyPHAvRS-jGLUhjM0bLbHS	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 14:44:27.282+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
m3_4yLj8Fu9Mv_U3e3r2RPWMU9qYFAXr7-YwcYckCYdodc4fJPc5ylqnUSpoXJI6	0a6d638d-bfab-4807-9eda-f66b2f263a04	2026-01-10 14:46:44.771+00	172.18.0.1	PostmanRuntime/7.51.0	\N	\N	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt, project_owner, project_usage, org_name, product_updates, project_status, ai_openai_api_key, ai_anthropic_api_key, ai_system_prompt) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	019b7e5e-4add-706c-9e28-b897eccff960	f	f	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
0a6d638d-bfab-4807-9eda-f66b2f263a04	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$q/Qzuy6pJlB9X+LitWGHdg$jmnvzulcjG9394L6f2ZSAwdzrMRPj7bgbgzvVqV6OIo	\N	\N	\N	\N	\N	\N	\N	active	c4279ea7-e10e-424e-a4e2-d7ed4163e0bf	\N	2026-01-05 12:36:18.544+00	/settings/extensions	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, date_created, date_updated, name, price, status, category, suppliers, stock) FROM stdin;
1	2026-01-02 12:09:46.357+00	2026-01-05 12:36:33.955+00	1	299.00000	active	1	\N	20
2	2026-01-02 12:09:46.36+00	2026-01-05 12:36:33.967+00	Updated Name	299.00000	active	6	\N	0
3	2026-01-02 12:09:46.362+00	2026-01-05 12:36:33.972+00	\N	299.00000	active	1	\N	0
4	2026-01-02 12:09:46.364+00	2026-01-05 12:36:33.978+00	\N	299.00000	active	2	6	0
5	2026-01-02 12:09:46.365+00	2026-01-05 12:36:33.984+00	Monitor	299.00000	active	\N	\N	0
6	2026-01-02 12:09:46.368+00	2026-01-05 12:36:33.988+00	Keyboard	299.00000	active	8	9	0
7	2026-01-02 12:09:46.369+00	2026-01-05 12:36:33.993+00	Mouse	299.00000	active	\N	9	0
8	2026-01-02 12:09:46.371+00	2026-01-05 12:36:33.998+00	Speaker	299.00000	active	\N	\N	0
10	2026-01-02 12:09:46.375+00	2026-01-05 12:36:34.003+00	Broken Product	299.00000	active	\N	\N	0
11	2026-01-03 14:15:46.505+00	2026-01-05 12:36:34.008+00	Laptop	299.00000	active	\N	\N	10
12	2026-01-03 14:15:46.51+00	2026-01-05 12:36:34.013+00	Desktop	299.00000	active	\N	\N	5
13	2026-01-03 14:15:46.511+00	2026-01-05 12:36:34.017+00	Tablet	299.00000	active	\N	\N	15
14	2026-01-03 14:15:46.515+00	2026-01-05 12:36:34.021+00	Smartphone	299.00000	active	\N	\N	20
15	2026-01-03 14:15:46.517+00	2026-01-05 12:36:34.026+00	Monitor	299.00000	active	\N	\N	10
16	2026-01-03 14:15:46.519+00	2026-01-05 12:36:34.03+00	Keyboard	299.00000	active	\N	\N	50
17	2026-01-03 14:15:46.521+00	2026-01-05 12:36:34.035+00	Mouse	299.00000	active	\N	\N	30
18	2026-01-03 14:15:46.522+00	2026-01-05 12:36:34.039+00	Speaker	299.00000	active	\N	\N	20
19	2026-01-03 14:15:47.517+00	2026-01-05 12:36:34.045+00	Headphones	299.00000	active	\N	\N	15
20	2026-01-03 14:15:47.518+00	2026-01-05 12:36:34.049+00	Broken Product	299.00000	active	\N	\N	-5
9	2026-01-02 12:09:46.374+00	2026-01-02 12:14:15.588+00	Headphones	80.00000	inactive	5	\N	0
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, date_created, date_updated, name, email, status) FROM stdin;
1	2026-01-02 12:07:22.766+00	\N	Supplier A	a@supplier.com	active
2	2026-01-02 12:07:22.768+00	\N	Supplier B	b@supplier.com	active
3	2026-01-02 12:07:22.77+00	\N	Supplier C	c@supplier.com	active
4	2026-01-02 12:07:22.772+00	\N	Supplier D	d@supplier.com	active
5	2026-01-02 12:07:22.774+00	\N	Supplier E	e@supplier.com	active
6	2026-01-02 12:07:22.775+00	\N	Supplier F	f@supplier.com	active
7	2026-01-02 12:07:22.777+00	\N	Supplier G	g@supplier.com	active
8	2026-01-02 12:07:22.778+00	\N	Supplier H	h@supplier.com	active
9	2026-01-02 12:07:22.779+00	\N	Supplier I	i@supplier.com	active
10	2026-01-02 12:07:22.781+00	\N	Supplier J	j@supplier.com	active
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 10, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 255, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 27, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 4, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 3, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 230, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 20, true);


--
-- Name: suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_id_seq', 10, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: directus_activity_timestamp_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX directus_activity_timestamp_index ON public.directus_activity USING btree ("timestamp");


--
-- Name: directus_revisions_parent_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX directus_revisions_parent_index ON public.directus_revisions USING btree (parent);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: products products_category_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_foreign FOREIGN KEY (category) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: products products_suppliers_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_suppliers_foreign FOREIGN KEY (suppliers) REFERENCES public.suppliers(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict SYvgGXGCarzlbtWiGIXRxygvrhXcis9nbu4LKFdC5FfOQ04GCutTdpTkddmjlMb

