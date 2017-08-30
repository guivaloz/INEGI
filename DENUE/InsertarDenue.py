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

from denue import *
import sys

def main(args):
    """ Procedimiento principal """
    try:
        # Eliminar tabla
        denue.eliminar_tabla()
        # Crear tabla
        denue.crear_tabla()
        # Insertar registros desde el archivo CSV, con corte YYYY-MM y filtrar por claves de municipios
        denue.insertar('Desempacados/denue_05_2017-03.csv', '2017-03', ['05017']) # Matamoros, Coahuila de Zaragoza
        denue.insertar('Desempacados/denue_05_2017-03.csv', '2017-03', ['05035']) # Torreón, Coahuila de Zaragoza
        denue.insertar('Desempacados/denue_10_2017-03.csv', '2017-03', ['10007']) # Gómez Palacio, Durango
        denue.insertar('Desempacados/denue_10_2017-03.csv', '2017-03', ['10012']) # Lerdo, Durango
    except Exception as e:
        print("ERROR: %s" % e)

if __name__ == '__main__':
    sys.exit(main(sys.argv))
