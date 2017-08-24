#!/usr/bin/env python3
#-*- coding:utf-8 -*-

#
# Copyright 2017 Guillermo Valdés Lozano <guillermo@movimientolibre.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

from scian import *
import sys

def main(args):
    """ Procedimiento principal """
    try:
        # Eliminar tablas
        scian4subramas.eliminar_tabla()
        scian3ramas.eliminar_tabla()
        scian2subsectores.eliminar_tabla()
        scian1sectores.eliminar_tabla()
        # Crear tablas
        scian1sectores.crear_tabla()
        scian2subsectores.crear_tabla()
        scian3ramas.crear_tabla()
        scian4subramas.crear_tabla()
        # Insertar registros desde archivos CSV
        scian1sectores.insertar('scian/scian1sectores.csv')
        scian2subsectores.insertar('scian/scian2subsectores.csv')
        scian3ramas.insertar('scian/scian3ramas.csv')
        scian4subramas.insertar('scian/scian4subramas.csv')
        print("Procedimiento principal completado.")
    except Exception as e:
        print("ERROR: %s" % e)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
