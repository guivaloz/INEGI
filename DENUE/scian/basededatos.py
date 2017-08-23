#-*- coding: utf-8 -*-

import psycopg2

class inegi(object):
    """ Base de datos INEGI """

    def __init__(self):
        """ Inicializar """
        servidor      = '127.0.0.1'
        bd            = 'inegi'
        usuario       = 'inegi'
        contrasena    = 'loquesea'
        self.conexion = psycopg2.connect("host=%s dbname='%s' user='%s' password='%s'" % (servidor, bd, usuario, contrasena,))
        self.cursor   = self.conexion.cursor()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """ Entregar los comandos y cerrar """
        self.conexion.commit()
        self.conexion.close()
