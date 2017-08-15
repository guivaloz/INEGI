#!/usr/bin/env python3
# coding: utf-8

#
# InsertarCSV.py
#
# Copyright 2016 Guillermo Valdés Lozano <guillermo@movimientolibre.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

"""
Diccionario de datos DENUE 15/06/2016

    ATRIBUTO     VARIABLE      TIPO     DESCRIPCIÓN
    id                         entero   Número de identificación del DENU, clave númerica única pada cada registro
    nom_estab    nombre        texto    Es el nombre comercial o nombre exterior con el que se identifica o anuncia la unidad
    raz_social   razon_social  texto    Es la forma con que está legalmente constituida y registrada la persona moral, o la denominación de una sociedad legalmente constituida
    codigo_act                 texto    Clasificación de las actividades desarrolladas por las unidades económicas usando el SCIAN
    nombre_act                 texto    Descripción del código de actividad conforme al SCIAN 2013
    per_ocu                    texto    Personal Ocupado: 1 = 0 a 5, 2 = 6 a 10, 3 = 11 a 30, 4 = 31 a 50, 5 = 51 a 100, 6 = 101 a 250, 7 = 251 y más
    tipo_v_e_1                 texto    Es la superficie del terreno destinada para el tránsito vehicular y/o peatonal, en la cual se encuentra ubicada la unidad económica (calle, avenida, andador, etc.)
    nom_v_e_1    calle         texto    Es el sustantivo propio con el cual se identifica la vialidad
    tipo_v_e_2                 texto    Es la superficie del terreno destinada para el tránsito vehicular y/o peatonal, en la cual se encuentra ubicada la unidad económica (calle, avenida, andador, etc.)
    nom_v_e_2                  texto    Es el sustantivo propio con el cual se identifica la vialidad
    tipo_v_e_3                 texto    Es la superficie del terreno destinada para el tránsito vehicular y/o peatonal, en la cual se encuentra ubicada la unidad económica (calle, avenida, andador, etc.)
    nom_v_e_3                  texto    Es el sustantivo propio con el cual se identifica la vialidad
    numero_ext   numero        entero   Son los valores numéricos que identifican a uno o varios inmuebles en una vialidad
    letra_ext                  texto    Son los caracteres alfanuméricos que identifican a uno o varios inmuebles en una vialidad
    edificio                   texto    Es el sustantivo propio con el que se identifica el inmueble donde está ubicada la unidad
    edificio_e                 texto    Es con el que se identifica el piso o nivel del inmueble donde está ubicada la unidad económica
    numero_int   numero_int    entero   Son los valores numéricos que identifican un domicilio al interior de un inmueble
    letra_int                  texto    Son los caracteres alfanuméricos que identifican un domicilio al interior de un inmueble
    tipo_asent                 texto    Es la clasificación que se da al asentamiento humano de acuerdo con su función (colonia)
    nomb_asent                 texto    Es el sustantivo propio con el cual se identifica el asentamiento humano
    tipoCenCom                 texto    Tipo de plaza, centro comercial, etcétera donde se encuentra la unidad económica
    nom_CenCom                 texto    Nombre de la plaza, centro comercial, etcétera donde se encuentra la unidad económica
    num_local                  texto    Dato alfanumérico que corresponde al local en donde se localizó la unidad económica
    cod_postal   cp            texto    Clave numérica integrada por cinco dígitos establecido por el Servicio Postal Mexicano
    cve_ent      entidad       texto    Clave que identifica a la entidad federativa
    entidad                    texto    Es el sustantivo propio que identifica a la entidad federativa
    cve_mun      municipio     texto    Clave que identifica al Municipio, y en el caso del Distrito Federal los que identifican a las Delegaciones
    municipio                  texto    Es el sustantivo propio que identifica al Municipio, y en el caso del Distrito Federal los que identifican a las Delegaciones
    cve_loc      localidad     texto    Clave que identifica a la localidad. Esta es el lugar ocupado con una o más edificaciones utilizadas como viviendas, las cuales pueden estar habitadas o no, este lugar es reconocido por un nombre dado por alguna disposición legal o la costumbre
    localidad                  texto    Es el sustantivo propio que identifica a la localidad. Esta es el lugar ocupado con una o más edificaciones utilizadas como viviendas, las cuales pueden estar habitadas o no, este lugar es reconocido por un nombre dado por alguna disposición legal o la costumbre
    ageb         ageb          texto    Es la extensión territorial que corresponde a la subdivisión de las AGEM. Constituye la unidad básica del Marco Geoestadístico Nacional y, dependiendo de sus características, se clasifica en dos tipos, Áreas Geoestadísticas Básicas Urbanas y Áreas Geoestadísticas Básicas Rurales
    manzana      manzana       texto    Clave geoestadística de la manzana, compuesta por tres dígitos, que identifica a una extensión territorial que está constituida por un grupo de viviendas, edificios, predios, lotes o terrenos de uso habitacional, comercial, industrial o de servicios
    telefono                   texto    Número telefónico, secuencia de dígitos que permite la comunicación vía telefónica con la unidad económica
    correoelec                 texto    Correo electrónico, es la serie de caracteres cuya finalidad es acceder a un servicio de red que posibilita a las unidades económicas el envío y recepción de mensajes mediante sistemas de comunicación electrónicos
    www                        texto    Son los datos que permiten el acceso a información de la unidad económica en Internet
    tipoUniEco                 texto    Grupo de categorías que sirve para identificar si el establecimiento es fijo o semifijo
    latitud      latitud       decimal  Es la distancia que existe entre la Unidad económica y el ecuador, medida sobre el meridiano que pasa por dicho punto
    longitud     longitud      decimal  Es la distancia que existe entre la Unidad económica y el meridiano de Greenwich, medida sobre el paralelo que pasa por dicho punto
    fecha_alta                 texto    Fecha en la que la unidad económica se integró al Directorio Nacional de Unidades Económicas

"""

