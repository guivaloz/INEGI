#!/usr/bin/env python3
#-*- coding:utf-8 -*-

from denue import *
import sys

def main(args):
    """ Function doc """
    try:
        denue.eliminar_tabla()
        denue.crear_tabla()
        denue.insertar('Desempacados/denue_05_2017-03.csv', '2017-03', ['05035'])
    except Exception as e:
        print("ERROR: %s" % e)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
