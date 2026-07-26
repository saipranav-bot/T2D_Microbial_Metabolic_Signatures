############################################################
# 16_species_trait_heatmap.R
# Figure 3: Species–Metabolic Trait Association Heatmap
############################################################


library(dplyr)
library(tidyr)
library(pheatmap)
library(readr)



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
# CREATE SPECIES TRAIT MATRIX
############################################################


heatmap_data <- combined_results %>%

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
# SET SPECIES AS ROW NAMES
############################################################


heatmap_matrix <- as.data.frame(
heatmap_data
)


rownames(heatmap_matrix) <- heatmap_matrix$feature


heatmap_matrix$feature <- NULL



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

as.matrix(heatmap_matrix),

cluster_rows=TRUE,

cluster_cols=TRUE,

scale="none",

border_color="grey",

main="Microbial Species Associations Across Metabolic Traits"

)



dev.off()



############################################################
# SAVE OBJECT
############################################################


save(

heatmap_matrix,

file=file.path(

object_dir,

"species_trait_heatmap.RData"

)

)



cat("\n===== FIGURE 3 COMPLETE =====\n")

cat(
"Saved Figure3_species_trait_heatmap.pdf\n"
)
