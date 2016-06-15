#!/bin/bash

#
# Convertir Marco Geoestadístico Nacional 2010
#

# Yo soy
SOY="[Convertir Marco Geoestadistico Nacional 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Cambiar al directorio donde se encuentra este bash script
cd "$(dirname "$0")"

# Debe de existir Desempacados
if [ ! -d Desempacados ]; then
    echo "$SOY Error: No existe el directorio Desempacados"
    exit $E_FATAL
fi

# Cambiarse al directorio Desempacados
cd Desempacados

# Elimnar SQL
echo "$SOY Eliminando archivos SQL..."
rm -f *.sql

# Convertir archivos SHP a SQL
echo "$SOY Convitiendo archivos SHP a SQL..."
for TABLA in "mgn_entidades" "mgn_municipios" "mgn_localidades_urbanas"
do
    if [ ! -e "$TABLA.shp" ]; then
        echo "$SOY Error: No se encuentra $TABLA.shp"
        exit $E_FATAL
    fi
    shp2pgsql -s 97999 -a -e -i -W LATIN1 $TABLA.shp > $TABLA.sql
    if [ "$?" -ne $EXITO ]; then
        echo "$SOY Error: Al convertir $TABLA.shp"
        exit $E_FATAL
    fi
done

echo "$SOY Script terminado."
exit $EXITO
