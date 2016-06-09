#!/bin/bash

#
# Descargar Cartografía Geoestadística cierre Censo 2010
#   cartografía geoestadística localidades amanzanadas urbana cierre censo 2010

# Orden para sólo probar (sin descargar) que existe el archivo en el servidor remoto
CURL="wget --spider"

# Orden para descargar
#CURL="wget --continue"

# URL base en el servidor de INEGI, así como el término de cada archivo
BASE="http://internet.contenidos.inegi.org.mx/contenidos/Productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/urbana/SHP_2"
SUFIJO="_s.zip"

#
# Durango
#

ESTADO="Durango"
declare -a municipios=(
    "10001"  # Canatlán
    "10002"  # Canelas
    "10003"  # Coneto de Comonfort
    "10004"  # Cuencamé
    "10005"  # Durango
    "10006"  # General Simón Bolívar
    "10007"  # Gómez Palacio
    "10008"  # Guadalupe Victoria
    "10009"  # Guanaceví
    "10010"  # Hidalgo
    "10011"  # Indé
    "10012"  # Lerdo
    "10013"  # Mapimí
    "10014"  # Mezquital
    "10015"  # Nazas
    "10016"  # Nombre de Dios
    "10017"  # Ocampo
    "10018"  # El Oro
    "10019"  # Otáez
    "10020"  # Pánuco de Coronado
    "10021"  # Peñón Blanco
    "10022"  # Poanas
    "10023"  # Pueblo Nuevo
    "10024"  # Rodeo
    "10025"  # San Bernardo
    "10026"  # San Dimas
    "10027"  # San Juan de Guadalupe
    "10028"  # San Juan del Río
    "10029"  # San Luis del Cordero
    "10030"  # San Pedro del Gallo
    "10031"  # Santa Clara
    "10032"  # Santiago Papasquiaro
    "10033"  # Suchil
    "10034"  # Tamazula
    "10035"  # Tepehuanes
    "10036"  # Tlahualilo
    "10037"  # Topia
    "10038"  # Vicente Guerrero
    "10039") # Nuevo Ideal
declare -a municipios_numeros=(
    "702825299378"  # Canatlán
    "702825299385"  # Canelas
    "702825299392"  # Coneto de Comonfort
    "702825299408"  # Cuencamé
    "702825299415"  # Durango
    "702825299422"  # General Simón Bolívar
    "702825299439"  # Gómez Palacio
    "702825299446"  # Guadalupe Victoria
    "702825299453"  # Guanaceví
    "702825299460"  # Hidalgo
    "702825299477"  # Indé
    "702825299484"  # Lerdo
    "702825299491"  # Mapimí
    "702825299507"  # Mezquital
    "702825299514"  # Nazas
    "702825299521"  # Nombre de Dios
    "702825299538"  # Ocampo
    "702825299545"  # El Oro
    "702825299552"  # Otáez
    "702825299569"  # Pánuco de Coronado
    "702825299576"  # Peñón Blanco
    "702825299583"  # Poanas
    "702825299590"  # Pueblo Nuevo
    "702825299606"  # Rodeo
    "702825299613"  # San Bernardo
    "702825299620"  # San Dimas
    "702825299637"  # San Juan de Guadalupe
    "702825299644"  # San Juan del Río
    "702825299651"  # San Luis del Cordero
    "702825299668"  # San Pedro del Gallo
    "702825299675"  # Santa Clara
    "702825299682"  # Santiago Papasquiaro
    "702825299699"  # Suchil
    "702825299705"  # Tamazula
    "702825299712"  # Tepehuanes
    "702825299729"  # Tlahualilo
    "702825299736"  # Topia
    "702825299743"  # Vicente Guerrero
    "702825299750") # Nuevo Ideal

# Descargar
contador=0
for municipio_numero in "${municipios_numeros[@]}"
do
    if [ ! -d Descargas ]; then
        mkdir Descargas
    fi
    if [ ! -z $municipio_numero ]; then
        URL="$BASE/$ESTADO/$municipio_numero$SUFIJO"
        DESTINO="Descargas/${municipios[$contador]}.zip"
        if [ "$CURL" = "wget --spider" ]; then
            $CURL $URL
        else
            $CURL $URL -o $DESTINO
        fi
    fi
    contador=`expr $contador + 1`
done
