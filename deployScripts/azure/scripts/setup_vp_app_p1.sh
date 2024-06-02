#!/bin/bash

# Variables to update
# Repo="Replace with the URL of the docker repository"
# Username="Replace with the username of the docker repo"
# Password="Replace with the Password of the docker repo"
# IMAGE_ID="Replace with the docker image - url/name:tag"
RepoUrl="ccreleases.azurecr.io"
Username="ccreleases"
Password="yPQ4QDiH1cZsP4k9nepKa/9Wi53P9v5U"
IMAGE_ID="ccreleases.azurecr.io/vp:VP_19.08.05_REL"

mongoConnString=$1
PORT=$2
GVAurl=$3
PCSurl=$4
shipmentgw2cloudinterval=$5
iotHubConnectionString=$6
storageAccConnectionString=$7
#--------------------------
# Send email variables
#--------------------------
vpURL=$8
emailId=$9
solutionName=$10
subscriptionId=$11
spAppId=$12
spObjectId=$13
spSecret=$14
tenantId=$15
email_server_webapp_name=$16
vp_source_uri=$17

aadClientId=$spAppId
aadClientSecret=$spSecret

#--------------------------
# Send email variables
#--------------------------

echo export mongoConnString=\'$mongoConnString\'  >> /home/ubuntu/.profile
echo export PORT=\'$PORT\'  >> /home/ubuntu/.profile
echo export GVAurl=\'$GVAurl\'  >> /home/ubuntu/.profile
echo export PCSurl=\'$PCSurl\'  >> /home/ubuntu/.profile
echo export shipmentgw2cloudinterval=\'$shipmentgw2cloudinterval\'  >> /home/ubuntu/.profile
echo export iotHubConnectionString=\'$iotHubConnectionString\'  >> /home/ubuntu/.profile
echo export storageAccConnectionString=\'$storageAccConnectionString\'  >> /home/ubuntu/.profile
echo export vpURL=\'$vpURL\'  >> /home/ubuntu/.profile
echo export emailId=\'$emailId\'  >> /home/ubuntu/.profile
echo export solutionName=\'$solutionName\'  >> /home/ubuntu/.profile

echo export aadClientId=\'$aadClientId\' >> /home/ubuntu/.profile
echo export aadClientSecret=\'$aadClientSecret\' >> /home/ubuntu/.profile
echo export tenantId=\'$tenantId\' >> /home/ubuntu/.profile
echo export NODE_TLS_REJECT_UNAUTHORIZED=0 >> /home/ubuntu/.profile

# used by transfer_proxy_files.sh
gvaDNSName=`echo $GVAurl | awk -F":" '{print $2}' | awk -F"\/\/" '{print $2}'`
echo export GVADNSName=\'$gvaDNSName\' >> /home/ubuntu/.profile

# used by  .js files
gvaHostName=`echo $GVAurl | awk -F":" '{print $2}' | awk -F"\/\/" '{print $2}' | awk -F"." '{print $1}'`
echo export GVAHostName=\'$gvaHostName\' >> /home/ubuntu/.profile

echo export vpRedirectURL=\'https://$solutionName-vp-webapp.azurewebsites.net\' >> /home/ubuntu/.profile
echo export GVAShippingUrl=\'https://$solutionName-gva-webapp.azurewebsites.net\' >> /home/ubuntu/.profile
echo export GVADevicesUrl=\'https://$solutionName-gva-webapp.azurewebsites.net\' >> /home/ubuntu/.profile
echo export subscriptionId=\'$subscriptionId\'  >> /home/ubuntu/.profile
echo export spAppId=\'$spAppId\'  >> /home/ubuntu/.profile
echo export spObjectId=\'$spObjectId\'  >> /home/ubuntu/.profile
echo export spSecret=\'$spSecret\'  >> /home/ubuntu/.profile
echo export tenantId=\'$tenantId\'  >> /home/ubuntu/.profile

#echo export blobConnString=\'$blobConnString\'  >> /home/ubuntu/.profile
echo export blobConnString=\'https://ccreleases.blob.core.windows.net/addresses/shipmentCreation.json\' >> /home/ubuntu/.profile

#reload profile
. /home/ubuntu/.profile

export HOME=/home/ubuntu

cd /home/ubuntu/
apt-get update
apt-get install -y docker.io

docker login $RepoUrl -u $Username -p $Password
docker pull $IMAGE_ID

echo "here are the available images (just in case)"
docker images

echo IMAGE_ID is $IMAGE_ID

GVAVARS=$(env);

if [ "$?" != "0"  ]; then
    echo "your vp_xxxx environment variables don't appear to be setup..."
    exit 1
else
    echo "vp vars are setup..."
    #echo "vp vars (debug): " $GVAVARS
fi

#this runs the container
docker \
    run \
    --env blobConnString \
    --env GVAurl \
    --env iotHubConnectionString \
    --env mongoConnString \
    --env PCSurl \
    --env storageAccConnectionString \
    --env Shipmentgw2cloudinterval \
    --env PORT \
    -p=$PORT:$PORT \
    --name vp \
    -d "$IMAGE_ID"
