#0 prepare environment for QC lesson
mkdir QC
cd QC
mkdir QC_Reports

#1 QC analysis of WGS data(Illumina)
#1.1 run FastQC on raw WGS data
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/wgs_forward.fastq
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/wgs_reverse.fastq
#1.2 trim WGS data
mkdir trimmed
java -jar /home/Kasianov/soft/Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 1 -phred33 /home/Kasianov/NGSCourse/2019/QC/wgs_forward.fastq /home/Kasianov/NGSCourse/2019/QC/wgs_reverse.fastq ./trimmed/wgs_forward_paired.trimmed.fastq ./trimmed/wgs_forward_unpaired.trimmed.fastq ./trimmed/wgs_reverse_paired.trimmed.fastq ./trimmed/wgs_forward_unpaired.trimmed.fastq ILLUMINACLIP:/home/Kasianov/NGSCourse/2019/QC/adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:30 MINLEN:36
#1.3 run FastQC on trimmed WGS data
fastqc -o QC_Reports trimmed/wgs_forward_paired.trimmed.fastq

#2 QC analysis of target sequencing data(S5)
#2.1 run FastQC on raw target sequencing data
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/ampliseq.S5.fastq
#2.2 trim raw target sequencing data
java -jar /home/Kasianov/soft/Trimmomatic-0.38/trimmomatic-0.38.jar SE -threads 1 -phred33 /home/Kasianov/NGSCourse/2019/QC/ampliseq.S5.fastq ./trimmed/ampliseq.S5.trimmed.fastq ILLUMINACLIP:/home/Kasianov/NGSCourse/2019/QC/adapters.IonTorrent.fa:2:30:10 SLIDINGWINDOW:4:30 LEADING:3 TRAILING:3 MINLEN:36
#2.3 run FastQC on trimmed target sequencing data
fastqc -o QC_Reports trimmed/ampliseq.S5.trimmed.fastq

#3 QC analysis of raw target sequencing data(Illumina)
#3.1 run FastQC on raw target sequencing data
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/ampliseq.Illumina.forward.fastq
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/ampliseq.Illumina.reverse.fastq
#3.2 trim raw target sequencing data
java -jar /home/Kasianov/soft/Trimmomatic-0.38/trimmomatic-0.38.jar PE -threads 1 -phred33 /home/Kasianov/NGSCourse/2019/QC/ampliseq.Illumina.forward.fastq /home/Kasianov/NGSCourse/2019/QC/ampliseq.Illumina.reverse.fastq ./trimmed/ampliseq.Illumina.forward_paired.trimmed.fastq ./trimmed/ampliseq.Illumina.forward_unpaired.trimmed.fastq ./trimmed/ampliseq.Illumina.paired.trimmed.fastq ./trimmed/ampliseq.Illumina.unpaired.trimmed.fastq ILLUMINACLIP:/home/Kasianov/NGSCourse/2019/QC/adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:30 MINLEN:36
#3.3 run FastQC on trimmed target sequencing data
fastqc -o QC_Reports ./trimmed/ampliseq.Illumina.forward_paired.trimmed.fastq

#4 QC analysis of raw RNA-seq data(Illumina)
#4.1 run FastQC on raw RNA-seq data
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/RNASeq.fastq

#5 QC analysis of raw Ribo-seq data
#5.1 run FastQC on raw RNA-seq data
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/RIbSeq.fastq

#6 QC analysis of raw PacBio WGS data
#6.1 run FastQC on raw RNA-seq data
fastqc -o QC_Reports /home/Kasianov/NGSCourse/2019/QC/PacBio.fastq

#7 Mate pairs trimming
#7.1 prepare environment for mate pairs trimming
mkdir MP_trimmed
cd MP_trimmed
#7.2 trimming mate pairs reads by nxtrim
/home/Kasianov/soft/nextclip/bin/nextclip -i /home/Kasianov/NGSCourse/2019/QC/mate_pairs.forward.fastq -j /home/Kasianov/NGSCourse/2019/QC/mate_pairs.reverse.fastq -o mp_trimmed
#7.3 prepare environment for next excercise
cd ../

#8 merge MiSeq reads
#8.1 prepare environment for merging overlapping Miseq reads
mkdir miseq_merged
#8.2 merging overlapping Miseq reads
/home/Kasianov/soft/FLASH/flash -r 262 -f 500 -s 70 -o merged_reads_wgs -d miseq_merged /home/Kasianov/NGSCourse/2019/QC/wgs_forward.fastq /home/Kasianov/NGSCourse/2019/QC/wgs_reverse.fastq
