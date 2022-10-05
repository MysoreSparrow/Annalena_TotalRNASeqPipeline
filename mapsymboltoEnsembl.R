library(tidyverse)
# Author : Keshav Prasad Gubbi

suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("DESeq2"))
suppressPackageStartupMessages(library("pheatmap"))
suppressPackageStartupMessages(library("PoiClaClu"))
suppressPackageStartupMessages(library("RColorBrewer"))
suppressPackageStartupMessages(library("tidyverse"))
suppressPackageStartupMessages(library("PoiClaClu"))
suppressPackageStartupMessages(library("vsn"))
suppressPackageStartupMessages(library("EnhancedVolcano"))
suppressPackageStartupMessages(library("gplots"))
suppressPackageStartupMessages(library("org.Mm.eg.db"))
suppressPackageStartupMessages(library("stringr"))
suppressPackageStartupMessages(library("genefilter"))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("ggplot2"))
suppressPackageStartupMessages(library("glmpca"))
suppressPackageStartupMessages(library("org.Mm.eg.db"))
suppressPackageStartupMessages(library("AnnotationDbi"))
suppressPackageStartupMessages(library("apeglm"))
suppressPackageStartupMessages(library("ComplexHeatmap"))
suppressPackageStartupMessages(library("clusterProfiler"))
suppressPackageStartupMessages(library("ggrepel"))
suppressPackageStartupMessages(library("corrplot"))
suppressPackageStartupMessages(library("GO.db"))
suppressPackageStartupMessages(library("edgeR"))
suppressPackageStartupMessages(library("GOstats"))
suppressPackageStartupMessages(library("pathview"))
suppressPackageStartupMessages(library("gage"))
suppressPackageStartupMessages(library("gageData"))
suppressPackageStartupMessages(library("GOSemSim"))
suppressPackageStartupMessages(library("DOSE"))
suppressPackageStartupMessages(library("enrichplot"))
suppressPackageStartupMessages(library("ggnewscale"))
suppressPackageStartupMessages(library("glue"))
suppressPackageStartupMessages(library("ggupset"))
suppressPackageStartupMessages(library("stringr"))
suppressPackageStartupMessages(library("stats"))
suppressPackageStartupMessages(library("FactoMineR"))
suppressPackageStartupMessages(library("factoextra"))
suppressPackageStartupMessages(library("pcaExplorer"))

## Input the Count Matrix

countsmatrix <- read.csv("/media/keshavprasadgubbi/HornefLab_Data2/fastq_files_Tuebingen/AJ/bam/bamfiles/featurecounts_Anna_totalRNAseq.csv")

### Clean up the Count Matrix
rownames(countsmatrix) <- countsmatrix[, 1] # converting first column of gene ID into rownames, to be used for sanity check later

# It is IMPORTANT to keep the names of the genes in the rownames
countsmatrix <- subset(countsmatrix, select = -c(EnsemblID)) # dropping the X column

## Display the column names
colnames(countsmatrix)

### Annotating and Exporting ENSEMBL ID into Gene Symbols

# Adding genes annotated from ENSEMBL ID to Gene symbols and ENTREZ Id to countsmatrix table.
# Will be keeping the symbols and entrez columsn to be added later into results table as it is for later use

cm_row <- rownames(countsmatrix)
head(cm_row)

# Mapping the ENSEMBL ID to Symbol and ENTREZ ID
symbols <- mapIds(
  org.Mm.eg.db,
  keys = cm_row,
  column = c("SYMBOL"),
  keytype = "ENSEMBL",
  multiVals = "first"
)

# Create symbols column
symbols <- symbols[!is.na(symbols)]
symbols <- symbols[match(rownames(countsmatrix), names(symbols))]

# Creating a new column called genename and putting in the symbols and entrez columns into count matrix
countsmatrix$genename <- symbols

# Removing all rows with NA values for genenames, so that those rows are filtered out.
countsmatrix <- unique(countsmatrix[rowSums(is.na(countsmatrix)) == 0, ]) # Apply rowSums & is.na

nrow(countsmatrix)

# Moving the ENSEMBL ID from rownames into separate column for itself.
countsmatrix <- tibble::rownames_to_column(countsmatrix, "E_ID")
# Removing the duplicated genes so that then these genes can be made into rownames for countsmatrix
countsmatrix <- distinct(countsmatrix[!duplicated(countsmatrix$genename), ])

# Now make the ganename column into rownames of count matrix
rownames(countsmatrix) <- countsmatrix[, "genename"]

# Dropping the column E_ID, genenames so that only numeric values are present in it as an input of DESEq Object.
countsmatrix <- subset(countsmatrix, select = -c(genename, E_ID)) #

# Changing countsmatrix into Matrix of numeric values so that only numeric values are present in it as an input of DESEq Object.
countsmatrix <- as.matrix(countsmatrix)
class(countsmatrix) <- "numeric"


### The Count Matrix is:
head(countsmatrix, 10)

colnames(countsmatrix) <- str_remove_all(colnames(countsmatrix),
                  pattern = "_Aligned.sortedByCoord.out.bam")
colnames(countsmatrix)
countsmatrix <- as.data.frame(countsmatrix)
countsmatrix <- tibble::rownames_to_column(countsmatrix, "symbols")

require(writexl)

write_xlsx(countsmatrix,
           "/media/keshavprasadgubbi/HornefLab_Data2/fastq_files_Tuebingen/AJ/bam/bamfiles/Countmatrix_mapped_Anna_totalRNAseq.xlsx")

write.table(countsmatrix,
            file = "/media/keshavprasadgubbi/HornefLab_Data2/fastq_files_Tuebingen/AJ/bam/bamfiles/Countmatrix_mapped_Anna_totalRNAseq.csv")