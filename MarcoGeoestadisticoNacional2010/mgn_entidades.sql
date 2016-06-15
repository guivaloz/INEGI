--
-- INEGI MGN Entidades
--

CREATE TABLE mgn_entidades (
    cve_ent    character varying    UNIQUE,
    nom_ent    character varying,
    __oid      integer
);

SELECT AddGeometryColumn('', 'mgn_entidades', 'geom', '97999', 'MULTIPOLYGON', 2);
