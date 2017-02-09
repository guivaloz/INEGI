--
-- INEGI Cartografía Geoestadística cierre Censo 2010 - cgc_agebs
--

CREATE TABLE cgc_agebs (
    codigo        character varying(16),
    cvegeo        character varying(13)    PRIMARY KEY,
    geografico    character varying(60),
    fechaact      character varying(7),
    geometria     character varying(5),
    institucio    character varying(20)
);

SELECT AddGeometryColumn('cgc_agebs', 'geom', 97999, 'MULTIPOLYGON', 2);
