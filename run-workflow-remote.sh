###############################################
##
##  Note: This example will run the "update_asset" workflow
##
###############################################
#
#! /bin/bash

# The host and port of the source server
HOST=""

# The user credentials on the source server (username:password)
LOGIN=""

# Filter path
# eg. "/content/dam/mysite"
PATH=""

# Workflow to run
# eg. "update_asset"
WORKFLOW=""

#If you want to run for only those asset for which property is missing
#MISSING_PROPERTY=dc:format
#Query to get all Dam Asset
    ALL_PATHS=`curl -s -u $LOGIN "$HOST/bin/querybuilder.json?path=$PATH&type=dam:Asset&p.limit=-1" | tr "[}{" "\n" | grep path | awk -F \" '{print $4 "\n"}'`
echo "Starting"
echo "$ALL_PATHS"
IFS=$'\n'
for SINGLE_PATH in $ALL_PATHS
do
echo "Fixing $SINGLE_PATH"
curl -s -u $LOGIN -d "model=/etc/workflow/models/dam/update_asset/jcr:content/model&payloadType=JCR_PATH&payload=$SINGLE_PATH" $HOST/etc/workflow/instances
sleep 3
done