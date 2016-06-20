--
-- INEGI Cartografía Geoestadística cierre Censo 2010 - cgc_manzanas
--

CREATE TABLE cgc_manzanas (
    geografico    character varying(60),
    cvegeo        character varying(16)    PRIMARY KEY,
    codigo        integer,
    fechaact      character varying(7),
    instituc      character varying(20),
    geometria     character varying(5)
);

SELECT AddGeometryColumn('cgc_manzanas', 'geom', 97999, 'MULTIPOLYGON', 2);
