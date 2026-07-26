############################################################
# 21_heatmap.R
# Species-trait association heatmap
# Visualization only
############################################################


library(dplyr)
library(tidyr)
library(pheatmap)


############################################################
# PATHS
############################################################

base_dir <- "HMP2_T2D_Publication_Results"

result_dir <- paste0(
base_dir,
"/Figures"
)


############################################################
# LOAD RESULTS
############################################################

load(
"HMP2_FINAL_MAASLIN2_RESULTS.RData"
)


############################################################
# PREPARE HEATMAP MATRIX
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



rownames(
heatmap_data
) <- heatmap_data$feature


heatmap_data <- heatmap_data %>%

select(
-feature
)



############################################################
# SAVE FIGURE
############################################################


pdf(
paste0(
result_dir,
"/Figure3_species_trait_heatmap.pdf"
),
width=10,
height=14
)



pheatmap(

as.matrix(heatmap_data),

cluster_rows = TRUE,

cluster_cols = TRUE,

scale = "none",

main =
"Microbial Species Association Across Metabolic Traits"

)



dev.off()



cat(
"Figure3 heatmap completed\n"
)
