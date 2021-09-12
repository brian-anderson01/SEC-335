#!/bin/bash

hostfile=$1
portfile=$2

#Asks user how they would like the output and ingests input
read -p "Would you like the Output [p]rinted or [e]xported? " printoption


function printresults() {
	echo "Printing results:"
	echo "Host IP    Open Port"
	for host in $(cat $hostfile); do
  	  for port in $(cat $portfile); do
    	    timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null && 
      	      echo "$host   $port"
  done
done

}

function exportresults(){
	read -p "What would you like to name the output file? " outname
	echo "host,port" >> $outname.csv
	echo "Please wait while the scan runs"
	
      	for host in $(cat $hostfile); do
	  for port in $(cat $portfile); do
	    timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
		echo "$host,$port" >> $outname.csv
  done 
done

echo "See exported file for results."
}


if [[ ${printoption} == [pP] ]]
then
	printresults

elif [[ ${printoption} == [eE] ]]
then
	exportresults

else
	echo "Please run the command again and choose a supported option"

fi

#Credit to my SYS320 repository for the bash refresher
