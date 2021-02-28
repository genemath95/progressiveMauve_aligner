#!/bin/bash

# author: Mathew Gene, July 23th, 2019

echo "Executing batch-greater-than-80.sh"
sleep 5

for FILE in *.csv; do
	[ -f "$FILE" ] || break
	echo "Processing $FILE"
	python /mnt/L/mathew/bcereus/scripts/backbone-greater-than-80.py $FILE
done

echo "batch-greater-than-80.sh script complete."


