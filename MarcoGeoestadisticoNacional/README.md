
# Marco Geoestadístico Nacional

En el menú horizontal vaya a Geografía > Temas > Cartografía Urbana o en este URL...

    http://www.inegi.org.mx/geo/contenidos/urbana/default.aspx

![Cartografía Urbana](imagenes/01-cartografia-urbana.png)

De clic en **Cartografía geoestadística urbana - descarga**

![Marco Geoestadístico Nacional](imagenes/02-marco-geoestadistico-nacional.png)

Cámbiese al directorio **Descargas**, que es donde tendremos los archivos ZIP que bajaremos.

    $ cd Descargas


### Descargar los estados

De clic en **Áreas Geoestadísticas Estatales (7.6 MB)**. O bien, para hacer una descarga directa:

    $ wget http://mapserver.inegi.org.mx/MGN/mge2014v6_2.zip


### Descargar los municipios

De clic en **Áreas Geoestadísticas Municipales (37.8 MB)**. O bien, para hacer una descarga directa:

    $ wget http://mapserver.inegi.org.mx/MGN/mgm2014v6_2.zip


### Descargar las localidades urbanas

De clic en **Polígonos de Localidades Urbanas Geoestadísticas (13.7 MB)**. O bien, para hacer una descarga directa:

    $ wget http://mapserver.inegi.org.mx/MGN/mglu2014v6_2.zip


### Descargar las localidades rurales

De clic en **Puntos de localidades Rurales (8.2 MB)**. O bien, para hacer una descarga directa:

    $ wget http://mapserver.inegi.org.mx/MGN/mglr2014v6_2.zip

Desempaque todos los archivos ZIP. Los archivos creados muévalos al directorio **Desempacados**.


### Convertir SHP a SQL

Primero siga el procedimiento del **Sistema de Referencia de Coordenadas (SRC)** que está en su directorio correspondiente.

El comando **shp2pgsql** es para crear archivos SQL con comandos INSERT que agregarán registros a la base de datos:

    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 mge2015v6_2.shp > mge2015v6_2.sql
    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 mgm2015v6_2.shp > mgm2015v6_2.sql
    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 mglu2015v6_2.shp > mglu2015v6_2.sql
    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 mglr2015v6_2.shp > mglr2015v6_2.sql

Donde el parámetro -s indica el SRC, -a que no haya CREATE, -e comandos individales, -i enteros int4 y -W la codificación de origen.

Observación: Los archivos SQL creados tienen comandos que esperan que exista una tabla para cada localidad, AGEB y manzana:

    INSERT INTO "mge2015v6_2" ("cve_ent","nom_ent",geom) VALUES (...
    INSERT INTO "mgm2015v6_2" ("cve_ent","cve_mun","nom_mun","concat",geom) VALUES (...
    INSERT INTO "mglu2015v6_2" ("cve_ent","cve_mun","cve_loc","nom_loc",geom) VALUES (...
    INSERT INTO "mglr2015v6_2" ("cve_ent","cve_mun","cve_loc","cve_ageb","nom_loc",geom) VALUES (...


### Alimentar la base de datos

Cree las tablas en la base de datos:

    $ psql -f 01.11-mgn_entidades.sql inegi
    $ psql -f 01.12-mgn_municipios.sql inegi
    $ psql -f 01.13-mgn_localidades_urbanas.sql inegi
    $ psql -f 01.14-mgn_localidades_rurales.sql inegi

Con **sed** cambie los nombres de las tablas:

    $ sed -i 's/mge2015v6_2/mgn_entidades/g' mge2015v6_2.sql
    $ sed -i 's/mgm2015v6_2/mgn_municipios/g' mgm2015v6_2.sql
    $ sed -i 's/mglu2015v6_2/mgn_localidades_urbanas/g' mglu2015v6_2.sql
    $ sed -i 's/mglr2015v6_2/mgn_localidades_rurales/g' mglr2015v6_2.sql

Explicación del comando sed:

    sed -i 's/original/new/g' file.txt
    sed = Stream Editor
     -i = in-place (i.e. save back to the original file)
    The command string:
        s        = the substitute command
        original = a regular expression describing the word to replace (or just the word itself)
        new      = the text to replace it with
        g        = global (i.e. replace all and not just the first occurrence)
    file.txt = the file name

Ejecute los archivos que insertarán:

    $ psql -f mge2015v6_2.sql inegi
    $ psql -f mgm2015v6_2.sql inegi
    $ psql -f mglu2015v6_2.sql inegi
    $ psql -f mglr2015v6_2.sql inegi
