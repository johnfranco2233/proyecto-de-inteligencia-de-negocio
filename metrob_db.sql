--
-- PostgreSQL database dump
--

\restrict F2VdT0klUg02WjvNEKy87nERPoD3aRh1d9lkS86jSsxGSqpdd5KVAXu0GB5WMON

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-26 19:10:51

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

--
-- TOC entry 225 (class 1259 OID 17113)
-- Name: carga_archivo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carga_archivo (
    id_carga integer NOT NULL,
    nombre_archivo character varying(150) NOT NULL,
    fecha_carga timestamp without time zone DEFAULT now() NOT NULL,
    filas_leidas integer DEFAULT 0 NOT NULL,
    filas_cargadas integer DEFAULT 0 NOT NULL,
    filas_rechazadas integer DEFAULT 0 NOT NULL,
    id_usuario integer
);


ALTER TABLE public.carga_archivo OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17112)
-- Name: carga_archivo_id_carga_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carga_archivo_id_carga_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carga_archivo_id_carga_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 224
-- Name: carga_archivo_id_carga_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carga_archivo_id_carga_seq OWNED BY public.carga_archivo.id_carga;


--
-- TOC entry 229 (class 1259 OID 17161)
-- Name: despacho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.despacho (
    id_despacho integer NOT NULL,
    fecha date NOT NULL,
    cod_ruta character varying(5) NOT NULL,
    franja character varying(20) NOT NULL,
    despachos_programados integer NOT NULL,
    despachos_realizados integer NOT NULL,
    id_carga integer NOT NULL,
    CONSTRAINT despacho_despachos_programados_check CHECK ((despachos_programados >= 0)),
    CONSTRAINT despacho_despachos_realizados_check CHECK ((despachos_realizados >= 0))
);


ALTER TABLE public.despacho OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17160)
-- Name: despacho_id_despacho_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.despacho_id_despacho_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.despacho_id_despacho_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 228
-- Name: despacho_id_despacho_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.despacho_id_despacho_seq OWNED BY public.despacho.id_despacho;


--
-- TOC entry 220 (class 1259 OID 17075)
-- Name: estacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estacion (
    cod_estacion character varying(5) NOT NULL,
    estacion character varying(100) NOT NULL,
    cod_ruta character varying(5) NOT NULL,
    tiene_cajero boolean NOT NULL
);


ALTER TABLE public.estacion OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17089)
-- Name: franja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.franja (
    franja character varying(20) NOT NULL,
    hora_inicio time without time zone,
    hora_fin time without time zone
);


ALTER TABLE public.franja OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17192)
-- Name: rechazo_carga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rechazo_carga (
    id_rechazo integer NOT NULL,
    id_carga integer NOT NULL,
    num_fila integer,
    motivo character varying(200) NOT NULL,
    contenido text
);


ALTER TABLE public.rechazo_carga OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17191)
-- Name: rechazo_carga_id_rechazo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rechazo_carga_id_rechazo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rechazo_carga_id_rechazo_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 230
-- Name: rechazo_carga_id_rechazo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rechazo_carga_id_rechazo_seq OWNED BY public.rechazo_carga.id_rechazo;


--
-- TOC entry 219 (class 1259 OID 17064)
-- Name: ruta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ruta (
    cod_ruta character varying(5) NOT NULL,
    nombre character varying(100) NOT NULL,
    km_recorrido numeric(6,1) NOT NULL,
    buses_asignados integer NOT NULL,
    CONSTRAINT ruta_buses_asignados_check CHECK ((buses_asignados >= 0)),
    CONSTRAINT ruta_km_recorrido_check CHECK ((km_recorrido > (0)::numeric))
);


ALTER TABLE public.ruta OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17096)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(150) NOT NULL,
    clave_hash character varying(255) NOT NULL,
    perfil character varying(15) NOT NULL,
    CONSTRAINT usuario_perfil_check CHECK (((perfil)::text = ANY ((ARRAY['administrador'::character varying, 'consulta'::character varying])::text[])))
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17095)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 227 (class 1259 OID 17135)
-- Name: validacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.validacion (
    id_validacion integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL,
    cod_estacion character varying(5) NOT NULL,
    id_tarjeta character varying(30) NOT NULL,
    tipo_tarjeta character varying(20) NOT NULL,
    valor_pasaje numeric(8,2) NOT NULL,
    id_carga integer NOT NULL,
    CONSTRAINT validacion_tipo_tarjeta_check CHECK (((tipo_tarjeta)::text = ANY ((ARRAY['General'::character varying, 'Estudiante'::character varying, 'Adulto mayor'::character varying])::text[]))),
    CONSTRAINT validacion_valor_pasaje_check CHECK ((valor_pasaje > (0)::numeric))
);


ALTER TABLE public.validacion OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17134)
-- Name: validacion_id_validacion_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.validacion_id_validacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.validacion_id_validacion_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 226
-- Name: validacion_id_validacion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.validacion_id_validacion_seq OWNED BY public.validacion.id_validacion;


--
-- TOC entry 4889 (class 2604 OID 17116)
-- Name: carga_archivo id_carga; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carga_archivo ALTER COLUMN id_carga SET DEFAULT nextval('public.carga_archivo_id_carga_seq'::regclass);


