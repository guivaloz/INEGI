#!/bin/bash

# Yo soy
SOY="[INEGI]"

# Constantes
BD="inegi"
BD_USUARIO="inegi"

# Abortal al presentarse cualquier error
set -e

#
# Crear Base de Datos INEGI
#

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

#
# Sistema Referencia Coordenadas
#

# Alimentar SRC
echo "$SOY Insertando SRC..."
psql -f SistemaReferenciaCoordenadas/src-itrf92-inegi.sql $BD

#
# Marco Geoestadistico Nacional 2010
#

cd MarcoGeoestadisticoNacional2010

# Crear tablas
echo "$SOY Creando las tablas..."
psql -U $BD_USUARIO -f 01.11-mgn_entidades.sql  $BD
psql -U $BD_USUARIO -f 01.12-mgn_municipios.sql $BD
psql -U $BD_USUARIO -f 01.13-mgn_localidades_urbanas.sql $BD
#psql -U $BD_USUARIO -f 01.14-mgn_localidades_rurales.sql $BD

cd Desempacados

# Elimnar SQL
echo "$SOY En MGN eliminando SQL..."
rm -f *.sql

# Exportar -s 97999
echo "$SOY En MGN exportando SHP a SQL..."
shp2pgsql -s 97999 -a -e -i -W LATIN1 mgn_entidades.shp           > mgn_entidades.sql
shp2pgsql -s 97999 -a -e -i -W LATIN1 mgn_municipios.shp          > mgn_municipios.sql
shp2pgsql -s 97999 -a -e -i -W LATIN1 mgn_localidades_urbanas.shp > mgn_localidades_urbanas.sql
#shp2pgsql -s 97999 -a -e -i -W LATIN1 mgn_localidades_rurales.shp > mgn_localidades_rurales.sql

# Insertar
echo "$SOY De MGN insertando entidades..."
psql -U $BD_USUARIO -f mgn_entidades.sql  $BD                 2>&1 > /dev/null
echo "$SOY De MGN insertando municipios..."
psql -U $BD_USUARIO -f mgn_municipios.sql $BD                 2>&1 > /dev/null
echo "$SOY De MGN insertando localidades urbanas..."
psql -U $BD_USUARIO -f mgn_localidades_urbanas.sql $BD        2>&1 > /dev/null
#echo "$SOY De MGN insertando localidades rurales..."
#psql -U $BD_USUARIO -f 01.14-mgn_localidades_rurales.sql $BD 2>&1 > /dev/null

echo "$SOY Script terminado."
exit 0
