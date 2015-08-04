#!/bin/bash
# Description: Script provides the Private IP address of the ASG group instances.
# Pre-requisite: AWS cli tools should be installed and aws keys must be setup before using this script.
# Author: Ramesh Kumar <ramesh.mimit@gmail.com>
# Usage: ./$0 ASGName

#if [ 
#   $1 == '' ]
#then
#  echo "Please prove ASG name as an argument"
#  exit 1
#else
  for i in `aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name $1 | grep -i instanceid  | awk '{ print $2}' | cut -d',' -f1| sed -e 's/"//g'`
    do
    aws ec2 describe-instances --instance-ids $i | grep -i PrivateIpAddress | awk '{ print $2 }' | head -1 | cut -d"," -f1 | sed -e 's/"//g'
  done;
#fi