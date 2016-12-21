--
-- den_denue.sql
--

CREATE TABLE den_denue (
    id               serial               PRIMARY KEY,

    nombre           character varying,
    razon_social     character varying,
    calle            character varying,
    numero           character varying(12),
    numero_interior  character varying(12),
    cp               character varying,
    manzana_clave    character varying

);

-- Centro con WGS84 = SRID(4326) porque es latitud y longitud tradicional, vea IBC5ActualizarCentroides.py
SELECT AddGeometryColumn('', 'den_denue', 'coordenadas', '4326', 'POINT', 2);
