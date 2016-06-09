
# INEGI

Apuntes y scripts para trabajar con datos abiertos de INEGI. Programando con [Python](https://www.python.org/), importando a la base de datos [PostgreSQL](https://www.postgresql.org/) y usando **GNU/Linux** como sistema operativo.

### Requerimientos

* GNU/Linux instalado con el entorno gráfico de su preferencia.
* PostgreSQL.
* PostGIS.
* Python versión 3 más las librerías:
    * [psycopg2](https://pypi.python.org/pypi/psycopg2) es un adaptador para PostgreSQL.
* QGIS.

### Para iniciar la base de datos

Si no lo ha hecho, cree el usuario **inegi** en PostgreSQL sin privilegio de crear nuevas bases de datos y sin ser superusuario.

    $ createuser -D -S inegi

Cree la base de datos **inegi** otorgándole la propiedad al usuario **inegi**:

    $ createdb -O inegi inegi

### Luego alimente el Sistema de Referencia de Coordenadas

INEGI usa el **ITRF92 INEGI**. Vaya al directorio **SistemaReferenciaCoordenadas** y siga los pasos de su propio README.md

### Cada directorio abarca un contenido de INEGI

Recomiendo comenzar con el **Marco Geostadístico Nacional** para bajar, alimentar y visualizar la información geográfica de estados, municipios, localidades y AGEBs.
