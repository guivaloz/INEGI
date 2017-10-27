--
-- vistas.sql
--
-- sector
--   subsector
--     rama
--       subrama

-- Conglomerado 'Centro Histórico'

DROP VIEW IF EXISTS den_denue_centro_historico;

CREATE VIEW den_denue_centro_historico AS
    SELECT
        d.id,
        s.titulo AS sector, ss.titulo AS subsector,
        r.titulo AS rama,   sr.titulo AS subrama,
        d.nombre, d.razon_social, d.codigo, d.personal_ocupado,
        d.calle, d.numero_ext, d.letra_ext, d.numero_int, d.letra_int, d.cp,
        d.manzana,
        d.coordenadas
    FROM
        den_denue         d,
        scian_subramas    sr,
        scian_ramas       r,
        scian_subsectores ss,
        scian_sectores    s
    WHERE
        conglomerado    = 'Centro Histórico'
        AND d.subrama   = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id
        AND ss.sector   = s.id;

GRANT SELECT ON den_denue_centro_historico TO inegi;

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
        s.codigo        = '46'
        AND d.subrama   = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id
        AND ss.sector   = s.id;

GRANT SELECT ON den_denue_comercio_al_por_menor TO inegi;

-- 52 Servicios Financieros y de Seguros

DROP VIEW IF EXISTS den_denue_servicios_financieros_y_de_seguros;

CREATE VIEW den_denue_servicios_financieros_y_de_seguros AS
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
        s.codigo        = '52'
        AND d.subrama   = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id
        AND ss.sector   = s.id;

GRANT SELECT ON den_denue_servicios_financieros_y_de_seguros TO inegi;

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
        ss.codigo       = '621'
        AND d.subrama   = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id;

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
        ss.codigo       = '722'
        AND d.subrama   = sr.id
        AND sr.rama     = r.id
        AND r.subsector = ss.id;

GRANT SELECT ON den_denue_servicios_preparacion_alimentos_bebidas TO inegi;
