--
-- INEGI MGN Municipios
--

CREATE TABLE mgn_municipios (
    cve_ent    character varying,
    cve_mun    character varying,
    nom_mun    character varying,
    concat     character varying,
    UNIQUE (cve_ent, cve_mun)
);

SELECT AddGeometryColumn('', 'mgn_municipios', 'geom', '97999', 'MULTIPOLYGON', 2);
