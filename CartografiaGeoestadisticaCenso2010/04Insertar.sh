#!/bin/bash

#
# Alimentar Cartografía Geoestadística Censo 2010
#

# Yo soy
SOY="[Alimentar Cartografía Geoestadística Censo 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Definir constantes de la Base de Datos
BD="inegi"
BD_USUARIO="inegi"

# Cambiar al directorio donde se encuentra este bash script y luego a Desempacados
cd "$(dirname "$0")"

# Debe de existir Desempacados
if [ ! -d Desempacados ]; then
    echo "$SOY Error: No existe el directorio Desempacados"
    exit $E_FATAL
fi

# Insertar
find Desempacados/ -name '*.sql' -exec psql -U $BD_USUARIO -f {} $BD \;

#
# Pendiente
#

# Término
echo "$SOY Script terminado."
exit $EXITO
