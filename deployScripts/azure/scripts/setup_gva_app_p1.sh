#!/bin/bash

# Variables to update
# Repo="Replace with the URL of the docker repository"
# Username="Replace with the username of the docker repo"
# Password="Replace with the Password of the docker repo"
# IMAGE_ID="Replace with the docker image - url/name:tag"
RepoUrl="ccreleases.azurecr.io"
Username="ccreleases"
Password="yPQ4QDiH1cZsP4k9nepKa/9Wi53P9v5U"
IMAGE_ID="ccreleases.azurecr.io/gva:GVA_19.08.08_REL"

gva_internaldb_host=$1
gva_internaldb_database=$2
gva_internaldb_username=$3
gva_internaldb_password=$4
gva_logging_env_info=$5
gva_blobstore_connect_str=$6
gva_devicesim_iothub_device_connect_str=$7
gva_gwlistener_event_hub_name=$8
gva_gwlistener_event_hub_compatible_endpoint=$9
gva_gwtagproxy_iothub_registry_rw_connect_str=$10
gva_gwmessenger_service_policy_connect_str=$11
gva_gwmessenger_test_device_id=$12
gva_logging_appinsights_instrumentation_key=$13
gva_pcs2_rest_baseurl=$14
gva_security_base_path=$15
gva_security=$16
gva_externaldb_connection_string=$17
gva_externaldb_username=$18
gva_externaldb_password=$19
gva_sms_alerts=$24
VPUrl=$20
gva_url=$21

aadClientId=$22
gva_source_uri=$23

echo export gva_internaldb_host=\'$gva_internaldb_host\'  >> /home/ubuntu/.profile
echo export gva_internaldb_database=\'$gva_internaldb_database\'  >> /home/ubuntu/.profile
echo export gva_internaldb_username=\'$gva_internaldb_username\'  >> /home/ubuntu/.profile
echo export gva_internaldb_password=\'$gva_internaldb_password\'  >> /home/ubuntu/.profile

echo export gva_logging_env_info=\'$gva_logging_env_info\'  >> /home/ubuntu/.profile
echo export gva_blobstore_connect_str=\'$gva_blobstore_connect_str\'  >> /home/ubuntu/.profile
echo export gva_devicesim_iothub_device_connect_str=\'$gva_devicesim_iothub_device_connect_str\'  >> /home/ubuntu/.profile

echo export gva_gwlistener_event_hub_name=\'$gva_gwlistener_event_hub_name\'  >> /home/ubuntu/.profile
echo export gva_gwlistener_event_hub_compatible_endpoint=\'$gva_gwlistener_event_hub_compatible_endpoint\'  >> /home/ubuntu/.profile

echo export gva_gwtagproxy_iothub_registry_rw_connect_str=\'$gva_gwtagproxy_iothub_registry_rw_connect_str\'  >> /home/ubuntu/.profile
echo export gva_gwmessenger_service_policy_connect_str=\'$gva_gwmessenger_service_policy_connect_str\'  >> /home/ubuntu/.profile
echo export gva_gwmessenger_test_device_id=\'$gva_gwmessenger_test_device_id\'  >> /home/ubuntu/.profile

echo export gva_logging_appinsights_instrumentation_key=\'$gva_logging_appinsights_instrumentation_key\'  >> /home/ubuntu/.profile
echo export gva_pcs2_rest_baseurl=\'$gva_pcs2_rest_baseurl\'  >> /home/ubuntu/.profile
echo export gva_security_base_path=\'$gva_security_base_path\'  >> /home/ubuntu/.profile
echo export gva_security=\'$gva_security\'  >> /home/ubuntu/.profile
echo export gva_sms_alerts=\'$gva_sms_alerts\'  >> /home/ubuntu/.profile

echo export gva_externaldb_connection_string=\'$gva_externaldb_connection_string\'  >> /home/ubuntu/.profile
echo export gva_externaldb_username=\'$gva_externaldb_username\' >> /home/ubuntu/.profile
echo export gva_externaldb_password=\'$gva_externaldb_password\' >> /home/ubuntu/.profile
echo export NODE_TLS_REJECT_UNAUTHORIZED=0 >> /home/ubuntu/.profile
echo export GVAURL=\'$gva_url\' >> /home/ubuntu/.profile

echo export gva_sms_alerts='disable' >> /home/ubuntu/.profile
echo export gva_sms_alert_account_sid='' >> /home/ubuntu/.profile
echo export gva_sms_alert_auth_token='' >> /home/ubuntu/.profile
echo export gva_sms_alert_phone_number='' >> /home/ubuntu/.profile

echo export gva_https='disable' >> /home/ubuntu/.profile
echo export gva_https_crt_file='/home/ubuntu/castle_canyon/security/ssl/server.cert' >> /home/ubuntu/.profile
echo export gva_https_key_file='/home/ubuntu/castle_canyon/security/ssl/server.key' >> /home/ubuntu/.profile
echo export gva_https_ca_bundle_file='/home/ubuntu/castle_canyon/security/ssl/server.ca-bundle' >> /home/ubuntu/.profile

echo export gva_gwlistener_store_data='enable' >> /home/ubuntu/.profile

echo export gva_keystore_uri='http://localhost:3002/' >> /home/ubuntu/.profile

echo export aadClientId=\'$aadClientId\' >> /home/ubuntu/.profile

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

GVAVARS=$(env|grep gva_);
if [ "$?" != "0"  ]; then
    echo "your gva_xxxx environment variables don't appear to be setup..."
    exit 1
else
    echo "gva vars are setup..."
    #echo "gva vars (debug): " $GVAVARS
fi

#this runs the container
docker \
    run \
    --env gva_devicesim_iothub_device_connect_str \
    --env gva_gwlistener_event_hub_name \
    --env gva_gwlistener_event_hub_compatible_endpoint \
    --env gva_gwmessenger_service_policy_connect_str \
    --env gva_gwmessenger_test_device_id \
    --env gva_gwtagproxy_iothub_registry_rw_connect_str \
    --env gva_internaldb_host \
    --env gva_internaldb_database \
    --env gva_internaldb_username \
    --env gva_internaldb_password \
    --env gva_externaldb_connection_string \
    --env gva_externaldb_username \
    --env gva_externaldb_password \
    --env gva_logging_env_info \
    --env gva_logging_appinsights_instrumentation_key \
    --env gva_blobstore_connect_str \
    --env gva_pcs2_rest_baseurl \
    --env gva_shippingapi_expose_developer_endpoints \
    --env gva_security_base_path \
    --env gva_security \
    --env gva_keystore_uri \
    --env gva_sms_alerts \
    --env gva_sms_alert_account_sid \
    --env gva_sms_alert_auth_token \
    --env gva_sms_alert_phone_number \
    --env gva_https \
    --env gva_https_crt_file \
    --env gva_https_key_file \
    --env gva_https_ca_bundle_file \
    --env gva_geolocation_api_key \
    --env gva_gwlistener_store_data \
    -p=3000:3000 \
    -p=3001:3001 \
    -p=3002:3002 \
    --name gva \
    -d "$IMAGE_ID"
