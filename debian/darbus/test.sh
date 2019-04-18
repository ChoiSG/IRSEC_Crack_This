#!/bin/bash

wow=$(nginx -V 2>&1)
if [ $(echo $wow | wc -c) -gt 1000 ]; then 
	echo "you did it"
	printf "\nNOT HEADSHOT. Here is the proof"
	echo $wow
else
	echo "fuuuuuuck"
fi 
