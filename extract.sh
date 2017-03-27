#!/bin/sh
	for fname in `find $1 -name $2`
	do
		if [ ! -d './fruit/' ]; then
			`mkdir ./fruit`;
		fi
		`cp $fname ./fruit/`
	done
