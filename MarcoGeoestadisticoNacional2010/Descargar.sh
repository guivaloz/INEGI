#!/bin/bash

# Abortar al presentarse cualquier error
set -e

#
# Descargar
#

cd Descargas

if [ ! -e "mge2010v5_0a.zip" ]; then
    wget http://mapserver.inegi.org.mx/MGN/mge2010v5_0a.zip
fi
if [ ! -e "mgm2010v5_0a.zip" ]; then
    wget http://mapserver.inegi.org.mx/MGN/mgm2010v5_0a.zip
fi
if [ ! -e "mglu2010v5_0a.zip" ]; then
    wget http://mapserver.inegi.org.mx/MGN/mglu2010v5_0a.zip
fi
if [ ! -e "mglr2010v5_0a.zip" ]; then
    wget http://mapserver.inegi.org.mx/MGN/mglr2010v5_0a.zip
fi

for EXT in "dbf" "prj" "sbn" "sbx" "shp" "shx" "xml"
do
    rm -rf "../Desempacados/*.${EXT}"
done

unzip -d ../Desempacados/ mge2010v5_0a.zip
unzip -d ../Desempacados/ mgm2010v5_0a.zip
unzip -d ../Desempacados/ mglu2010v5_0a.zip
unzip -d ../Desempacados/ mglr2010v5_0a.zip

cd ../Desempacados

for EXT in "dbf" "prj" "sbn" "sbx" "shp" "shx" "xml"
do
    if [ -e "Entidades_2010_5A.${EXT}" ]; then
        mv "Entidades_2010_5A.${EXT}" "mgn_entidades.${EXT}"
    fi
    if [ -e "Municipios_2010_5A.${EXT}" ]; then
        mv "Municipios_2010_5A.${EXT}" "mgn_municipios.${EXT}"
    fi
    if [ -e "Localidades urbanas_2010_5A.${EXT}" ]; then
        mv "Localidades urbanas_2010_5A.${EXT}" "mgn_localidades_urbanas.${EXT}"
    fi
    if [ -e "Localidades rurales_2010_5A.${EXT}" ]; then
        mv "Localidades rurales_2010_5A.${EXT}" "mgn_localidades_rurales.${EXT}"
    fi
done
