############################################################
# MaAsLin2 Association Analysis
# Trait: HDL
# Project: HMP2 T2D Microbiome Analysis
############################################################


library(Maaslin2)
library(dplyr)



############################################################
# PATHS
############################################################


input_file <- 
"HMP2_T2D_Microbiome_Analysis/data/processed/species_abundance.tsv"


metadata_file <- 
"HMP2_T2D_Microbiome_Analysis/data/processed/HMP2_metadata_final.tsv"


output_dir <- 
"HMP2_T2D_Microbiome_Analysis/results/Maaslin2_HDL"



############################################################
# LOAD DATA
############################################################


microbiome <- read.csv(

input_file,

sep="\t",

row.names=1,

check.names=FALSE

)



metadata <- read.csv(

metadata_file,

sep="\t",

row.names=1,

check.names=FALSE

)



############################################################
# SAMPLE MATCHING
############################################################


common_samples <- intersect(

rownames(metadata),

colnames(microbiome)

)



microbiome <- microbiome[,common_samples]


metadata <- metadata[common_samples,]



############################################################
# FORMAT FEATURE TABLE
############################################################


feature_table <- as.data.frame(

t(microbiome)

)



############################################################
# RUN MaAsLin2
############################################################


fit <- Maaslin2(

input_data = feature_table,

input_metadata = metadata,

output = output_dir,

fixed_effects = c(
"HDL"
),

normalization = "TSS",

transform = "LOG",

analysis_method = "LM",

correction = "BH",

standardize = TRUE

)



############################################################
# SAVE RESULTS
############################################################


results <- read.csv(

paste0(

output_dir,

"/all_results.tsv"

),

sep="\t"

)



write.csv(

results,

"HMP2_T2D_Microbiome_Analysis/results/Tables/MaAsLin2_HDL_results.csv",

row.names=FALSE

)



save(

fit,

results,

file =
"HMP2_T2D_Microbiome_Analysis/results/R_objects/MaAsLin2_HDL.RData"

)



cat(

"\nHDL MaAsLin2 completed successfully\n"

)
