
# INEGI Encuesta Intercensal 2015

La Encuesta Intercensal 2015 tiene la finalidad de actualizar la información sociodemográfica a la mitad del período comprendido entre el Censo de 2010 y el que habrá de realizarse en 2020.

### ¿Dónde están estos datos abiertos?

En el siguiente URL...

    http://www.inegi.org.mx/est/contenidos/Proyectos/encuestas/hogares/especiales/ei2015/

Luego de clic en **Microdatos,** y **descarga.**

### Descarga masiva de los datos abiertos

Para descargar todas las encuestas como archivos ZIP en una carpeta llamada Descargas...

    $ mkdir Descargas
    $ cd Descargas
    $ curl -O http://www3.inegi.org.mx/contenidos/proyectos/enchogares/especiales/intercensal/2015/microdatos/eic2015_[01-32]_csv.zip

Verifique la integridad de los archivos ZIP...

    $ unzip -tq \*.zip

Luego desempáquelos al directorio "Deseampacados"...

    $ mkdir ../Desempacados
    $ unzip -d ../Desempacados/ \*.zip

### Base de datos en PostgreSQL

Cree un usuario de nombre **inegi** sin privilegios de superusuario PostgreSQL.

    $ createuser -D -S inegi

Cree la base de datos de nombre **inegi** y atribuya su propiedad al usuario **inegi**

    $ createdb -O inegi inegi

Para crear las tablas e importar los archivos CSV ejecute ImportarArchivosCSV.py

    $ ./ImportarArchivosCSV.py
