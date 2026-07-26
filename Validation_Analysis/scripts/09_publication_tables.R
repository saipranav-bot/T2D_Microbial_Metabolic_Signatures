############################################################
# Generate publication-ready microbiome association tables
# Project: HMP2 T2D Microbiome Analysis
############################################################


library(dplyr)


############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
project_dir,
"Validation_Analysis/tables"
)


dir.create(
table_dir,
recursive=TRUE,
showWarnings=FALSE
)


############################################################
# LOAD COMBINED MAASLIN2 RESULTS
############################################################


combined_results <- read.csv(

file.path(
table_dir,
"HMP2_all_trait_maaslin2_results.csv"
),

check.names=FALSE

)


cat(
"Loaded associations:",
nrow(combined_results),
"\n"
)



############################################################
# TABLE 1: TRAIT SUMMARY
############################################################


table1_trait_summary <- combined_results %>%

group_by(Trait) %>%

summarise(

Total_Associations = n(),

Significant_Associations =
sum(qval < 0.05, na.rm=TRUE),

Positive_Associations =
sum(coef > 0 & qval < 0.05, na.rm=TRUE),

Negative_Associations =
sum(coef < 0 & qval < 0.05, na.rm=TRUE)

)


write.csv(

table1_trait_summary,

file.path(
table_dir,
"Table1_trait_summary.csv"
),

row.names=FALSE

)



############################################################
# TABLE 2: ALL MICROBIOME ASSOCIATIONS
############################################################


table2_all_associations <- combined_results %>%

filter(qval < 0.05) %>%

arrange(qval)


write.csv(

table2_all_associations,

file.path(
table_dir,
"Table2_all_microbiome_associations.csv"
),

row.names=FALSE

)



############################################################
# TABLE 3: HUB SPECIES
############################################################


hub_species <- combined_results %>%

filter(qval < 0.05) %>%

group_by(feature) %>%

summarise(

Traits_Associated = n_distinct(Trait),

Mean_Effect =
mean(coef, na.rm=TRUE),

Best_qvalue =
min(qval, na.rm=TRUE)

) %>%

arrange(Best_qvalue)


write.csv(

hub_species,

file.path(
table_dir,
"Table3_hub_species.csv"
),

row.names=FALSE

)



############################################################
# TABLE 4: SPECIES TRAIT OVERLAP
############################################################


species_trait_overlap <- combined_results %>%

filter(qval < 0.05) %>%

select(
feature,
Trait,
coef,
qval
) %>%

arrange(
feature,
qval
)


write.csv(

species_trait_overlap,

file.path(
table_dir,
"Table4_species_trait_overlap.csv"
),

row.names=FALSE

)



############################################################
# FINAL PUBLICATION TABLE
############################################################


publication_table <- combined_results %>%

filter(qval < 0.05) %>%

select(
Trait,
feature,
coef,
stderr,
pval,
qval
) %>%

arrange(qval)


write.csv(

publication_table,

file.path(
table_dir,
"HMP2_microbiome_metabolic_associations_publication_table.csv"
),

row.names=FALSE

)



############################################################
# SUMMARY
############################################################


cat(
"
Publication tables generated:

Table1_trait_summary.csv
Table2_all_microbiome_associations.csv
Table3_hub_species.csv
Table4_species_trait_overlap.csv
HMP2_microbiome_metabolic_associations_publication_table.csv

Saved in:
",
table_dir,
"\n"
)
