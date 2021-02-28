#!/bin/bash
# author: Mathew Gene, June 4th, 2019
# updated July 8th, 2019

# runs progressiveMauve for all plasmids to genomes and prepares the output for R segement plot visualization
# ensure .fasta plasmids/query sequence and assemblies are in the current directory

echo -e "\e[42mScript initialized.\e[27m"

mkdir temp
ls | grep -v temp | xargs mv -t temp
cd temp

for PLASMID in *.fasta; do	# create folder for running progressiveMauve on respective plasmid
	[ -f "$PLASMID" ] || break
	PLASMID_NAME=$(echo "$PLASMID" | sed 's/\.fasta *$//')

	#QUERY_LENGTH=$(wc -c $PLASMID)	###################################### need to add -84 to remove header somehow

	mkdir $PLASMID_NAME
	cp *.realigned.multi.fasta.concatenated $PLASMID_NAME
	cd $PLASMID_NAME
	#perl /mnt/L/mathew/bcereus/scripts/link-scripts/link_fast.pl /mnt/L/mathew/bcereus/working-dataset/strains-filtered.txt /mnt/L/mathew/bcereus/working-dataset/assemblies-filtered/
		
	echo "Currently analyzing plasmid $PLASMID_NAME."
	for GENOME in *.realigned.multi.fasta.concatenated;	# run progressiveMauve on current assembly
	 do
		[ -f "$GENOME" ] || break
		NAME=$(echo "$GENOME" | sed 's/\.realigned.multi.fasta.concatenated *$//')
		echo -e "\e[101mCurrently alligning $PLASMID_NAME to $NAME."
		mkdir $NAME.results
		progressiveMauve --output=$NAME ../$PLASMID $GENOME > /dev/null 2>&1
		rm $NAME
		mv $NAME.backbone $NAME.results
		mv $NAME.bbcols $NAME.results
	 done

	# remove extraneous files
	rm *.realigned.multi.fasta.concatenated
	rm *.sslist
	cd ../
	rm *.sslist
	
	echo -e "\e[42mPlasmid $PLASMID_NAME completed."
 done

rm *.realigned.multi.fasta.concatenated
rm *.fasta

echo -e "\e[42mRunning concatenate script."
bash /mnt/L/mathew/bcereus/scripts/mauve-alinger-script/mauve-cc-batch-backbone-concatenate.sh

mkdir ../output-concatented

for FOLDER in `ls`; do 	# move all concatenated backbone files to upper directory
	cd $FOLDER
	mv *.txt ../../output-concatented
	cd ../
 done

cd ../output-concatented

echo -e "\e[101mRunning backbone parser script."
bash /mnt/L/mathew/bcereus/scripts/mauve-alinger-script/mauve-cc-batch-backone-parser.sh

echo -e "\e[101mRunning .csv converter script."
bash /mnt/L/mathew/bcereus/scripts/mauve-alinger-script/convert-tsv-t-csv.sh

#cd ../temp/$PLASMID_NAME/backbone-complete
#bash /mnt/L/mathew/bcereus/scripts/batch-mauve-backbone-percentage.sh $QUERY_LENGTH

echo -e "\e[42mmauve-cc-final.sh script complete."

