#!/bin/bash
  
WD_FOLDER=${HOME}/hdd20tb

# Deduplication, methylation extraction and profiles
for REPLICA in 8cell_rep1 ICM_rep1 Epiblast_rep1
do
	./bismark-0.22.3/deduplicate_bismark -p --output_dir ${WD_FOLDER}/aligned ${WD_FOLDER}/aligned/${REPLICA}_trimmed_WGBS_R1_bismark_bt2_pe.bam
	./bismark-0.22.3/bismark_methylation_extractor -p --gzip --bedGraph --output ${WD_FOLDER}/aligned ${WD_FOLDER}/aligned/${REPLICA}_trimmed_WGBS_R1_bismark_bt2_pe.deduplicated.bam
	./bismark-0.22.3/coverage2cytosine --merge_CpG --genome_folder ${WD_FOLDER}/genome/ --dir ${WD_FOLDER}/aligned/ -o ${REPLICA} ${WD_FOLDER}/aligned/${REPLICA}_trimmed_WGBS_R1_bismark_bt2_pe.deduplicated.bismark.cov.gz
	bedtools genomecov -bg -ibam ${WD_FOLDER}/aligned/${REPLICA}_trimmed_WGBS_R1_bismark_bt2_pe.deduplicated.bam -g ${WD_FOLDER}/genome/chromsizes.txt > ${WD_FOLDER}/aligned/${REPLICA}_alignment_coverage.bed
done

