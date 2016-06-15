#!/bin/bash

#
# Insertar Marco Geoestadistico Nacional 2010
#

# Yo soy
SOY="[Insertar Marco Geoestadistico Nacional 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Definir constantes
BD="inegi"
BD_USUARIO="inegi"

# Cambiar al directorio donde se encuentra este bash script y luego a Desempacados
cd "$(dirname "$0")"

# Debe de existir Desempacados
if [ ! -d Desempacados ]; then
    echo "$SOY Error: No existe el directorio Desempacados"
    exit $E_FATAL
fi

# Cambiarse al directorio Desempacados
cd Desempacados

# Insertar
for TABLA in "mgn_entidades" "mgn_municipios" "mgn_localidades_urbanas"
do
    echo "$SOY Insertando $TABLA..."
    psql -U $BD_USUARIO -f $TABLA.sql $BD 2>&1 > /dev/null
    if [ "$?" -ne $EXITO ]; then
        echo "$SOY Error: Al insertar $TABLA.sql"
        exit $E_FATAL
    fi
done

echo "$SOY Script terminado."
exit $EXITO
