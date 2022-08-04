#!/bin/bash

#Request cores. In this case - 2 cores will be requested
SBATCH --cpus-per-task=8

#Request memory per thread. Here it's 1 GB per requested core
SBATCH --mem-per-cpu=128G

# Set a job name
SBATCH --job-name=prodce_bams_totalrnaseq_annalena

#Specify time before the job is killed by scheduler (in case is hangs). In this case - 24 hours
SBATCH --time=24:00:00 

#Declare the merged STDOUT/STDERR file
SBATCH --output=totalrnaseq_annalena_output.%J.out

#Run something
#module load R
echo $PATH #only diplays the current PATH-variable

#Please note: you have to load the modules and every other variable you might have set in yout .bashrc again in the execution file, in order for it to be loaded properly on the compute nodes.

# define variables
gd=/data/keshav/total_rnaseq/genome_index_fromSTAR_usingm39

filepath=/data/keshav/total_rnaseq/Aline_RNAseq/merged

# get our data files
# get our data files
R1FILES=$filepath/AJ1_sm_R1.fastq.gz,$filepath/AJ2_sm_R1.fastq.gz,$filepath/AJ3_sm_R1.fastq.gz,$filepath/AJ4_sm_R1.fastq.gz,$filepath/AJ5_sm_R1.fastq.gz,$filepath/AJ6_sm_R1.fastq.gz,$filepath/AJ7_sm_R1.fastq.gz,$filepath/AJ8_sm_R1.fastq.gz,$filepath/AJ9_sm_R1.fastq.gz,$filepath/AJ10_sm_R1.fastq.gz,$filepath/AJ11_sm_R1.fastq.gz,$filepath/AJ12_sm_R1.fastq.gz,$filepath/AJ13_sm_R1.fastq.gz,$filepath/AJ14_sm_R1.fastq.gz,$filepath/AJ15_sm_R1.fastq.gz,$filepath/AJ16_sm_R1.fastq.gz,$filepath/AJ17_sm_R1.fastq.gz,$filepath/AJ18_sm_R1.fastq.gz,$filepath/AJ19_sm_R1.fastq.gz,$filepath/AJ20_sm_R1.fastq.gz
R2FILES=filepath/AJ1_sm_R2.fastq.gz,$filepath/AJ2_sm_R2.fastq.gz,$filepath/AJ3_sm_R2.fastq.gz,$filepath/AJ4_sm_R2.fastq.gz,$filepath/AJ5_sm_R2.fastq.gz,$filepath/AJ6_sm_R2.fastq.gz,$filepath/AJ7_sm_R2.fastq.gz,$filepath/AJ8_sm_R2.fastq.gz,$filepath/AJ9_sm_R2.fastq.gz,$filepath/AJ10_sm_R2.fastq.gz,$filepath/AJ11_sm_R2.fastq.gz,$filepath/AJ12_sm_R2.fastq.gz,$filepath/AJ13_sm_R2.fastq.gz,$filepath/AJ14_sm_R2.fastq.gz,$filepath/AJ15_sm_R2.fastq.gz,$filepath/AJ16_sm_R2.fastq.gz,$filepath/AJ17_sm_R2.fastq.gz,$filepath/AJ18_sm_R2.fastq.gz,$filepath/AJ19_sm_R2.fastq.gz,$filepath/AJ20_sm_R2.fastq.gz


#for f in $(ls *.fastq.gz)
#do
#    echo $f
STAR --runThreadN 8 --genomeDir $gd --readFilesIn $R1FILES $R2FILES --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix ./aligned/aligned_$f. --readFilesCommand zcat
#done
echo "done!"
