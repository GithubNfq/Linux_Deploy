#!/bin/bash
#Autor Carlos Ferreiro
actual_Dir=$(dirname $0)
#Importar funciones
source $actual_Dir/tools.sh

# Variables
declare -a programas
mapfile -t programas < $actual_Dir/programs.list

install_programs ${programas[@],,} # ${programas[@],,} convierte a minúsculas
