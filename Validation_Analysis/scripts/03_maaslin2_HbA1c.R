############################################################
# 03_maaslin2_HbA1c.R
# MaAsLin2 association analysis: microbiome species vs HbA1c
############################################################


############################################################
# LOAD PACKAGES
############################################################

library(Maaslin2)
library(dplyr)


############################################################
# DIRECTORIES
############################################################

base_dir <- "HMP2_T2D_Microbiome_Analysis"

data_dir <- paste0(
base_dir,
"/data/processed"
)

result_dir <- paste0(
base_dir,
"/results/Tables"
)

dir.create(
result_dir,
recursive=TRUE,
showWarnings=FALSE
)


############################################################
# LOAD DATA
############################################################

# microbiome abundance table
microbiome <- read.csv(
paste0(
data_dir,
"/species_abundance.tsv"
),
sep="\t",
row.names=1,
check.names=FALSE
)


# metadata
metadata <- read.csv(
paste0(
data_dir,
"/metadata_HMP2.csv"
),
row.names=1,
check.names=FALSE
)



############################################################
# MATCH SAMPLE ORDER
############################################################


common_samples <- intersect(
colnames(microbiome),
rownames(metadata)
)


microbiome <- microbiome[,common_samples]


metadata <- metadata[common_samples,]



############################################################
# TRANSPOSE FEATURE TABLE
############################################################


features <- as.data.frame(
t(microbiome)
)



############################################################
# SELECT HbA1c MODEL VARIABLE
############################################################


metadata_hba1c <- metadata %>%
select(
HbA1c
)



############################################################
# RUN MAASLIN2
############################################################


fit_data <- Maaslin2(

input_data = features,

input_metadata = metadata_hba1c,

output = paste0(
base_dir,
"/results/Maaslin2_HbA1c"
),

fixed_effects = c(
"HbA1c"
),

normalization = "TSS",

transform = "LOG",

analysis_method="LM",

max_significance=0.05

)



############################################################
# SAVE RESULTS
############################################################


results <- read.csv(
paste0(
base_dir,
"/results/Maaslin2_HbA1c/all_results.tsv"
),
sep="\t"
)


write.csv(

results,

paste0(
result_dir,
"/HbA1c_MaAsLin2_results.csv"
),

row.names=FALSE

)



cat(
"\nHbA1c MaAsLin2 analysis completed\n"
)
