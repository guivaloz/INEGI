#!/bin/bash

#
# Alimentar AGEBs
#

find Desempacados/ -name "*.shp" -exec shp2pgsql -s 97999 -c -e -i -W LATIN1 {} mgn_agebs > {}.sql \;

#     $ shp2pgsql -s 97999 -c -e -i -W LATIN1 050350001A.shp dag_agebs > insertar-trcimplan_desagregacion-dag_agebs.sql
