--
-- vistas.sql
--

-- 46 Comercio al por menor

DROP VIEW IF EXISTS den_denue_comercio_al_por_menor;

CREATE VIEW den_denue_comercio_al_por_menor AS
    SELECT
        d.id, d.corte, r.titulo AS rama, sr.titulo AS subrama,
        d.nombre, d.razon_social, d.codigo, d.personal_ocupado,
        d.calle, d.numero_ext, d.letra_ext, d.numero_int, d.letra_int, d.cp,
        d.entidad, d.municipio, d.localidad, d.ageb, d.manzana,
        d.coordenadas
    FROM
        den_denue         d,
        scian_subramas    sr,
        scian_ramas       r,
        scian_subsectores ss,
        scian_sectores    s
    WHERE
        d.subrama       = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id
        AND ss.sector   = s.id
        AND s.codigo    = '46';

GRANT SELECT ON den_denue_comercio_al_por_menor TO inegi;

-- 621 Servicios médicos de consulta externa y servicios relacionados

DROP VIEW IF EXISTS den_denue_servicios_medicos;

CREATE VIEW den_denue_servicios_medicos AS
    SELECT
        d.id, d.corte, sr.titulo AS subrama,
        d.nombre, d.razon_social, d.codigo, d.personal_ocupado,
        d.calle, d.numero_ext, d.letra_ext, d.numero_int, d.letra_int, d.cp,
        d.entidad, d.municipio, d.localidad, d.ageb, d.manzana,
        d.coordenadas
    FROM
        den_denue         d,
        scian_subramas    sr,
        scian_ramas       r,
        scian_subsectores ss
    WHERE
        d.subrama       = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id
        AND ss.codigo   = '621';

GRANT SELECT ON den_denue_servicios_medicos TO inegi;

-- 722 Servicios de preparación de alimentos y bebidas

DROP VIEW IF EXISTS den_denue_servicios_preparacion_alimentos_bebidas;

CREATE VIEW den_denue_servicios_preparacion_alimentos_bebidas AS
    SELECT
        d.id, d.corte, sr.titulo AS subrama,
        d.nombre, d.razon_social, d.codigo, d.personal_ocupado,
        d.calle, d.numero_ext, d.letra_ext, d.numero_int, d.letra_int, d.cp,
        d.entidad, d.municipio, d.localidad, d.ageb, d.manzana,
        d.coordenadas
    FROM
        den_denue         d,
        scian_subramas    sr,
        scian_ramas       r,
        scian_subsectores ss
    WHERE
        d.subrama       = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id
        AND ss.codigo   = '722';

GRANT SELECT ON den_denue_servicios_preparacion_alimentos_bebidas TO inegi;
