#!/bin/bash

collectl_file=$1
mkdir output
collectl -oD -sm --verbose -p $collectl_file > output/m.txt
echo "m subsys complete"
collectl -oD -sc --verbose -p $collectl_file > output/c.txt
echo "c subsys complete"
collectl -oD -smM --verbose -p $collectl_file > output/M.txt
echo "M subsys complete"
collectl -oD -scC --verbose -p $collectl_file > output/C.txt
echo "C subsys complete"
collectl -oD -sZ --top syst --verbose -p $collectl_file > output/Z_syst.txt
echo "Z syst complete"

collectl -oD -sZ --top usrt --verbose -p $collectl_file > output/Z_usrt.txt
echo "Z usrt complete"
collectl -oD -sZ --top rss --verbose -p $collectl_file > output/Z_rss.txt
echo "Z rss complete"
