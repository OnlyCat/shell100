#!/bin/sh

	current=`cd $(readlink -f $1); pwd`;
	for sourcename in `ls  $1`
	do
		sourcepath=${current}"/"${sourcename}
		if [ -f $sourcepath ];
		then
			targetname=`echo $sourcename | tr '[A-Z]' '[a-z]'`
			targetpath=${current}"/"${targetname}
			echo $sourcename "=>" $targetname
			mv $sourcepath  $targetpath;
		fi
	done
