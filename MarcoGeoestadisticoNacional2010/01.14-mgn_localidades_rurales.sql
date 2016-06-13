--
-- INEGI MGN Localidades Rurales
--

CREATE TABLE mgn_localidades_rurales (
    cve_ent     character varying,
    cve_mun     character varying,
    cve_loc     character varying,
    cve_ageb    character varying,
    nom_loc     character varying,
    __oid       integer,
    UNIQUE (cve_ent, cve_mun, cve_loc, cve_ageb)
);

SELECT AddGeometryColumn('', 'mgn_localidades_rurales', 'geom', '97999', 'POINT', 2);
