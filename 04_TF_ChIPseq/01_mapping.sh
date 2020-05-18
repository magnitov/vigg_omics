# !/bin/bash
DATA_FOLDER=./raw_reads/
RESULTS_FOLDER=./aligned/
GENOME_INDEX=./genomes/chr10
SAMPLE=$1

echo "Start ChIP-seq data processing for $SAMPLE"

echo 'Map reads...'
bowtie2 -p 8 -S ${RESULTS_FOLDER}/tmp.sam -x ${GENOME_INDEX} -U ${DATA_FOLDER}/${SAMPLE}.fastq.gz --no-discordant --no-mixed 2>${RESULTS_FOLDER}/bowtie.log
echo 'Filter non-uniquely mapped reads...'
grep 'AS:.*XS:.' ${RESULTS_FOLDER}/tmp.sam | awk '{print $1}' > ${RESULTS_FOLDER}/non-unique_list.txt
java -jar picard.jar  FilterSamReads \
	I=${RESULTS_FOLDER}/tmp.sam \
	O=${RESULTS_FOLDER}/tmp1.sam \
        READ_LIST_FILE=${RESULTS_FOLDER}/non-unique_list.txt \
        FILTER=excludeReadList
echo 'Get only uniquely mapped reads with MAPQ>=30...'
grep 'AS:' ${RESULTS_FOLDER}/tmp1.sam | awk '{ if ($5>=30) print $1 }' > ${RESULTS_FOLDER}/unique_list.txt
java -jar picard.jar  FilterSamReads \
	I=${RESULTS_FOLDER}/tmp1.sam \
	O=${RESULTS_FOLDER}/tmp2.sam \
	READ_LIST_FILE=${RESULTS_FOLDER}/unique_list.txt \
	FILTER=includeReadList
echo 'Make bam...'
samtools view -@ 8 -o ${RESULTS_FOLDER}/bowtie_unsorted.bam ${RESULTS_FOLDER}/tmp2.sam
echo 'Sort bam...'
samtools sort -@ 8 -T sorting_ -o ${RESULTS_FOLDER}/${SAMPLE}.bam ${RESULTS_FOLDER}/bowtie_unsorted.bam
echo 'Remove temporary files...'
rm ${RESULTS_FOLDER}/bowtie.log ${RESULTS_FOLDER}/non-unique_list.txt ${RESULTS_FOLDER}/unique_list.txt
rm ${RESULTS_FOLDER}/tmp* ${RESULTS_FOLDER}/bowtie_unsorted.bam
echo 'Done!'
