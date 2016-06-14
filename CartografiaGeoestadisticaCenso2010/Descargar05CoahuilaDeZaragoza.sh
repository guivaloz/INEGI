#!/bin/bash

#
# Descargar Cartografía Geoestadística cierre Censo 2010 - Coahuila de Zaragoza
#
# Basado en otro script hecho por Diego Valle-Jones https://www.diegovalle.net
#

# Yo soy
SOY="[Descargar Cartografía Geoestadística cierre Censo 2010 - Coahuila de Zaragoza]"

# Constantes que definen los tipos de errores
EXITO=0
E_FATAL=99

# Orden para sólo probar (sin descargar) que existe el archivo en el servidor remoto
#CURL="wget --spider"

# Orden para descargar
CURL="wget"

# URL base en el servidor de INEGI, así como el término de cada archivo
BASE="http://internet.contenidos.inegi.org.mx/contenidos/Productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/urbana/SHP_2"
SUFIJO="_s.zip"

#
# Coahuila de Zaragoza
#

ESTADO="Coahuila_de_Zaragoza"
declare -a municipios=(
    "05001"  # Abasolo
    "05002"  # Acuña
    "05003"  # Allende
    "05004"  # Arteaga
    "05005"  # Candela
    "05006"  # Castaños
    "05007"  # Cuatro Ciénegas
    "05008"  # Escobedo
    "05009"  # Francisco I. Madero
    "05010"  # Frontera
    "05011"  # General Cepeda
    "05012"  # Guerrero
    "05013"  # Hidalgo
    "05014"  # Jiménez
    "05015"  # Juárez
    "05016"  # Lamadrid
    "05017"  # Matamoros
    "05018"  # Monclova
    "05019"  # Morelos
    "05020"  # Múzquiz
    "05021"  # Nadadores
    "05022"  # Nava
    "05023"  # Ocampo
    "05024"  # Parras
    "05025"  # Piedras Negras
    "05026"  # Progreso
    "05027"  # Ramos Arizpe
    "05028"  # Sabinas
    "05029"  # Sacramento
    "05030"  # Saltillo
    "05031"  # San Buenaventura
    "05032"  # San Juan de Sabinas
    "05033"  # San Pedro
    "05034"  # Sierra Mojada
    "05035"  # Torreón
    "05036"  # Viesca
    "05037"  # Villa Unión
    "05038") # Zaragoza

declare -a municipios_numeros=(
    "702825297022"  # Abasolo
    "702825297039"  # Acuña
    "702825297046"  # Allende
    "702825297053"  # Arteaga
    "702825297060"  # Candela
    "702825297077"  # Castaños
    "702825297084"  # Cuatro Ciénegas
    "702825297091"  # Escobedo
    "702825297107"  # Francisco I. Madero
    "702825297114"  # Frontera
    "702825297121"  # General Cepeda
    "702825297138"  # Guerrero
    "702825312480"  # Hidalgo
    "702825297145"  # Jiménez
    "702825297152"  # Juárez
    "702825312923"  # Lamadrid
    "702825297169"  # Matamoros
    "702825297176"  # Monclova
    "702825297183"  # Morelos
    "702825297190"  # Múzquiz
    "702825297206"  # Nadadores
    "702825297213"  # Nava
    "702825297220"  # Ocampo
    "702825297237"  # Parras
    "702825297244"  # Piedras Negras
    "702825297251"  # Progreso
    "702825297268"  # Ramos Arizpe
    "702825297275"  # Sabinas
    "702825313449"  # Sacramento
    "702825297282"  # Saltillo
    "702825297299"  # San Buenaventura
    "702825297305"  # San Juan de Sabinas
    "702825297312"  # San Pedro
    "702825297329"  # Sierra Mojada
    "702825297336"  # Torreón
    "702825297343"  # Viesca
    "702825297350"  # Villa Unión
    "702825297367") # Zaragoza

# Crear directorios
if [ ! -d Descargas ]; then
    mkdir Descargas
fi
if [ ! -d Desempacados ]; then
    mkdir Desempacados
fi

# Descargar
contador=0
for municipio_numero in "${municipios_numeros[@]}"
do
    DESCARGA="Descargas/${municipios[$contador]}.zip"
    DESEMPACADO="Desempacados/${municipios[$contador]}"
    if [ ! -z $municipio_numero ]; then
        URL="$BASE/$ESTADO/$municipio_numero$SUFIJO"
        if [ "$CURL" = "wget --spider" ]; then
            $CURL $URL
        else
            if [ ! -e "$DESCARGA" ]; then
                $CURL $URL -O $DESCARGA
                if [ "$?" -ne $EXITO ]; then
                    echo "ERROR: Al tratar de descargar $DESCARGA"
                    exit $E_FATAL
                fi
            fi
            if [ -e "$DESCARGA" ]; then
                if [ ! -d "$DESEMPACADO" ]; then
                    unzip -q -j -U $DESCARGA -d $DESEMPACADO -x "*.pdf"
                    if [ "$?" -ne $EXITO ]; then
                        echo "ERROR: Al parecer está corrupto $DESCARGA"
                        exit $E_FATAL
                    fi
                    echo "Desempacado archivos ZIP..."
                    find $DESEMPACADO/ -name "*.zip" -exec unzip -q -j -U {} -d $DESEMPACADO/  -x "*.pdf" \;
                    echo "Eliminando archivos ZIP..."
                    find $DESEMPACADO/ -name "*.zip" -delete
                    echo "Eliminando archivos directorios vacíos..."
                    find $DESEMPACADO/ -type d -exec rmdir {} \;
                else
                    echo "AVISO: Ya existe $DESEMPACADO entonces NO se desempaca."
                fi
            else
                echo "ERROR: No se encuentra $DESCARGA"
                exit $E_FATAL
            fi
        fi
    fi
    contador=`expr $contador + 1`
done

echo "$SOY Script terminado."
exit $EXITO
