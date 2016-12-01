
# Directorio Estadístico Nacional de Unidades Económicas (DENUE)

Localizado en el siguiente URL...

    http://www.beta.inegi.org.mx/app/mapa/denue/default.aspx

De clic clic en la opción Descargar.

Elija el estado. Descargue los CSV y SHP más recientes, por ejemplo de Coahuila de Zaragoza(05).

Para descargar de forma manual

    $ cd ~/Documentos/GitHub/guivaloz/INEGI/DENUE/Descargas/
    $ wget http://www.beta.inegi.org.mx/contenidos/masiva/denue/denue_05_csv.zip
    $ wget http://www.beta.inegi.org.mx/contenidos/masiva/denue/denue_05_shp.zip

Parece que los archivos históricos tienen el mes en número (01) y los dos últimos dígitos del año (16).

Estos son los de enero de 2016:

    http://www.beta.inegi.org.mx/contenidos/masiva/denue/denue_05_0116_csv.zip
    http://www.beta.inegi.org.mx/contenidos/masiva/denue/denue_05_0116_shp.zip

Descomprima.

    $ unzip -d ../Desempacados/ denue_05_shp.zip

El comando **shp2pgsql** es para crear archivos SQL con comandos INSERT que agregarán registros a la base de datos.

Con WGS84 = SRID(4326) porque es latitud y longitud tradicional.

    $ cd ../Desempacados/denue_05_shp/conjunto_de_datos/
    $ shp2pgsql -s 4326 -a -e -i -W LATIN1 denue_inegi_05_.shp > denue_inegi_05_.sql
    $ shp2pgsql -s 4326 -a -e -i -W UTF-8 denue_inegi_05_.shp > denue_inegi_05_.sql
    $ less denue_inegi_05_.sql
