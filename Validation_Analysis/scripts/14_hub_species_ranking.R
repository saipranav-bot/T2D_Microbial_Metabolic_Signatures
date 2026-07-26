############################################################
# 14_hub_species_ranking.R
# Identify microbial hub species across metabolic traits
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
# LOAD ASSOCIATION TABLE
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

group_by(

feature

) %>%

summarise(

traits_count=n(),


traits=paste(

unique(clinical_trait),

collapse=", "

),


mean_effect=mean(

coef,

na.rm=TRUE

),


max_effect=max(

abs(coef),

na.rm=TRUE

),


best_qvalue=min(

qval,

na.rm=TRUE

),


positive_hits=sum(

coef > 0,

na.rm=TRUE

),


negative_hits=sum(

coef < 0,

na.rm=TRUE

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
# TOP HUB SPECIES OBJECT
############################################################


top_hubs <- hub_species %>%

head(20)



write.csv(

top_hubs,

file.path(

table_dir,

"top20_hub_species.csv"

),

row.names=FALSE

)



############################################################
# SAVE R OBJECT
############################################################


save(

hub_species,

top_hubs,

file=file.path(

object_dir,

"hub_species_ranking.RData"

)

)



############################################################
# SUMMARY
############################################################


cat("\n===== HUB SPECIES ANALYSIS COMPLETE =====\n")

cat(
"Generated Table3_hub_species.csv\n"
)

cat(
"Generated top20_hub_species.csv\n"
)


print(
head(top_hubs,10)
)
