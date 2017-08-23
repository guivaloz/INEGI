#-*- coding:utf-8 -*-

import csv
import os.path
from . import basededatos
from . import scian3ramas

def eliminar_tabla():
    """ Eliminar tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("DROP TABLE IF EXISTS scian_subramas")
    print("  Eliminada la tabla scian_subramas si existía.")

def crear_tabla():
    """ Crear tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("""
            CREATE TABLE scian_subramas (
                id           serial             PRIMARY KEY,
                rama         integer            REFERENCES scian_ramas NOT NULL,
                codigo       character(5)       UNIQUE,
                titulo       character varying,
                descripcion  text
            )""")
    print("  Creada la tabla scian_ramas.")

def insertar(archivo):
    """ Verificar si existe el archivo CSV """
    if not os.path.isfile(archivo):
        raise Exception("No existe el archivo {}".format(archivo))
    """ Insertar registros del archivo CSV a la base de datos """
    contador = 0
    with basededatos.inegi() as bd:
        with open(archivo, newline='') as contenedor:
            lector = csv.DictReader(contenedor)
            for renglon in lector:
                codigo      = renglon['Código'].strip()
                titulo      = renglon['Título'].strip()
                descripcion = renglon['Descripción'].strip()
                bd.cursor.execute("""
                    INSERT INTO scian_subramas
                        (rama, codigo, titulo, descripcion)
                    VALUES
                        (%s, %s, %s, %s)
                    """, (scian3ramas.consultar_codigo[:4], codigo, titulo, descripcion,))
                contador = contador + 1
    print("  Se insertaron {} subramas.".format(contador))
