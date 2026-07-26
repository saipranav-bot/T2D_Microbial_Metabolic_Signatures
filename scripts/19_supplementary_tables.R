library(dplyr)
library(openxlsx)


dir.create(
"results/supplementary",
recursive=TRUE,
showWarnings=FALSE
)


# ----------------------------
# Supplementary Table S1
# ----------------------------

diff <- read.csv(
"results/metacardis_differential_pathways.csv",
check.names=FALSE
)


diff <- diff %>%
arrange(FDR)


write.xlsx(
diff,
"results/supplementary/Supplementary_Table_S1_Differential_Pathways.xlsx",
rowNames=FALSE
)



# ----------------------------
# Supplementary Table S2
# ----------------------------

species <- read.csv(
"results/microbial_species_contributors.csv",
check.names=FALSE
)


species <- species %>%
arrange(FDR)


write.xlsx(
species,
"results/supplementary/Supplementary_Table_S2_Microbial_Contributors.xlsx",
rowNames=FALSE
)



# ----------------------------
# Summary
# ----------------------------

cat(
"Supplementary tables generated successfully\n"
)

cat(
"Table S1:",
nrow(diff),
"pathways\n"
)

cat(
"Table S2:",
nrow(species),
"species-pathway associations\n"
)
