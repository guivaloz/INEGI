#!/bin/bash

#
# Descargar - 05 Coahuila de Zaragoza
#

# Yo soy
SOY="[Descargar - 05 Coahuila de Zaragoza]"

# Constantes que definen los tipos de errores
EXITO=0
E_FATAL=99

# Orden para sólo probar (sin descargar) que existe el archivo en el servidor remoto
#CURL="wget --spider"

# Orden para descargar
CURL="wget"

# URL base en el servidor de INEGI, así como el término de cada archivo
BASE="http://internet.contenidos.inegi.org.mx/contenidos/Productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/urbana/SHP"
INTERMEDIO="SHP"
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

#     http://internet.contenidos.inegi.org.mx/contenidos/Productos/prod_serv/contenidos/espanol/bvinegi/productos/geografia/urbana/SHP/Coahuila_de_Zaragoza/SHP/702825582968_s.zip
#    702825582968_s.zip
declare -a municipios_numeros=(
    "702825582968"  # Abasolo
    "702825582975"  # Acuña
    "702825582982"  # Allende
    "702825582999"  # Arteaga
    "702825583002"  # Candela
    "702825583019"  # Castaños
    "702825583026"  # Cuatro Ciénegas
    "702825583033"  # Escobedo
    "702825583040"  # Francisco I. Madero
    "702825583057"  # Frontera
    "702825583064"  # General Cepeda
    "702825583071"  # Guerrero
    "702825583088"  # Hidalgo
    "702825583095"  # Jiménez
    "702825583101"  # Juárez
    "702825583118"  # Lamadrid
    "702825583125"  # Matamoros
    "702825583132"  # Monclova
    "702825583149"  # Morelos
    "702825583156"  # Múzquiz
    "702825583163"  # Nadadores
    "702825583170"  # Nava
    "702825583187"  # Ocampo
    "702825583194"  # Parras
    "702825583200"  # Piedras Negras
    "702825583217"  # Progreso
    "702825583224"  # Ramos Arizpe
    "702825583231"  # Sabinas
    "702825583248"  # Sacramento
    "702825583255"  # Saltillo
    "702825583262"  # San Buenaventura
    "702825583279"  # San Juan de Sabinas
    "702825583286"  # San Pedro
    "702825583293"  # Sierra Mojada
    "702825583309"  # Torreón
    "702825583316"  # Viesca
    "702825583323"  # Villa Unión
    "702825583330") # Zaragoza

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
        URL="$BASE/$ESTADO/$INTERMEDIO/$municipio_numero$SUFIJO"
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
