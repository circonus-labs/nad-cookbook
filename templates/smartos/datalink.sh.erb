#!/bin/bash

# Set field delimiters to line breaks
OLDIFS=$IFS
LINEBREAKS=$( echo -en "\n\b" )
IFS=$LINEBREAKS

interfaces=`dladm show-link -s -o LINK,RBYTES,OBYTES | tail -n +2`

# for loop iterates over line breaks
for link in ${interfaces}; do

  # assigning net uses whitespace delimiter
  IFS=$OLDIFS
  net=( `echo ${link}` )
  echo -e "unix:${net[0]}:link:in\tn\t${net[1]}"
  echo -e "unix:${net[0]}:link:out\tn\t${net[2]}"
done

# restore field delimiter
IFS=$OLDIFS
