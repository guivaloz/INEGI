#!/usr/bin/env python3
#-*- coding:utf-8 -*-

from scian import *
import sys

def main(args):
    """ Ejecutar procedimiento principal """
    try:
        """ Eliminar tablas """
        scian4subramas.eliminar_tabla()
        scian3ramas.eliminar_tabla()
        scian2subsectores.eliminar_tabla()
        scian1sectores.eliminar_tabla()
        """ Crear tablas """
        scian1sectores.crear_tabla()
        scian2subsectores.crear_tabla()
        scian3ramas.crear_tabla()
        scian4subramas.crear_tabla()
        """ Insertar registros """
        scian1sectores.insertar('scian/scian1sectores.csv')
        scian2subsectores.insertar('scian/scian2subsectores.csv')
        scian3ramas.insertar('scian/scian3ramas.csv')
        scian4subramas.insertar('scian/scian4subramas.csv')
        print("Procedimiento principal completado.")
    except Exception as e:
        print("ERROR: %s" % e)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
