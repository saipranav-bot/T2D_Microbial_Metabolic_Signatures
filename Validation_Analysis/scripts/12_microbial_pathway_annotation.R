############################################################
# 12_microbial_pathway_annotation.R
# Functional annotation of significant microbial species
# linked with metabolic traits
############################################################


library(dplyr)
library(readr)
library(stringr)



############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
project_dir,
"results/Tables"
)



############################################################
# LOAD SIGNIFICANT SPECIES
############################################################


assoc <- read.csv(

file.path(
table_dir,
"Table2_all_microbiome_associations.csv"
),

check.names=FALSE

)



############################################################
# EXTRACT SIGNIFICANT SPECIES
############################################################


species_list <- assoc %>%

select(
feature
) %>%

distinct()



############################################################
# BASIC FUNCTIONAL CATEGORY ANNOTATION
# Based on known microbial metabolic roles
############################################################


species_function <- data.frame(

feature=c(

"s__Bacteroides_faecis",
"s__Alistipes_inops",
"s__Gemmiger_formicilis",
"s__Blautia_hydrogenotrophica",
"s__Collinsella_intestinalis",
"s__Butyricimonas_virosa",
"s__Oxalobacter_formigenes",
"s__Eubacterium_rectale"

),


functional_category=c(

"SCFA production; carbohydrate metabolism",

"Bile acid metabolism; immune modulation",

"Butyrate production; energy metabolism",

"Hydrogen metabolism; fermentation",

"Choline metabolism; insulin resistance association",

"Butyrate production; gut barrier support",

"Oxalate metabolism",

"Butyrate production; metabolic health"

),


T2D_mechanism=c(

"Short chain fatty acid regulation and glucose homeostasis",

"Inflammation regulation and metabolic improvement",

"Improved insulin sensitivity through butyrate pathways",

"Fermentation and microbial metabolite production",

"Potential metabolic dysregulation through metabolite pathways",

"Barrier integrity and anti-inflammatory effects",

"Host metabolite regulation",

"SCFA-mediated metabolic protection"

)

)



############################################################
# MERGE ANNOTATION
############################################################


annotated_species <- assoc %>%

left_join(

species_function,

by="feature"

)



############################################################
# HANDLE UNKNOWN SPECIES
############################################################


annotated_species <- annotated_species %>%

mutate(

functional_category=

ifelse(

is.na(functional_category),

"Uncharacterized microbial function",

functional_category

),


T2D_mechanism=

ifelse(

is.na(T2D_mechanism),

"Mechanistic role requires further validation",

T2D_mechanism

)

)



############################################################
# SAVE FUNCTIONAL TABLE
############################################################


write.csv(

annotated_species,

file.path(

table_dir,

"microbial_pathway_annotation.csv"

),

row.names=FALSE

)



############################################################
# FUNCTIONAL CATEGORY SUMMARY
############################################################


functional_summary <- annotated_species %>%

group_by(
functional_category
) %>%

summarise(

species_count=n(),

mean_effect=mean(
coef,
na.rm=TRUE
)

) %>%

arrange(
desc(species_count)
)



write.csv(

functional_summary,

file.path(

table_dir,

"functional_category_summary.csv"

),

row.names=FALSE

)



############################################################
# SAVE OBJECT
############################################################


save(

annotated_species,

functional_summary,

file=file.path(

project_dir,

"results/R_objects/microbial_function_annotation.RData"

)

)



cat("\n===== MICROBIAL PATHWAY ANNOTATION COMPLETE =====\n")

cat(
"Generated microbial_pathway_annotation.csv\n"
)

cat(
"Generated functional_category_summary.csv\n"
)
