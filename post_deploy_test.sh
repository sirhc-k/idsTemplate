#!/bin/bash

####
# Variables
####

TEST_URL="$1"

####
# Test
####
echo "TEST_URL = ${TEST_URL}"
# Setup ANT for tests
echo "Setup ANT support for testing"
wget -q http://apache.claz.org//ant/binaries/apache-ant-1.9.4-bin.tar.gz

tar -zxvf apache-ant-1.9.4-bin.tar.gz > /dev/null

mv apache-ant-1.9.4 ant

echo "ant version:"
./ant/bin/ant -version

# Test Execution
echo "Execute tests"
./ant/bin/ant -buildfile test.xml -DTARGET_URL=${TEST_URL}