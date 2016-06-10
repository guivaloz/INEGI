#!/usr/bin/env python3
# coding: utf-8

#
# Importar Archivos CSV de la Encuesta Intercensal 2015
#

# Liberías
import glob              # Obtener las rutas de rutas para sistemas Unix https://docs.python.org/3.4/library/glob.html
import os                # Operaciones misceláneas con el sistema operativo https://docs.python.org/3.4/library/os.html
import sys               # Interactuar con otros programas usando estándar de término en sys.exit(1) https://docs.python.org/3.4/library/sys.html
from pathlib import Path # Trabajar con rutas de rutas https://docs.python.org/3.4/library/pathlib.html

# Definir constantes
base_datos       = 'inegi'
tabla_personas   = 'encuesta_intercensal_2015_personas'
tabla_viviendas  = 'encuesta_intercensal_2015_viviendas'
codificacion_sql = "SET CLIENT_ENCODING TO 'LATIN1';"

# Iniciar variables
contador = 0

try:
    print("Importar Archivos CSV de la Encuesta Intercensal 2015")
    # Eliminar las tablas
    os.system('psql -c "DROP TABLE %s" %s' % (tabla_personas, base_datos,))
    os.system('psql -c "DROP TABLE %s" %s' % (tabla_viviendas, base_datos,))
    # Crear las tablas
    resultado = os.system('psql -f inegi_%s.sql %s' % (tabla_personas, base_datos,))
    if resultado != 0:
        raise Exception('Falló la creación de la tabla %s' % tabla_personas)
    resultado = os.system('psql -f inegi_%s.sql %s' % (tabla_viviendas, base_datos,))
    if resultado != 0:
        raise Exception('Falló la creación de la tabla %s' % tabla_personas)
    # Obtener la lista con las rutas absolutas a los archivos CSV y ordenarlas ascendentemente
    actual_dir = os.getcwd()
    rutas      = glob.glob(actual_dir + "/Desempacados/*.CSV")
    rutas.sort()
    # Bucle por las rutas
    for ruta in rutas:
        if os.path.isfile(ruta):
            # Obtener sólo el nombre del ruta
            path    = Path(ruta)
            archivo = path.name
            print("  Importando %s..." % archivo)
            # Definir comando SQL
            if archivo[:10] == 'TR_PERSONA':
                tabla = tabla_personas
            elif archivo[:11] == 'TR_VIVIENDA':
                tabla = tabla_viviendas
            else:
                continue
            comando_sql = "COPY %s FROM '%s' DELIMITER ',' CSV HEADER;" % (tabla, ruta,)
            # Importar
            orden = 'psql -c "%s%s" %s' % (codificacion_sql, comando_sql, base_datos,)
            resultado = os.system(orden)
            if resultado == 0:
                contador = contador + 1
            else:
                print("    Falló la importación" % archivo)
        else:
            print("  No se encuentra %s" % ruta)
    # Mensaje de término
    if contador == 0:
        raise Exception('No se importó ningún archivo')
    else:
        print("Se importaron %s rutas CSV" % contador)

except Exception as e:
    print("Error: %s" % e)
    sys.exit(1)