# Librerías
import csv        # Trabajar con archivos CSV https://docs.python.org/3.4/library/csv.html
import os.path    # Averiguar si existe un archivo https://docs.python.org/3.4/library/os.path.html
import psycopg2   # Adaptador para la BD PostgreSQL https://pypi.python.org/pypi/psycopg2
import subprocess # Ejecución de programas externos https://docs.python.org/3.4/library/subprocess.html
import sys        # Interactuar con otros programas usando estándar de término en sys.exit(1) https://docs.python.org/3.4/library/sys.html

# Definir constantes sobre la BD
bd_nombre  = "inegi"
bd_usuario = "inegi"

# Definir conector a la BD
conexion = None

# Ruta al archivo SQL que crea la tabla
tabla_sql_ruta = "den_denue.sql"

# Ruta al archivo CSV con todos los registros de Coahuila de Zaragoza(05)
denue_ruta = "Desempacados/denue_05_csv/conjunto_de_datos/denue_inegi_05_.csv"

# Sólo insertar registros con la clave del Municipio de Torreón(05035)
municipio_clave_filtro = "05035"

# Iniciar contador
contador = 0

try:
    print("Alimentar DENUE con CSV")
    print("")
    #
    # Verificar que exista el archivo SQL
    #
    if not os.path.isfile(tabla_sql_ruta):
        raise Exception("No existe el archivo %s" % tabla_sql_ruta)
    #
    # Verificar que exista el archivo CSV
    #
    if not os.path.isfile(denue_ruta):
        raise Exception("No existe el archivo %s" % denue_ruta)
    #
    # Puntero a la BD
    #
    conexion = psycopg2.connect("host=127.0.0.1 dbname='%s' user='%s' password='loquesea'" % (bd_nombre, bd_usuario,))
    cursor   = conexion.cursor()
    #
    # Preparar tabla en la BD
    #
    # Eliminar
    comando_sql = "DROP TABLE den_denue"
    argumentos  = "psql -c '%s' %s" % (comando_sql, bd_nombre,)
    resultado   = subprocess.call(argumentos, shell=True)
    if resultado != 0:
        print("  Parece que NO existe la tabla den_denue en la B.D.")
    # Crear
    argumentos  = "psql -U %s -f %s %s" % (bd_usuario, tabla_sql_ruta, bd_nombre,)
    resultado   = subprocess.call(argumentos, shell=True)
    if resultado != 0:
        raise Exception("Error al tratar de ejecutar %s" % (tabla_sql_ruta,))
    #
    # Leer archivo CSV
    #
    with open(denue_ruta, 'r') as contenedor:
        lector = csv.DictReader(contenedor)
        for renglon in lector:
            # Tomar columnas id nom_estab raz_social codigo_act nombre_act per_ocu tipo_vial nom_vial tipo_v_e_1 nom_v_e_1 tipo_v_e_2 nom_v_e_2 tipo_v_e_3 nom_v_e_3 numero_ext letra_ext edificio edificio_e numero_int letra_int tipo_asent nomb_asent tipoCenCom nom_CenCom num_local cod_postal cve_ent entidad cve_mun municipio cve_loc localidad ageb manzana telefono correoelec www tipoUniEco latitud longitud fecha_alta
            nombre          = renglon['nom_estab'].strip()
            razon_social    = renglon['raz_social'].strip()
            calle           = renglon['nom_vial'].strip()
            numero          = renglon['numero_ext'].strip()
            numero_interior = renglon['numero_int'].strip()
            cp              = renglon['cod_postal'].strip()
            entidad         = renglon['cve_ent']
            municipio       = renglon['cve_mun']
            localidad       = renglon['cve_loc']
            ageb            = renglon['ageb']
            manzana         = renglon['manzana']
            latitud         = renglon['latitud']
            longitud        = renglon['longitud']
            # Si son cero
            if numero == '0':
                numero = ''
            if numero_interior == '0':
                numero_interior = ''
            # Definir clave del municipio
            municipio_clave = "%s%s" % (entidad, municipio,)
            # Si está en Torreón
            if municipio_clave == municipio_clave_filtro:
                # Definir clave de la manzana
                manzana_clave   = "%s%s%s%s" % (municipio_clave, localidad, ageb, manzana,)
                # Insertar
                if latitud != '' and longitud != '':
                    coordenadas = "POINT(%s %s)" % (longitud, latitud,)
                    cursor.execute("INSERT INTO den_denue (nombre, razon_social, calle, numero, numero_interior, cp, manzana_clave, coordenadas) VALUES (%s, %s, %s, %s, %s, %s, %s, ST_GeomFromText(%s, 4326))", (nombre, razon_social, calle, numero, numero_interior, cp, manzana_clave, coordenadas,))
                else:
                    cursor.execute("INSERT INTO den_denue (nombre, razon_social, calle, numero, numero_interior, cp, manzana_clave) VALUES (%s, %s, %s, %s, %s, %s, %s)", (nombre, razon_social, calle, numero, numero_interior, cp, manzana_clave,))
                # Poner mensaje en terminal
                #print("\"%s\", %s, %s" % (nombre, cp, manzana_clave,))
                # Incrementar contador
                contador = contador + 1
                if contador % 100 == 0:
                    print("  %s" % contador)
        # Enviar comandos a la B.D.
        conexion.commit()
        # Mensaje de término
        print("Terminaron las inserciones al municipio %s." % municipio_clave_filtro)
        print("  Contador: %s" % contador)

except Exception as e:
    print(e)
    sys.exit(1)

finally:
    if conexion:
        conexion.close()
