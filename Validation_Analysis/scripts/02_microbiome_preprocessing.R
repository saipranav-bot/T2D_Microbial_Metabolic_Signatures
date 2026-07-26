############################################################

# HMP2 T2D MICROBIOME ANALYSIS

# Script: 02_microbiome_preprocessing.R

#

# Purpose:

# Prepare species abundance matrix for MaAsLin2

#

############################################################





############################################################

# LOAD PACKAGES

############################################################





library(dplyr)

library(readr)

library(tibble)





############################################################

# CREATE DIRECTORIES

############################################################





dir.create(



"data/processed",



recursive=TRUE,



showWarnings=FALSE



)







############################################################

# LOAD SPECIES ABUNDANCE TABLE

############################################################





# Input:

# Rows = samples

# Columns = microbial species





species_table <- read.csv(



"data/raw/HMP2_species_abundance.csv",



row.names = 1,



check.names = FALSE



)







############################################################

# INSPECTION

############################################################





dim(species_table)



head(species_table)







############################################################

# REMOVE LOW PREVALENCE SPECIES

############################################################





prevalence_threshold <- 0.10







species_filtered <- species_table %>%



select(



where(



~ mean(. > 0) >= prevalence_threshold



)



)







############################################################

# TRANSPOSE FOR MAASLIN2

############################################################





species_maaslin <- species_filtered %>%



rownames_to_column(

"sample_id"

)







############################################################

# SAVE FILTERED SPECIES TABLE

############################################################





write.csv(



species_maaslin,



"data/processed/HMP2_species_filtered_maaslin2.csv",



row.names=FALSE



)







############################################################

# CREATE SPECIES LIST

############################################################





species_list <- colnames(



species_filtered



)







write.csv(



data.frame(

species=species_list

),



"data/processed/significant_species_input_list.csv",



row.names=FALSE



)







############################################################

# SUMMARY

############################################################





cat(



"Original species:",

ncol(species_table),



"\nFiltered species:",



ncol(species_filtered),



"\n"



)





cat(



"Microbiome preprocessing completed\n"



)
