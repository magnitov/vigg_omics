#!/bin/bash

METHPIPE_PATH=/home/magnitov/Downloads/methpipe-3.4.3/bin

# Create files fot MethPipe
for REPLICA in 8cell_rep1 ICM_rep1 Epiblast_rep1
do
	awk '{ print $1"\t"$2"\t+\tCpG\t"$4/100"\t"$5+$6}' ./CpG_methylation/${REPLICA}.CpG_report.merged_CpG_evidence.cov > ./CpG_methylation/${REPLICA}.for_methpipe.txt
done
# Create proportion table
LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
${METHPIPE_PATH}/merge-methcounts -t ./CpG_methylation/8cell_rep1.for_methpipe.txt ./CpG_methylation/ICM_rep1.for_methpipe.txt ./CpG_methylation/Epiblast_rep1.for_methpipe.txt > ./CpG_methylation/proportion_table.txt
