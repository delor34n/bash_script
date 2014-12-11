#!/bin/sh

#INCLUIMOS LAS FUNCIONES
. ./functions.sh

echo ""
echo " ##########################################################"
echo " #           UNIVERSIDAD DE SANTIAGO DE CHILE             #"
echo " #               FACULTAD DE CIENCIA                      #"
echo " #   DPTO. DE MATEMÁTICA Y CIENCIA DE LA COMPUTACIÓN      #"
echo " #       LICENCIATURA EN CIENCIA DE LA COMPUTACIÓN        #"
echo " #                                                        #"
echo " #                                                        #"
echo " # NOMBRE: MARÍA FERNANDA MALDONADO PANTOJAS              #"
echo " # PROFESOR: JORGE URBINA                           	   #"
echo " #                                                        #"
echo " # Script que permite cambiar los permisos a los 		  #"
echo " # archivos de un directorio. Luego de la ejecución del   #"
echo " # programa quedan en modo 755 (rwxr-xr-x)			  #"
echo " #                                                        #"
echo " # Al termino se indica en una tabla el número de 	   #"
echo " # archivos de los diferentes propietario, (se excluyen   #"
echo " # los directorios).							  #"
echo " #                                                        #"
echo " # Se utiliza el editor de linea sed para cambiar algunas #"
echo " # lineas del archivo.					  	   #"
echo " #                                                        #"
echo " # El programa comienza eliminando las copias de          #"
echo " # seguridad realizadas en el directorio 'B' y luego 	   #"
echo " # crea unas nuevas desde el directorio 'A' hacia el      #"
echo " # directorio 'B' 							  #"
echo " ##########################################################"
echo ""
echo ""

#ELIMINAMOS LAS COPIAS DE SEGURIDAD ANTERIORES CON UNA FUNCIÓN EXTERNA
eliminarCopias

#OBTENEMOS EL LISTADO DE ARCHIVOS
FILES_LIST="`ls -l A/ | awk '{print $9}'`"

#OBTENEMOS EL LISTADO DE PROPIETARIOS DE DICHOS ARCHIVOS
FILES_OWNERS="`ls -l A/ | awk '{print $3}'`"

sleep 1
#LOS MOSTRAMOS
echo "** LISTADO DE ARCHIVOS **"
echo "${FILES_LIST}"
echo ""
sleep 1
echo "** LISTADO DE PROPIETARIOS **"
echo "${FILES_OWNERS}"
echo ""
sleep 1

#LLAMAMOS A UNA FUNCIÓN PARA SIMULAR UNA BARRA DE PROGRESO
echo ""
barraProgreso 0.1 ">> REALIZANDO COPIA DE SEGURIDAD"

echo ""
barraProgreso 0.1 ">> CAMBIANDO PERMISOS A 755"

echo ""
barraProgreso 0.1 ">> INSERTANDO MENSAJE EN ARCHIVOS COPIADOS"

#ITERAMOS POR CADA ARCHIVO EN EL DIRECTORIO "A"
for FILE in $FILES_LIST; do
	
	#CREAMOS UNA COPIA DE SEGURIDAD EN "B" UTILIZANDO SED
  	sed 1p A/${FILE} > B/${FILE}

  	#OBTENEMOS EL ARCHIVO, LUEGO CON "AWK" LE OTORGAMOS PERMISOS 755:
  	# 	"/ASCII TEXT/" DEFINE EL FORMATO ASCII COMO PARAMETRO DE ENTRADA
  	#	"$1" == PRIMERA COLUMNA == PERMISOS
  	#	CON "XARGS" SE LE ASIGNA LOS PERMISOS (755 ó rwxr-xr-x) AL ARCHIVO
  	file B/${FILE} | awk '/ASCII text/ {gsub(/:/,"",$1); print $1}' | xargs chmod 755

  	#AGREGAMOS UN MENSAJE EN LOS ARCHIVOS ENTRE LAS LÍNEAS 3 y 7.
  	sed -i '3i\ \' B/${FILE}
  	sed -i '4i\ ########################################## \' B/${FILE}
  	sed -i '5i\ ###### [ SISTEMAS OPERATIVOS 2014 ] ###### \' B/${FILE}
  	sed -i '6i\ ########################################## \' B/${FILE}
  	sed -i '7i\ \' B/${FILE}

done

echo ""
echo ">> CONTANDO CANTIDAD DE ARCHIVOS POR USUARIO"
echo ""
sleep 1
#MOSTRAMOS LA CANTIDAD DE ARCHIVOS POR USUARIO
echo "+-----------+-----+"
echo "|  USUARIO  |  #  |"
echo "+-----------+-----+"
echo ${FILES_OWNERS} | tr " " "\n" | sort | uniq -c | sort -k2nr | awk '{printf("| %s  |  %s  |\n",$2,$1)}'
echo "+-----------+-----+"
echo ""