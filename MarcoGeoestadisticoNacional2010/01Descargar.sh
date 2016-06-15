#!/bin/bash

#
# Descargar Marco Geoestadístico Nacional 2010
#

# Yo soy
SOY="[Descargar Marco Geoestadístico Nacional 2010]"

# Definir constantes que definen los tipos de errores
EXITO=0
E_NOARGS=65
E_FATAL=99

# Cambiar al directorio donde se encuentra este bash script
cd "$(dirname "$0")"

# Crear el directorio Descargas si no existe
if [ ! -d Descargas ]; then
    mkdir Descargas
    if [ "$?" -ne $EXITO ]; then
        echo "$SOY Error: No pude crear el directorio Descargas"
        exit $E_FATAL
    fi
fi

# Cambiarse al directorio Descargas
cd Descargas

# Bajar los archivos ZIP de INEGI si no existen
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

# Crear el directorio Desempacados si no existe
if [ ! -d ../Desempacados ]; then
    mkdir ../Desempacados
    if [ "$?" -ne $EXITO ]; then
        echo "$SOY Error: No pude crear el directorio Desempacados"
        exit $E_FATAL
    fi
fi

# Eliminar archivos anteriores
for EXT in "dbf" "prj" "sbn" "sbx" "shp" "shx" "xml"
do
    rm -f "../Desempacados/*.${EXT}"
done

# Desempacar
for NOMBRE in "mge2010v5_0a" "mgm2010v5_0a" "mglu2010v5_0a" "mglr2010v5_0a"
do
    unzip -d ../Desempacados/ $NOMBRE.zip
    if [ "$?" -ne $EXITO ]; then
        echo "$SOY Error: Al desempacar $NOMBRE.zip"
        exit $E_FATAL
    fi
done

# Cambiarse al directorio Desempacados
cd ../Desempacados

# Renombrar los archivos a los nombres de las tablas
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

echo "$SOY Script terminado."
exit $EXITO
