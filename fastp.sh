
#! /bin/bash/

#ls *.fastq.gz

#for f in $(ls *.fastq.gz)
for i in {42..51}
do
        echo "Index: $i"
        #fastp -i $f -o out.$f 
        fastp -i 22030a0${i}*_01_S${i}_L001_R1_001.fastq.gz -I 22030a0${i}*_01_S${i}_L001_R2_001.fastq.gz -o out.22030a0${i}*_01_S${i}_L001_R1_001.fastq.gz -O out.22030a0${i}_L001_01_S${i}*_R2_001.fastq.gz -l 18 --detect_adapter_for_pe --correction --trim_poly_g --trim_poly_x --overrepresentation_analysis --thread 4
        fastp -i 22030a0${i}*_01_S${i}_L002_R1_001.fastq.gz -I 22030a0${i}*_01_S${i}_L002_R2_001.fastq.gz -o out.22030a0${i}*_01_S${i}_L002_R1_001.fastq.gz -O out.22030a0${i}_L002_01_S${i}*_R2_001.fastq.gz -l 18 --detect_adapter_for_pe --correction --trim_poly_g --trim_poly_x --overrepresentation_analysis --thread 4
done

echo "done!"





#fastp -i AD53_sm_R1.fastq.gz -I AD53_sm_R2.fastq.gz -o out.AD53_sm_R1.fastq.gz -O out.AD53_sm_R2.fastq.gz
#fastp -i 22030a042_01_S42_L001_R1_001.fastq.gz -I 22030a042_01_S42_L002_R1_001.fastq.gz -o out.22030a042_01_S42_L001_R1_001.fastq.gz -O out.22030a042_01_S42_L002_R1_001.fastq.gz -l 20
