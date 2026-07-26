############################################################
# 17_species_trait_overlap.R
# Table 4: Species shared across metabolic traits
############################################################


library(dplyr)
library(tidyr)
library(readr)



############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
project_dir,
"results/Tables"
)


object_dir <- file.path(
project_dir,
"results/R_objects"
)



############################################################
# LOAD DATA
############################################################


combined_results <- read.csv(

file.path(
table_dir,
"Table2_all_microbiome_associations.csv"
)

)



############################################################
# SPECIES TRAIT OVERLAP
############################################################


species_overlap <- combined_results %>%

group_by(feature) %>%

summarise(

traits = paste(

clinical_trait,

collapse=", "

),

number_traits = n(),

.qvalue = min(qval),

mean_effect = mean(coef),

.max_effect = max(abs(coef))

) %>%

arrange(

desc(number_traits),

.qvalue

)



############################################################
# SAVE TABLE 4
############################################################


write.csv(

species_overlap,

file.path(

table_dir,

"Table4_species_trait_overlap.csv"

),

row.names=FALSE

)



############################################################
# SPECIES TRAIT MATRIX
############################################################


overlap_matrix <- combined_results %>%

select(

feature,

clinical_trait

) %>%

mutate(

presence=1

) %>%

pivot_wider(

names_from = clinical_trait,

values_from = presence,

values_fill = 0

)



write.csv(

overlap_matrix,

file.path(

table_dir,

"species_trait_overlap_matrix.csv"

),

row.names=FALSE

)



############################################################
# SAVE OBJECT
############################################################


save(

species_overlap,

overlap_matrix,

file=file.path(

object_dir,

"species_trait_overlap.RData"

)

)



############################################################
# CHECK
############################################################


cat("\n===== SPECIES OVERLAP COMPLETE =====\n")


print(

head(species_overlap,20)

)
