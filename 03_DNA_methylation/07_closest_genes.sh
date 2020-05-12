#!/bin/bash

# Get genes from chromosome 14
awk '{ if ($3=="gene" && $1=="chr14") print $1"\t"$4"\t"$5"\t"$7"\t"$14 }' gencode.vM25.annotation.gtf | sed 's/"//g' | sed 's/;//g' > genes_chr14.bed
# Find closest genes
bedtools closest -io -a genes_chr14.bed -b ./CpG_methylation/dmrs_large.bed -d | sort -k10,10n | awk '{ if ($10<=1000) print $5 }' > closest_genes.txt
