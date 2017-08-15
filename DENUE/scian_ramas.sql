--
-- INEGI SCIAN Ramas
--

CREATE TABLE scian_ramas {
    id             serial               PRIMARY KEY,
    subsector      integer              REFERENCES ,

    codigo         character(),
    titulo         character varying,
    descripcion    text

}
