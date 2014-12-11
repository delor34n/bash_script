#!/bin/bash

barraProgreso() {
	count=0
	total=34
	pstr="[======================================================================]"
	echo $2
	echo ""
	while [ $count -lt $total ]; do
		sleep $1 # this is work
	  	count=$(( $count + 1 ))
	  	pd=$(( $count * 73 / $total ))
	  	printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
	done

	echo ""
	echo ""
}

eliminarCopias() {

	check="`ls -l B/ | awk '{print $2}'`"
	if [ "${check}" = "0" ]
	then
		echo ""
		echo "### NO EXISTEN COPIAS DE SEGURIDAD PARA ELIMINAR!! ###"
		echo ""
		echo ""
		sleep 1
	else
		#LLAMAMOS A UNA FUNCIÓN PARA SIMULAR UNA BARRA DE PROGRESO
		barraProgreso 0.05 ">> ELIMINANDO ARCHIVOS TEMPORALES"
		rm B/*
	fi
	
}