#!/bin/bash

#
# Convertir SHP a SQL
#

# Yo soy
SOY="[Convertir SHP a SQL]"

# Constantes que definen los tipos de errores
EXITO=0
E_FATAL=99

# Parámetro ruta al archivo SHP
ARCHIVO_SHP="$1"
ARCHIVO_SQL=".sql"

# Convertir SHP a SQL
shp2pgsql -s 97999 -c -e -i -W LATIN1 $ARCHIVO_SHP mgn_agebs > $ARCHIVO_SQL \;

# Reemplazar en los comandos SQL
