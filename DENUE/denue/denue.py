#!/usr/bin/env python3
#-*- coding:utf-8 -*-

import csv
import os.path
from . import basededatos

def eliminar_tabla():
    """ Eliminar tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("DROP TABLE IF EXISTS den_denue")
    print("  Eliminada la tabla den_denue si existía.")

def crear_tabla():
    """ Crear tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("""
            CREATE TABLE den_denue (
                id                serial             PRIMARY KEY,
                nombre            character varying,
                razon_social      character varying,
                codigo            character varying,
                personal_ocupado  character varying,
                calle             character varying,
                numero_ext        character varying,
                letra_ext         character varying,
                numero_int        character varying,
                letra_int         character varying,
                cp                character varying,
                entidad           character(2),
                municipio         character(5),
                localidad         character(9),
                ageb              character(13),
                manzana           character(16)
            )""")
        bd.cursor.execute("SELECT AddGeometryColumn('', 'den_denue', 'coordenadas', '4326', 'POINT', 2)")
    print("  Creada la tabla den_denue.")

def insertar(archivo, fecha, municipios):
    """ Verificar si existe el archivo CSV """
    if not os.path.isfile(archivo):
        raise Exception("No existe el archivo {}".format(archivo))
    """ Insertar registros del archivo CSV a la base de datos """
    contador     = 0
    contador_sin = 0
    with basededatos.inegi() as bd:
        with open(archivo, newline='') as contenedor:
            lector = csv.DictReader(contenedor)
            for renglon in lector:
                nombre           = renglon['nom_estab'].strip()
                razon_social     = renglon['raz_social'].strip()
                codigo           = renglon['codigo_act'].strip()
                personal_ocupado = renglon['per_ocu'].strip()
                calle            = renglon['nom_v_e_1'].strip()
                numero_ext       = renglon['numero_ext'].strip()
                letra_ext        = renglon['letra_ext'].strip()
                numero_int       = renglon['numero_int'].strip()
                letra_int        = renglon['letra_int'].strip()
                cp               = renglon['cod_postal'].strip()
                entidad          = renglon['cve_ent'].strip()
                municipio        = entidad + renglon['cve_mun'].strip()
                localidad        = municipio + renglon['cve_loc'].strip()
                ageb             = localidad + renglon['ageb'].strip()
                manzana          = ageb + renglon['manzana'].strip()
                latitud          = renglon['latitud']
                longitud         = renglon['longitud']
                if numero_ext == '0':
                    numero_ext = ''
                if numero_int == '0':
                    numero_int = ''
                if municipio in municipios:
                    if latitud != '' and longitud != '':
                        coordenadas = "POINT(%s %s)" % (longitud, latitud,)
                        bd.cursor.execute("""
                            INSERT INTO den_denue
                                (nombre, razon_social, codigo, personal_ocupado,
                                 calle, numero_ext, letra_ext, numero_int, letra_int, cp,
                                 entidad, municipio, localidad, ageb, manzana,
                                 coordenadas)
                            VALUES
                                (%s, %s, %s, %s,
                                 %s, %s, %s, %s, %s, %s,
                                 %s, %s, %s, %s, %s,
                                 ST_GeomFromText(%s, 4326))
                            """, (nombre, razon_social, codigo, personal_ocupado, calle, numero_ext, letra_ext, numero_int, letra_int, cp, entidad, municipio, localidad, ageb, manzana, coordenadas,))
                        contador = contador + 1
                    else:
                        contador_sin = contador_sin + 1
    print("  Para la fecha {} y los municipios {} se insertaron {} unidades.".format(fecha, ", ".join(sorted(municipios)), contador))
    if contador_sin > 0:
        print("    Se omitieron {} por coordenadas incompletas.".format(contador_sin))

