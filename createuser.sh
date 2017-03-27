#!/bin/sh
#FileName CreateUser.sh

function isroot 
{
	return $UID	
}

function isgroup
{
	groupname=$1;
	egrep "^$groupname" /etc/group > /dev/null;
	return $?
}

function mkgroup
{
	groupadd $1
}

function userexists
{
	username=$1;
	egrep "^$username" /etc/passwd > /dev/null;
	return $?;
}

function mkuser
{
	uname=$1
	gname=$2
	useradd -g $gname $uname
	if [ $? -eq 0 ]; then 
		echo "123456" | passwd $uname --stdin;
	fi
}


isroot
if [ $? -ne 0 ]; then
	echo "Please use the root user to run";
	exit ;
fi



read -p "Please add user group name:" gname;
isgroup $gname;

if [ $? -ne 0 ]; then
	read -p "User group $gname not found , Create user group $gname(Y/N):" sign;
 	typeset -l $sign;
	if [ $sign = "y" ]; then
		echo "user group is creating...";
		
		mkgroup $gname;
		if [ $? -eq 0 ]; then 
			echo "user group created successfully";
		else
			echo "user group created failed";
			exit;
		fi

	else
		echo "shell exit";
		exit;
	fi



fi

read -p "Please enter the user prefix:" utag;
read -p "Pleade enter the number of users:" ucount;

i=1;
while [ $i -le $ucount ]
do
	user=$utag$i;
	userexists $user;
	if [ $? -ne 0 ]; then 
		mkuser $user $gname	
	fi
	i=$(($i+1));
done
	

