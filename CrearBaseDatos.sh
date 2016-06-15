#!/bin/bash

#
# Crear Base de Datos INEGI
#

# Yo soy
SOY="[INEGI]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Definir constantes
BD="inegi"
BD_USUARIO="inegi"

# Cambiar al directorio donde se encuentra este bash script
cd "$(dirname "$0")"

# Eliminar BD
echo "$SOY Eliminando BD..."
dropdb $BD

# Crear BD
echo "$SOY Creando BD..."
createdb -O $BD_USUARIO $BD

# Poner extensiones PostGIS
echo "$SOY Creando extensiones PostGIS..."
psql -c "CREATE EXTENSION postgis;" $BD
psql -c "CREATE EXTENSION postgis_topology;" $BD

# Sistema Referencia Coordenadas
SistemaReferenciaCoordenadas/04Insertar.sh
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi

# Marco Geoestadistico Nacional 2010
MarcoGeoestadisticoNacional2010/01Descargar.sh
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi
MarcoGeoestadisticoNacional2010/02CrearTablas.sh
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi
MarcoGeoestadisticoNacional2010/03Convertir.sh
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi
MarcoGeoestadisticoNacional2010/04Insertar.sh
if [ "$?" -ne $EXITO ]; then
    exit $E_FATAL
fi

echo "$SOY Script terminado."
exit $EXITO
