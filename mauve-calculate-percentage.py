# Author: Mathew Gene, July 5th, 2019
# calculates the percentage of the query sequence present for a specified strain
# must execute using python3 in terminal
# to execute: python3 mauve-calculate-percentage.py filename query_length

import csv
import sys

filename = sys.argv[1]
query_length = int(sys.argv[2])
#filename = "mauve-backbone/c-NBCE0063.backbone"

backbone_file = open(filename)
backbone_data = csv.reader(backbone_file, delimiter="\t")
backbone_list = list(backbone_data)

#query_length = 15600
i=0
sum_list = []

while i < len(backbone_list):
    if int(backbone_list[i][1]) == 0:
        i += 1
        continue
    elif int(backbone_list[i][3]) == 0:
        i += 1
        continue
    else:
        segment = abs(int(backbone_list[i][2])) - abs(int(backbone_list[i][1]))
        #print(segment)
        sum_list.append(segment)
        i += 1

sum = sum(sum_list)
percent_aligned = (sum / query_length) * 100
percent_aligned_rounded = round(percent_aligned, 2)

#print("Filename: ", filename)
#print("The query length is: ", query_length)
#print("The sum is: ", sum)
#print("The percent aligned is: ", percent_aligned_rounded)

output_file = open("backbone_percentage_output", "a")
output_file.write(filename + '\t' + str(percent_aligned_rounded) + '\n')

