#!/bin/bash

#####
# Stage environment properties that must
# be set
#
# TEST_URL
#####

#############
# Colors	#
#############
green='\e[0;32m'
red='\e[0;31m'
label_color='\e[0;33m'
no_color='\e[0m' # No Color

#############
# Variables	#
#############
# CF_HOSTNAME must be an environment variable passed into the script
HOST=${CF_HOSTNAME}
create_test_data=false

echo -e "${label_color}Creating TradeDataSource service if necessary${no_color}"
if cf service TradeDatasource; then
	echo -e "${label_color}TradeDataSource service already exists${no_scolor}"
else
	echo -e "${label_color}Creating TradeDataSource service${no_scolor}"
    cf create-service sqldb sqldb_free TradeDatasource
    create_test_data=true
fi

echo -e "${label_color}Pushing ${CF_APP}${no_color}"
cf push "${CF_APP}" -n ${HOST}
#if cf push "${CF_APP}" -n ${HOST}; then
#	cf logs "${CF_APP}" --recent
#else
#	cf logs "${CF_APP}" --recent
#    exit 1
#fi

####
# Setup data
####
if [ "$create_test_data" = true ] ; then
	echo -e "${label_color}Populating test data${no_color}"
	curl http://${HOST}.${CF_DOMAIN}/config?action=buildDB > /dev/null
	EXIT_CODE=$?
	if [ $EXIT_CODE -ne 0 ]; then
    	cf logs "${CF_APP}" --recent
    	exit $EXIT_CODE
	fi
fi

#####
# Set TEST_URL stage property value
#####
TEST_URL="http://${HOST}.${CF_DOMAIN}"
export TEST_URL
	
#echo -e "${label_color}Executing post deployment tests${no_color}"
#ant -buildfile test2.xml -DTARGET_URL="${TEST_URL}"