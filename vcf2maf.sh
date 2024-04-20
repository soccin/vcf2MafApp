#!/bin/bash

module load samtools/1.19.2

SDIR="$( cd "$( dirname "$0" )" && pwd )"

GENOME=$1
IVCF=$2
NID=$3
TID=$4


MROOT=$(realpath $SDIR/rsrc)
VEPROOT=$MROOT/vep
VEPDATA=$MROOT/vep/vep_data

VCF2MAF=$MROOT/vcf2maf/vcf2maf-1.6.21/vcf2maf.pl

if [ -e $GENOME ]; then
    source $GENOME
else
    echo -e "\n   Invalid genome file [$GENOME]\n\n"
    exit
fi

perl $VCF2MAF \
    --vep-path $SDIR \
    --vep-data $VEPDATA \
    --vep-forks 12  \
    --ref-fasta $FASTA \
    --species $SPECIES \
    --ncbi-build $BUILD \
    --retain-info CALLER,DP,STATUS \
    --retain-fmt AD \
    --input-vcf $IVCF \
    --output-maf ${IVCF/.vcf/.vep.maf} \
    --normal-id $NID \
    --tumor-id $TID
