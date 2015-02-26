#!/bin/bash

TEST_URL="$1"

echo "TEST_URL = ${TEST_URL}"
# Setup ANT for test
echo "Setup ANT support for testing"
wget -q http://apache.claz.org//ant/binaries/apache-ant-1.9.4-bin.tar.gz

tar -zxvf apache-ant-1.9.4-bin.tar.gz > /dev/null

mv apache-ant-1.9.4 ant
#export ANT_HOME=./ant

echo "ant version:"
./ant/bin/ant -version

# Test Execution
echo "Execute tests"
./ant/bin/ant -buildfile test.xml -DTARGET_URL=${TEST_URL}

# Print test results
#for filename in ./output/*.txt; do
#    echo "$filename"
#    cat $filename
#done
