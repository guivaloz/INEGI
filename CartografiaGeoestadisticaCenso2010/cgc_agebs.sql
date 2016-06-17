--
-- INEGI Cartografía Geoestadística cierre Censo 2010 - cgc_agebs
--

CREATE TABLE cgc_agebs (
    geografico    character varying(60),
    cvegeo        character varying(13)    PRIMARY KEY,
    codigo        integer,
    fechaact      character varying(7),
    instituc      character varying(20),
    geometria     character varying(5)
);

SELECT AddGeometryColumn('cgc_agebs', 'geom', 97999, 'MULTIPOLYGON', 2);
