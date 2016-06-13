
# Cartografía Geoestadística cierre Censo 2010

### Descarga manual

En el siguiente URL:

    http://www.inegi.org.mx/geo/contenidos/geoestadistica/m_geoestadistico.aspx

![Marco Geoestadístico Nacional](imagenes/marco-geoestadistico-nacional.jpg)

De clic en **Marco Geoestadístico - Datos vectoriales** de **Marco Geoestadístico 2010 versión 5.0 A (Censo de Población y Vivienda 2010)**

Será llevado al buscador de **Productos.**

Luego modifique la búsqueda con los siguientes parámetros para obtener menos resultados pero más precisos:

    Localidades Amanzanadas Cartografía Geoestadística 2010

Active también el filtro del estado que le interese. Por ejemplo, para Coahuila de Zaragoza:

![Productos](imagenes/productos.jpg)


### Descarga masiva

Dos Bash Scripts apuntan a los archivos ZIP de los estados de Coahuila de Zaragoza y Durango.

* Descargar05CoahuilaDeZaragoza.sh
* Descargar10Durango.sh

Éstos descargan por el comando curl y desempacan los archivos ZIP. Lamentablemente es irregular el contenido de los archivos desempacados, a veces depositan los archivos, otras subdirectorios e incluso más archivos ZIP. Tendrá que arreglar manualmente cada uno.


### Convertir SHP a SQL

El comando **shp2pgsql** es para crear archivos SQL con comandos INSERT que agregarán registros a la base de datos:

    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 050350001l.shp > 050350001l.sql
    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 050350001a.shp > 050350001a.sql
    $ shp2pgsql -s 97999 -a -e -i -W LATIN1 050350001m.shp > 050350001m.sql

Donde el parámetro -s indica el SRC, -a que no haya CREATE, -e comandos individales, -i enteros int4 y -W la codificación de origen.

Los archivos SQL creados tienen comandos que esperan que exista una tabla para cada localidad, AGEB y manzana:

    INSERT INTO "050350001l" ("geografico","cvegeo","codigo","fechaact","instituc","geometria",geom) ...
    INSERT INTO "050350001a" ("geografico","cvegeo","codigo","fechaact","instituc","geometria",geom) ...
    INSERT INTO "050350001m" ("geografico","cvegeo","codigo","fechaact","instituc","geometria",geom) ...
