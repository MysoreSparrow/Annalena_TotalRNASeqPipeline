#! /bin/bash/

# Untar the .tar files and delete teh .tar file
#tar -xvf *.tar
echo "untarring the files:" 
for file in *.tar; do tar xvf "${file}" && rm "${file}"; done

#find -type f -name *22030a001_01_S1_*_R1*.fastq.gz 

echo List of R1 and R2 Files
# Enlist only the R1 and R2 fastq files
ls -l *R[1,2]*.fastq.gz

# For 01
# merge for L1R1 and L2R1 and obtain lanemerged (lm) R1 file
cat *22030a001_01*_L00[1,2]_R1_001.fastq.gz > 22030a001_01_S1_lm_R1.fastq.gz
# merge for L1R2 and L2R2 and obtain lanemerged (lm) R2 file
cat *22030a001_01*_L00[1,2]_R2_001.fastq.gz > 22030a001_01_S1_lm_R2.fastq.gz

# For 02
# merge for L1R1 and L2R1 and obtain lanemerged (lm) R1 file
cat *22030a001_02*_L00[1,2]_R1_001.fastq.gz > 22030a001_02_S1_lm_R1.fastq.gz
# merge for L1R2 and L2R2 and obtain lanemerged (lm) R2 file
cat *22030a001_02*_L00[1,2]_R2_001.fastq.gz > 22030a001_02_S1_lm_R2.fastq.gz

# Enlist only the lanemerged R1 and R2 fastq files
ls -l *_lm_R[1,2]*.fastq.gz

#22030a001_01_S1_lm_R1.fastq.gz
#22030a001_02_S1_lm_R1.fastq.gz

# Now perform Sample merging of the lane merged files

# merge 01_lm_R1 and 02_lm_R1 into single samplemerged(sm) R1 file
cat 22030a001_0[1,2]_S1_lm_R1.fastq.gz > AJ01_S1_sm_R1.fastq.gz
# merge 01_lm_R2 and 02_lm_R2 into single samplemerged(sm) R2 file
cat 22030a001_0[1,2]_S1_lm_R2.fastq.gz > AJ01_S1_sm_R2.fastq.gz

# Move the two samplemerged R1 and R2 file into external folder
mv *sm*.fastq.gz /home/keshavprasadgubbi/Documents/Anna-Lena_dataset/mergedfiles
