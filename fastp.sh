
#! /bin/bash/

ls *.fastq.gz

#for f in $(ls *.fastq.gz)
for i in {41..60}
do
        echo "Index: $i"
        #fastp -i $f -o out.$f 
        fastp -i *AD0${i}*_sm_R1.fastq.gz -I *AD0${i}*_sm_R2.fastq.gz -o out.*AD0${i}*_R1.fastq.gz -O out.*AD0${i}*_R2.fastq.gz --length_required 20 --detect_adapter_for_pe --correction --low_complexity_filter --trim_poly_g --trim_poly_x --overrepresentation_analysis --thread 8  
done

echo "done!"





#fastp -i AD53_sm_R1.fastq.gz -I AD53_sm_R2.fastq.gz -o out.AD53_sm_R1.fastq.gz -O out.AD53_sm_R2.fastq.gz
#fastp -i 22030a042_01_S42_L001_R1_001.fastq.gz -I 22030a042_01_S42_L002_R1_001.fastq.gz -o out.22030a042_01_S42_L001_R1_001.fastq.gz -O out.22030a042_01_S42_L002_R1_001.fastq.gz -l 20
# AD041_sm_R1.fastq.gz
