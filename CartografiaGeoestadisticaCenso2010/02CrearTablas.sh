#!/bin/bash

#
# Crear Tablas
#

# Yo soy
SOY="[Crear Tablas Cartografía Geoestadística Censo 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Definir constantes
BD="inegi"
BD_USUARIO="inegi"

# Cambiar al directorio donde se encuentra este bash script
cd "$(dirname "$0")"

# Eliminar tablas
echo "$SOY Eliminando la tabla cgc_manzanas..."
psql -U $BD_USUARIO -c "DROP TABLE cgc_manzanas" $BD
if [ "$?" -ne $EXITO ]; then
    echo "$SOY Parace que no existía cgc_manzanas. De ser así, no hay problema."
fi
echo "$SOY Eliminando la tabla cgc_agebs..."
psql -U $BD_USUARIO -c "DROP TABLE cgc_agebs" $BD
if [ "$?" -ne $EXITO ]; then
    echo "$SOY Parace que no existía cgc_agebs. De ser así, no hay problema."
fi

# Crear tablas
echo "$SOY Creando la tabla cgc_agebs..."
psql -U $BD_USUARIO -f cgc_agebs.sql $BD
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi
echo "$SOY Creando la tabla cgc_manzanas..."
psql -U $BD_USUARIO -f cgc_manzanas.sql $BD
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi

echo "$SOY Script terminado."
exit $EXITO
