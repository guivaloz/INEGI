#!/bin/bash

#
# Convertir
#

# Yo soy
SOY="[Convertir]"

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
find Desempacados/ -name '*A.shp' -and -not -name '*CA.shp' -and -not -name '*SIA.shp' -exec ./03ConvertirSHP2SQL.sh cgc_agebs {} \;

# Convertir archivos SHP a SQL y cambiar los comandos INSERT
echo "$SOY Convirtiendo Manzanas..."
find Desempacados/ -name '*M.shp' -exec ./03ConvertirSHP2SQL.sh cgc_manzanas {} \;

# Término
echo "$SOY Script terminado."
exit $EXITO
