--
-- INEGI SCIAN Sectores
--

CREATE TABLE scian_sectores {
    id             serial               PRIMARY KEY,

    codigo         character(2)         UNIQUE,
    titulo         character varying,
    descripcion    text

}
