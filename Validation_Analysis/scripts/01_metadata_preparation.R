############################################################
# HMP2 T2D MICROBIOME ANALYSIS
# Script: 01_metadata_preparation.R
#
# Purpose:
# Prepare HMP2 clinical metadata for microbiome-metabolic
# association analysis using MaAsLin2
#
############################################################


############################################################
# LOAD PACKAGES
############################################################

library(dplyr)
library(readr)
library(stringr)


############################################################
# CREATE DIRECTORIES
############################################################

dir.create(
"data/processed",
recursive = TRUE,
showWarnings = FALSE
)


############################################################
# LOAD HMP2 METADATA
############################################################

# Modify path according to downloaded HMP2 metadata file

metadata <- read.csv(
"data/raw/HMP2_metadata.csv",
stringsAsFactors = FALSE
)


############################################################
# BASIC INSPECTION
############################################################

dim(metadata)

head(metadata)

colnames(metadata)



############################################################
# SELECT IMPORTANT CLINICAL VARIABLES
############################################################


clinical_metadata <- metadata %>%

select(

subject_id,

participant_id,

age,

sex,

BMI,

hba1c,

glucose,

triglycerides,

hdl,

ldl

)



############################################################
# CLEAN COLUMN NAMES
############################################################


clinical_metadata <- clinical_metadata %>%

rename(

HbA1c = hba1c,

Glucose = glucose,

Triglycerides = triglycerides,

HDL = hdl,

LDL = ldl

)



############################################################
# REMOVE DUPLICATE SUBJECTS
############################################################


clinical_metadata <- clinical_metadata %>%

distinct(
subject_id,
.keep_all = TRUE
)



############################################################
# SAVE CLEAN METADATA
############################################################


write.csv(

clinical_metadata,

"data/processed/HMP2_clean_clinical_metadata.csv",

row.names = FALSE

)



############################################################
# CREATE TRAIT SPECIFIC METADATA FILES
############################################################


traits <- c(

"HbA1c",

"Glucose",

"Triglycerides",

"HDL",

"LDL"

)



for(trait in traits){


trait_metadata <- clinical_metadata %>%

select(

subject_id,

age,

sex,

BMI,

all_of(trait)

)



write.csv(

trait_metadata,

paste0(

"data/processed/HMP2_",

trait,

"_metadata.csv"

),

row.names=FALSE

)


}



############################################################
# END
############################################################


cat(
"Metadata preparation completed successfully\n"
)
