
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
