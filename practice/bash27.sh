#!/bin/bash

for (( i=1;i<=10;i++ ));do
	
	sleep 1s

	if [[ $i -eq 5 ]];then
		continue
	fi

	echo ${i}

done

