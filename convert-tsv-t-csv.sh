#!/bin/bash
# author: Mathew Gene, June 17th, 2019

# convert tab seperated file to comma separated file

echo -e "\e[42mScript initialized.\e[27m"

for FILE in `ls`:
 do
	sed -i 's/\t/,/g' $FILE
	echo -e "\e[42m $FILE converted to .csv."
 done

echo -e "\e[42mScript complete."


