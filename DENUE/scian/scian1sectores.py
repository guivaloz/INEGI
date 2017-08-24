#-*- coding:utf-8 -*-

import csv
import os.path
from . import basededatos

def eliminar_tabla():
    """ Eliminar tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("DROP TABLE IF EXISTS scian_sectores")
    print("  Eliminada la tabla scian_sectores si existía.")

def crear_tabla():
    """ Crear tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("""
            CREATE TABLE scian_sectores (
                id           serial             PRIMARY KEY,
                codigo       character(5)       UNIQUE,
                titulo       character varying,
                descripcion  text
            )""")
    print("  Creada la tabla scian_sectores.")

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
                    INSERT INTO scian_sectores
                        (codigo, titulo, descripcion)
                    VALUES
                        (%s, %s, %s)
                    """, (codigo, titulo, descripcion,))
                contador = contador + 1
    print("  Se insertaron {} sectores.".format(contador))

def obtener_relacion_codigos():
    """ Como hay rangos de códigos nn-mm se elabora un diccionario código => sector_id """
    with basededatos.inegi() as bd:
        bd.cursor.execute("SELECT id, codigo FROM scian_sectores")
        if bd.cursor.rowcount == 0:
            raise Exception("No se encontraron registros en scian_sectores.")
        diccionario = dict()
        for r in bd.cursor.fetchall():
            i = int(r[0])
            c = r[1].strip()
            if '-' in c:
                a = c.split('-')
                for j in range(int(a[0]), int(a[1])+1):
                    diccionario[str(j)] = i
            else:
                diccionario[c] = i
    return diccionario
