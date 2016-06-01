
# INEGI Encuesta Intercensal 2015

Encuesta Intercensal 2015 con la finalidad de actualizar la información sociodemográfica a la mitad del periodo comprendido entre el Censo de 2010 y el que habrá de realizarse en 2020.

### ¿Dónde están estos datos abiertos?

Entre a...

    http://www.inegi.org.mx/est/contenidos/Proyectos/encuestas/hogares/especiales/ei2015/

Luego en Microdatos, descarga.

### Descarga masiva de los datos abiertos.

Para descargar todas las encuestas como archivos ZIP en una carpeta llamada Descargas...

    $ mkdir Descargas
    $ cd Descargas
    $ curl -O http://www3.inegi.org.mx/contenidos/proyectos/enchogares/especiales/intercensal/2015/microdatos/eic2015_[01-32]_csv.zip

Verifique la integridad de los archivos ZIP...

    $ unzip -tq \*.zip

Luego desempáquelos al directorio "Deseampacados"...

    $ mkdir ../Desempacados
    $ unzip -d ../Desempacados/ \*.zip

### Crear tablas e importar los archivos CSV

Ejecute el script ImportarArchivosCSV.py
