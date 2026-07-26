############################################################
# 11_species_trait_heatmap.R
# Generate microbiome species vs metabolic trait heatmap
############################################################


library(dplyr)
library(tidyr)
library(pheatmap)



############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
project_dir,
"results/Tables"
)


figure_dir <- file.path(
project_dir,
"results/Figures"
)



dir.create(
figure_dir,
recursive=TRUE,
showWarnings=FALSE
)



############################################################
# LOAD ASSOCIATION DATA
############################################################


results <- read.csv(

file.path(
table_dir,
"Table2_all_microbiome_associations.csv"
),

check.names=FALSE

)



############################################################
# CREATE SPECIES-TRAIT EFFECT MATRIX
############################################################


heatmap_data <- results %>%

select(
feature,
clinical_trait,
coef
) %>%

pivot_wider(

names_from = clinical_trait,

values_from = coef,

values_fill = 0

)



############################################################
# SAVE MATRIX
############################################################


write.csv(

heatmap_data,

file.path(
table_dir,
"species_trait_effect_matrix.csv"
),

row.names=FALSE

)



############################################################
# PREPARE MATRIX FOR PHEATMAP
############################################################


rownames(heatmap_data) <- heatmap_data$feature


heatmap_matrix <- heatmap_data %>%

select(
-feature
) %>%

as.matrix()



############################################################
# GENERATE HEATMAP
############################################################


pdf(

file.path(
figure_dir,
"Figure3_species_trait_heatmap.pdf"
),

width=10,

height=14

)



pheatmap(

heatmap_matrix,

cluster_rows=TRUE,

cluster_cols=TRUE,

scale="none",

border_color=NA,

fontsize_row=7,

fontsize_col=10,

main=
"Microbial Species Associations Across Metabolic Traits"

)



dev.off()



############################################################
# SAVE OBJECT
############################################################


save(

heatmap_matrix,

file=file.path(
project_dir,
"results/R_objects/species_trait_heatmap.RData"
)

)



cat("\n===== SPECIES TRAIT HEATMAP COMPLETE =====\n")

cat(
"Heatmap saved: Figure3_species_trait_heatmap.pdf\n"
)
