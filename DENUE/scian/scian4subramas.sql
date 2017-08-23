--
-- INEGI SCIAN Subramas
--

CREATE TABLE scian_subramas {
    id             serial               PRIMARY KEY,
    subsector      integer              REFERENCES scian_ramas NOT NULL,

    codigo         character(5)         UNIQUE,
    titulo         character varying,
    descripcion    text

}
