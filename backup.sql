--
-- PostgreSQL database dump
--

-- Dumped from database version 11.16 (Debian 11.16-1.pgdg90+1)
-- Dumped by pg_dump version 11.16 (Debian 11.16-1.pgdg90+1)

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

SET default_with_oids = false;

--
-- Name: analytics; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.analytics (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.analytics OWNER TO wiki;

--
-- Name: apiKeys; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."apiKeys" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key text NOT NULL,
    expiration character varying(255) NOT NULL,
    "isRevoked" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public."apiKeys" OWNER TO wiki;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."apiKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."apiKeys_id_seq" OWNER TO wiki;

--
-- Name: apiKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."apiKeys_id_seq" OWNED BY public."apiKeys".id;


--
-- Name: assetData; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."assetData" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."assetData" OWNER TO wiki;

--
-- Name: assetFolders; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."assetFolders" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    "parentId" integer
);


ALTER TABLE public."assetFolders" OWNER TO wiki;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."assetFolders_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."assetFolders_id_seq" OWNER TO wiki;

--
-- Name: assetFolders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."assetFolders_id_seq" OWNED BY public."assetFolders".id;


--
-- Name: assets; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.assets (
    id integer NOT NULL,
    filename character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    ext character varying(255) NOT NULL,
    kind text DEFAULT 'binary'::text NOT NULL,
    mime character varying(255) DEFAULT 'application/octet-stream'::character varying NOT NULL,
    "fileSize" integer,
    metadata json,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "folderId" integer,
    "authorId" integer,
    CONSTRAINT assets_kind_check CHECK ((kind = ANY (ARRAY['binary'::text, 'image'::text])))
);


ALTER TABLE public.assets OWNER TO wiki;

--
-- Name: COLUMN assets."fileSize"; Type: COMMENT; Schema: public; Owner: wiki
--

COMMENT ON COLUMN public.assets."fileSize" IS 'In kilobytes';


--
-- Name: assets_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.assets_id_seq OWNER TO wiki;

--
-- Name: assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.assets_id_seq OWNED BY public.assets.id;


--
-- Name: authentication; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.authentication (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL,
    "selfRegistration" boolean DEFAULT false NOT NULL,
    "domainWhitelist" json NOT NULL,
    "autoEnrollGroups" json NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "strategyKey" character varying(255) DEFAULT ''::character varying NOT NULL,
    "displayName" character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.authentication OWNER TO wiki;

--
-- Name: brute; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.brute (
    key character varying(255),
    "firstRequest" bigint,
    "lastRequest" bigint,
    lifetime bigint,
    count integer
);


ALTER TABLE public.brute OWNER TO wiki;

--
-- Name: commentProviders; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."commentProviders" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public."commentProviders" OWNER TO wiki;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    content text NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "pageId" integer,
    "authorId" integer,
    render text DEFAULT ''::text NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    ip character varying(255) DEFAULT ''::character varying NOT NULL,
    "replyTo" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.comments OWNER TO wiki;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO wiki;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: editors; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.editors (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json NOT NULL
);


ALTER TABLE public.editors OWNER TO wiki;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    permissions json NOT NULL,
    "pageRules" json NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "redirectOnLogin" character varying(255) DEFAULT '/'::character varying NOT NULL
);


ALTER TABLE public.groups OWNER TO wiki;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO wiki;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;


--
-- Name: locales; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.locales (
    code character varying(5) NOT NULL,
    strings json,
    "isRTL" boolean DEFAULT false NOT NULL,
    name character varying(255) NOT NULL,
    "nativeName" character varying(255) NOT NULL,
    availability integer DEFAULT 0 NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.locales OWNER TO wiki;

--
-- Name: loggers; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.loggers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    level character varying(255) DEFAULT 'warn'::character varying NOT NULL,
    config json
);


ALTER TABLE public.loggers OWNER TO wiki;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.migrations OWNER TO wiki;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO wiki;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.migrations_lock OWNER TO wiki;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_lock_index_seq OWNER TO wiki;

--
-- Name: migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.migrations_lock_index_seq OWNED BY public.migrations_lock.index;


--
-- Name: navigation; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.navigation (
    key character varying(255) NOT NULL,
    config json
);


ALTER TABLE public.navigation OWNER TO wiki;

--
-- Name: pageHistory; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."pageHistory" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    action character varying(255) DEFAULT 'updated'::character varying,
    "pageId" integer,
    content text,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "versionDate" character varying(255) DEFAULT ''::character varying NOT NULL,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public."pageHistory" OWNER TO wiki;

--
-- Name: pageHistoryTags; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."pageHistoryTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageHistoryTags" OWNER TO wiki;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."pageHistoryTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistoryTags_id_seq" OWNER TO wiki;

--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."pageHistoryTags_id_seq" OWNED BY public."pageHistoryTags".id;


--
-- Name: pageHistory_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."pageHistory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageHistory_id_seq" OWNER TO wiki;

--
-- Name: pageHistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."pageHistory_id_seq" OWNED BY public."pageHistory".id;


--
-- Name: pageLinks; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."pageLinks" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    "localeCode" character varying(5) NOT NULL,
    "pageId" integer
);


ALTER TABLE public."pageLinks" OWNER TO wiki;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."pageLinks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageLinks_id_seq" OWNER TO wiki;

--
-- Name: pageLinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."pageLinks_id_seq" OWNED BY public."pageLinks".id;


--
-- Name: pageTags; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."pageTags" (
    id integer NOT NULL,
    "pageId" integer,
    "tagId" integer
);


ALTER TABLE public."pageTags" OWNER TO wiki;

--
-- Name: pageTags_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."pageTags_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."pageTags_id_seq" OWNER TO wiki;

--
-- Name: pageTags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."pageTags_id_seq" OWNED BY public."pageTags".id;


--
-- Name: pageTree; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."pageTree" (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    title character varying(255) NOT NULL,
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isFolder" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    parent integer,
    "pageId" integer,
    "localeCode" character varying(5),
    ancestors json
);


