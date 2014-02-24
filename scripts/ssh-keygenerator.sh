###### Start #########

#!/bin/bash
#################################################
# Script: keysGenerator
# Description: This script create RSA keys and commit them to SVN repository
##################################################

#just for fun
loading_dots () {
    i=0

    while [ "$i" -lt "$1" ]
    do
	echo -n "."
	sleep 1
	i=`expr $i + 1`
    done
}
echo ""
echo "*************************************" 
echo "*Welcome to the Key Generator script*"
echo "*************************************" 
echo ""

echo "Please enter your LDAP login:"
read user

echo "Thank you."
echo ""
echo "Creating your SSH keys"

loading_dots 3 &
ssh-keygen -q -f ~/.ssh/"id_rsa" -t rsa -b 4096 -P ''

#Checking that Keys has been successfully created
if [ $? -eq 0 ]
then
    echo "Keys created."
    echo ""
else
    echo "Error while creating Keys, try the process manually."
    exit 1
fi

echo "Please provide your SVN credentials."
echo "Login:" 
read login
echo ""

echo "Password:"
read -s password

echo ""
echo "Thank you."
echo ""
echo "Commiting your key to the SVN repository."
loading_dots 5 &

svn co -q --username "$login" --password "$password" https://jboutelle.svn.cvsdude.com/system/keys

cp  ~/.ssh/id_rsa.pub ./keys/users/home/"$user".pub
svn -q add ./keys/users/home/"$user".pub
svn -q commit -m "adding key for $user" ./keys/users/home/"$user".pub
rm -rf ./keys

echo ""
echo "Key sent."
echo ""

#importing config file for SSH auto hops
if [ -e ~/.ssh/config ]
then
    echo "Do you want to erase you current .ssh/config file with the new one? (yes/no):"
    read erase
  
    #making sure the user want to overide the already existing config
    if [ $erase == "yes" ]
    then
	svn export -q https://jboutelle.svn.cvsdude.com/contrib/sylvain/authentication_project/config ~/.ssh/config
	echo "SSH config for auto-hops imported."
	if [ $# -eq 1 ]
	then
	    echo "Error importing SSH config file."
	fi
    else
	echo "File not replaced."
    fi
fi

echo ""
echo "You are all set!"
echo "Please wait 2 minutes for your key to be pushed to the servers."


######## END ##########


