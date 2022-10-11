#!/bin/bash

#Request cores. In this case - 2 cores will be requested
#SBATCH --cpus-per-task=6

#Request memory per thread. Here it's 1 GB per requested core
#SBATCH --mem-per-cpu=128G

# Set a job name
#SBATCH --job-name=prodce_bams_totalrnaseq_annalena

#Specify time before the job is killed by scheduler (in case is hangs). In this case - 24 hours
#SBATCH --time=72:00:00 

#Declare the merged STDOUT/STDERR file
#SBATCH --output=/data/keshav/total_rnaseq/Anna_RNAseq/merged/output/anna58.%J.out

#Run something
#module load R
#echo $PATH #only diplays the current PATH-variable

#Please note: you have to load the modules and every other variable you might have set in yout .bashrc again in the execution file, in order for it to be loaded properly on the compute nodes.
pwd
conda info --envs
source /home/keshav/anaconda3/bin/activate
conda activate base 

chmod 777 *.fastq.gz
echo "Starting now!!!."

# define variables
gd=/data/keshav/genome_generate/genome_mm38
echo $gd

filepath=/data/keshav/total_rnaseq/Aline_RNAseq/merged


# get the data files as a list of comma separated R1 files and then with a space for R2 files.
R1FILES=$filepath/out.58_sm_R1.fastq.gz
R2FILES=$filepath/out.58_sm_R2.fastq.gz

STAR --runThreadN 6 --genomeDir $gd --readFilesIn $R1FILES $R2FILES --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix ./anew58/anew58_ --readFilesCommand zcat

echo "done!"

