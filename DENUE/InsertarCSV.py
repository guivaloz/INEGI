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
