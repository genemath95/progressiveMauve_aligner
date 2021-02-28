#!/bin/bash
# author: Mathew Gene, June 4th, 2019

# extracts backbones from mauve output, adds strain name to backbone file,
# and concatentates backbone file for each plasmid

for PLASMIDFOLDER in `ls`:
 if [ -d "$PLASMIDFOLDER" ]; then
  do
	PLASMID_NAME=$(echo "$PLASMIDFOLDER" | sed 's/\: *$//')
	cd $PLASMID_NAME
	mkdir $PLASMID_NAME
	mv *.results $PLASMID_NAME
	cd $PLASMID_NAME
	
	mkdir ../backbone-complete

	for FILE in `ls` ;
	 do
		NAME=$(echo "$FILE" | sed 's/\.results *$//')
		cd $FILE
		cp $NAME.backbone ../../backbone-complete
		cd ../
	 done

	cd ../backbone-complete/

	for FILE in `ls` ;
	 do
		NAME=$(echo "$FILE" | sed 's/\.backbone *$//')
		sed -i '2,$s/^/'$NAME'\t/' $FILE	# adds strain name column
		sed -i '1d' $FILE	# removes header
	 done

	cat $(ls -t) > $PLASMID_NAME.txt	# concatentate backbone files together
	mv $PLASMID_NAME.txt ../
	
	echo "Plasmid $PLASMID_NAME analysis completed."
 	cd ../../
  done
 fi

echo "Mauve parser completed."
