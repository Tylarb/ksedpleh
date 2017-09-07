#!/bin/bash

sar_convert_main() {

if [ "$rhel_major" == "5" ]
then
  $DIR/sar51 -At -f "$sar_file" > "$sar_file"_converted
fi



if [ "$rhel_major" == "6" ]
then
  if $DIR/sar65 -At -f "$sar_file" >/dev/null
  then
    $DIR/sar65 -At -f "$sar_file" > "$sar_file"_converted
  else
    $DIR/sar61 -At -f "$sar_file" > "$sar_file"_converted
  fi
fi



if [ "$rhel_major" == "7" ]
then
  $DIR/sar71 -At -f "$sar_file" > "$sar_file"_converted
fi
}