"""
Diccionario de datos DENUE 15/06/2016

    ATRIBUTO     VARIABLE          TIPO     DESCRIPCIÓN
    id                             entero   Número de identificación del DENU, clave númerica única pada cada registro
    nom_estab    nombre            texto    Es el nombre comercial o nombre exterior con el que se identifica o anuncia la unidad
    raz_social   razon_social      texto    Es la forma con que está legalmente constituida y registrada la persona moral, o la denominación de una sociedad legalmente constituida
    codigo_act   codigo            texto    Clasificación de las actividades desarrolladas por las unidades económicas usando el SCIAN
    nombre_act                     texto    Descripción del código de actividad conforme al SCIAN 2013
    per_ocu      personal_ocupado  texto    Personal Ocupado: 1 = 0 a 5, 2 = 6 a 10, 3 = 11 a 30, 4 = 31 a 50, 5 = 51 a 100, 6 = 101 a 250, 7 = 251 y más
    tipo_v_e_1                     texto    Es la superficie del terreno destinada para el tránsito vehicular y/o peatonal, en la cual se encuentra ubicada la unidad económica (calle, avenida, andador, etc.)
    nom_v_e_1    calle             texto    Es el sustantivo propio con el cual se identifica la vialidad
    tipo_v_e_2                     texto    Es la superficie del terreno destinada para el tránsito vehicular y/o peatonal, en la cual se encuentra ubicada la unidad económica (calle, avenida, andador, etc.)
    nom_v_e_2                      texto    Es el sustantivo propio con el cual se identifica la vialidad
    tipo_v_e_3                     texto    Es la superficie del terreno destinada para el tránsito vehicular y/o peatonal, en la cual se encuentra ubicada la unidad económica (calle, avenida, andador, etc.)
    nom_v_e_3                      texto    Es el sustantivo propio con el cual se identifica la vialidad
    numero_ext   numero_ext        entero   Son los valores numéricos que identifican a uno o varios inmuebles en una vialidad
    letra_ext    letra_ext         texto    Son los caracteres alfanuméricos que identifican a uno o varios inmuebles en una vialidad
    edificio                       texto    Es el sustantivo propio con el que se identifica el inmueble donde está ubicada la unidad
    edificio_e                     texto    Es con el que se identifica el piso o nivel del inmueble donde está ubicada la unidad económica
    numero_int   numero_int        entero   Son los valores numéricos que identifican un domicilio al interior de un inmueble
    letra_int    letra_int         texto    Son los caracteres alfanuméricos que identifican un domicilio al interior de un inmueble
    tipo_asent                     texto    Es la clasificación que se da al asentamiento humano de acuerdo con su función (colonia)
    nomb_asent                     texto    Es el sustantivo propio con el cual se identifica el asentamiento humano
    tipoCenCom                     texto    Tipo de plaza, centro comercial, etcétera donde se encuentra la unidad económica
    nom_CenCom                     texto    Nombre de la plaza, centro comercial, etcétera donde se encuentra la unidad económica
    num_local                      texto    Dato alfanumérico que corresponde al local en donde se localizó la unidad económica
    cod_postal   cp                texto    Clave numérica integrada por cinco dígitos establecido por el Servicio Postal Mexicano
    cve_ent      entidad           texto    Clave que identifica a la entidad federativa
    entidad                        texto    Es el sustantivo propio que identifica a la entidad federativa
    cve_mun      municipio         texto    Clave que identifica al Municipio, y en el caso del Distrito Federal los que identifican a las Delegaciones
    municipio                      texto    Es el sustantivo propio que identifica al Municipio, y en el caso del Distrito Federal los que identifican a las Delegaciones
    cve_loc      localidad         texto    Clave que identifica a la localidad. Esta es el lugar ocupado con una o más edificaciones utilizadas como viviendas, las cuales pueden estar habitadas o no, este lugar es reconocido por un nombre dado por alguna disposición legal o la costumbre
    localidad                      texto    Es el sustantivo propio que identifica a la localidad. Esta es el lugar ocupado con una o más edificaciones utilizadas como viviendas, las cuales pueden estar habitadas o no, este lugar es reconocido por un nombre dado por alguna disposición legal o la costumbre
    ageb         ageb              texto    Es la extensión territorial que corresponde a la subdivisión de las AGEM. Constituye la unidad básica del Marco Geoestadístico Nacional y, dependiendo de sus características, se clasifica en dos tipos, Áreas Geoestadísticas Básicas Urbanas y Áreas Geoestadísticas Básicas Rurales
    manzana      manzana           texto    Clave geoestadística de la manzana, compuesta por tres dígitos, que identifica a una extensión territorial que está constituida por un grupo de viviendas, edificios, predios, lotes o terrenos de uso habitacional, comercial, industrial o de servicios
    telefono                       texto    Número telefónico, secuencia de dígitos que permite la comunicación vía telefónica con la unidad económica
    correoelec                     texto    Correo electrónico, es la serie de caracteres cuya finalidad es acceder a un servicio de red que posibilita a las unidades económicas el envío y recepción de mensajes mediante sistemas de comunicación electrónicos
    www                            texto    Son los datos que permiten el acceso a información de la unidad económica en Internet
    tipoUniEco                     texto    Grupo de categorías que sirve para identificar si el establecimiento es fijo o semifijo
    latitud      latitud           decimal  Es la distancia que existe entre la Unidad económica y el ecuador, medida sobre el meridiano que pasa por dicho punto
    longitud     longitud          decimal  Es la distancia que existe entre la Unidad económica y el meridiano de Greenwich, medida sobre el paralelo que pasa por dicho punto
    fecha_alta                     texto    Fecha en la que la unidad económica se integró al Directorio Nacional de Unidades Económicas

"""
