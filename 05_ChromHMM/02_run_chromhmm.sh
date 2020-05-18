#!/bin/bash
# Prepare files
java -mx5000M -jar ./ChromHMM/ChromHMM.jar BinarizeBam -b 200 hg19.chrom.sizes HISTONE_TRACKS cellmarkfiletable.txt BINARIZED_TRACKS
# Run ChromHMM
java -mx1200M -jar ./ChromHMM/ChromHMM.jar LearnModel BINARIZED_TRACKS A549_OUTPUT 7 hg19
