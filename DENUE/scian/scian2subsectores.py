#-*- coding:utf-8 -*-

import csv
import os.path
from . import basededatos
from . import scian1sectores

def eliminar_tabla():
    """ Eliminar tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("DROP TABLE IF EXISTS scian_subsectores")
    print("  Eliminada la tabla scian_subsectores si existía.")

def crear_tabla():
    """ Crear tabla """
    with basededatos.inegi() as bd:
        bd.cursor.execute("""
            CREATE TABLE scian_subsectores (
                id           serial             PRIMARY KEY,
                sector       integer            REFERENCES scian_sectores NOT NULL,
                codigo       character(3)       UNIQUE,
                titulo       character varying,
                descripcion  text
            )""")
    print("  Creada la tabla scian_subsectores.")

def insertar(archivo):
    """ Verificar si existe el archivo CSV """
    if not os.path.isfile(archivo):
        raise Exception("No existe el archivo {}".format(archivo))
    """  """
    relacion_codigos = scian1sectores.obtener_relacion_codigos()
    """ Insertar registros del archivo CSV a la base de datos """
    contador = 0
    with basededatos.inegi() as bd:
        with open(archivo, newline='') as contenedor:
            lector = csv.DictReader(contenedor)
            for renglon in lector:
                codigo      = renglon['Código'].strip()
                titulo      = renglon['Título'].strip()
                descripcion = renglon['Descripción'].strip()
                if codigo[:2] in relacion_codigos:
                    sector_id = relacion_codigos[codigo[:2]]
                else:
                    raise Exception("No se encuentra sector para el codigo {}.".format(codigo[:2]))
                bd.cursor.execute("""
                    INSERT INTO scian_subsectores
                        (sector, codigo, titulo, descripcion)
                    VALUES
                        (%s, %s, %s, %s)
                    """, (sector_id, codigo, titulo, descripcion,))
                contador = contador + 1
    print("  Se insertaron {} subsectores.".format(contador))

def consultar_codigo(codigo):
    """ Consultar un código y entregar su id """
    with basededatos.inegi() as bd:
        bd.cursor.execute("SELECT id FROM scian_subsectores WHERE codigo = %s", (codigo,))
        if bd.cursor.rowcount == 0:
            raise Exception("No se encuentra el código {} en subsectores.".format(codigo))
        consulta = bd.cursor.fetchone()
        return int(consulta[0])
