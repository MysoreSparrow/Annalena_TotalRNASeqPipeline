 #!/bin/bash

# define variables
#gd=/mnt/cbe3b976-3837-467e-801d-f641e979b935/genome_index_fromSTAR_usingm39/


filepath=/media/keshavprasadgubbi/HornefLab_Data2/fastq_files_Tuebingen/Anna-Lena_dataset/test

# get our data files
R1FILES=$filepath/AJ1_sm_R1.fastq.gz,$filepath/AJ2_sm_R1.fastq.gz,$filepath/AJ3_sm_R1.fastq.gz,$filepath/AJ4_sm_R1.fastq.gz,$filepath/AJ5_sm_R1.fastq.gz,$filepath/AJ6_sm_R1.fastq.gz,$filepath/AJ7_sm_R1.fastq.gz,$filepath/AJ8_sm_R1.fastq.gz,$filepath/AJ9_sm_R1.fastq.gz,$filepath/AJ10_sm_R1.fastq.gz
R2FILES=filepath/AJ1_sm_R2.fastq.gz,$filepath/AJ2_sm_R2.fastq.gz,$filepath/AJ3_sm_R2.fastq.gz,$filepath/AJ4_sm_R2.fastq.gz,$filepath/AJ5_sm_R2.fastq.gz,$filepath/AJ6_sm_R2.fastq.gz,$filepath/AJ7_sm_R2.fastq.gz,$filepath/AJ8_sm_R2.fastq.gz,$filepath/AJ9_sm_R2.fastq.gz,$filepath/AJ10_sm_R2.fastq.gz


for f in $(ls *.fastq.gz)
do
    echo $f
    STAR --runThreadN 8 --genomeDir $gd --readFilesIn $R1FILES $R2FILES --outSAMtype BAM SortedByCoordinate \
         --quantMode GeneCounts --outFileNamePrefix ./aligned/aligned_$f. --readFilesCommand zcat
done
echo "done!"

# Use this cmd if the fastq files are .fastq.gz:  --readFilesCommand zcat

#/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_758_S6_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_756_S15_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_760_S12_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_764_S7_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_768_S17_R2_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_Ctrl2_S21_R2_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_476_S20_R2_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_757_S11_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_761_S4_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_765_S1_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_768_S8_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_754_S3_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_757_S18_R2_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_762_S5_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_766_S13_R1_001.fastq,/root/alina_rnaseq/mapping_alignment/trimmed_run5/run5_trimmed_769_S9_R1_001.fastq
