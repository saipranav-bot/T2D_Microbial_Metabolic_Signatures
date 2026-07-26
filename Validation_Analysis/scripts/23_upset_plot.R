############################################################
# 23_upset_plot.R
# Species overlap across metabolic traits
# Visualization only
############################################################


library(dplyr)
library(tidyr)
library(UpSetR)



############################################################
# PATHS
############################################################


base_dir <- "HMP2_T2D_Publication_Results"

figure_dir <- paste0(
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
# CREATE OVERLAP MATRIX
############################################################


overlap_matrix <- combined_results %>%

select(
feature,
clinical_trait
) %>%

mutate(
presence = 1
) %>%

pivot_wider(
names_from = clinical_trait,
values_from = presence,
values_fill = 0
)



############################################################
# PREPARE UPSET INPUT
############################################################


upset_data <- overlap_matrix %>%

select(
-HbA1c
)


rownames(upset_data) <- overlap_matrix$feature


upset_data <- as.data.frame(
upset_data
)



############################################################
# SAVE FIGURE
############################################################


pdf(

paste0(
figure_dir,
"/Figure6_species_trait_upset_plot.pdf"
),

width=10,

height=6

)



upset(

upset_data,

sets=c(
"HbA1c",
"Glucose",
"Triglycerides",
"HDL",
"LDL"
),

order.by="freq",

main.bar.color="black",

sets.bar.color="darkblue",

text.scale=1.3

)



dev.off()



cat(
"Figure6 UpSet plot completed\n"
)
