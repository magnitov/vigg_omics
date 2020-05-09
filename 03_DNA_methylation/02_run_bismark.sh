#!/bin/bash

WD_FOLDER=${HOME}/hdd20tb

mkdir -p ${WD_FOLDER}/aligned

# BS convert and index reference genome
${WD_FOLDER}/bismark-0.22.3/bismark_genome_preparation --verbose ${WD_FOLDER}/genome/
# Align reads
for REPLICA in 8cell_rep1 ICM_rep1 Epiblast_rep1
do
	${WD_FOLDER}/bismark-0.22.3/bismark -p 4 --gzip -o ${WD_FOLDER}/aligned/ ${WD_FOLDER}/genome/ -1 ${WD_FOLDER}/trimmed_reads/${REPLICA}_trimmed_WGBS_R1.fastq.gz -2 ${WD_FOLDER}/trimmed_reads/${REPLICA}_trimmed_WGBS_R2.fastq.gz
done