ALTER TABLE public."pageTree" OWNER TO wiki;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    hash character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    "isPrivate" boolean DEFAULT false NOT NULL,
    "isPublished" boolean DEFAULT false NOT NULL,
    "privateNS" character varying(255),
    "publishStartDate" character varying(255),
    "publishEndDate" character varying(255),
    content text,
    render text,
    toc json,
    "contentType" character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "editorKey" character varying(255),
    "localeCode" character varying(5),
    "authorId" integer,
    "creatorId" integer,
    extra json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pages OWNER TO wiki;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pages_id_seq OWNER TO wiki;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: renderers; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.renderers (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public.renderers OWNER TO wiki;

--
-- Name: searchEngines; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."searchEngines" (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    config json
);


ALTER TABLE public."searchEngines" OWNER TO wiki;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.sessions (
    sid character varying(255) NOT NULL,
    sess json NOT NULL,
    expired timestamp with time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO wiki;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value json,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.settings OWNER TO wiki;

--
-- Name: storage; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.storage (
    key character varying(255) NOT NULL,
    "isEnabled" boolean DEFAULT false NOT NULL,
    mode character varying(255) DEFAULT 'push'::character varying NOT NULL,
    config json,
    "syncInterval" character varying(255),
    state json
);


ALTER TABLE public.storage OWNER TO wiki;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    tag character varying(255) NOT NULL,
    title character varying(255),
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO wiki;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO wiki;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: userAvatars; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."userAvatars" (
    id integer NOT NULL,
    data bytea NOT NULL
);


ALTER TABLE public."userAvatars" OWNER TO wiki;

--
-- Name: userGroups; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."userGroups" (
    id integer NOT NULL,
    "userId" integer,
    "groupId" integer
);


ALTER TABLE public."userGroups" OWNER TO wiki;

--
-- Name: userGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."userGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userGroups_id_seq" OWNER TO wiki;

--
-- Name: userGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."userGroups_id_seq" OWNED BY public."userGroups".id;


--
-- Name: userKeys; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public."userKeys" (
    id integer NOT NULL,
    kind character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "validUntil" character varying(255) NOT NULL,
    "userId" integer
);


ALTER TABLE public."userKeys" OWNER TO wiki;

--
-- Name: userKeys_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public."userKeys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."userKeys_id_seq" OWNER TO wiki;

--
-- Name: userKeys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public."userKeys_id_seq" OWNED BY public."userKeys".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: wiki
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "providerId" character varying(255),
    password character varying(255),
    "tfaIsActive" boolean DEFAULT false NOT NULL,
    "tfaSecret" character varying(255),
    "jobTitle" character varying(255) DEFAULT ''::character varying,
    location character varying(255) DEFAULT ''::character varying,
    "pictureUrl" character varying(255),
    timezone character varying(255) DEFAULT 'America/New_York'::character varying NOT NULL,
    "isSystem" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    "mustChangePwd" boolean DEFAULT false NOT NULL,
    "createdAt" character varying(255) NOT NULL,
    "updatedAt" character varying(255) NOT NULL,
    "providerKey" character varying(255) DEFAULT 'local'::character varying NOT NULL,
    "localeCode" character varying(5) DEFAULT 'en'::character varying NOT NULL,
    "defaultEditor" character varying(255) DEFAULT 'markdown'::character varying NOT NULL,
    "lastLoginAt" character varying(255),
    "dateFormat" character varying(255) DEFAULT ''::character varying NOT NULL,
    appearance character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO wiki;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: wiki
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO wiki;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wiki
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apiKeys id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."apiKeys" ALTER COLUMN id SET DEFAULT nextval('public."apiKeys_id_seq"'::regclass);


--
-- Name: assetFolders id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."assetFolders" ALTER COLUMN id SET DEFAULT nextval('public."assetFolders_id_seq"'::regclass);


--
-- Name: assets id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.assets ALTER COLUMN id SET DEFAULT nextval('public.assets_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: groups id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: migrations_lock index; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.migrations_lock_index_seq'::regclass);


--
-- Name: pageHistory id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistory" ALTER COLUMN id SET DEFAULT nextval('public."pageHistory_id_seq"'::regclass);


--
-- Name: pageHistoryTags id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistoryTags" ALTER COLUMN id SET DEFAULT nextval('public."pageHistoryTags_id_seq"'::regclass);


--
-- Name: pageLinks id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageLinks" ALTER COLUMN id SET DEFAULT nextval('public."pageLinks_id_seq"'::regclass);


--
-- Name: pageTags id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTags" ALTER COLUMN id SET DEFAULT nextval('public."pageTags_id_seq"'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: userGroups id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userGroups" ALTER COLUMN id SET DEFAULT nextval('public."userGroups_id_seq"'::regclass);


--
-- Name: userKeys id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userKeys" ALTER COLUMN id SET DEFAULT nextval('public."userKeys_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: analytics; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.analytics (key, "isEnabled", config) FROM stdin;
azureinsights	f	{"instrumentationKey":""}
baidutongji	f	{"propertyTrackingId":""}
countly	f	{"appKey":"","serverUrl":""}
elasticapm	f	{"serverUrl":"http://apm.example.com:8200","serviceName":"wiki-js","environment":""}
fathom	f	{"host":"","siteId":""}
fullstory	f	{"org":""}
google	t	{"propertyTrackingId":""}
gtm	f	{"containerTrackingId":""}
hotjar	f	{"siteId":""}
matomo	f	{"siteId":1,"serverHost":"https://example.matomo.cloud"}
newrelic	f	{"licenseKey":"","appId":"","beacon":"bam.nr-data.net","errorBeacon":"bam.nr-data.net"}
plausible	f	{"domain":"","plausibleJsSrc":"https://plausible.io/js/plausible.js"}
statcounter	f	{"projectId":"","securityToken":""}
umami	f	{"websiteID":"","url":""}
yandex	f	{"tagNumber":""}
\.


--
-- Data for Name: apiKeys; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."apiKeys" (id, name, key, expiration, "isRevoked", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: assetData; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."assetData" (id, data) FROM stdin;
1	\\x3c73766720786d6c3a73706163653d22707265736572766522207374796c653d22656e61626c652d6261636b67726f756e643a6e65772030203020353030203530303b222076696577426f783d2230203020353030203530302220793d223070782220783d223070782220786d6c6e733a786c696e6b3d22687474703a2f2f7777772e77332e6f72672f313939392f786c696e6b2220786d6c6e733d22687474703a2f2f7777772e77332e6f72672f323030302f737667222069643d224c617965725f31222076657273696f6e3d22312e31223e0a3c7374796c6520747970653d22746578742f637373223e0a092e7374307b66696c6c3a234535313633363b7d0a092e7374317b66696c6c3a233635363236333b7d0a3c2f7374796c653e0a3c672069643d22584d4c49445f315f223e0a093c7061746820643d224d3137332e362c3231352e34682d32362e38632d312e332c302d322e362c302e372d332e332c312e396c2d342e352c372e3468323763312e372c302e312c332e312c312e372c332e312c332e366c302c31342e32682d32302e320a0909762d342e31763063302d302e382c302e362d312e352c312e332d312e356831342e31762d352e3263302d312e332d302e372d322d312e372d32682d31392e36632d322e342c302d342e332c322e322d342e332c342e397631322e396c302c302e3263302e332c312e392c312e382c332e342c332e362c332e346833382e320a0909762d3238433138302e342c3231382e392c3137372e342c3231352e342c3137332e362c3231352e342220636c6173733d22737430222069643d22584d4c49445f31335f223e3c2f706174683e0a093c7061746820643d224d3431372e362c3231352e34682d32362e38632d312e332c302d322e362c302e372d332e332c312e396c2d342e352c372e3468323763312e372c302e312c332e312c312e372c332e312c332e366c302c31342e32682d32302e320a0909762d342e31763063302d302e382c302e362d312e352c312e332d312e356831342e31762d352e3263302d312e332d302e372d322d312e372d32682d31392e36632d322e342c302d342e332c322e322d342e332c342e397631322e396c302c302e3263302e332c312e392c312e382c332e342c332e362c332e346833382e320a0909762d3238433432342e352c3231382e392c3432312e342c3231352e342c3431372e362c3231352e342220636c6173733d22737430222069643d22584d4c49445f31345f223e3c2f706174683e0a093c7061746820643d224d3333332e332c3230322e357631337632362e38682d31362e38632d312e322c302d322d312e322d322d322e31762d31312e38763063302d322c312e352d332e362c332e332d332e3668382e350a090963312e332c302c322e362d302e382c332e312d312e386c332e392d372e356c2d32332e362c30632d332e382c302d362e392c332e342d362e392c372e376c302c302e3163302c302c302c32302c302c32312e3563302c342e312c332c362e342c352e362c362e346833362e35762d34382e37483333332e337a2220636c6173733d22737430222069643d22584d4c49445f31355f223e3c2f706174683e0a093c7061746820643d224d3335372e332c3231352e34632d322e392c302d342e382c322e352d342e382c352e327633302e356831312e37762d32322e3763302d322c312e332d332e372c332e312d332e3768382e360a090963312e332d302e312c322e332d302e392c332d326c342e352d372e32483335372e337a2220636c6173733d22737430222069643d22584d4c49445f31365f223e3c2f706174683e0a093c7061746820643d224d3233362e332c3232372e317632342e316831312e36762d32312e35762d31332e3863302c302d352e342c332e372d392e322c362e34433233372e322c3232332e332c3233362e332c3232352e312c3233362e332c3232372e310a0909204d3233362e332c3230322e346831312e3676396c2d31312e362c382e36563230322e347a2220636c6173733d22737430222069643d22584d4c49445f31395f223e3c2f706174683e0a093c7061746820643d224d3132332e322c3230322e354836372e357634382e376831312e36762d33372e336831322e3463312e322c302c322e312c312e312c322e312c322e3468307633342e396831312e36762d33342e390a090963302d312e332c312d322e342c322e322d322e346c302c3068392e3163312e382c302c332e322c312e362c332e322c332e367633332e386831312e36762d33392e37433133312e322c3230362e352c3132372e362c3230322e352c3132332e322c3230322e352220636c6173733d22737430222069643d22584d4c49445f32305f223e3c2f706174683e0a093c7061746820643d224d3238382e342c3231352e35632d302e312c302d33322e392c302d33322e392c307633352e376831312e37762d32362e346831332e3363312e382c302c332e332c312e362c332e332c332e3668307632322e386831312e360a0909762d3238433239352e332c3231382e392c3239322e322c3231352e352c3238382e342c3231352e352220636c6173733d22737430222069643d22584d4c49445f32315f223e3c2f706174683e0a093c7061746820643d224d3232382e362c3232332e3263302d342e332d332e312d372e372d362e392d372e37682d302e31682d31352e31632d312e342c302d322c302e382d322e372c312e396c2d342e362c372e336831342e370a090963312e372c302e312c332e312c312e372c332e312c332e366c302c32322e386831312e36563232332e324c3232382e362c3232332e32204d3138372e362c3230322e356831312e367634382e37682d31312e36563230322e357a2220636c6173733d22737430222069643d22584d4c49445f32345f223e3c2f706174683e0a093c7061746820643d224d3336322e382c3237312e3463302d312e322d302e322d322e332d302e362d332e31632d302e342d302e382d302e392d312e352d312e362d32632d302e372d302e352d312e342d302e392d322e332d312e310a0909632d302e392d302e322d312e372d302e332d322e362d302e33632d302e392c302d312e382c302d322e372c30632d302e392c302d312e382c302d322e372c306c2d312e362c31342e3463302e392c302e312c312e382c302e322c322e372c302e3263302e392c302e312c312e382c302e312c322e372c302e310a090963322e382c302c352d302e372c362e352d322e31433336322e312c3237362e332c3336322e382c3237342e322c3336322e382c3237312e34204d3336362e382c32393563302c302e372d302e332c312e332d312c312e37632d302e372c302e342d312e392c302e362d332e352c302e360a0909632d302e342c302d302e382d302e312d312e312d302e34632d302e332d302e322d302e352d302e362d302e372d302e396c2d352e392d31332e35632d302e322c302d302e352c302e312d302e382c302e31682d302e37632d302e392c302d312e372c302d322e332d302e310a0909632d302e372d302e312d312e352d302e322d322e342d302e336c2d312e372c31342e37632d302e322c302e312d302e352c302e322d302e382c302e32632d302e332c302d302e372c302e312d312e312c302e31632d302e372c302d312e322d302e322d312e342d302e340a0909632d302e332d302e332d302e342d302e382d302e342d312e3463302d302e322c302d302e372c302e312d312e3663302e312d302e382c302e322d312e382c302e332d332e3163302e312d312e322c302e332d322e362c302e342d342e3263302e322d312e352c302e332d332e322c302e352d342e390a090963302e332d322e382c302e372d352e352c312d382e3363302e332d322e372c302e372d352e352c312d382e336c2d342d302e31632d302e322d302e322d302e322d302e352d302e322d3163302d312e342c312d322e312c332d322e316831312e3363312e322c302c322e342c302e312c332e362c302e340a090963312e322c302e332c322e332c302e372c332e332c312e3463312c302e372c312e372c312e362c322e332c322e3763302e362c312e312c302e392c322e352c302e392c342e3263302c332e312d302e372c352e362d322e322c372e33632d312e352c312e372d332e352c332e312d362e312c332e396c352e352c31322e310a09096c322e362d302e33433336362e372c3239342e312c3336362e382c3239342e352c3336362e382c3239352220636c6173733d22737431222069643d22584d4c49445f32375f223e3c2f706174683e0a093c7061746820643d224d3338302e312c3236332e3163302c302e392d302e322c312e352d302e372c32632d302e352c302e352d312e322c302e382d322e312c302e38632d302e372c302d312e322d302e322d312e372d302e350a0909632d302e342d302e332d302e362d302e392d302e362d312e3763302d302e382c302e332d312e352c302e382d3263302e352d302e352c312e332d302e382c322e322d302e3863302e382c302c312e342c302e322c312e372c302e360a0909433337392e392c3236312e392c3338302e312c3236322e352c3338302e312c3236332e31204d3338312e322c32393563302c302e372d302e342c312e322d312e322c312e36632d302e382c302e342d322e312c302e372d332e392c302e37632d312e312c302d322d302e322d322e362d302e380a0909632d302e362d302e352d302e392d312e342d302e392d322e3763302d312c302e312d322e342c302e342d342e326c322e312d31362e326c2d332e382c302e31632d302e332d302e332d302e342d302e362d302e342d312e3163302d302e382c302e342d312e332c312e322d312e370a090963302e382d302e342c322e322d302e352c342e312d302e3563312e322c302c312e392c302e322c322e332c302e3563302e342c302e332c302e352c312c302e342c326c2d312e332c31302e36632d302e332c322e332d302e352c342e332d302e372c352e39632d302e322c312e372d302e332c322e382d302e332c332e330a090963302c302e362c302e312c312c302e332c312e3263302e322c302e322c302e372c302e322c312e352c302e3263302e332c302c302e372d302e312c312e322d302e3263302e352d302e312c302e392d302e322c312e322d302e33433338312c3239332e372c3338312e322c3239342e332c3338312e322c3239352220636c6173733d22737431222069643d22584d4c49445f33305f223e3c2f706174683e0a093c7061746820643d224d3430322e352c3237322e3763302c302e362d302e312c312e312d302e332c312e34632d302e322c302e332d302e362c302e352d312c302e37632d302e382d302e372d312e372d312e322d322e372d312e350a0909632d312d302e322d322e312d302e342d332e332d302e34632d312e382c302d332e312c302e342d342c312e33632d302e392c302e392d312e342c312e382d312e342c322e3963302c302e372c302e312c312e332c302e322c312e3763302e322c302e352c302e352c302e392c302e392c312e330a090963302e342c302e342c312e312c302e382c312e392c312e3263302e382c302e342c312e382c302e382c332c312e3363312e312c302e352c322c312c322e372c312e3463302e372c302e352c312e332c302e392c312e372c312e3563302e342c302e352c302e372c312e312c302e392c312e370a090963302e322c302e362c302e322c312e332c302e322c3263302c312d302e322c312e392d302e352c322e39632d302e342c312d302e392c312e382d312e362c322e36632d302e372c302e372d312e362c312e342d322e372c312e38632d312e312c302e352d322e342c302e372d332e392c302e370a0909632d302e362c302d312e342c302d322e332d302e31632d312c302d322d302e322d332d302e34632d312d302e322d312e392d302e362d322e362d312e31632d302e372d302e352d312e312d312e322d312e312d322e3163302d302e362c302e322d312e312c302e362d312e350a090963302e342d302e342c302e382d302e362c312e342d302e3863302e382c312e312c322c312e392c332e342c322e3463312e342c302e352c322e382c302e372c342c302e3763312e352c302c322e382d302e342c332e362d312e3163302e392d302e382c312e332d312e372c312e332d330a090963302d312d302e332d312e392d312d322e35632d302e372d302e372d322d312e342d332e392d322e32632d312e322d302e352d322e332d302e392d332e312d312e34632d302e392d302e352d312e352d312d322d312e36632d302e352d302e362d302e392d312e332d312e312d322e310a0909632d302e322d302e382d302e342d312e372d302e342d322e3763302d312e312c302e322d322e322c302e372d332e3263302e352d312c312e312d312e382c322d322e3563302e382d302e372c312e382d312e332c332d312e3763312e322d302e342c322e342d302e362c332e382d302e360a090963322e312c302c332e382c302e332c342e392c302e39433430312e392c3237312c3430322e352c3237312e382c3430322e352c3237322e372220636c6173733d22737431222069643d22584d4c49445f33315f223e3c2f706174683e0a093c7061746820643d224d3432312e322c3237362e3663302d312e322d302e332d322e322d312d322e39632d302e372d302e372d312e392d312e312d332e362d312e31632d302e382c302d312e362c302e312d322e342c302e340a0909632d302e392c302e332d312e372c302e372d322e342c312e34632d302e382c302e362d312e352c312e352d322e312c322e36632d302e362c312e312d312e312c322e352d312e342c342e3163302e372c302e312c312e362c302e322c322e362c302e3363312c302e312c322c302e312c322e382c302e310a090963322e382c302c342e382d302e342c352e392d312e33433432302e372c3237392e342c3432312e322c3237382e322c3432312e322c3237362e36204d3432342e352c3237362e3163302c352e352d332e352c382e322d31302e362c382e32632d302e392c302d312e392c302d322e392d302e310a0909632d312d302e312d322e312d302e322d332e312d302e3463302c302e332d302e312c302e352d302e312c302e3876302e3763302c352e392c322e322c382e392c362e352c382e3963312e332c302c322e372d302e322c342d302e3563312e332d302e332c322e372d302e382c342d312e350a090963302e352c302e342c302e372c302e392c302e372c312e3663302c302e392d302e372c312e382d322e312c322e36632d312e342c302e382d332e382c312e322d372c312e32632d362e352c302d392e372d332e382d392e372d31312e3463302d322e352c302e332d342e372c302e392d362e380a090963302e362d322e312c312e342d332e382c322e352d352e3363312e312d312e352c322e352d322e362c342e312d332e3463312e362d302e382c332e352d312e322c352e372d312e3263312e342c302c322e352c302e322c332e342c302e3563302e392c302e332c312e362c302e382c322e322c312e340a090963302e362c302e362c312c312e332c312e322c322e31433432342e342c3237342e332c3432342e352c3237352e322c3432342e352c3237362e312220636c6173733d22737431222069643d22584d4c49445f33345f223e3c2f706174683e0a093c7061746820643d224d3433322e352c3239332e3963302c312d302e332c312e382d302e392c322e33632d302e362c302e352d312e342c302e382d322e342c302e38632d302e372c302d312e332d302e322d312e382d302e360a0909632d302e352d302e342d302e372d312d302e372d312e3963302d302e392c302e332d312e372c302e392d322e3363302e362d302e362c312e342d302e392c322e342d302e3963302e392c302c312e352c302e322c312e392c302e370a0909433433322e332c3239322e362c3433322e352c3239332e322c3433322e352c3239332e392220636c6173733d22737431222069643d22584d4c49445f33355f223e3c2f706174683e0a3c2f673e0a3c2f7376673e0a
\.


--
-- Data for Name: assetFolders; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."assetFolders" (id, name, slug, "parentId") FROM stdin;
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.assets (id, filename, hash, ext, kind, mime, "fileSize", metadata, "createdAt", "updatedAt", "folderId", "authorId") FROM stdin;
1	mahindra-rise-logo-vector-01.svg	a887e2736a6f6499204343030a2983edcf702e07	.svg	image	image/svg+xml	6020	\N	2023-05-12T05:21:36.387Z	2023-05-12T05:21:36.387Z	\N	1
\.


--
-- Data for Name: authentication; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.authentication (key, "isEnabled", config, "selfRegistration", "domainWhitelist", "autoEnrollGroups", "order", "strategyKey", "displayName") FROM stdin;
local	t	{}	f	{"v":[]}	{"v":[]}	0	local	Local
\.


--
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.brute (key, "firstRequest", "lastRequest", lifetime, count) FROM stdin;
\.


--
-- Data for Name: commentProviders; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."commentProviders" (key, "isEnabled", config) FROM stdin;
artalk	f	{"server":"","siteName":""}
commento	f	{"instanceUrl":"https://cdn.commento.io"}
default	t	{"akismet":"","minDelay":30}
disqus	f	{"accountName":""}
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.comments (id, content, "createdAt", "updatedAt", "pageId", "authorId", render, name, email, ip, "replyTo") FROM stdin;
7	demo comments has been updated	2023-06-02T09:26:32.751Z	2023-06-02T09:26:32.751Z	7	1	<p>demo comments has been updated</p>\n	Administrator	admin@mahindra.com	124.30.106.74	0
8	hi test case	2023-06-05T03:48:19.020Z	2023-06-05T03:48:19.020Z	12	8	<p>hi test case</p>\n	cff	cf01@gmail.com	124.30.106.74	0
\.


--
-- Data for Name: editors; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.editors (key, "isEnabled", config) FROM stdin;
api	f	{}
asciidoc	f	{}
ckeditor	f	{}
code	f	{}
markdown	t	{}
redirect	f	{}
wysiwyg	f	{}
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.groups (id, name, permissions, "pageRules", "isSystem", "createdAt", "updatedAt", "redirectOnLogin") FROM stdin;
2	Guests	["read:pages","read:assets","read:comments"]	[]	t	2023-05-12T05:09:45.301Z	2023-05-12T05:14:59.169Z	/
1	Administrators	["manage:system"]	[]	t	2023-05-12T05:09:45.298Z	2023-06-01T04:38:12.287Z	/
3	M&M	["read:pages","read:assets","read:comments","write:comments","manage:comments"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments","read:history","read:source","delete:pages","manage:pages","write:pages","write:assets","manage:assets","write:scripts","write:styles","manage:comments"],"path":"home","locales":[]},{"id":"c35514daf7","deny":true,"match":"START","roles":["read:pages","write:pages","manage:pages","delete:pages","read:source","read:history","read:assets","write:assets","manage:assets","write:scripts","write:styles","read:comments","write:comments","manage:comments"],"path":"home/Bosch/home","locales":[]}]	f	2023-05-12T05:17:55.696Z	2023-06-01T12:14:17.895Z	/en/home/mahindra/home
6	APTIV	["read:pages","read:assets","read:comments","write:comments"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments"],"path":"","locales":[]}]	f	2023-06-02T10:10:29.855Z	2023-06-02T10:10:29.855Z	/
4	Bosch	["read:pages","read:assets","read:comments","write:comments","write:pages","manage:comments","manage:pages","delete:pages","write:styles","read:source","read:history","write:scripts","manage:assets","write:assets"]	[{"id":"default","deny":false,"match":"START","roles":["read:pages","read:assets","read:comments","write:comments","write:pages","manage:pages","read:source","delete:pages","read:history","write:assets","manage:assets","write:scripts","write:styles","manage:comments"],"path":"home","locales":[]},{"id":"834b5fea8f","deny":true,"match":"START","roles":["read:pages","write:pages","manage:pages","delete:pages","read:source","read:history","read:assets","write:assets","manage:assets","write:scripts","write:styles","read:comments","write:comments","manage:comments"],"path":"home/mahindra/home","locales":[]}]	f	2023-05-12T05:18:05.516Z	2023-05-12T11:13:31.811Z	/home/Bosch/home
\.


--
-- Data for Name: locales; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.locales (code, strings, "isRTL", name, "nativeName", availability, "createdAt", "updatedAt") FROM stdin;
en	{"common":{"footer":{"poweredBy":"Powered by","copyright":"© {{year}} {{company}}. All rights reserved.","license":"Content is available under the {{license}}, by {{company}}."},"actions":{"save":"Save","cancel":"Cancel","download":"Download","upload":"Upload","discard":"Discard","clear":"Clear","create":"Create","edit":"Edit","delete":"Delete","refresh":"Refresh","saveChanges":"Save Changes","proceed":"Proceed","ok":"OK","add":"Add","apply":"Apply","browse":"Browse...","close":"Close","page":"Page","discardChanges":"Discard Changes","move":"Move","rename":"Rename","optimize":"Optimize","preview":"Preview","properties":"Properties","insert":"Insert","fetch":"Fetch","generate":"Generate","confirm":"Confirm","copy":"Copy","returnToTop":"Return to top","exit":"Exit","select":"Select","convert":"Convert"},"newpage":{"title":"This page does not exist yet.","subtitle":"Would you like to create it now?","create":"Create Page","goback":"Go back"},"unauthorized":{"title":"Unauthorized","action":{"view":"You cannot view this page.","source":"You cannot view the page source.","history":"You cannot view the page history.","edit":"You cannot edit the page.","create":"You cannot create the page.","download":"You cannot download the page content.","downloadVersion":"You cannot download the content for this page version.","sourceVersion":"You cannot view the source of this version of the page."},"goback":"Go Back","login":"Login As..."},"notfound":{"gohome":"Home","title":"Not Found","subtitle":"This page does not exist."},"welcome":{"title":"Welcome to your wiki!","subtitle":"Let's get started and create the home page.","createhome":"Create Home Page","goadmin":"Administration"},"header":{"home":"Home","newPage":"New Page","currentPage":"Current Page","view":"View","edit":"Edit","history":"History","viewSource":"View Source","move":"Move / Rename","delete":"Delete","assets":"Assets","imagesFiles":"Images & Files","search":"Search...","admin":"Administration","account":"Account","myWiki":"My Wiki","profile":"Profile","logout":"Logout","login":"Login","searchHint":"Type at least 2 characters to start searching...","searchLoading":"Searching...","searchNoResult":"No pages matching your query.","searchResultsCount":"Found {{total}} results","searchDidYouMean":"Did you mean...","searchClose":"Close","searchCopyLink":"Copy Search Link","language":"Language","browseTags":"Browse by Tags","siteMap":"Site Map","pageActions":"Page Actions","duplicate":"Duplicate","convert":"Convert"},"page":{"lastEditedBy":"Last edited by","unpublished":"Unpublished","editPage":"Edit Page","toc":"Page Contents","bookmark":"Bookmark","share":"Share","printFormat":"Print Format","delete":"Delete Page","deleteTitle":"Are you sure you want to delete page {{title}}?","deleteSubtitle":"The page can be restored from the administration area.","viewingSource":"Viewing source of page {{path}}","returnNormalView":"Return to Normal View","id":"ID {{id}}","published":"Published","private":"Private","global":"Global","loading":"Loading Page...","viewingSourceVersion":"Viewing source as of {{date}} of page {{path}}","versionId":"Version ID {{id}}","unpublishedWarning":"This page is not published.","tags":"Tags","tagsMatching":"Pages matching tags","convert":"Convert Page","convertTitle":"Select the editor you want to use going forward for the page {{title}}:","convertSubtitle":"The page content will be converted into the format of the newly selected editor. Note that some formatting or non-rendered content may be lost as a result of the conversion. A snapshot will be added to the page history and can be restored at any time.","editExternal":"Edit on {{name}}"},"error":{"unexpected":"An unexpected error occurred."},"password":{"veryWeak":"Very Weak","weak":"Weak","average":"Average","strong":"Strong","veryStrong":"Very Strong"},"user":{"search":"Search User","searchPlaceholder":"Search Users..."},"duration":{"every":"Every","minutes":"Minute(s)","hours":"Hour(s)","days":"Day(s)","months":"Month(s)","years":"Year(s)"},"outdatedBrowserWarning":"Your browser is outdated. Upgrade to a {{modernBrowser}}.","modernBrowser":"modern browser","license":{"none":"None","ccby":" Creative Commons Attribution License","ccbysa":"Creative Commons Attribution-ShareAlike License","ccbynd":"Creative Commons Attribution-NoDerivs License","ccbync":"Creative Commons Attribution-NonCommercial License","ccbyncsa":"Creative Commons Attribution-NonCommercial-ShareAlike License","ccbyncnd":"Creative Commons Attribution-NonCommercial-NoDerivs License","cc0":"Public Domain","alr":"All Rights Reserved"},"sidebar":{"browse":"Browse","mainMenu":"Main Menu","currentDirectory":"Current Directory","root":"(root)"},"comments":{"title":"Comments","newPlaceholder":"Write a new comment...","fieldName":"Your Name","fieldEmail":"Your Email Address","markdownFormat":"Markdown Format","postComment":"Post Comment","loading":"Loading comments...","postingAs":"Posting as {{name}}","beFirst":"Be the first to comment.","none":"No comments yet.","updateComment":"Update Comment","deleteConfirmTitle":"Confirm Delete","deleteWarn":"Are you sure you want to permanently delete this comment?","deletePermanentWarn":"This action cannot be undone!","modified":"modified {{reldate}}","postSuccess":"New comment posted successfully.","contentMissingError":"Comment is empty or too short!","updateSuccess":"Comment was updated successfully.","deleteSuccess":"Comment was deleted successfully.","viewDiscussion":"View Discussion","newComment":"New Comment","fieldContent":"Comment Content","sdTitle":"Talk"},"pageSelector":{"createTitle":"Select New Page Location","moveTitle":"Move / Rename Page Location","selectTitle":"Select a Page","virtualFolders":"Virtual Folders","pages":"Pages","folderEmptyWarning":"This folder is empty."}},"auth":{"loginRequired":"Login required","fields":{"emailUser":"Email / Username","password":"Password","email":"Email Address","verifyPassword":"Verify Password","name":"Name","username":"Username"},"actions":{"login":"Log In","register":"Register"},"errors":{"invalidLogin":"Invalid Login","invalidLoginMsg":"The email or password is invalid.","invalidUserEmail":"Invalid User Email","loginError":"Login error","notYetAuthorized":"You have not been authorized to login to this site yet.","tooManyAttempts":"Too many attempts!","tooManyAttemptsMsg":"You've made too many failed attempts in a short period of time, please try again {{time}}.","userNotFound":"User not found"},"providers":{"local":"Local","windowslive":"Microsoft Account","azure":"Azure Active Directory","google":"Google ID","facebook":"Facebook","github":"GitHub","slack":"Slack","ldap":"LDAP / Active Directory"},"tfa":{"title":"Two Factor Authentication","subtitle":"Security code required:","placeholder":"XXXXXX","verifyToken":"Verify"},"registerTitle":"Create an account","switchToLogin":{"text":"Already have an account? {{link}}","link":"Login instead"},"loginUsingStrategy":"Login using {{strategy}}","forgotPasswordLink":"Forgot your password?","orLoginUsingStrategy":"or login using...","switchToRegister":{"text":"Don't have an account yet? {{link}}","link":"Create an account"},"invalidEmailUsername":"Enter a valid email / username.","invalidPassword":"Enter a valid password.","loginSuccess":"Login Successful! Redirecting...","signingIn":"Signing In...","genericError":"Authentication is unavailable.","registerSubTitle":"Fill-in the form below to create your account.","pleaseWait":"Please wait","registerSuccess":"Account created successfully!","registering":"Creating account...","missingEmail":"Missing email address.","invalidEmail":"Email address is invalid.","missingPassword":"Missing password.","passwordTooShort":"Password is too short.","passwordNotMatch":"Both passwords do not match.","missingName":"Name is missing.","nameTooShort":"Name is too short.","nameTooLong":"Name is too long.","forgotPasswordCancel":"Cancel","sendResetPassword":"Reset Password","forgotPasswordSubtitle":"Enter your email address to receive the instructions to reset your password:","registerCheckEmail":"Check your emails to activate your account.","changePwd":{"subtitle":"Choose a new password","instructions":"You must choose a new password:","newPasswordPlaceholder":"New Password","newPasswordVerifyPlaceholder":"Verify New Password","proceed":"Change Password","loading":"Changing password..."},"forgotPasswordLoading":"Requesting password reset...","forgotPasswordSuccess":"Check your emails for password reset instructions!","selectAuthProvider":"Select Authentication Provider","enterCredentials":"Enter your credentials","forgotPasswordTitle":"Forgot your password","tfaFormTitle":"Enter the security code generated from your trusted device:","tfaSetupTitle":"Your administrator has required Two-Factor Authentication (2FA) to be enabled on your account.","tfaSetupInstrFirst":"1) Scan the QR code below from your mobile 2FA application:","tfaSetupInstrSecond":"2) Enter the security code generated from your trusted device:"},"admin":{"dashboard":{"title":"Dashboard","subtitle":"Wiki.js","pages":"Pages","users":"Users","groups":"Groups","versionLatest":"You are running the latest version.","versionNew":"A new version is available: {{version}}","contributeSubtitle":"Wiki.js is a free and open source project. There are several ways you can contribute to the project.","contributeHelp":"We need your help!","contributeLearnMore":"Learn More","recentPages":"Recent Pages","mostPopularPages":"Most Popular Pages","lastLogins":"Last Logins"},"general":{"title":"General","subtitle":"Main settings of your wiki","siteInfo":"Site Info","siteBranding":"Site Branding","general":"General","siteUrl":"Site URL","siteUrlHint":"Full URL to your wiki, without the trailing slash. (e.g. https://wiki.example.com)","siteTitle":"Site Title","siteTitleHint":"Displayed in the top bar and appended to all pages meta title.","logo":"Logo","uploadLogo":"Upload Logo","uploadClear":"Clear","uploadSizeHint":"An image of {{size}} pixels is recommended for best results.","uploadTypesHint":"{{typeList}} or {{lastType}} files only","footerCopyright":"Footer Copyright","companyName":"Company / Organization Name","companyNameHint":"Name to use when displaying copyright notice in the footer. Leave empty to hide.","siteDescription":"Site Description","siteDescriptionHint":"Default description when none is provided for a page.","metaRobots":"Meta Robots","metaRobotsHint":"Default: Index, Follow. Can also be set on a per-page basis.","logoUrl":"Logo URL","logoUrlHint":"Specify an image to use as the logo. SVG, PNG, JPG are supported, in a square ratio, 34x34 pixels or larger. Click the button on the right to upload a new image.","contentLicense":"Content License","contentLicenseHint":"License shown in the footer of all content pages.","siteTitleInvalidChars":"Site Title contains invalid characters.","saveSuccess":"Site configuration saved successfully.","pageExtensions":"Page Extensions","pageExtensionsHint":"A comma-separated list of URL extensions that will be treated as pages. For example, adding md will treat /foobar.md the same as /foobar.","editMenuExternalName":"Button Site Name","editMenuExternalNameHint":"The name of the external site to display on the edit button. Do not include the \\"Edit on\\" prefix.","editMenuExternalIcon":"Button Icon","editMenuExternalIconHint":"The icon to display on the edit button. For example, mdi-github to display the GitHub icon.","editMenuExternalUrl":"Button URL","editMenuExternalUrlHint":"Url to the page on the external repository. Use the {filename} placeholder where the filename should be included. (e.g. https://github.com/foo/bar/blob/main/{filename} )","editShortcuts":"Edit Shortcuts","editFab":"FAB Quick Edit Menu","editFabHint":"Display the edit floating action button (FAB) with a speed-dial menu in the bottom right corner of the screen.","editMenuBar":"Edit Menu Bar","displayEditMenuBar":"Display Edit Menu Bar","displayEditMenuBarHint":"Display the edit menu bar in the page header.","displayEditMenuBtn":"Display Edit Button","displayEditMenuBtnHint":"Display a button to edit the current page.","displayEditMenuExternalBtn":"Display External Edit Button","displayEditMenuExternalBtnHint":"Display a button linking to an external repository (e.g. GitHub) where users can edit or submit a PR for the current page.","footerOverride":"Footer Text Override","footerOverrideHint":"Optionally override the footer text with a custom message. Useful if none of the above licenses are appropriate."},"locale":{"title":"Locale","subtitle":"Set localization options for your wiki","settings":"Locale Settings","namespacing":"Multilingual Namespacing","downloadTitle":"Download Locale","base":{"labelWithNS":"Base Locale","hint":"All UI text elements will be displayed in selected language.","label":"Site Locale"},"autoUpdate":{"label":"Update Automatically","hintWithNS":"Automatically download updates to all namespaced locales enabled below.","hint":"Automatically download updates to this locale as they become available."},"namespaces":{"label":"Multilingual Namespaces","hint":"Enables multiple language versions of the same page."},"activeNamespaces":{"label":"Active Namespaces","hint":"List of locales enabled for multilingual namespacing. The base locale defined above will always be included regardless of this selection."},"namespacingPrefixWarning":{"title":"The locale code will be prefixed to all paths. (e.g. /{{langCode}}/page-name)","subtitle":"Paths without a locale code will be automatically redirected to the base locale defined above."},"sideload":"Sideload Locale Package","sideloadHelp":"If you are not connected to the internet or cannot download locale files using the method above, you can instead sideload packages manually by uploading them below.","code":"Code","name":"Name","nativeName":"Native Name","rtl":"RTL","availability":"Availability","download":"Download"},"stats":{"title":"Statistics"},"theme":{"title":"Theme","subtitle":"Modify the look & feel of your wiki","siteTheme":"Site Theme","siteThemeHint":"Themes affect how content pages are displayed. Other site sections (such as the editor or admin area) are not affected.","darkMode":"Dark Mode","darkModeHint":"Not recommended for accessibility. May not be supported by all themes.","codeInjection":"Code Injection","cssOverride":"CSS Override","cssOverrideHint":"CSS code to inject after system default CSS. Consider using custom themes if you have a large amount of css code. Injecting too much CSS code will result in poor page load performance! CSS will automatically be minified.","headHtmlInjection":"Head HTML Injection","headHtmlInjectionHint":"HTML code to be injected just before the closing head tag. Usually for script tags.","bodyHtmlInjection":"Body HTML Injection","bodyHtmlInjectionHint":"HTML code to be injected just before the closing body tag.","downloadThemes":"Download Themes","iconset":"Icon Set","iconsetHint":"Set of icons to use for the sidebar navigation.","downloadName":"Name","downloadAuthor":"Author","downloadDownload":"Download","cssOverrideWarning":"{{caution}} When adding styles for page content, you must scope them to the {{cssClass}} class. Omitting this could break the layout of the editor!","cssOverrideWarningCaution":"CAUTION:","options":"Theme Options","tocHeadingLevels":"Default TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels by default."},"groups":{"title":"Groups"},"users":{"title":"Users","active":"Active","inactive":"Inactive","verified":"Verified","unverified":"Unverified","edit":"Edit User","id":"ID {{id}}","basicInfo":"Basic Info","email":"Email","displayName":"Display Name","authentication":"Authentication","authProvider":"Provider","password":"Password","changePassword":"Change Password","newPassword":"New Password","tfa":"Two Factor Authentication (2FA)","toggle2FA":"Toggle 2FA","authProviderId":"Provider Id","groups":"User Groups","noGroupAssigned":"This user is not assigned to any group yet. You must assign at least 1 group to a user.","selectGroup":"Select Group...","groupAssign":"Assign","extendedMetadata":"Extended Metadata","location":"Location","jobTitle":"Job Title","timezone":"Timezone","userUpdateSuccess":"User updated successfully.","userAlreadyAssignedToGroup":"User is already assigned to this group!","deleteConfirmTitle":"Delete User?","deleteConfirmText":"Are you sure you want to delete user {{username}}?","updateUser":"Update User","groupAssignNotice":"Note that you cannot assign users to the Administrators or Guests groups from this panel.","deleteConfirmForeignNotice":"Note that you cannot delete a user that already created content. You must instead either deactivate the user or delete all content that was created by that user.","userVerifySuccess":"User has been verified successfully.","userActivateSuccess":"User has been activated successfully.","userDeactivateSuccess":"User deactivated successfully.","deleteConfirmReplaceWarn":"Any content (pages, uploads, comments, etc.) that was created by this user will be reassigned to the user selected below. It is recommended to create a dummy target user (e.g. Deleted User) if you don't want the content to be reassigned to any current active user.","userTFADisableSuccess":"2FA was disabled successfully.","userTFAEnableSuccess":"2FA was enabled successfully."},"auth":{"title":"Authentication","subtitle":"Configure the authentication settings of your wiki","strategies":"Strategies","globalAdvSettings":"Global Advanced Settings","jwtAudience":"JWT Audience","jwtAudienceHint":"Audience URN used in JWT issued upon login. Usually your domain name. (e.g. urn:your.domain.com)","tokenExpiration":"Token Expiration","tokenExpirationHint":"The expiration period of a token until it must be renewed. (default: 30m)","tokenRenewalPeriod":"Token Renewal Period","tokenRenewalPeriodHint":"The maximum period a token can be renewed when expired. (default: 14d)","strategyState":"This strategy is {{state}} {{locked}}","strategyStateActive":"active","strategyStateInactive":"not active","strategyStateLocked":"and cannot be disabled.","strategyConfiguration":"Strategy Configuration","strategyNoConfiguration":"This strategy has no configuration options you can modify.","registration":"Registration","selfRegistration":"Allow self-registration","selfRegistrationHint":"Allow any user successfully authorized by the strategy to access the wiki.","domainsWhitelist":"Limit to specific email domains","domainsWhitelistHint":"A list of domains authorized to register. The user email address domain must match one of these to gain access.","autoEnrollGroups":"Assign to group","autoEnrollGroupsHint":"Automatically assign new users to these groups.","security":"Security","force2fa":"Force all users to use Two-Factor Authentication (2FA)","force2faHint":"Users will be required to setup 2FA the first time they login and cannot be disabled by the user.","configReference":"Configuration Reference","configReferenceSubtitle":"Some strategies may require some configuration values to be set on your provider. These are provided for reference only and may not be needed by the current strategy.","siteUrlNotSetup":"You must set a valid {{siteUrl}} first! Click on {{general}} in the left sidebar.","allowedWebOrigins":"Allowed Web Origins","callbackUrl":"Callback URL / Redirect URI","loginUrl":"Login URL","logoutUrl":"Logout URL","tokenEndpointAuthMethod":"Token Endpoint Authentication Method","refreshSuccess":"List of strategies has been refreshed.","saveSuccess":"Authentication configuration saved successfully.","activeStrategies":"Active Strategies","addStrategy":"Add Strategy","strategyIsEnabled":"Active","strategyIsEnabledHint":"Are users able to login using this strategy?","displayName":"Display Name","displayNameHint":"The title shown to the end user for this authentication strategy."},"editor":{"title":"Editor"},"logging":{"title":"Logging"},"rendering":{"title":"Rendering","subtitle":"Configure the page rendering pipeline"},"search":{"title":"Search Engine","subtitle":"Configure the search capabilities of your wiki","rebuildIndex":"Rebuild Index","searchEngine":"Search Engine","engineConfig":"Engine Configuration","engineNoConfig":"This engine has no configuration options you can modify.","listRefreshSuccess":"List of search engines has been refreshed.","configSaveSuccess":"Search engine configuration saved successfully.","indexRebuildSuccess":"Index rebuilt successfully."},"storage":{"title":"Storage","subtitle":"Set backup and sync targets for your content","targets":"Targets","status":"Status","lastSync":"Last synchronization {{time}}","lastSyncAttempt":"Last attempt was {{time}}","errorMsg":"Error Message","noTarget":"You don't have any active storage target.","targetConfig":"Target Configuration","noConfigOption":"This storage target has no configuration options you can modify.","syncDirection":"Sync Direction","syncDirectionSubtitle":"Choose how content synchronization is handled for this storage target.","syncDirBi":"Bi-directional","syncDirPush":"Push to target","syncDirPull":"Pull from target","unsupported":"Unsupported","syncDirBiHint":"In bi-directional mode, content is first pulled from the storage target. Any newer content overwrites local content. New content since last sync is then pushed to the storage target, overwriting any content on target if present.","syncDirPushHint":"Content is always pushed to the storage target, overwriting any existing content. This is safest choice for backup scenarios.","syncDirPullHint":"Content is always pulled from the storage target, overwriting any local content which already exists. This choice is usually reserved for single-use content import. Caution with this option as any local content will always be overwritten!","syncSchedule":"Sync Schedule","syncScheduleHint":"For performance reasons, this storage target synchronize changes on an interval-based schedule, instead of on every change. Define at which interval should the synchronization occur.","syncScheduleCurrent":"Currently set to every {{schedule}}.","syncScheduleDefault":"The default is every {{schedule}}.","actions":"Actions","actionRun":"Run","targetState":"This storage target is {{state}}","targetStateActive":"active","targetStateInactive":"inactive","actionsInactiveWarn":"You must enable this storage target and apply changes before you can run actions."},"api":{"title":"API Access","subtitle":"Manage keys to access the API","enabled":"API Enabled","disabled":"API Disabled","enableButton":"Enable API","disableButton":"Disable API","newKeyButton":"New API Key","headerName":"Name","headerKeyEnding":"Key Ending","headerExpiration":"Expiration","headerCreated":"Created","headerLastUpdated":"Last Updated","headerRevoke":"Revoke","noKeyInfo":"No API keys have been generated yet.","revokeConfirm":"Revoke API Key?","revokeConfirmText":"Are you sure you want to revoke key {{name}}? This action cannot be undone!","revoke":"Revoke","refreshSuccess":"List of API keys has been refreshed.","revokeSuccess":"The key has been revoked successfully.","newKeyTitle":"New API Key","newKeySuccess":"API key created successfully.","newKeyNameError":"Name is missing or invalid.","newKeyGroupError":"You must select a group.","newKeyGuestGroupError":"The guests group cannot be used for API keys.","newKeyNameHint":"Purpose of this key","newKeyName":"Name","newKeyExpiration":"Expiration","newKeyExpirationHint":"You can still revoke a key anytime regardless of the expiration.","newKeyPermissionScopes":"Permission Scopes","newKeyFullAccess":"Full Access","newKeyGroupPermissions":"or use group permissions...","newKeyGroup":"Group","newKeyGroupHint":"The API key will have the same permissions as the selected group.","expiration30d":"30 days","expiration90d":"90 days","expiration180d":"180 days","expiration1y":"1 year","expiration3y":"3 years","newKeyCopyWarn":"Copy the key shown below as {{bold}}","newKeyCopyWarnBold":"it will NOT be shown again","toggleStateEnabledSuccess":"API has been enabled successfully.","toggleStateDisabledSuccess":"API has been disabled successfully."},"system":{"title":"System Info","subtitle":"Information about your system","hostInfo":"Host Information","currentVersion":"Current Version","latestVersion":"Latest Version","published":"Published","os":"Operating System","hostname":"Hostname","cpuCores":"CPU Cores","totalRAM":"Total RAM","workingDirectory":"Working Directory","configFile":"Configuration File","ramUsage":"RAM Usage: {{used}} / {{total}}","dbPartialSupport":"Your database version is not fully supported. Some functionality may be limited or not work as expected.","refreshSuccess":"System Info has been refreshed."},"utilities":{"title":"Utilities","subtitle":"Maintenance and miscellaneous tools","tools":"Tools","authTitle":"Authentication","authSubtitle":"Various tools for authentication / users","cacheTitle":"Flush Cache","cacheSubtitle":"Flush cache of various components","graphEndpointTitle":"GraphQL Endpoint","graphEndpointSubtitle":"Change the GraphQL endpoint for Wiki.js","importv1Title":"Import from Wiki.js 1.x","importv1Subtitle":"Migrate data from a previous 1.x installation","telemetryTitle":"Telemetry","telemetrySubtitle":"Enable/Disable telemetry or reset the client ID","contentTitle":"Content","contentSubtitle":"Various tools for pages","exportTitle":"Export to Disk","exportSubtitle":"Save content to tarball for backup / migration"},"dev":{"title":"Developer Tools","flags":{"title":"Flags"},"graphiql":{"title":"GraphiQL"},"voyager":{"title":"Voyager"}},"contribute":{"title":"Contribute to Wiki.js","subtitle":"Help support Wiki.js development and operations","fundOurWork":"Fund our work","spreadTheWord":"Spread the word","talkToFriends":"Talk to your friends and colleagues about how awesome Wiki.js is!","followUsOnTwitter":"Follow us on {{0}}.","submitAnIdea":"Submit an idea or vote on a proposed one on the {{0}}.","submitAnIdeaLink":"feature requests board","foundABug":"Found a bug? Submit an issue on {{0}}.","helpTranslate":"Help translate Wiki.js in your language. Let us know on {{0}}.","makeADonation":"Make a donation","contribute":"Contribute","openCollective":"Wiki.js is also part of the Open Collective initiative, a transparent fund that goes toward community resources. You can contribute financially by making a monthly or one-time donation:","needYourHelp":"We need your help to keep improving the software and run the various associated services (e.g. hosting and networking).","openSource":"Wiki.js is a free and open-source software brought to you with {{0}} by {{1}} and {{2}}.","openSourceContributors":"contributors","tshirts":"You can also buy Wiki.js t-shirts to support the project financially:","shop":"Wiki.js Shop","becomeAPatron":"Become a Patron","patreon":"Become a backer or sponsor via Patreon (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","paypal":"Make a one-time or recurring donation via Paypal:","ethereum":"We accept donations using Ethereum:","github":"Become a sponsor via GitHub Sponsors (goes directly into supporting lead developer Nicolas Giard's goal of working full-time on Wiki.js)","becomeASponsor":"Become a Sponsor"},"nav":{"site":"Site","users":"Users","modules":"Modules","system":"System"},"pages":{"title":"Pages"},"navigation":{"title":"Navigation","subtitle":"Manage the site navigation","link":"Link","divider":"Divider","header":"Header","label":"Label","icon":"Icon","targetType":"Target Type","target":"Target","noSelectionText":"Select a navigation item on the left.","untitled":"Untitled {{kind}}","navType":{"external":"External Link","home":"Home","page":"Page","searchQuery":"Search Query","externalblank":"External Link (New Window)"},"edit":"Edit {{kind}}","delete":"Delete {{kind}}","saveSuccess":"Navigation saved successfully.","noItemsText":"Click the Add button to add your first navigation item.","emptyList":"Navigation is empty","visibilityMode":{"all":"Visible to everyone","restricted":"Visible to select groups..."},"selectPageButton":"Select Page...","mode":"Navigation Mode","modeSiteTree":{"title":"Site Tree","description":"Classic Tree-based Navigation"},"modeCustom":{"title":"Custom Navigation","description":"Static Navigation Menu + Site Tree Button"},"modeNone":{"title":"None","description":"Disable Site Navigation"},"copyFromLocale":"Copy from locale...","sourceLocale":"Source Locale","sourceLocaleHint":"The locale from which navigation items will be copied from.","copyFromLocaleInfoText":"Select the locale from which items will be copied from. Items will be appended to the current list of items in the active locale.","modeStatic":{"title":"Static Navigation","description":"Static Navigation Menu Only"}},"mail":{"title":"Mail","subtitle":"Configure mail settings","configuration":"Configuration","dkim":"DKIM (optional)","test":"Send a test email","testRecipient":"Recipient Email Address","testSend":"Send Email","sender":"Sender","senderName":"Sender Name","senderEmail":"Sender Email","smtp":"SMTP Settings","smtpHost":"Host","smtpPort":"Port","smtpPortHint":"Usually 465 (recommended), 587 or 25.","smtpTLS":"Secure (TLS)","smtpTLSHint":"Should be enabled when using port 465, otherwise turned off (587 or 25).","smtpUser":"Username","smtpPwd":"Password","dkimHint":"DKIM (DomainKeys Identified Mail) provides a layer of security on all emails sent from Wiki.js by providing the means for recipients to validate the domain name and ensure the message authenticity.","dkimUse":"Use DKIM","dkimDomainName":"Domain Name","dkimKeySelector":"Key Selector","dkimPrivateKey":"Private Key","dkimPrivateKeyHint":"Private key for the selector in PEM format","testHint":"Send a test email to ensure your SMTP configuration is working.","saveSuccess":"Configuration saved successfully.","sendTestSuccess":"A test email was sent successfully.","smtpVerifySSL":"Verify SSL Certificate","smtpVerifySSLHint":"Some hosts requires SSL certificate checking to be disabled. Leave enabled for proper security.","smtpName":"Client Identifying Hostname","smtpNameHint":"An optional name to send to the SMTP server to identify your mailer. Leave empty to use server hostname. For Google Workspace customers, this should be your main domain name."},"webhooks":{"title":"Webhooks","subtitle":"Manage webhooks to external services"},"adminArea":"Administration Area","analytics":{"title":"Analytics","subtitle":"Add analytics and tracking tools to your wiki","providers":"Providers","providerConfiguration":"Provider Configuration","providerNoConfiguration":"This provider has no configuration options you can modify.","refreshSuccess":"List of providers refreshed successfully.","saveSuccess":"Analytics configuration saved successfully"},"comments":{"title":"Comments","provider":"Provider","subtitle":"Add discussions to your wiki pages","providerConfig":"Provider Configuration","providerNoConfig":"This provider has no configuration options you can modify.","configSaveSuccess":"Comments configuration saved successfully."},"tags":{"title":"Tags","subtitle":"Manage page tags","emptyList":"No tags to display.","edit":"Edit Tag","tag":"Tag","label":"Label","date":"Created {{created}} and last updated {{updated}}.","delete":"Delete this tag","noSelectionText":"Select a tag from the list on the left.","noItemsText":"Add a tag to a page to get started.","refreshSuccess":"Tags have been refreshed.","deleteSuccess":"Tag deleted successfully.","saveSuccess":"Tag has been saved successfully.","filter":"Filter...","viewLinkedPages":"View Linked Pages","deleteConfirm":"Delete Tag?","deleteConfirmText":"Are you sure you want to delete tag {{tag}}? The tag will also be unlinked from all pages."},"ssl":{"title":"SSL","subtitle":"Manage SSL configuration","provider":"Provider","providerHint":"Select Custom Certificate if you have your own certificate already.","domain":"Domain","domainHint":"Enter the fully qualified domain pointing to your wiki. (e.g. wiki.example.com)","providerOptions":"Provider Options","providerDisabled":"Disabled","providerLetsEncrypt":"Let's Encrypt","providerCustomCertificate":"Custom Certificate","ports":"Ports","httpPort":"HTTP Port","httpPortHint":"Non-SSL port the server will listen to for HTTP requests. Usually 80 or 3000.","httpsPort":"HTTPS Port","httpsPortHint":"SSL port the server will listen to for HTTPS requests. Usually 443.","httpPortRedirect":"Redirect HTTP requests to HTTPS","httpPortRedirectHint":"Will automatically redirect any requests on the HTTP port to HTTPS.","writableConfigFileWarning":"Note that your config file must be writable in order to persist ports configuration.","renewCertificate":"Renew Certificate","status":"Certificate Status","expiration":"Certificate Expiration","subscriberEmail":"Subscriber Email","currentState":"Current State","httpPortRedirectTurnOn":"Turn On","httpPortRedirectTurnOff":"Turn Off","renewCertificateLoadingTitle":"Renewing Certificate...","renewCertificateLoadingSubtitle":"Do not leave this page.","renewCertificateSuccess":"Certificate renewed successfully.","httpPortRedirectSaveSuccess":"HTTP Redirection changed successfully."},"security":{"title":"Security","maxUploadSize":"Max Upload Size","maxUploadBatch":"Max Files per Upload","maxUploadBatchHint":"How many files can be uploaded in a single batch?","maxUploadSizeHint":"The maximum size for a single file.","maxUploadSizeSuffix":"bytes","maxUploadBatchSuffix":"files","uploads":"Uploads","uploadsInfo":"These settings only affect Wiki.js. If you're using a reverse-proxy (e.g. nginx, apache, Cloudflare), you must also change its settings to match.","subtitle":"Configure security settings","login":"Login","loginScreen":"Login Screen","jwt":"JWT Configuration","bypassLogin":"Bypass Login Screen","bypassLoginHint":"Should the user be redirected automatically to the first authentication provider.","loginBgUrl":"Login Background Image URL","loginBgUrlHint":"Specify an image to use as the login background. PNG and JPG are supported, 1920x1080 recommended. Leave empty for default. Click the button on the right to upload a new image. Note that the Guests group must have read-access to the selected image!","hideLocalLogin":"Hide Local Authentication Provider","hideLocalLoginHint":"Don't show the local authentication provider on the login screen. Add ?all to the URL to temporarily use it.","loginSecurity":"Security","enforce2fa":"Enforce 2FA","enforce2faHint":"Force all users to use Two-Factor Authentication when using an authentication provider with a user / password form."},"extensions":{"title":"Extensions","subtitle":"Install extensions for extra functionality"}},"editor":{"page":"Page","save":{"processing":"Rendering","pleaseWait":"Please wait...","createSuccess":"Page created successfully.","error":"An error occurred while creating the page","updateSuccess":"Page updated successfully.","saved":"Saved"},"props":{"pageProperties":"Page Properties","pageInfo":"Page Info","title":"Title","shortDescription":"Short Description","shortDescriptionHint":"Shown below the title","pathCategorization":"Path & Categorization","locale":"Locale","path":"Path","pathHint":"Do not include any leading or trailing slashes.","tags":"Tags","tagsHint":"Use tags to categorize your pages and make them easier to find.","publishState":"Publishing State","publishToggle":"Published","publishToggleHint":"Unpublished pages are still visible to users with write permissions on this page.","publishStart":"Publish starting on...","publishStartHint":"Leave empty for no start date","publishEnd":"Publish ending on...","publishEndHint":"Leave empty for no end date","info":"Info","scheduling":"Scheduling","social":"Social","categorization":"Categorization","socialFeatures":"Social Features","allowComments":"Allow Comments","allowCommentsHint":"Enable commenting abilities on this page.","allowRatings":"Allow Ratings","displayAuthor":"Display Author Info","displaySharingBar":"Display Sharing Toolbar","displaySharingBarHint":"Show a toolbar with buttons to share and print this page","displayAuthorHint":"Show the page author along with the last edition time.","allowRatingsHint":"Enable rating capabilities on this page.","scripts":"Scripts","css":"CSS","cssHint":"CSS will automatically be minified upon saving. Do not include surrounding style tags, only the actual CSS code.","styles":"Styles","html":"HTML","htmlHint":"You must surround your javascript code with HTML script tags.","toc":"TOC","tocTitle":"Table of Contents","tocUseDefault":"Use Site Defaults","tocHeadingLevels":"TOC Heading Levels","tocHeadingLevelsHint":"The table of contents will show headings from and up to the selected levels."},"unsaved":{"title":"Discard Unsaved Changes?","body":"You have unsaved changes. Are you sure you want to leave the editor and discard any modifications you made since the last save?"},"select":{"title":"Which editor do you want to use for this page?","cannotChange":"This cannot be changed once the page is created.","customView":"or create a custom view?"},"assets":{"title":"Assets","newFolder":"New Folder","folderName":"Folder Name","folderNameNamingRules":"Must follow the asset folder {{namingRules}}.","folderNameNamingRulesLink":"naming rules","folderEmpty":"This asset folder is empty.","fileCount":"{{count}} files","headerId":"ID","headerFilename":"Filename","headerType":"Type","headerFileSize":"File Size","headerAdded":"Added","headerActions":"Actions","uploadAssets":"Upload Assets","uploadAssetsDropZone":"Browse or Drop files here...","fetchImage":"Fetch Remote Image","imageAlign":"Image Alignment","renameAsset":"Rename Asset","renameAssetSubtitle":"Enter the new name for this asset:","deleteAsset":"Delete Asset","deleteAssetConfirm":"Are you sure you want to delete asset","deleteAssetWarn":"This action cannot be undone!","refreshSuccess":"List of assets refreshed successfully.","uploadFailed":"File upload failed.","folderCreateSuccess":"Asset folder created successfully.","renameSuccess":"Asset renamed successfully.","deleteSuccess":"Asset deleted successfully.","noUploadError":"You must choose a file to upload first!"},"backToEditor":"Back to Editor","markup":{"bold":"Bold","italic":"Italic","strikethrough":"Strikethrough","heading":"Heading {{level}}","subscript":"Subscript","superscript":"Superscript","blockquote":"Blockquote","blockquoteInfo":"Info Blockquote","blockquoteSuccess":"Success Blockquote","blockquoteWarning":"Warning Blockquote","blockquoteError":"Error Blockquote","unorderedList":"Unordered List","orderedList":"Ordered List","inlineCode":"Inline Code","keyboardKey":"Keyboard Key","horizontalBar":"Horizontal Bar","togglePreviewPane":"Hide / Show Preview Pane","insertLink":"Insert Link","insertAssets":"Insert Assets","insertBlock":"Insert Block","insertCodeBlock":"Insert Code Block","insertVideoAudio":"Insert Video / Audio","insertDiagram":"Insert Diagram","insertMathExpression":"Insert Math Expression","tableHelper":"Table Helper","distractionFreeMode":"Distraction Free Mode","markdownFormattingHelp":"Markdown Formatting Help","noSelectionError":"Text must be selected first!","toggleSpellcheck":"Toggle Spellcheck"},"ckeditor":{"stats":"{{chars}} chars, {{words}} words"},"conflict":{"title":"Resolve Save Conflict","useLocal":"Use Local","useRemote":"Use Remote","useRemoteHint":"Discard local changes and use latest version","useLocalHint":"Use content in the left panel","viewLatestVersion":"View Latest Version","infoGeneric":"A more recent version of this page was saved by {{authorName}}, {{date}}","whatToDo":"What do you want to do?","whatToDoLocal":"Use your current local version and ignore the latest changes.","whatToDoRemote":"Use the remote version (latest) and discard your changes.","overwrite":{"title":"Overwrite with Remote Version?","description":"Are you sure you want to replace your current version with the latest remote content? {{refEditsLost}}","editsLost":"Your current edits will be lost."},"localVersion":"Local Version {{refEditable}}","editable":"(editable)","readonly":"(read-only)","remoteVersion":"Remote Version {{refReadOnly}}","leftPanelInfo":"Your current edit, based on page version from {{date}}","rightPanelInfo":"Last edited by {{authorName}}, {{date}}","pageTitle":"Title:","pageDescription":"Description:","warning":"Save conflict! Another user has already modified this page."},"unsavedWarning":"You have unsaved edits. Are you sure you want to leave the editor?"},"tags":{"currentSelection":"Current Selection","clearSelection":"Clear Selection","selectOneMoreTags":"Select one or more tags","searchWithinResultsPlaceholder":"Search within results...","locale":"Locale","orderBy":"Order By","selectOneMoreTagsHint":"Select one or more tags on the left.","retrievingResultsLoading":"Retrieving page results...","noResults":"Couldn't find any page with the selected tags.","noResultsWithFilter":"Couldn't find any page matching the current filtering options.","pageLastUpdated":"Last Updated {{date}}","orderByField":{"creationDate":"Creation Date","ID":"ID","lastModified":"Last Modified","path":"Path","title":"Title"},"localeAny":"Any"},"history":{"restore":{"confirmTitle":"Restore page version?","confirmText":"Are you sure you want to restore this page content as it was on {{date}}? This version will be copied on top of the current history. As such, newer versions will still be preserved.","confirmButton":"Restore","success":"Page version restored succesfully!"}},"profile":{"displayName":"Display Name","location":"Location","jobTitle":"Job Title","timezone":"Timezone","title":"Profile","subtitle":"My personal info","myInfo":"My Info","viewPublicProfile":"View Public Profile","auth":{"title":"Authentication","provider":"Provider","changePassword":"Change Password","currentPassword":"Current Password","newPassword":"New Password","verifyPassword":"Confirm New Password","changePassSuccess":"Password changed successfully."},"groups":{"title":"Groups"},"activity":{"title":"Activity","joinedOn":"Joined on","lastUpdatedOn":"Profile last updated on","lastLoginOn":"Last login on","pagesCreated":"Pages created","commentsPosted":"Comments posted"},"save":{"success":"Profile saved successfully."},"pages":{"title":"Pages","subtitle":"List of pages I created or last modified","emptyList":"No pages to display.","refreshSuccess":"Page list has been refreshed.","headerTitle":"Title","headerPath":"Path","headerCreatedAt":"Created","headerUpdatedAt":"Last Updated"},"comments":{"title":"Comments"},"preferences":"Preferences","dateFormat":"Date Format","localeDefault":"Locale Default","appearance":"Appearance","appearanceDefault":"Site Default","appearanceLight":"Light","appearanceDark":"Dark"}}	f	English	English	100	2023-05-12T05:09:45.291Z	2023-06-05T05:10:13.059Z
\.


--
-- Data for Name: loggers; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.loggers (key, "isEnabled", level, config) FROM stdin;
airbrake	f	warn	{}
bugsnag	f	warn	{"key":""}
disk	f	info	{}
eventlog	f	warn	{}
loggly	f	warn	{"token":"","subdomain":""}
logstash	f	warn	{}
newrelic	f	warn	{}
papertrail	f	warn	{"host":"","port":0}
raygun	f	warn	{}
rollbar	f	warn	{"key":""}
sentry	f	warn	{"key":""}
syslog	f	warn	{}
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.migrations (id, name, batch, migration_time) FROM stdin;
1	2.0.0.js	1	2023-05-12 05:08:56.751+00
2	2.1.85.js	1	2023-05-12 05:08:56.754+00
3	2.2.3.js	1	2023-05-12 05:08:56.762+00
4	2.2.17.js	1	2023-05-12 05:08:56.765+00
5	2.3.10.js	1	2023-05-12 05:08:56.766+00
6	2.3.23.js	1	2023-05-12 05:08:56.768+00
7	2.4.13.js	1	2023-05-12 05:08:56.771+00
8	2.4.14.js	1	2023-05-12 05:08:56.78+00
9	2.4.36.js	1	2023-05-12 05:08:56.782+00
10	2.4.61.js	1	2023-05-12 05:08:56.784+00
11	2.5.1.js	1	2023-05-12 05:08:56.791+00
12	2.5.12.js	1	2023-05-12 05:08:56.792+00
13	2.5.108.js	1	2023-05-12 05:08:56.794+00
14	2.5.118.js	1	2023-05-12 05:08:56.796+00
15	2.5.122.js	1	2023-05-12 05:08:56.804+00
16	2.5.128.js	1	2023-05-12 05:08:56.806+00
\.


--
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: navigation; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.navigation (key, config) FROM stdin;
site	[{"locale":"en","items":[{"id":"7b18ca3b-c926-4b5d-a1e9-a5732d774d5b","kind":"link","label":"Home","icon":"mdi-home","targetType":"home","target":"/","visibilityMode":"all","visibilityGroups":null},{"id":"6fac7117-5fbb-4e39-8523-14c14ee9efa3","kind":"divider","label":null,"icon":null,"targetType":null,"target":null,"visibilityMode":"all","visibilityGroups":[]}]}]
\.


--
-- Data for Name: pageHistory; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."pageHistory" (id, path, hash, title, description, "isPrivate", "isPublished", "publishStartDate", "publishEndDate", action, "pageId", content, "contentType", "createdAt", "editorKey", "localeCode", "authorId", "versionDate", extra) FROM stdin;
1	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p>Home</p>\n	html	2023-05-12T05:17:26.798Z	ckeditor	en	1	2023-05-12T05:15:43.159Z	{}
2	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p>Home</p>\n	html	2023-05-12T05:22:58.607Z	ckeditor	en	1	2023-05-12T05:17:29.217Z	{}
3	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p>Mahindra</p>\n<p>Bosch</p>\n	html	2023-05-12T05:23:29.031Z	ckeditor	en	1	2023-05-12T05:23:01.015Z	{}
4	home/mahindra/home	d19fc987ac549cc78c9d3b7b341f9672d59cbaa2	M&M Home		f	t			updated	2	<ul>\n  <li><span class="text-huge"><strong>HMI</strong></span></li>\n  <li><span class="text-huge"><strong>CC</strong></span></li>\n  <li><span class="text-huge"><strong>TESTING</strong></span></li>\n  <li><span class="text-huge"><strong>DEVOPS</strong></span></li>\n</ul>\n	html	2023-05-12T05:25:48.902Z	ckeditor	en	1	2023-05-12T05:25:12.982Z	{}
5	home/mahindra/home	d19fc987ac549cc78c9d3b7b341f9672d59cbaa2	M&M Home		f	t			updated	2	<p><span class="text-big"><strong>HMI</strong></span></p>\n<p><span class="text-big"><strong>CC</strong></span></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-05-12T05:31:16.666Z	ckeditor	en	1	2023-05-12T05:25:51.369Z	{}
6	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><span class="text-big"><strong>Mahindra</strong></span></p>\n<p style="text-align:center;"><span class="text-big"><strong>Bosch</strong></span></p>\n	html	2023-05-12T05:31:57.519Z	ckeditor	en	1	2023-05-12T05:23:31.545Z	{}
7	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home"><span class="text-big"><strong>Mahindra</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n	html	2023-05-12T05:32:35.740Z	ckeditor	en	1	2023-05-12T05:32:00.022Z	{}
8	home/Bosch/home	e6190234f411ff9995dc6127954b873af198c9db	BOSCH HOME		f	t			updated	3	<p><strong>HMI</strong></p>\n<p><strong>CC</strong></p>\n<p><strong>TESTING</strong></p>\n	html	2023-05-12T05:43:05.542Z	ckeditor	en	1	2023-05-12T05:29:04.146Z	{}
9	home/Bosch/home	e6190234f411ff9995dc6127954b873af198c9db	BOSCH HOME		f	t			updated	3	<p><a href="/home/Bosch/home/HMI"><strong>HMI</strong></a></p>\n<p><strong>CC</strong></p>\n<p><strong>TESTING</strong></p>\n	html	2023-05-22T10:34:46.682Z	ckeditor	en	1	2023-05-12T05:43:07.983Z	{}
10	home/Bosch/home	e6190234f411ff9995dc6127954b873af198c9db	BOSCH HOME		f	t			moved	3	<p><a href="/home/Bosch/home/HMI"><strong>HMI</strong></a></p>\n<p><strong>CC</strong></p>\n<p><strong>TESTING</strong></p>\n	html	2023-05-22T10:34:49.139Z	ckeditor	en	1	2023-05-22T10:34:49.106Z	{}
11	home/ADPD/Bosch/home	18ee7a6f2f1a1d7bc397f2977e43e61ca2a6ecbd	BOSCH HOME		f	t			deleted	3	<p><a href="/home/Bosch/home/HMI"><strong>HMI</strong></a></p>\n<p><strong>CC</strong></p>\n<p><strong>TESTING</strong></p>\n	html	2023-05-22T12:26:10.574Z	ckeditor	en	1	2023-05-22T10:34:49.141Z	{}
12	home/ADPD	ac1862b11cfeda74cf75e00ae811936357a38085	ADPD		f	t			deleted	6	<p>ADPD</p>\n	html	2023-05-22T12:31:20.032Z	ckeditor	en	1	2023-05-22T10:33:12.909Z	{}
13	home/mahindra/home	d19fc987ac549cc78c9d3b7b341f9672d59cbaa2	M&M Home		f	t			updated	2	<p><a href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><span class="text-big"><strong>CC</strong></span></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-05-24T04:35:57.635Z	ckeditor	en	1	2023-05-12T05:31:19.164Z	{}
14	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/home"><span class="text-big"><strong>Mahindra</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n	html	2023-05-24T10:14:43.242Z	ckeditor	en	1	2023-05-12T05:32:38.226Z	{}
15	home/Bosch/home	e6190234f411ff9995dc6127954b873af198c9db	BOSCH Home		f	t			updated	8	<p><a href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><a href="/home/mahindra/home/CC"><span class="text-big"><strong>CC</strong></span></a></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-05-24T10:26:40.401Z	ckeditor	en	1	2023-05-24T10:26:19.497Z	{}
16	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/home"><span class="text-big"><strong>Mahindra</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n	html	2023-05-24T10:27:25.181Z	ckeditor	en	1	2023-05-24T10:26:20.640Z	{}
17	sample/demo	64d7c4feeb024666f5ae5836caf434e90654edc1	Demo		f	t			updated	10	<p>DEMO PAGE</p>\n	html	2023-05-24T13:00:58.317Z	ckeditor	en	1	2023-05-24T13:00:01.378Z	{}
18	sample/demo	64d7c4feeb024666f5ae5836caf434e90654edc1	Demo		f	t			moved	10	<p>DEMO PAGE</p>\n	html	2023-05-24T13:01:00.753Z	ckeditor	en	1	2023-05-24T13:01:00.720Z	{}
19	home/demo	09774cd2c18bdfeb5801befad3b89ee478c4c9d4	Demo		f	t			updated	10	<p>DEMO PAGE</p>\n	html	2023-05-24T13:02:12.631Z	ckeditor	en	1	2023-05-24T13:01:00.756Z	{}
20	home/demo	09774cd2c18bdfeb5801befad3b89ee478c4c9d4	Demo		f	t			moved	10	<p>DEMO PAGE</p>\n	html	2023-05-24T13:02:15.111Z	ckeditor	en	1	2023-05-24T13:02:15.077Z	{}
21	home/sample/demo	4248e25793862aac8822e3529f28fea57f4d93a9	Demo		f	t			updated	10	<p>DEMO PAGE</p>\n	html	2023-05-26T04:45:31.011Z	ckeditor	en	1	2023-05-24T13:02:15.114Z	{}
22	home/sample/demo1	d731136aad5ba81b33437dd332977e42c645084c	demo1		f	t			updated	11	<p>demo1</p>\n	html	2023-05-26T04:46:02.824Z	ckeditor	en	1	2023-05-24T13:03:17.328Z	{}
23	home/ADPD/homepage	0b2a1e762648ff141f850503b4766a2c54c8534c	ADPD HOME		f	t			updated	9	<p>ADPD Home</p>\n	html	2023-05-26T04:49:46.707Z	ckeditor	en	1	2023-05-24T12:01:41.815Z	{}
24	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/home"><span class="text-big"><strong>Mahindra</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n	html	2023-05-26T04:50:09.459Z	ckeditor	en	1	2023-05-24T10:27:27.631Z	{}
25	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/home"><span class="text-big"><strong>Mahindra</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n	html	2023-05-26T04:50:25.275Z	ckeditor	en	1	2023-05-26T04:50:11.916Z	{}
26	home/mahindra/home	d19fc987ac549cc78c9d3b7b341f9672d59cbaa2	M&M Home		f	t			updated	2	<p><a href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><a href="/home/mahindra/home/CC"><span class="text-big"><strong>CC</strong></span></a></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-05-26T04:51:55.304Z	ckeditor	en	1	2023-05-24T04:36:00.057Z	{}
27	home/mahindra/home	d19fc987ac549cc78c9d3b7b341f9672d59cbaa2	MSDVC		f	t			updated	2	<p><a href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><a href="/home/mahindra/home/CC"><span class="text-big"><strong>CC</strong></span></a></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-05-26T04:52:29.152Z	ckeditor	en	1	2023-05-26T04:51:57.736Z	{}
28	home/mahindra/home	d19fc987ac549cc78c9d3b7b341f9672d59cbaa2	MSDVC		f	t			moved	2	<p><a href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><a href="/home/mahindra/home/CC"><span class="text-big"><strong>CC</strong></span></a></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-05-26T04:52:31.635Z	ckeditor	en	1	2023-05-26T04:52:31.595Z	{}
29	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/home"><span class="text-big"><strong>Mahindra</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n	html	2023-06-01T12:09:43.471Z	ckeditor	en	1	2023-05-26T04:50:27.696Z	{}
30	home/mahindra/MRV	2b6220794c0522342dbc996f7fac5e6bd039e707	MRV HOME PAGE		f	t			updated	12	<p>MRV DEMO PAGE</p>\n	html	2023-06-01T12:10:07.026Z	ckeditor	en	1	2023-06-01T12:07:43.574Z	{}
31	home/mahindra/home/HMI	066e743f62aa8333408240bc8432cba9a3ce3f78	HMI		f	t			updated	4	<p style="text-align:center;"><strong>HMI DEMO PAGE</strong></p>\n	html	2023-06-01T12:20:58.918Z	ckeditor	en	1	2023-05-12T05:30:26.057Z	{}
32	home/Bosch/home	e6190234f411ff9995dc6127954b873af198c9db	BOSCH Home		f	t			updated	8	<p><span class="text-big"><strong>HMI</strong></span></p>\n<p><span class="text-big"><strong>CC</strong></span></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	html	2023-06-01T12:21:50.454Z	ckeditor	en	1	2023-05-24T10:26:42.786Z	{}
33	home/mahindra/home/CC	b4845f9c32745df8af20665fb2d78c72a6169972	CC		f	t			updated	7	= **CC**\n\n> Hi this is a\nCC DEMO PAGE	asciidoc	2023-06-01T12:22:37.155Z	asciidoc	en	1	2023-05-24T04:34:37.571Z	{}
34	home/Bosch/home/HMI	4d9554be40219bd6e9945f4d81d92fd0c1a4380b	HMI		f	t			updated	5	<p><strong>HMI DEMO PAGE</strong></p>\n	html	2023-06-01T12:23:33.797Z	ckeditor	en	1	2023-05-12T05:42:38.673Z	{}
35	home/mahindra/home/CC	b4845f9c32745df8af20665fb2d78c72a6169972	CC		f	t			moved	7	= **CC**\n\n> Hi this is a\nCC DEMO PAGE	asciidoc	2023-06-01T12:35:02.327Z	asciidoc	en	1	2023-06-01T12:22:40.097Z	{}
36	home/mahindra/home/HMI	066e743f62aa8333408240bc8432cba9a3ce3f78	HMI		f	t			moved	4	<p style="text-align:center;"><strong>HMI DEMO PAGE</strong></p>\n	html	2023-06-01T12:36:01.110Z	ckeditor	en	1	2023-06-01T12:21:01.359Z	{}
37	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/MRV"><span class="text-big"><strong>MRV</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/mahindra/MDSVC"><span class="text-big"><strong>MSDVC</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n<p style="text-align:center;">&nbsp;</p>\n	html	2023-06-02T07:48:24.499Z	ckeditor	en	1	2023-06-01T12:09:45.980Z	{}
38	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			updated	1	<p style="text-align:center;"><a href="/home/mahindra/MRV"><span class="text-big"><strong>MRV</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/mahindra/MDSVC"><span class="text-big"><strong>MSDVC</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n<p style="text-align:center;">APTIV</p>\n	html	2023-06-02T07:48:43.499Z	ckeditor	en	1	2023-06-02T07:48:29.655Z	{}
39	home/mahindra/new-page	307fcf0842ad6b115ef01b01bbf923b30dc12822	MSDVC CBE	SOFTWARE DEFINED VEHICLE CENTER	f	t			deleted	13	MSDV\n\nHI THIS IS THE TEST PAGE	markdown	2023-06-05T04:09:56.532Z	markdown	en	1	2023-06-05T04:06:53.236Z	{}
40	home/mahindra/home/HMI	066e743f62aa8333408240bc8432cba9a3ce3f78	HMI HomePage	Home page for HMI team	f	t			updated	14	== Introduction\n\nThis is a home page for HMI team to further update their contents	asciidoc	2023-06-05T05:53:09.407Z	asciidoc	en	1	2023-06-05T05:51:57.511Z	{}
41	home/mahindra/home/HMI	066e743f62aa8333408240bc8432cba9a3ce3f78	HMI HomePage	Home page for HMI team	f	t			moved	14	== Introduction\n\nThis is a home page for HMI team to further update their contents	asciidoc	2023-06-05T05:53:12.425Z	asciidoc	en	1	2023-06-05T05:53:12.342Z	{}
42	msdv/HMI	038b186e65ab97d35a60fe7d20ed8fc3947efbbc	HMI HomePage	Home page for HMI team	f	t			updated	14	== Introduction\n\nThis is a home page for HMI team to further update their contents	asciidoc	2023-06-05T05:57:05.374Z	asciidoc	en	1	2023-06-05T05:53:12.427Z	{}
43	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	Home		f	t			deleted	1	<p style="text-align:center;"><a href="/home/mahindra/MRV"><span class="text-big"><strong>MRV</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/mahindra/MDSVC"><span class="text-big"><strong>MSDVC</strong></span></a></p>\n<p style="text-align:center;"><a href="/home/Bosch/home"><span class="text-big"><strong>Bosch</strong></span></a></p>\n<p style="text-align:center;">&nbsp;</p>\n	html	2023-06-05T06:19:04.722Z	ckeditor	en	1	2023-06-02T07:48:45.983Z	{}
\.


--
-- Data for Name: pageHistoryTags; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."pageHistoryTags" (id, "pageId", "tagId") FROM stdin;
\.


--
-- Data for Name: pageLinks; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."pageLinks" (id, path, "localeCode", "pageId") FROM stdin;
1	home/mahindra/home/HMI	en	2
6	home/mahindra/home/CC	en	2
11	home/ADPD/homepage	en	14
\.


--
-- Data for Name: pageTags; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."pageTags" (id, "pageId", "tagId") FROM stdin;
12	10	2
13	11	2
14	9	3
16	2	5
17	12	6
18	4	7
19	8	8
20	7	9
21	5	10
22	14	7
23	15	11
\.


--
-- Data for Name: pageTree; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."pageTree" (id, path, depth, title, "isPrivate", "isFolder", "privateNS", parent, "pageId", "localeCode", ancestors) FROM stdin;
1	home	1	HMI	f	t	\N	\N	15	en	[]
2	home/ADPD	2	ADPD	f	t	\N	1	\N	en	[1]
3	home/ADPD/homepage	3	ADPD HOME	f	f	\N	2	9	en	[1,2]
4	home/Bosch	2	Bosch	f	t	\N	1	\N	en	[1]
5	home/Bosch/home	3	BOSCH Home	f	t	\N	4	8	en	[1,4]
6	home/Bosch/home/HMI	4	HMI	f	f	\N	5	5	en	[1,4,5]
7	home/mahindra	2	mahindra	f	t	\N	1	\N	en	[1]
8	home/mahindra/MDSVC	3	MSDVC	f	t	\N	7	2	en	[1,7]
9	home/mahindra/MDSVC/CC	4	CC	f	f	\N	8	7	en	[1,7,8]
10	home/mahindra/MDSVC/HMI	4	HMI	f	f	\N	8	4	en	[1,7,8]
11	home/mahindra/MRV	3	MRV HOME PAGE	f	f	\N	7	12	en	[1,7]
12	home/sample	2	sample	f	t	\N	1	\N	en	[1]
13	home/sample/demo	3	Demo	f	f	\N	12	10	en	[1,12]
14	home/sample/demo1	3	demo1	f	f	\N	12	11	en	[1,12]
15	msdv	1	msdv	f	t	\N	\N	\N	en	[]
16	msdv/HMI	2	HMI HomePage	f	f	\N	15	14	en	[15]
\.


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.pages (id, path, hash, title, description, "isPrivate", "isPublished", "privateNS", "publishStartDate", "publishEndDate", content, render, toc, "contentType", "createdAt", "updatedAt", "editorKey", "localeCode", "authorId", "creatorId", extra) FROM stdin;
15	home	b29b5d2ce62e55412776ab98f05631e0aa96597b	HMI	Homepage for HMI	f	t	\N			# HMI\nHI WELCOME TO HMI	<h1 class="toc-header" id="hmi"><a href="#hmi" class="toc-anchor">¶</a> HMI</h1>\n<p>HI WELCOME TO HMI</p>\n	[{"title":"HMI","anchor":"#hmi","children":[]}]	markdown	2023-06-05T06:20:27.651Z	2023-06-05T06:20:30.385Z	markdown	en	1	1	{"js":"","css":""}
4	home/mahindra/MDSVC/HMI	eae420deffa0b3d23df864d8a3ab5172621822e9	HMI		f	t	\N			<p style="text-align:center;"><strong>HMI DEMO PAGE</strong></p>\n	<p style="text-align:center;"><strong>HMI DEMO PAGE</strong></p>\n	[]	html	2023-05-12T05:30:23.587Z	2023-06-01T12:36:01.115Z	ckeditor	en	1	1	{"js":"","css":""}
8	home/Bosch/home	e6190234f411ff9995dc6127954b873af198c9db	BOSCH Home		f	t	\N			<p><span class="text-big"><strong>HMI</strong></span></p>\n<p><span class="text-big"><strong>CC</strong></span></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	<p><span class="text-big"><strong>HMI</strong></span></p>\n<p><span class="text-big"><strong>CC</strong></span></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	[]	html	2023-05-24T10:26:16.920Z	2023-06-01T12:21:52.954Z	ckeditor	en	1	1	{"js":"","css":""}
14	msdv/HMI	038b186e65ab97d35a60fe7d20ed8fc3947efbbc	HMI HomePage	Home page for HMI team	f	t	\N			= Introduction\n\nThis is a home page for HMI team to further update their contents\n\n= About us\n\nlink:/home/ADPD/homepage[homepage]\n\n	<h1 class="toc-header" id="introduction"><a href="#introduction" class="toc-anchor">¶</a> Introduction</h1>\n<div id="preamble">\n<div class="sectionbody">\n<div class="paragraph">\n<p>This is a home page for HMI team to further update their contents</p>\n</div>\n</div>\n</div>\n<h1 class="sect0 toc-header" id="_about_us"><a href="#_about_us" class="toc-anchor">¶</a> About us</h1>\n<div class="paragraph">\n<p><a class="is-internal-link is-valid-page" href="/home/ADPD/homepage">homepage</a></p>\n</div>	[{"title":"Introduction","anchor":"#introduction","children":[]},{"title":"About us","anchor":"#_about_us","children":[]}]	asciidoc	2023-06-05T05:51:54.546Z	2023-06-05T05:57:08.322Z	asciidoc	en	1	1	{"js":"","css":""}
10	home/sample/demo	4248e25793862aac8822e3529f28fea57f4d93a9	Demo		f	t	\N			<p>DEMO PAGE</p>\n	<p>DEMO PAGE</p>\n	[]	html	2023-05-24T12:59:58.864Z	2023-05-26T04:45:36.167Z	ckeditor	en	1	1	{"js":"","css":""}
11	home/sample/demo1	d731136aad5ba81b33437dd332977e42c645084c	demo1		f	t	\N			<p>demo1</p>\n	<p>demo1</p>\n	[]	html	2023-05-24T13:03:14.863Z	2023-05-26T04:46:05.261Z	ckeditor	en	1	1	{"js":"","css":""}
12	home/mahindra/MRV	2b6220794c0522342dbc996f7fac5e6bd039e707	MRV HOME PAGE		f	t	\N			<p>MRV HOME PAGE</p>\n	<p>MRV HOME PAGE</p>\n	[]	html	2023-06-01T12:07:38.672Z	2023-06-01T12:10:09.480Z	ckeditor	en	1	1	{"js":"","css":""}
9	home/ADPD/homepage	0b2a1e762648ff141f850503b4766a2c54c8534c	ADPD HOME		f	t	\N			<p>ADPD Home</p>\n	<p>ADPD Home</p>\n	[]	html	2023-05-24T12:01:39.404Z	2023-05-26T04:49:49.159Z	ckeditor	en	1	1	{"js":"","css":""}
5	home/Bosch/home/HMI	4d9554be40219bd6e9945f4d81d92fd0c1a4380b	HMI		f	t	\N			<p><strong>HMI DEMO PAGE</strong></p>\n	<p><strong>HMI DEMO PAGE</strong></p>\n	[]	html	2023-05-12T05:42:36.246Z	2023-06-01T12:23:36.243Z	ckeditor	en	1	1	{"js":"","css":""}
7	home/mahindra/MDSVC/CC	6c59ff9f57b94fb49f451a3b0ffe2c6096c9ba74	CC		f	t	\N			= **CC**\n\n> Hi this is a\nCC DEMO PAGE	<h1 class="toc-header" id="cc"><a href="#cc" class="toc-anchor">¶</a> <strong>CC</strong></h1>\n<div class="quoteblock">\n<blockquote>\n<div class="paragraph">\n<p>Hi this is a\nCC DEMO PAGE</p>\n</div>\n</blockquote>\n</div>	[{"title":"CC","anchor":"#cc","children":[]}]	asciidoc	2023-05-24T04:34:31.887Z	2023-06-01T12:35:02.331Z	asciidoc	en	1	1	{"js":"","css":""}
2	home/mahindra/MDSVC	4ef3b2814be6d3ff9298ffbc2c2558d8bb104b14	MSDVC		f	t	\N			<p><a href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><a href="/home/mahindra/home/CC"><span class="text-big"><strong>CC</strong></span></a></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	<p><a class="is-internal-link is-valid-page" href="/home/mahindra/home/HMI"><span class="text-big"><strong>HMI</strong></span></a></p>\n<p><a class="is-internal-link is-valid-page" href="/home/mahindra/home/CC"><span class="text-big"><strong>CC</strong></span></a></p>\n<p><span class="text-big"><strong>TESTING</strong></span></p>\n<p><span class="text-big"><strong>DEVOPS</strong></span></p>\n	[]	html	2023-05-12T05:25:10.495Z	2023-06-05T05:51:58.759Z	ckeditor	en	1	1	{"js":"","css":""}
\.


--
-- Data for Name: renderers; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.renderers (key, "isEnabled", config) FROM stdin;
asciidocCore	t	{"safeMode":"server"}
htmlAsciinema	f	{}
htmlBlockquotes	t	{}
htmlCodehighlighter	t	{}
htmlCore	t	{"absoluteLinks":false,"openExternalLinkNewTab":false,"relAttributeExternalLink":"noreferrer"}
htmlDiagram	t	{}
htmlImagePrefetch	f	{}
htmlMediaplayers	t	{}
htmlMermaid	t	{}
htmlSecurity	t	{"safeHTML":true,"allowDrawIoUnsafe":true,"allowIFrames":false}
htmlTabset	t	{}
htmlTwemoji	t	{}
markdownAbbr	t	{}
markdownCore	t	{"allowHTML":true,"linkify":true,"linebreaks":true,"underline":false,"typographer":false,"quotes":"English"}
markdownEmoji	t	{}
markdownExpandtabs	t	{"tabWidth":4}
markdownFootnotes	t	{}
markdownImsize	t	{}
markdownKatex	t	{"useInline":true,"useBlocks":true}
markdownKroki	f	{"server":"https://kroki.io","openMarker":"```kroki","closeMarker":"```"}
markdownMathjax	f	{"useInline":true,"useBlocks":true}
markdownMultiTable	f	{"multilineEnabled":true,"headerlessEnabled":true,"rowspanEnabled":true}
markdownPlantuml	t	{"server":"https://plantuml.requarks.io","openMarker":"```plantuml","closeMarker":"```","imageFormat":"svg"}
markdownSupsub	t	{"subEnabled":true,"supEnabled":true}
markdownTasklists	t	{}
openapiCore	t	{}
\.


--
-- Data for Name: searchEngines; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."searchEngines" (key, "isEnabled", config) FROM stdin;
algolia	f	{"appId":"","apiKey":"","indexName":"wiki"}
aws	f	{"domain":"","endpoint":"","region":"us-east-1","accessKeyId":"","secretAccessKey":"","AnalysisSchemeLang":"en"}
azure	f	{"serviceName":"","adminKey":"","indexName":"wiki"}
db	t	{}
elasticsearch	f	{"apiVersion":"6.x","hosts":"","verifyTLSCertificate":true,"tlsCertPath":"","indexName":"wiki","analyzer":"simple","sniffOnStart":false,"sniffInterval":0}
manticore	f	{}
postgres	f	{"dictLanguage":"english"}
solr	f	{"host":"solr","port":8983,"core":"wiki","protocol":"http"}
sphinx	f	{}
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.sessions (sid, sess, expired) FROM stdin;
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.settings (key, value, "updatedAt") FROM stdin;
graphEndpoint	{"v":"https://graph.requarks.io"}	2023-05-12T05:09:45.180Z
lang	{"code":"en","autoUpdate":true,"namespacing":false,"namespaces":[]}	2023-05-12T05:09:45.188Z
logo	{"hasLogo":false,"logoIsSquare":false}	2023-05-12T05:09:45.192Z
telemetry	{"isEnabled":true,"clientId":"a4c0d3d1-95c0-4b34-bb02-cd3a67cff220"}	2023-05-12T05:09:45.205Z
theming	{"theme":"default","darkMode":true,"iconset":"mdi","injectCSS":"","injectHead":"","injectBody":"","tocPosition":"right"}	2023-05-24T10:07:57.842Z
host	{"v":"https://wiki.yourdomain.com"}	2023-05-12T05:21:58.320Z
title	{"v":"Mahindra"}	2023-05-12T05:21:58.324Z
company	{"v":""}	2023-05-12T05:21:58.326Z
contentLicense	{"v":""}	2023-05-12T05:21:58.328Z
footerOverride	{"v":""}	2023-05-12T05:21:58.329Z
seo	{"description":"","robots":["index","follow"],"analyticsService":"","analyticsId":""}	2023-05-12T05:21:58.331Z
logoUrl	{"v":"/mahindra-rise-logo-vector-01.svg"}	2023-05-12T05:21:58.338Z
pageExtensions	{"v":["md","html","txt"]}	2023-05-12T05:21:58.343Z
auth	{"audience":"urn:wiki.js","tokenExpiration":"30m","tokenRenewal":"14d"}	2023-05-12T05:21:58.347Z
editShortcuts	{"editFab":true,"editMenuBar":true,"editMenuBtn":true,"editMenuExternalBtn":true,"editMenuExternalName":"GitHub","editMenuExternalIcon":"mdi-github","editMenuExternalUrl":"https://github.com/org/repo/blob/main/{filename}"}	2023-05-12T05:21:58.349Z
features	{"featurePageRatings":true,"featurePageComments":true,"featurePersonalWikis":true}	2023-05-12T05:21:58.351Z
security	{"securityOpenRedirect":true,"securityIframe":true,"securityReferrerPolicy":true,"securityTrustProxy":true,"securitySRI":true,"securityHSTS":false,"securityHSTSDuration":300,"securityCSP":false,"securityCSPDirectives":""}	2023-05-12T05:21:58.352Z
uploads	{"maxFileSize":5242880,"maxFiles":10,"scanSVG":true,"forceDownload":true}	2023-05-12T05:21:58.354Z
certs	{"jwk":{"kty":"RSA","n":"z--6gQsCVcwq7HZptz8pTwh_32qvPPUP-Mgoaa68Yn_yPK6g_xgAYmznpElNis1g_ZhCirarq1nR18wV69RYJhzsR3ots0cEv78ZxXiT1TUZkzD5WaVk7qkK8XhlkyXwacgK-wXo-AHMlg-6ytp1XYRLwxcu25pLwGtViw9_Wnp1UaCG0UVd2LKrgjCSuUxv194ObOmTDyqQaIqzvCkKcWAsXYgKwOymHlgwx4rglURmoVyqeCPNltBmfnGydoKfRGHVcoJ-1xr9IoXBKYBbyv_7ZrQwXKazee7lvzlHybRXauusQE1qQOPtrzbCTEA0eWcSnhn88hrcaC15pFcs0w","e":"AQAB"},"public":"-----BEGIN RSA PUBLIC KEY-----\\nMIIBCgKCAQEAz++6gQsCVcwq7HZptz8pTwh/32qvPPUP+Mgoaa68Yn/yPK6g/xgA\\nYmznpElNis1g/ZhCirarq1nR18wV69RYJhzsR3ots0cEv78ZxXiT1TUZkzD5WaVk\\n7qkK8XhlkyXwacgK+wXo+AHMlg+6ytp1XYRLwxcu25pLwGtViw9/Wnp1UaCG0UVd\\n2LKrgjCSuUxv194ObOmTDyqQaIqzvCkKcWAsXYgKwOymHlgwx4rglURmoVyqeCPN\\nltBmfnGydoKfRGHVcoJ+1xr9IoXBKYBbyv/7ZrQwXKazee7lvzlHybRXauusQE1q\\nQOPtrzbCTEA0eWcSnhn88hrcaC15pFcs0wIDAQAB\\n-----END RSA PUBLIC KEY-----\\n","private":"-----BEGIN RSA PRIVATE KEY-----\\nProc-Type: 4,ENCRYPTED\\nDEK-Info: AES-256-CBC,39C46BD53ADB90CCEF8D1F9DB0867A5B\\n\\nJGRpOQcPMQe+HU1Ugm3O23HFGs3S7impzOSfUEEk+l5DlsuijFRy+4FQGPHNbbr0\\nUsCKaVszHCk3DXXnbKORb3GIGBkNWRW2PqhPWNwHw+vVwqKuxMZeDPFtO2IgGykD\\nmdpdj0Z7AFDjRHegq+HqzSDDCWNMzWfa++5IUDM13OHXO8XxfV3EEvuud2qAzHiq\\nwcnQrXAsiJvCndfzBkLxk/3hoZzNyVwBJVVvweyBnviICu6j52HlQFatDqp9GSOv\\nrPheA94TDY8H9slLE5WX7w5bUVA0DCVtjcsnS55r60b2+VvacgwnPxOE5bxtamwy\\nOwAb1j+uQvQ7WZXr3GMJGHaAlOxEhC3sV5Hdh0QxfxDyHh+aCqEuinfTMM8NdgZ1\\nkDHUa6JueAjIJjggvPmgCH0+K0hcSAgDVDQjSB8WJswU3aPx24q4OGKUwg/PPSvR\\ns7MgsU6TIZKphbqHF9uJKl5K9Fj/LN8k2NIjQBXanTcdDOwBLakqL+cFrFN0BG6V\\nTK/wveJhz2eVic+mZks7tC9Z+WDwQNi2EuM0NBr0lGCq4W1aANnsg6JcmVV2ualb\\nyY+Jl5Zf7GxxOlSP0HF2N2UbeGXWbG6xW1paYJmAI154siEZDiDp6ljxsvsSyncb\\n0X8qQqttUx0jF6hsWfZZMMC/kcOHng/L0EVJbWoR8R0h98P1ttxpN1/Z1iyEk+DV\\n5QSk2eZahL7UHnlmz8HKACNHPxMZTOBaejrPzt0BGXIgQ5uozbxa3TlpNrdbWLVk\\nTIJgcg5thG0QI2uiGsNR4fwo+7DVVLP4IKyH+jvwk2a36Wyyk/0e9EKGrDBmk40K\\n9pHRj7UPbfeO+eO32q3kWKfXAxru2xF4MIGOyWm1+zDQm6an1BiCMrZgi+JOZu7P\\nKEude/vjvgXxlCQewJ3e0oClK9m0rfE2axlzmkiQPFryI8u+e2d4pNGU6iIXgjTa\\nlO+OJaiYy+5Yl0h2V7yCRBbgSzR7Q0nuhZMdfqIH1bXWDTe/iaxer9+jOohuX462\\ndOVUtzDSgfyS8H5Yr7HEuA4JTru9z014A7pZVkBsAZ6xJHpfEw2eqpRqwo3kbQg/\\ne/yZ7ea9HazU73wzxC6DDu6/q8ZCtPsY2OUzFKrYdWRjRc5sBea3C2iU6uHRBvEC\\nHb2m7tUvdAHlQyuQpXY0ZRarNYIIhzUFa7ZZnfqlU3olDAltqcfkJ8iaqL+IayHx\\nnhV5vNrmSED/RKS6o1WE20hUW0fHuCDspMkcS0oPzoyvm9jBH2l2o203nk4gVCA+\\nH1XpW5mBj60VT0FWzyAx22QcglzH+cLB1ZNsS4pfLIHh/VOf8byuNSo9DbhCZwE9\\nTceyofVNh7mrP+Pls2DeDEc8NnSUyAr56yzTOr8zZyXznhZ94QH6uabwIOI5i5fO\\n8+oS0rjpdyI5DdbDPK4w0fPEax3PuTAIsJiF/4wcMJ6QgCTv0iSFMD1hgoUoYgYz\\n6jMC1tLPd16eg+CKZPrBlGEcSHfhSyUPW0OX7/XZzuhK6l4lCA2AQUsVSo79Ga6A\\njOMWHmWMlh7dfaycRXwtoOqRTQYDa1fv8s4LTqgbD4ytZsOvtj9R5ZBCE6MAMf2N\\n-----END RSA PRIVATE KEY-----\\n"}	2023-05-18T10:39:39.006Z
sessionSecret	{"v":"ad38449e1112c6eb6f160ac9ef169c22a903a8e755cca5322efbb901a6460739"}	2023-05-18T10:39:39.010Z
api	{"isEnabled":false}	2023-05-24T10:19:31.976Z
nav	{"mode":"MIXED"}	2023-05-25T06:19:38.612Z
mail	{"senderName":"Admin_Wiki","senderEmail":"adminwiki@mahindra.com","host":"smtp.gmail.com","port":465,"name":"smtp.gmail.com","secure":true,"verifySSL":true,"user":"mohanpalanisamy30@gmail.com","pass":"Mohansmart@046","useDKIM":false,"dkimDomainName":"","dkimKeySelector":"","dkimPrivateKey":""}	2023-06-01T09:34:17.382Z
\.


--
-- Data for Name: storage; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.storage (key, "isEnabled", mode, config, "syncInterval", state) FROM stdin;
azure	f	push	{"accountName":"","accountKey":"","containerName":"wiki","storageTier":"Cool"}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
box	f	push	{"clientId":"","clientSecret":"","rootFolder":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
digitalocean	f	push	{"endpoint":"nyc3.digitaloceanspaces.com","bucket":"","accessKeyId":"","secretAccessKey":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
dropbox	f	push	{"appKey":"","appSecret":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
git	f	sync	{"authType":"ssh","repoUrl":"","branch":"master","sshPrivateKeyMode":"path","sshPrivateKeyPath":"","sshPrivateKeyContent":"","verifySSL":true,"basicUsername":"","basicPassword":"","defaultEmail":"name@company.com","defaultName":"John Smith","localRepoPath":"./data/repo","gitBinaryPath":""}	PT5M	{"status":"pending","message":"Initializing...","lastAttempt":null}
gdrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
disk	f	push	{"path":"","createDailyBackups":false}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
onedrive	f	push	{"clientId":"","clientSecret":""}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
s3generic	f	push	{"endpoint":"https://service.region.example.com","bucket":"","accessKeyId":"","secretAccessKey":"","sslEnabled":true,"s3ForcePathStyle":false,"s3BucketEndpoint":false}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
sftp	f	push	{"host":"","port":22,"authMode":"privateKey","username":"","privateKey":"","passphrase":"","password":"","basePath":"/root/wiki"}	P0D	{"status":"pending","message":"Initializing...","lastAttempt":null}
s3	t	push	{"region":"ap-south-1","bucket":"wiki0601","accessKeyId":"AKIAY7OWLB3VAIYOO252","secretAccessKey":"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"}	P0D	{"status":"operational","message":"","lastAttempt":"2023-06-01T11:04:55.195Z"}
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.tags (id, tag, title, "createdAt", "updatedAt") FROM stdin;
1	1.0	1.0	2023-05-12T05:15:40.400Z	2023-05-12T05:15:40.400Z
2	demo	demo	2023-05-26T04:45:31.023Z	2023-05-26T04:45:31.023Z
3	adpd	adpd	2023-05-26T04:49:46.717Z	2023-05-26T04:49:46.717Z
4	home	home	2023-05-26T04:50:25.283Z	2023-05-26T04:50:25.283Z
5	msdvc home	msdvc home	2023-05-26T04:51:55.320Z	2023-05-26T04:51:55.320Z
6	mrv	mrv	2023-06-01T12:07:38.682Z	2023-06-01T12:07:38.682Z
7	msdvc_hmi	msdvc_hmi	2023-06-01T12:20:58.928Z	2023-06-01T12:20:58.928Z
8	bosch	bosch	2023-06-01T12:21:50.466Z	2023-06-01T12:21:50.466Z
9	msdvc_cc	msdvc_cc	2023-06-01T12:22:37.164Z	2023-06-01T12:22:37.164Z
10	bosch_hmi	bosch_hmi	2023-06-01T12:23:33.808Z	2023-06-01T12:23:33.808Z
11	homepage	homepage	2023-06-05T06:20:27.664Z	2023-06-05T06:20:27.664Z
\.


--
-- Data for Name: userAvatars; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."userAvatars" (id, data) FROM stdin;
\.


--
-- Data for Name: userGroups; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."userGroups" (id, "userId", "groupId") FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
5	5	1
6	6	1
8	8	3
9	8	4
\.


--
-- Data for Name: userKeys; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public."userKeys" (id, kind, token, "createdAt", "validUntil", "userId") FROM stdin;
1	tfaSetup	PhmuOXHPr3vWWhrcveGeC	2023-06-01T04:39:25.967Z	2023-06-02T04:39:25.954Z	6
3	tfaSetup	fITVdwIaVUQQZUwmGS2Qt	2023-06-01T04:45:30.864Z	2023-06-02T04:45:30.863Z	6
5	tfaSetup	BcnNHnS_O8K72bl-Qc-Rx	2023-06-01T09:12:33.106Z	2023-06-02T09:12:33.106Z	6
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wiki
--

COPY public.users (id, email, name, "providerId", password, "tfaIsActive", "tfaSecret", "jobTitle", location, "pictureUrl", timezone, "isSystem", "isActive", "isVerified", "mustChangePwd", "createdAt", "updatedAt", "providerKey", "localeCode", "defaultEditor", "lastLoginAt", "dateFormat", appearance) FROM stdin;
2	guest@example.com	Guest	\N		f	\N			\N	America/New_York	t	t	t	f	2023-05-12T05:09:46.052Z	2023-05-12T05:09:46.052Z	local	en	markdown	\N		
8	cf01@gmail.com	cff	\N	$2a$12$O06YS0QwAZ6YgNYnsb1DcO25g8mYOmGMLFQHEZI/iF3uZRAZMaqUW	f	\N			\N	America/New_York	f	t	t	f	2023-06-05T03:30:48.181Z	2023-06-05T03:47:48.790Z	local	en	markdown	2023-06-05T03:47:48.795Z		
4	demo@bosch.com	bosch_demo	\N	$2a$12$BaayOw/JbsskCyOknOmKberYPXTCwsv01Mk3tlxCH4sCG1zq/nsxe	f	\N			\N	America/New_York	f	t	t	f	2023-05-12T05:34:24.622Z	2023-05-12T05:34:24.622Z	local	en	markdown	2023-05-12T11:13:47.887Z		
5	admin1@mahindra.com	admin1@mahindra.com	\N	$2a$12$EnRH/npcoflLqMnpxWoN6eCrZGVRENsy2pNhMf5mGn8WfxaX9hM62	f	\N			\N	America/New_York	f	t	t	f	2023-05-25T11:56:10.764Z	2023-05-25T11:56:10.764Z	local	en	markdown	2023-05-25T11:56:57.863Z		
3	demo@mahindra.com	demo_mahindra	\N	$2a$12$B1gk401eqjxlea92R9Szl.hceAaOj56rNFcmC8LugQvZStZcWYZOS	f	\N			\N	America/New_York	f	t	t	f	2023-05-12T05:33:46.969Z	2023-05-12T05:34:39.060Z	local	en	markdown	2023-06-01T12:14:23.840Z		
1	admin@mahindra.com	Administrator	\N	$2a$12$dFhsAucaEbdRlxh7CapFtuaLFtoUCXK7NzFkhkhOpmyDwpvJHoSIK	f	\N			\N	America/New_York	f	t	t	f	2023-05-12T05:09:45.559Z	2023-05-12T05:33:00.171Z	local	en	markdown	2023-06-05T09:30:31.898Z		
6	mohanpalanisamy30@gmail.com	Mohan	\N	$2a$12$mMNKN/kkNR3Qk8Y.4GrPGuODWR3egbvii4S6NFLifeREX7mR7VBhO	f	2GI6DZ3XUQX36VWQPLERWG3DFIIEUK2O			\N	America/New_York	f	t	t	f	2023-06-01T04:37:32.974Z	2023-06-01T09:12:33.081Z	local	en	markdown	2023-06-01T09:10:53.303Z		
\.


--
-- Name: apiKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."apiKeys_id_seq"', 1, false);


--
-- Name: assetFolders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."assetFolders_id_seq"', 1, false);


--
-- Name: assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.assets_id_seq', 1, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.comments_id_seq', 8, true);


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.groups_id_seq', 6, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- Name: migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.migrations_lock_index_seq', 1, true);


--
-- Name: pageHistoryTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."pageHistoryTags_id_seq"', 1, false);


--
-- Name: pageHistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."pageHistory_id_seq"', 43, true);


--
-- Name: pageLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."pageLinks_id_seq"', 11, true);


--
-- Name: pageTags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."pageTags_id_seq"', 23, true);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.pages_id_seq', 15, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.tags_id_seq', 11, true);


--
-- Name: userGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."userGroups_id_seq"', 9, true);


--
-- Name: userKeys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public."userKeys_id_seq"', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wiki
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);


--
-- Name: analytics analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.analytics
    ADD CONSTRAINT analytics_pkey PRIMARY KEY (key);


--
-- Name: apiKeys apiKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."apiKeys"
    ADD CONSTRAINT "apiKeys_pkey" PRIMARY KEY (id);


--
-- Name: assetData assetData_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."assetData"
    ADD CONSTRAINT "assetData_pkey" PRIMARY KEY (id);


--
-- Name: assetFolders assetFolders_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT "assetFolders_pkey" PRIMARY KEY (id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (id);


--
-- Name: authentication authentication_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.authentication
    ADD CONSTRAINT authentication_pkey PRIMARY KEY (key);


--
-- Name: commentProviders commentProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."commentProviders"
    ADD CONSTRAINT "commentProviders_pkey" PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editors editors_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.editors
    ADD CONSTRAINT editors_pkey PRIMARY KEY (key);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: locales locales_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.locales
    ADD CONSTRAINT locales_pkey PRIMARY KEY (code);


--
-- Name: loggers loggers_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.loggers
    ADD CONSTRAINT loggers_pkey PRIMARY KEY (key);


--
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: navigation navigation_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.navigation
    ADD CONSTRAINT navigation_pkey PRIMARY KEY (key);


--
-- Name: pageHistoryTags pageHistoryTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT "pageHistoryTags_pkey" PRIMARY KEY (id);


--
-- Name: pageHistory pageHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT "pageHistory_pkey" PRIMARY KEY (id);


--
-- Name: pageLinks pageLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT "pageLinks_pkey" PRIMARY KEY (id);


--
-- Name: pageTags pageTags_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT "pageTags_pkey" PRIMARY KEY (id);


--
-- Name: pageTree pageTree_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT "pageTree_pkey" PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: renderers renderers_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.renderers
    ADD CONSTRAINT renderers_pkey PRIMARY KEY (key);


--
-- Name: searchEngines searchEngines_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."searchEngines"
    ADD CONSTRAINT "searchEngines_pkey" PRIMARY KEY (key);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (key);


--
-- Name: storage storage_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.storage
    ADD CONSTRAINT storage_pkey PRIMARY KEY (key);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_tag_unique; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_tag_unique UNIQUE (tag);


--
-- Name: userAvatars userAvatars_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userAvatars"
    ADD CONSTRAINT "userAvatars_pkey" PRIMARY KEY (id);


--
-- Name: userGroups userGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT "userGroups_pkey" PRIMARY KEY (id);


--
-- Name: userKeys userKeys_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT "userKeys_pkey" PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_providerkey_email_unique; Type: CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_email_unique UNIQUE ("providerKey", email);


--
-- Name: pagelinks_path_localecode_index; Type: INDEX; Schema: public; Owner: wiki
--

CREATE INDEX pagelinks_path_localecode_index ON public."pageLinks" USING btree (path, "localeCode");


--
-- Name: sessions_expired_index; Type: INDEX; Schema: public; Owner: wiki
--

CREATE INDEX sessions_expired_index ON public.sessions USING btree (expired);


--
-- Name: assetFolders assetfolders_parentid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."assetFolders"
    ADD CONSTRAINT assetfolders_parentid_foreign FOREIGN KEY ("parentId") REFERENCES public."assetFolders"(id);


--
-- Name: assets assets_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: assets assets_folderid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.assets
    ADD CONSTRAINT assets_folderid_foreign FOREIGN KEY ("folderId") REFERENCES public."assetFolders"(id);


--
-- Name: comments comments_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: comments comments_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id);


--
-- Name: pageHistory pagehistory_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pageHistory pagehistory_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pageHistory pagehistory_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistory"
    ADD CONSTRAINT pagehistory_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageHistoryTags pagehistorytags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public."pageHistory"(id) ON DELETE CASCADE;


--
-- Name: pageHistoryTags pagehistorytags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageHistoryTags"
    ADD CONSTRAINT pagehistorytags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageLinks pagelinks_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageLinks"
    ADD CONSTRAINT pagelinks_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages pages_authorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_authorid_foreign FOREIGN KEY ("authorId") REFERENCES public.users(id);


--
-- Name: pages pages_creatorid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_creatorid_foreign FOREIGN KEY ("creatorId") REFERENCES public.users(id);


--
-- Name: pages pages_editorkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_editorkey_foreign FOREIGN KEY ("editorKey") REFERENCES public.editors(key);


--
-- Name: pages pages_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTags pagetags_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTags pagetags_tagid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTags"
    ADD CONSTRAINT pagetags_tagid_foreign FOREIGN KEY ("tagId") REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: pageTree pagetree_pageid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_pageid_foreign FOREIGN KEY ("pageId") REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pageTree pagetree_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."pageTree"
    ADD CONSTRAINT pagetree_parent_foreign FOREIGN KEY (parent) REFERENCES public."pageTree"(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_groupid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_groupid_foreign FOREIGN KEY ("groupId") REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: userGroups usergroups_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userGroups"
    ADD CONSTRAINT usergroups_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: userKeys userkeys_userid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public."userKeys"
    ADD CONSTRAINT userkeys_userid_foreign FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: users users_defaulteditor_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_defaulteditor_foreign FOREIGN KEY ("defaultEditor") REFERENCES public.editors(key);


--
-- Name: users users_localecode_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_localecode_foreign FOREIGN KEY ("localeCode") REFERENCES public.locales(code);


--
-- Name: users users_providerkey_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wiki
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_providerkey_foreign FOREIGN KEY ("providerKey") REFERENCES public.authentication(key);


--
-- PostgreSQL database dump complete
--

