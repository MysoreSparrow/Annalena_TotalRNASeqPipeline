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
SBATCH --output=/data/keshav/total_rnaseq/output/totalrnaseq_annalena_output.%J.out

#Run something
#module load R
#echo $PATH #only diplays the current PATH-variable

#Please note: you have to load the modules and every other variable you might have set in yout .bashrc again in the execution file, in order for it to be loaded properly on the compute nodes.
pwd
conda info --envs
source /home/keshav/anaconda3/bin/activate
conda activate base 

echo "Starting with Genome Variable."
# define variables
gd=/data/keshav/total_rnaseq/genome_index_fromSTAR_usingm39
echo $gd
filepath=/data/keshav/total_rnaseq/Annalena/merged_files


# get the data files as a list of comma separated R1 files and then with a space for R2 files.
R1FILES=$filepath/AJ1_sm_R1.fastq.gz,$filepath/AJ2_sm_R1.fastq.gz,$filepath/AJ3_sm_R1.fastq.gz,$filepath/AJ4_sm_R1.fastq.gz,$filepath/AJ5_sm_R1.fastq.gz,$filepath/AJ6_sm_R1.fastq.gz,$filepath/AJ7_sm_R1.fast$
R2FILES=$filepath/AJ1_sm_R2.fastq.gz,$filepath/AJ2_sm_R2.fastq.gz,$filepath/AJ3_sm_R2.fastq.gz,$filepath/AJ4_sm_R2.fastq.gz,$filepath/AJ5_sm_R2.fastq.gz,$filepath/AJ6_sm_R2.fastq.gz,$filepath/AJ7_sm_R2.fast$


#for f in $(ls *.fastq.gz)
#do
#    echo $f
#/data/keshav/total_rnaseq/Annalena/merged_files/aligned
STAR --runThreadN 8 --genomeDir $gd --readFilesIn $R1FILES $R2FILES --outSAMtype BAM SortedByCoordinate --quantMode GeneCounts --outFileNamePrefix ./aligned/aligned_ --readFilesCommand zcat
#done
echo "done!"



