--
-- INEGI SCIAN Subsectores
--

CREATE TABLE scian_subsectores {
    id             serial               PRIMARY KEY,
    sector         integer              REFERENCES scian_sectores NOT NULL,

    codigo         character(3)         UNIQUE,
    titulo         character varying,
    descripcion    text

}
