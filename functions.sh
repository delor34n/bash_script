#!/bin/bash

progressBar() {
	count=0
	total=34
	pstr="[======================================================================]"

	while [ $count -lt $total ]; do
	  sleep 0.1 # this is work
	  count=$(( $count + 1 ))
	  pd=$(( $count * 73 / $total ))
	  printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr
	done

	echo ""
	echo ""
}