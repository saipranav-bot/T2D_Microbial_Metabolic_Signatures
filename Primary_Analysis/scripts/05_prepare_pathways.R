#################################################
# 05_prepare_pathways.R
# Prepare pathway abundance for differential analysis
#################################################

library(dplyr)

cat("Loading data...\n")

# Load pathway abundance
pathways <- read.csv(
    "results/metacardis_pathway_abundance.csv",
    row.names = 1,
    check.names = FALSE
)

# Load selected metadata
metadata <- read.csv(
    "results/metacardis_T2D_control_metadata.csv",
    row.names = 1
)


cat("Original pathway matrix:\n")
print(dim(pathways))


# Keep only selected samples

common_samples <- intersect(
    colnames(pathways),
    rownames(metadata)
)


pathways <- pathways[, common_samples]

metadata <- metadata[common_samples, ]


cat("\nAfter sample matching:\n")
print(dim(pathways))


#################################################
# Remove low abundance pathways
#################################################

# Keep pathways present in at least 20% samples

prevalence <- rowMeans(pathways > 0)

pathways_filtered <- pathways[
    prevalence >= 0.20,
]


cat("\nAfter prevalence filtering:\n")
print(dim(pathways_filtered))


#################################################
# Save
#################################################

write.csv(
    pathways_filtered,
    "results/metacardis_filtered_pathways.csv"
)

write.csv(
    metadata,
    "results/metacardis_analysis_metadata.csv"
)


cat("\nSaved filtered pathway matrix\n")
