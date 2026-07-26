############################################################
# 19_hub_species_ranking.R
# Table 3: Hub microbiome species ranking
############################################################


library(dplyr)
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
# LOAD ASSOCIATION DATA
############################################################


combined_results <- read.csv(

file.path(

table_dir,

"Table2_all_microbiome_associations.csv"

)

)



############################################################
# HUB SPECIES CALCULATION
############################################################


hub_species <- combined_results %>%

group_by(feature) %>%

summarise(

traits_count = n(),

traits = paste(

clinical_trait,

collapse=", "

),

mean_effect = mean(

coef,

na.rm=TRUE

),

max_effect = max(

abs(coef),

na.rm=TRUE

),

best_qvalue = min(

qval,

na.rm=TRUE

),

positive_hits = sum(

coef > 0

),

negative_hits = sum(

coef < 0

)

) %>%

arrange(

desc(traits_count),

best_qvalue

)



############################################################
# SAVE TABLE 3
############################################################


write.csv(

hub_species,

file.path(

table_dir,

"Table3_hub_species.csv"

),

row.names=FALSE

)



############################################################
# TOP 20 HUB SPECIES
############################################################


top20_hubs <- hub_species %>%

head(20)



write.csv(

top20_hubs,

file.path(

table_dir,

"Top20_hub_species.csv"

),

row.names=FALSE

)



############################################################
# SAVE OBJECT
############################################################


save(

hub_species,

top20_hubs,

file=file.path(

object_dir,

"hub_species_ranking.RData"

)

)



############################################################
# CHECK
############################################################


cat("\n===== HUB SPECIES COMPLETE =====\n")


print(

head(

hub_species,

20

)

)
