
# INEGI

Apuntes y scripts para trabajar con datos abiertos de INEGI. Programando con [Python](https://www.python.org/), importando los datos a la base de datos [PostgreSQL](https://www.postgresql.org/) y usando **GNU/Linux** como sistema operativo.


### Requerimientos

* GNU/Linux instalado con el entorno gráfico de su preferencia.
* PostgreSQL.
* PostGIS.
* Python versión 3 más las librerías:
    * [psycopg2](https://pypi.python.org/pypi/psycopg2) es un adaptador para PostgreSQL.
* QGIS.


### 1) inicie la base de datos

Si no lo ha hecho, cree el usuario **inegi** en PostgreSQL sin privilegio de crear nuevas bases de datos y sin ser superusuario.

    $ createuser -D -S inegi

Cree la base de datos **inegi** otorgándole la propiedad al usuario **inegi**:

    $ createdb -O inegi inegi


### 2) Ejecute CrearBaseDatos.sh

Es recomendable iniciar la B.D. con el **Sistema de Referencia de Coordenadas** de INEGI más el **Marco Geoestadístico Nacional 2010**.

**CrearBaseDatos.sh** ejecutará en el orden debido cada script que descarga, desempaca e inserta los registros a la B.D.:

1. SistemaReferenciaCoordenadas/04Insertar.sh
2. MarcoGeoestadisticoNacional2010/01Descargar.sh
3. MarcoGeoestadisticoNacional2010/02CrearTablas.sh
4. MarcoGeoestadisticoNacional2010/03Convertir.sh
5. MarcoGeoestadisticoNacional2010/04Insertar.sh

Así tendrá listas las **entidades, municipios y localidades urbanas.** Por ejemplo, filtrando los estados 05 (Coahuila de Zaragoza) y 10 (Durango) en QGIS:

![QGIS Muestra de Marco Geostadístico Nacional 2010](imagenes/qgis-mgn2010.png)

No deje de leer los archivos **README.md** que hay dentro de cada uno de los directorios.


### 3) Alimente más datos georreferenciados de sus estados.

Continúe con **Cartografía Geoestadística cierre Censo 2010** que proporciona AGEBs y manzanas.

Para **Coahuila de Zaragoza** y **Durango** siga esta secuencia...

1. 01Descargar05.sh
2. 01Descargar10.sh
3. 02CrearTablas.sh
4. 03Convertir.sh
5. 04Insertar.sh

Copie y modifique los _bash scripts_ para descargar sus entidades.

Por ejemplo, mostrando AGBEs y Manzanas en QGIS:

![QGIS Muestra de Marco Geostadístico Nacional 2010](imagenes/qgis-cgc2010.png)


### 4) Datos de DENUE

Está en construcción un script en Python llamado **InsertarCSV.py** para insertar los datos de DENUE a partir de la descarga de archivos CSV.

Lea el README.md en el directorio DENUE.
