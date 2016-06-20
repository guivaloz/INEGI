#!/bin/bash

#
# Convertir Cartografía Geoestadística Censo 2010
#

# Yo soy
SOY="[Convertir Cartografía Geoestadística Censo 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Debe de existir Desempacados
if [ ! -d Desempacados ]; then
    echo "$SOY Error: No existe el directorio Desempacados"
    exit $E_FATAL
fi

# Convertir archivos SHP a SQL y cambiar los comandos INSERT
echo "$SOY Convirtiendo AGEBs..."
find Desempacados/ -name '*a.shp' -and -not -name '*sia.shp' -exec ./03ConvertirSHP2SQL.sh cgc_agebs {} \;

# Convertir archivos SHP a SQL y cambiar los comandos INSERT
echo "$SOY Convirtiendo Manzanas..."
find Desempacados/ -name '*m.shp' -and -not -name '*fm.shp' -exec ./03ConvertirSHP2SQL.sh cgc_manzanas {} \;

# Término
echo "$SOY Script terminado."
exit $EXITO
