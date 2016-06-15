--
-- INEGI MGN Localidades Urbanas
--

CREATE TABLE mgn_localidades_urbanas (
    cve_ent    character varying,
    cve_mun    character varying,
    cve_loc    character varying,
    nom_loc    character varying,
    __oid      integer,
    UNIQUE (cve_ent, cve_mun, cve_loc)
);

SELECT AddGeometryColumn('', 'mgn_localidades_urbanas', 'geom', '97999', 'MULTIPOLYGON', 2);
