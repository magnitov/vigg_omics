#!/bin/bash
WD_FOLDER=${HOME}/hdd20tb

mkdir -p ${WD_FOLDER}/quality
mkdir -p ${WD_FOLDER}/trimmed_reads
mkdir -p ${WD_FOLDER}/quality_trimmed

# Run FastQC
fastqc ${WD_FOLDER}/reads/* -o ${WD_FOLDER}/quality
# Trim reads by quality
for REPLICATE in 8cell_rep1 ICM_rep1 Epiblast_rep1
do
	java -jar ${WD_FOLDER}/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 ${WD_FOLDER}/reads/${REPLICATE}_WGBS_R1.fastq.gz ${WD_FOLDER}/reads/${REPLICATE}_WGBS_R2.fastq.gz ${WD_FOLDER}/trimmed_reads/${REPLICATE}_trimmed_WGBS_R1.fastq.gz ${WD_FOLDER}/trimmed_reads/${REPLICATE}_trimmed_unpaired_WGBS_R1.fastq.gz ${WD_FOLDER}/trimmed_reads/${REPLICATE}_trimmed_WGBS_R2.fastq.gz ${WD_FOLDER}/trimmed_reads/${REPLICATE}_trimmed_unpaired_WGBS_R2.fastq.gz SLIDINGWINDOW:4:20 MINLEN:20
	rm ${WD_FOLDER}/trimmed_reads/*unpaired*
done
# Run FastQC o trimmed reads
fastqc ${WD_FOLDER}/trimmed_reads/* -o ${WD_FOLDER}/quality_trimmed
