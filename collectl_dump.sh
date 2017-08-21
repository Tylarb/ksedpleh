#!/bin/bash

collectl_file=$1

collectl -oD -sm --verbose -p $collectl_file > m.txt
echo "m subsys complete"
collectl -oD -sc --verbose -p $collectl_file > c.txt
echo "c subsys complete"
collectl -oD -sM --verbose -p $collectl_file > M.txt
echo "M subsys complete"
collectl -oD -sC --verbose -p $collectl_file > C.txt
echo "C subsys complete"
collectl -oD -sZ --top syst --verbose -p $collectl_file > Z_syst.txt
echo "Z syst complete"

collectl -oD -sZ --top usrt --verbose -p $collectl_file > Z_usrt.txt
echo "Z usrt complete"
collectl -oD -sZ --top rss --verbose -p $collectl_file > Z_rss.txt
echo "Z rss complete"
