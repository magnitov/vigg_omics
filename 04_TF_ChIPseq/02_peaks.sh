#!/bin/bash
# Call peaks
macs2 callpeak -t ./aligned/SOX2.bam -c ./aligned/Input.bam -g hs -n SOX2.macs --outdir ./peaks/
macs2 callpeak -t ./aligned/SOX2_RMST.bam -c ./aligned/Input.bam -g hs -n SOX2_RMST.macs --outdir ./peaks/
# Find motifs
findMotifsGenome.pl ./peaks/SOX2.macs_peaks.narrowPeak ../CHIP_SEQ_2A/hg19/chr10.fa motifs_sox2
findMotifsGenome.pl ./peaks/SOX2_RMST.macs_peaks.narrowPeak ../CHIP_SEQ_2A/hg19/chr10.fa motifs_sox2_rsmt
