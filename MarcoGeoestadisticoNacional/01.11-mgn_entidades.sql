--
-- INEGI MGN Entidades
--

CREATE TABLE mgn_entidades (
    cve_ent    character varying    UNIQUE,
    nom_ent    character varying
);

SELECT AddGeometryColumn('', 'mgn_entidades', 'geom', '97999', 'MULTIPOLYGON', 2);
