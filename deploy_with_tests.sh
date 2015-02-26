#!/bin/bash

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
HOST="$1"
create_test_data=false

echo -e "${label_color}Creating TradeDataSource service if necessary${no_color}"
cf service TradeDatasource
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
	echo -e "${label_color}Creating TradeDataSource service${no_color}"
    cf create-service sqldb sqldb_small TradeDatasource
    create_test_data=true
fi

echo -e "${label_color}Pushing ${CF_APP}${no_color}"
cf push "${CF_APP}" -n ${HOST}
EXIT_CODE=$?
#cf logs "${CF_APP}" --recent
if [ $EXIT_CODE -ne 0 ]; then
    exit $EXIT_CODE
fi

####
# Setup data
####
if [ "$create_test_data" = true ] ; then
	echo -e "${label_color}Populating test data${no_color}"
	curl http://${HOST}.mybluemix.net/config?action=buildDB > /dev/null
	EXIT_CODE=$?
	if [ $EXIT_CODE -ne 0 ]; then
    	cf logs "${CF_APP}" --recent
    	exit $EXIT_CODE
	fi
fi
	
echo -e "${label_color}Executing post deployment tests${no_color}"
ant -v -buildfile test.xml -DTARGET_URL="http://${HOST}.mybluemix.net"