#-*- coding:utf-8 -*-

import csv
import os.path
from . import basededatos
from . import scian2subsectores

def eliminar_tabla():
    """ Eliminar tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("DROP TABLE IF EXISTS scian_ramas")
    print("  Eliminada la tabla scian_ramas si existía.")

def crear_tabla():
    """ Crear tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("""
            CREATE TABLE scian_ramas (
                id           serial             PRIMARY KEY,
                subsector    integer            REFERENCES scian_subsectores NOT NULL,
                codigo       character(4)       UNIQUE,
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
                    INSERT INTO scian_ramas
                        (subsector, codigo, titulo, descripcion)
                    VALUES
                        (%s, %s, %s, %s)
                    """, (scian2subsectores.consultar_codigo(codigo[:3]), codigo, titulo, descripcion,))
                contador = contador + 1
    print("  Se insertaron {} ramas.".format(contador))

def consultar_codigo(codigo):
    """ Consultar un código y entregar su id """
    with basededatos.inegi() as bd:
        bd.cursor.execute("SELECT id FROM scian_ramas WHERE codigo = %s", (codigo,))
        if bd.cursor.rowcount == 0:
            return 1 # No se encontró, debería buscar un rango 'nn-mm'
        consulta = bd.cursor.fetchone()
        return int(consulta[0])
