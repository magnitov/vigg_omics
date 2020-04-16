#1 assembly de novo
mkdir -p genome_assembly_hw

for KMER in 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60
do
	mkdir -p genome_assembly_hw/k${KMER}
	/home/Kasianov/soft/platanus/platanus assemble -s 0 -k ${KMER} -o genome_assembly_hw/k${KMER}/platanus_k${KMER} -f /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq
done

#2 genome assembly quality control
cd genome_assembly_hw
mkdir -p assembly_metrics
#2.1 quast
python /home/Kasianov/soft/quast-5.0.2/quast.py -o assembly_metrics -m 0 --threads 1 k15/platanus_k15_contig.fa k18/platanus_k18_contig.fa k21/platanus_k21_contig.fa k24/platanus_k24_contig.fa k27/platanus_k27_contig.fa k30/platanus_k30_contig.fa k33/platanus_k33_contig.fa k36/platanus_k36_contig.fa k39/platanus_k39_contig.fa k42/platanus_k42_contig.fa k45/platanus_k45_contig.fa k48/platanus_k48_contig.fa k51/platanus_k51_contig.fa k54/platanus_k54_contig.fa k57/platanus_k57_contig.fa k60/platanus_k60_contig.fa
cp assembly_metrics/report.tsv QUAST_summary.txt
#2.2 ALE
mkdir -p index
mkdir -p align
mkdir -p ALE_results

for KMER in 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57 60
do
	bowtie2-build k${KMER}/platanus_k${KMER}_contig.fa index/platanus_k${KMER}
	bowtie2 -x index/platanus_k${KMER} -1 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq -2 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq -S align/platanus_k${KMER}.sam
	/home/Kasianov/soft/ALE-master/ALE-master/src/ALE align/platanus_k${KMER}.sam k${KMER}/platanus_k${KMER}_contig.fa ALE_results/platanus_k${KMER}.ale
done

paste ALE_results/platanus_k15.ale ALE_results/platanus_k18.ale ALE_results/platanus_k21.ale ALE_results/platanus_k24.ale ALE_results/platanus_k27.ale ALE_results/platanus_k30.ale ALE_results/platanus_k33.ale ALE_results/platanus_k36.ale ALE_results/platanus_k39.ale ALE_results/platanus_k42.ale ALE_results/platanus_k45.ale ALE_results/platanus_k48.ale ALE_results/platanus_k51.ale ALE_results/platanus_k54.ale ALE_results/platanus_k57.ale ALE_results/platanus_k60.ale | awk '{ print $2"\t"$3"\t"$6"\t"$9"\t"$12"\t"$15"\t"$18"\t"$21"\t"$24"\t"$27"\t"$30"\t"$33"\t"$36"\t"$39"\t"$42"\t"$45"\t"$48 }' | head -14 > ALE_summary.txt

#3 remove unnecessary files
rm -r index align k*
