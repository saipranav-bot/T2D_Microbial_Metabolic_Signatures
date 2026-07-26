library(dplyr)
library(openxlsx)


dir.create(
"results/final_summary",
recursive=TRUE,
showWarnings=FALSE
)


# Differential pathways

diff <- read.csv(
"results/metacardis_differential_pathways.csv"
)


top20 <- diff %>%
filter(!grepl("UNINTEGRATED", pathway)) %>%
mutate(absFC=abs(log2FC)) %>%
arrange(FDR, desc(absFC)) %>%
slice_head(n=20)


write.xlsx(
top20,
"results/final_summary/Top20_T2D_Pathways.xlsx",
rowNames=FALSE
)



# Microbial drivers

species <- read.csv(
"results/microbial_species_contributors.csv"
)


drivers <- species %>%
group_by(species) %>%
summarise(
pathway_count=n(),
mean_log2FC=mean(log2FC),
min_FDR=min(FDR)
) %>%
arrange(desc(pathway_count))


write.xlsx(
drivers,
"results/final_summary/Microbial_Drivers.xlsx",
rowNames=FALSE
)


cat("Final summary tables completed\n")
