#!/bin/bash
IMAGE_ID="unknown-barf"

if [ "$1" == "" ]; then
        echo "specify a image id in arg 1"
        echo "here are the available images:"
docker images
exit 1
fi

echo "here are the available images (just in case)"
docker images

IMAGE_ID="$1"

echo IMAGE_ID is $IMAGE_ID

GVAVARS=$(env|grep gva_);
if [ "$?" != "0"  ]; then
    echo "your gva_xxxx environment variables don't appear to be setup..."
    exit 1
else
    echo "gva vars are setup..."
    #echo "gva vars (debug): " $GVAVARS
fi

#SMS alerts
gva_sms_alerts='enabled'

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
    --env gva_geolocation_api_key \
    --env gva_https \
    --env gva_https_crt_file \
    --env gva_https_key_file \
    --env gva_https_ca_bundle_file \
    --env gva_gwlistener_store_data \
    -p=3000:3000 \
    -p=3001:3001 \
    -p=3002:3002 \
    --name gva \
    -d "$IMAGE_ID"
