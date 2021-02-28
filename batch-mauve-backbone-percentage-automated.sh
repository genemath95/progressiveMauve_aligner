#!/bin/bash

# author: Mathew Gene, July 24th, 2019
# run as: bash /scripts/batch-mauve-backbone-percentage.sh query-size-in-bp

/mnt/L/mathew/bcereus/reference/virulence-genes/query_lengths.txt

for QUERY in ls; do
	echo "Processing $FILE"
	grep $QUERY 
done

for FILE in *.backbone; do
	[ -f "$FILE" ] || break
	echo "Processing $FILE"
	python3 /mnt/L/mathew/bcereus/scripts/mauve-calculate-percentage.py $FILE $1
done

sed -e s/c-//g -i backbone_percentage_output
sed -e s/.backbone//g -i backbone_percentage_output

mv backbone_percentage_output ../
cd ../
mv backbone_percentage_output ${PWD##*/}.backbone_percentage_output.csv
sed -i 's/\t/,/g' ${PWD##*/}.backbone_percentage_output.csv	# replaces tabs with commas
mv ${PWD##*/}.backbone_percentage_output.csv ../../

echo "batch-mauve-backbone-percentage.sh script complete."

