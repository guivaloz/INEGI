#!/bin/bash

#
# Convertir SHP a SQL
#
# Recibe los nombres de los archivos SHP como parámetros
# Puede usar el comando find para AGEBs:
#   $ find Desempacados/ -name '*a.shp' -and -not -name '*sia.shp' -exec ./ConvertirSHP2SQL.sh cgc_agebs {} \;
# Y para manzanas:
#   $ find Desempacados/ -name '*m.shp' -and -not -name '*fm.shp' -exec ./ConvertirSHP2SQL.sh cgc_manzanas {} \;
#
# Notas del comando shp2pgsql
#
# Sintaxis
#   shp2pgsql [parámetros] <archivo_shp> <tabla_nombre> > <archivo_sql>
#
# Parámetros
#   -s 97999
#   -a
#   -e
#   -i
#   -W LATIN1

# Yo soy
SOY="[Convertir SHP a SQL]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# El primer parámetro es la tabla
TABLA=$1
shift

# Para cada parámetro
for ARCHIVO_SHP in "$@"
do
    # Definir variables
    DIR=`dirname "$ARCHIVO_SHP"`
    NOMBRE=`basename "${ARCHIVO_SHP%.[^.]*}"`
    ARCHIVO_SQL="${DIR}/${NOMBRE}.sql"
    # Elimiar archivo SQL si existiera
    if [ -e "$ARCHIVO_SQL" ]; then
        rm -f $ARCHIVO_SQL
    fi
    # Convertir archivo SHP a SQL
    echo "$SOY Convirtiendo $ARCHIVO_SHP..."
    shp2pgsql -s 97999 -a -e -i -W LATIN1 $ARCHIVO_SHP $TABLA > $ARCHIVO_SQL
done
