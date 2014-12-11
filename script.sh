#!/bin/sh

#INCLUIMOS LAS FUNCIONES
. ./functions.sh

echo ""
echo " #########################################################"
echo " #           UNIVERSIDAD DE SANTIAGO DE CHILE            #"
echo " #               FACULTAD DE CIENCIA                     #"
echo " #   DPTO. DE MATEMÁTICA Y CIENCIA DE LA COMPUTACIÓN     #"
echo " #       LICENCIATURA EN CIENCIA DE LA COMPUTACIÓN       #"
echo " #                                                       #"
echo " #                                                       #"
echo " # NOMBRE: MARÍA FERNANDA MALDONADO PANTOJAS             #"
echo " # PROFESOR: JORGE URBINA                                #"
echo " #                                                       #"
echo " # SCRIPT QUE BLABLABLABLA...                            #"
echo " #########################################################"
echo ""
echo ""

#ELIMINAMOS LAS COPIAS DE SEGURIDAD ANTERIORES CON UNA FUNCIÓN EXTERNA
eliminarCopias

#OBTENEMOS EL LISTADO DE ARCHIVOS
FILES_LIST="`ls -l A/ | awk '{print $9}'`"

#OBTENEMOS EL LISTADO DE PROPIETARIOS DE DICHOS ARCHIVOS
FILES_OWNERS="`ls -l A/ | awk '{print $3}'`"

#LOS MOSTRAMOS
echo "** LISTADO DE ARCHIVOS **"
echo "${FILES_LIST}"
echo ""
echo "** LISTADO DE PROPIETARIOS **"
echo "${FILES_OWNERS}"
echo ""

#LLAMAMOS A UNA FUNCIÓN PARA SIMULAR UNA BARRA DE PROGRESO
barraProgreso

for FILE in $FILES_LIST; do
  sed 1p A/${FILE} > B/${FILE}
done 