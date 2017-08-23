--
-- INEGI SCIAN Ramas
--

CREATE TABLE scian_ramas {
    id             serial               PRIMARY KEY,
    subsector      integer              REFERENCES scian_subsectores NOT NULL,

    codigo         character(4)         UNIQUE,
    titulo         character varying,
    descripcion    text

}
