#! /bin/bash/

# Untar the .tar files and delete teh .tar file
#for file in *.tar; do echo "untarring the file: $file" tar -xvf "${file}" && rm "${file}"; done
#for file in *.tar; do tar -xvkf ${file} ; done

echo List of R1 and R2 Files
# Enlist only the R1 and R2 fastq files
ls -l *_lm_R[1,2]*.fastq.gz


# For loop with number range for merging by lanes and then by samples for both R1 and R2
for i in {1..20}
do
        echo "Index: $i"
	# merge for S1 : L1R1 and L2R1 and obtain lanemerged (lm) R1 file
	cat *22030a0**${i}_01_S${i}_L00[1,2]_R1_001.fastq.gz > 22030a0${i}_01_S${i}_lm_R1.fastq.gz
	# merge for L1R2 and L2R2 and obtain lanemerged (lm) R2 file
	cat *22030a0**${i}_01_S${i}_L00[1,2]_R2_001.fastq.gz > 22030a0${i}_01_S${i}_lm_R2.fastq.gz
	
	# merge for S2 : L1R1 and L2R1 and obtain lanemerged (lm) R1 file
	cat *22030a0**${i}_02_S${i}_L00[1,2]_R1_001.fastq.gz > 22030a0${i}_02_S${i}_lm_R1.fastq.gz
	# merge for L1R2 and L2R2 and obtain lanemerged (lm) R2 file
	cat *22030a0**${i}_02_S${i}_L00[1,2]_R2_001.fastq.gz > 22030a0${i}_02_S${i}_lm_R2.fastq.gz

	# Now perform Sample merging of the lane merged files

	# merge 01_lm_R1 and 02_lm_R1 into single samplemerged(sm) R1 file
	cat 22030a0*${i}*_0[1,2]_S${i}_lm_R1.fastq.gz > AJ${i}_sm_R1.fastq.gz
	# merge 01_lm_R2 and 02_lm_R2 into single samplemerged(sm) R2 file
	cat 22030a0*${i}*_0[1,2]_S${i}_lm_R2.fastq.gz > AJ${i}_sm_R2.fastq.gz
done

# Enlist only the lanemerged R1 and R2 fastq files
echo List of Lane merged R1 and R2 Files
ls -l *_lm_R[1,2]*.fastq.gz

echo List of Sample merged R1 and R2 Files
ls -l *_sm_R[1,2]*.fastq.gz

# Move the two samplemerged R1 and R2 file into external folder
#mv *sm*.fastq.gz /home/keshavprasadgubbi/Documents/Anna-Lena_dataset/mergedfiles

