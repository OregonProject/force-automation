#!/bin/bash

force whoami | grep "Username"
read -p "Would you like to change users?: " CHANGE
case "$CHANGE" in 
   [yY] | [yY][eE][sS])
     force login -i=test
     ;;
   [nN] | [nN][oO])
     :
     ;;
   *)
     echo "Please enter y/yes or n/no"
     ;;
esac

read -p "Enter the Salesforce Object: " sObject
read -p "Enter the SOQL query: " SOQL

force query --all --format csv "$SOQL" >> sf_$sObject.csv

read -p "Would you like to insert this file somewhere else?: " INSERT
case "$INSERT" in 
   [yY] | [yY][eE][sS])
     force login -i=test
     force bulk insert $sObject sf_$sObject.csv
     ;;
   [nN] | [nN][oO])
     echo "You can find your file in the current directory as 'sf_$sObject.csv'"
     ;;
   *)
     echo "Please enter y/yes or n/no"
     ;;
esac

