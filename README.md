# INEGI

Apuntes y scripts para trabajar con datos abiertos de INEGI. Programando con Python e importando a la base de datos PostgreSQL.

### Para iniciar la base de datos

Si no lo ha hecho, cree el usuario inegi en PostgreSQL sin privilegio de crear nuevas bases de datos y sin ser superusuario.

    $ createuser -D -S inegi

Cree la base de datos inegi otorgándole la propiedad al usuario inegi:

    $ createdb -O inegi inegi

Lea el archivo README.md de cada directorio para más instrucciones.

Si desea empezar de nuevo, elimine la base de datos con:

    $ dropdb inegi
