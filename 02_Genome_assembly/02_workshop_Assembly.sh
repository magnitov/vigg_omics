#1 assembly de novo
#1.1 prepare environment for assembly de novo
mkdir genome_assembly
mkdir genome_assembly/k39
mkdir genome_assembly/k49
mkdir genome_assembly/k63
#1.2 run spades
/home/Kasianov/soft/SPAdes-3.13.0-Linux/bin/spades.py --careful -1 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq -2 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq -o genome_assembly/spades
#1.3 run platanus with start k-mer value 39
/home/Kasianov/soft/platanus/platanus assemble -s 0 -k 39 -o genome_assembly/k39/platanus_k39 -f /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq
#1.4 run platanus with start k-mer value 49
/home/Kasianov/soft/platanus/platanus assemble -s 0 -k 49 -o genome_assembly/k49/platanus_k49 -f /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq
#1.5 run platanus with start k-mer value 63
/home/Kasianov/soft/platanus/platanus assemble -s 0 -k 63 -o genome_assembly/k63/platanus_k63 -f /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq

#2 genome assembly quality control
#2.1 prepare environment for assembly quality control
cd genome_assembly
mkdir assembly_analysis
#2.2 run quast
python /home/Kasianov/soft/quast-5.0.2/quast.py -o assembly_analysis/platanus_spades -m 0 --threads 1 k39/platanus_k39_contig.fa k49/platanus_k49_contig.fa k63/platanus_k63_contig.fa spades/scaffolds.fasta
#2.3 prepare environment for reads mapping
mkdir index
mkdir align
#2.4 generate index for mapping
bowtie2-build k39/platanus_k39_contig.fa index/platanus_k39
bowtie2-build k49/platanus_k49_contig.fa index/platanus_k49
bowtie2-build k63/platanus_k63_contig.fa index/platanus_k63
bowtie2-build spades/scaffolds.fasta index/spades
#2.5 mapping reads on assembly results
bowtie2 -x index/platanus_k39 -1 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq -2 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq -S align/platanus_k39.sam
bowtie2 -x index/platanus_k49 -1 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq -2 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq -S align/platanus_k49.sam
bowtie2 -x index/platanus_k63 -1 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq -2 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq -S align/platanus_k63.sam
bowtie2 -x index/spades -1 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R1_001.fastq -2 /home/Kasianov/NGSCourse/2019/assembly/reads/7_S4_L001_R2_001.fastq -S align/spades.sam
#2.6 prepare environment for ALE
mkdir ALE_results
#2.7 run ALE on platanus results with parameter k=39
/home/Kasianov/soft/ALE-master/ALE-master/src/ALE align/platanus_k39.sam k39/platanus_k39_contig.fa ALE_results/platanus_k39.ale
#2.8 run ALE on platanus results with parameter k=49
/home/Kasianov/soft/ALE-master/ALE-master/src/ALE align/platanus_k49.sam k49/platanus_k49_contig.fa ALE_results/platanus_k49.ale
#2.9 run ALE on platanus results with parameter k=63
/home/Kasianov/soft/ALE-master/ALE-master/src/ALE align/platanus_k63.sam k63/platanus_k63_contig.fa ALE_results/platanus_k63.ale
#2.10 run ALE on spades results
/home/Kasianov/soft/ALE-master/ALE-master/src/ALE align/spades.sam spades/scaffolds.fasta ALE_results/spades.ale
