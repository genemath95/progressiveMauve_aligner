#!/bin/bash
# author: Mathew Gene, June 5th, 2019
# edited June 14th, 2019

# adds header, gene column, and removes negative characters from concatenated backbone files in current directory

for FILE in `ls` ;
 do
	sed -i '1,$s/^/'1'\t/' $FILE	# adds 1's for gene column
	sed -i '1iGene\tIsolate_ID\tseq0_leftend\tseq0_rightend\tseq1_leftend\tseq1_rightend' $FILE	# adds header to file
	awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' OFS=$'\t' $FILE > $FILE.temp	# swaps first two columns
	awk '{ gsub(/-/,"", $3); print } ' OFS=$'\t' $FILE.temp > $FILE.temp2	# removes (-) in leftend
	awk '{ gsub(/-/,"", $4); print } ' OFS=$'\t' $FILE.temp2 > final_$FILE	# removes (-) in rightend
	sed -i 's/\t/,/g' final_$FILE # converts tsv to csv
	rm *.temp*	# delete temp files
	rename "s/.txt/.csv/" final_$FILE
 done

rm *.txt

for f in *.csv; do
    mv -- "$f" "${f#final_}"
done
