#!/bin/bash
echo "Wait for XSA to complete startup."

instance="90"

xsaport="3"$instance"30"
#xsaport="443"

echo -ne "Waiting for XSA API to start listening on $xsaport."

#Prior run cleanup
sudo rm -f /tmp/onof.txt
sudo rm -f /tmp/onoroff.txt
sudo rm -f /tmp/oftotal.txt

LISTENING=0

while [  $LISTENING -lt 1  ]; do 
  XSAON="$( sudo lsof -n -i -P | grep LISTEN | grep $xsaport )"
  if [  "$XSAON" = "" ]; then
    echo -ne "."
    sleep 2
  else
    let LISTENING=1
    echo -ne ".OK\n"
  fi
done 

xs t -s SAP

percent=0

while [  $percent -lt 100 ]; do 
  xs a | grep STARTED | tr -s ' ' |  cut -d ' ' -f 3 > /tmp/onof.txt
  cat /tmp/onof.txt | cut -d '/' -f 1 > /tmp/onoroff.txt
  cat /tmp/onof.txt | cut -d '/' -f 2 > /tmp/oftotal.txt
  sum=0
  while read num; do 
    sum=$(($sum + $num))
  done < /tmp/onof.txt
  tot=0
  while read num; do 
    tot=$(($tot + $num))
  done < /tmp/oftotal.txt
  percent=$((200*$sum/$tot % 2 + 100*$sum/$tot))
  printf "\r%'d of %'d (%'d%%)" $sum $tot $percent 
  sleep 1
done
echo -ne "\n"
echo "XSA startup is complete."

