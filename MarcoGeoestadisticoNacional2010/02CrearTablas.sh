#!/bin/bash

#
# Crear Tablas Marco Geoestadístico Nacional 2010
#

# Yo soy
SOY="[Crear Tablas Marco Geoestadístico Nacional 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Definir constantes
BD="inegi"
BD_USUARIO="inegi"

# Cambiar al directorio donde se encuentra este bash script
cd "$(dirname "$0")"

# Crear tablas
echo "$SOY Creando las tablas..."
psql -U $BD_USUARIO -f mgn_entidades.sql $BD
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi
psql -U $BD_USUARIO -f mgn_municipios.sql $BD
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi
psql -U $BD_USUARIO -f mgn_localidades_urbanas.sql $BD
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi

echo "$SOY Script terminado."
exit $EXITO