--
-- TOC entry 4895 (class 2604 OID 17164)
-- Name: despacho id_despacho; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despacho ALTER COLUMN id_despacho SET DEFAULT nextval('public.despacho_id_despacho_seq'::regclass);


--
-- TOC entry 4896 (class 2604 OID 17195)
-- Name: rechazo_carga id_rechazo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rechazo_carga ALTER COLUMN id_rechazo SET DEFAULT nextval('public.rechazo_carga_id_rechazo_seq'::regclass);


--
-- TOC entry 4888 (class 2604 OID 17099)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 4894 (class 2604 OID 17138)
-- Name: validacion id_validacion; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validacion ALTER COLUMN id_validacion SET DEFAULT nextval('public.validacion_id_validacion_seq'::regclass);


--
-- TOC entry 4915 (class 2606 OID 17128)
-- Name: carga_archivo carga_archivo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carga_archivo
    ADD CONSTRAINT carga_archivo_pkey PRIMARY KEY (id_carga);


--
-- TOC entry 4921 (class 2606 OID 17175)
-- Name: despacho despacho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despacho
    ADD CONSTRAINT despacho_pkey PRIMARY KEY (id_despacho);


--
-- TOC entry 4907 (class 2606 OID 17083)
-- Name: estacion estacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estacion
    ADD CONSTRAINT estacion_pkey PRIMARY KEY (cod_estacion);


--
-- TOC entry 4909 (class 2606 OID 17094)
-- Name: franja franja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.franja
    ADD CONSTRAINT franja_pkey PRIMARY KEY (franja);


--
-- TOC entry 4925 (class 2606 OID 17202)
-- Name: rechazo_carga rechazo_carga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rechazo_carga
    ADD CONSTRAINT rechazo_carga_pkey PRIMARY KEY (id_rechazo);


--
-- TOC entry 4905 (class 2606 OID 17074)
-- Name: ruta ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_pkey PRIMARY KEY (cod_ruta);


--
-- TOC entry 4911 (class 2606 OID 17111)
-- Name: usuario usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_key UNIQUE (correo);


--
-- TOC entry 4913 (class 2606 OID 17109)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4919 (class 2606 OID 17149)
-- Name: validacion validacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validacion
    ADD CONSTRAINT validacion_pkey PRIMARY KEY (id_validacion);


--
-- TOC entry 4922 (class 1259 OID 17210)
-- Name: idx_despacho_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_despacho_fecha ON public.despacho USING btree (fecha);


--
-- TOC entry 4923 (class 1259 OID 17211)
-- Name: idx_despacho_ruta; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_despacho_ruta ON public.despacho USING btree (cod_ruta);


--
-- TOC entry 4916 (class 1259 OID 17209)
-- Name: idx_validacion_estacion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_validacion_estacion ON public.validacion USING btree (cod_estacion);


--
-- TOC entry 4917 (class 1259 OID 17208)
-- Name: idx_validacion_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_validacion_fecha ON public.validacion USING btree (fecha_hora);


--
-- TOC entry 4927 (class 2606 OID 17129)
-- Name: carga_archivo carga_archivo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carga_archivo
    ADD CONSTRAINT carga_archivo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 4930 (class 2606 OID 17176)
-- Name: despacho despacho_cod_ruta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despacho
    ADD CONSTRAINT despacho_cod_ruta_fkey FOREIGN KEY (cod_ruta) REFERENCES public.ruta(cod_ruta);


--
-- TOC entry 4931 (class 2606 OID 17181)
-- Name: despacho despacho_franja_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despacho
    ADD CONSTRAINT despacho_franja_fkey FOREIGN KEY (franja) REFERENCES public.franja(franja);


--
-- TOC entry 4932 (class 2606 OID 17186)
-- Name: despacho despacho_id_carga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despacho
    ADD CONSTRAINT despacho_id_carga_fkey FOREIGN KEY (id_carga) REFERENCES public.carga_archivo(id_carga);


--
-- TOC entry 4926 (class 2606 OID 17084)
-- Name: estacion estacion_cod_ruta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estacion
    ADD CONSTRAINT estacion_cod_ruta_fkey FOREIGN KEY (cod_ruta) REFERENCES public.ruta(cod_ruta);


--
-- TOC entry 4933 (class 2606 OID 17203)
-- Name: rechazo_carga rechazo_carga_id_carga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rechazo_carga
    ADD CONSTRAINT rechazo_carga_id_carga_fkey FOREIGN KEY (id_carga) REFERENCES public.carga_archivo(id_carga);


--
-- TOC entry 4928 (class 2606 OID 17150)
-- Name: validacion validacion_cod_estacion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validacion
    ADD CONSTRAINT validacion_cod_estacion_fkey FOREIGN KEY (cod_estacion) REFERENCES public.estacion(cod_estacion);


--
-- TOC entry 4929 (class 2606 OID 17155)
-- Name: validacion validacion_id_carga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.validacion
    ADD CONSTRAINT validacion_id_carga_fkey FOREIGN KEY (id_carga) REFERENCES public.carga_archivo(id_carga);


-- Completed on 2026-11-26 19:10:52

--
-- PostgreSQL database dump complete
--

\unrestrict F2VdT0klUg02WjvNEKy87nERPoD3aRh1d9lkS86jSsxGSqpdd5KVAXu0GB5WMON

