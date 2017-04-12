#!/bin/sh

function char_rand()
{
	char=''
	min=-1;
	max=-1;
	case $1	in
	1)
		min=65
		max=$((90-$min+1))	
		;;
	2)
		min=97
		max=$((122-$min+1))	
		;;
	3)
		min=48
		max=$((57-$min+1))	
		;;		
	4)
		min=33
		max=$((126-$min+1))
	esac
	echo $(($RANDOM%$max+$min))
}


function char_conver()
{
	echo $1 | awk '{printf("%c", $1)}'
}


function hex_conver()
{
	echo "obase=$1;ibase=$2;$3" | bc
}


function contrast()
{
	if [ $1 -eq $2 ];
	then
		echo 1
	else
		echo -1
	fi
}

echo -e "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
echo -e "*\tWelcome to the ASCII memory script\t*"
echo -e "*\t\t1.Lower case character a-z\t*"
echo -e "*\t\t2.Uppercase case character A-Z\t*"
echo -e "*\t\t3.Numeric case character 0-9\t*"
echo -e "*\t\t4.Non print control character\t*"
echo -e "*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
read -p "Please enter a memory type:" num

success=0;
error=0;

while true
do
	asc_dec=`char_rand $num`
	
	chat=`char_conver $asc_dec`
	
	asc_bin=`hex_conver 2 10 $asc_dec`
	
	read -p "Character [$chat] ASCII binary code is:" user_asc
	
	result=`contrast $asc_bin $user_asc`
	
	if [ $result -eq 1 ];
	then
		let success++;
		echo -e "\033[42m SUCCESS:\033[0m character: $chat \n\t Standard decimal ASCII code:$asc_dec \n\t Standard binary ASCII code:$asc_bin \n\t Your input:$user_asc"
	else
		let error++;
		echo -e "\033[41m ERROR:\033[0m character: $chat \n\t Standard decimal ASCII code:$asc_dec \n\t Standard binary ASCII code:$asc_bin \n\t Your input:$user_asc"
	fi
	
	trap "echo ;echo ------------------------------------------; echo Correct:$success Error:$error; exit"  2
done
