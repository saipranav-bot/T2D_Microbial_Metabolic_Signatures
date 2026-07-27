#############################################################
# 05_prepare_pathways.R
# Prepare MetaCardis pathway abundance matrix for T2D analysis
#
# Purpose:
#   - Extract T2D/control samples
#   - Match pathway abundance with metadata
#   - Remove species-stratified pathways
#   - Remove UNMAPPED/UNINTEGRATED features
#   - Keep only global MetaCyc pathways
#############################################################

library(dplyr)

cat("\n=====================================\n")
cat("Preparing MetaCardis pathway data\n")
cat("=====================================\n\n")


#############################################################
# Load metadata
#############################################################

metadata <- read.csv(
    "results/metacardis_T2D_control_metadata.csv",
    row.names = 1,
    check.names = FALSE
)

cat("Metadata samples:", nrow(metadata), "\n")


#############################################################
# Load pathway abundance matrix
#############################################################

pathway_data <- read.csv(
    "results/metacardis_pathway_abundance.csv",
    row.names = 1,
    check.names = FALSE
)


cat("Original pathway features:", nrow(pathway_data), "\n")
cat("Original samples:", ncol(pathway_data), "\n\n")


#############################################################
# Match samples
#############################################################

common_samples <- intersect(
    rownames(metadata),
    colnames(pathway_data)
)


cat("Common samples:", length(common_samples), "\n")


# Keep only selected samples

pathway_data <- pathway_data[, common_samples]

metadata <- metadata[common_samples, ]


#############################################################
# Filter global pathways only
#############################################################

cat("\nFiltering pathway features...\n")


# Remove species-level stratified pathways
# Example:
# PWY-6737|g__Bacteroides

pathway_data <- pathway_data[
    !grepl("\\|", rownames(pathway_data)),
]


# Remove unmapped/unintegrated

pathway_data <- pathway_data[
    !grepl(
        "UNMAPPED|UNINTEGRATED",
        rownames(pathway_data),
        ignore.case = TRUE
    ),
]


cat(
    "Remaining pathway features:",
    nrow(pathway_data),
    "\n"
)


#############################################################
# Remove very rare pathways
#############################################################

# Keep pathways present in at least 10% samples

prevalence <- rowSums(pathway_data > 0) /
              ncol(pathway_data)


pathway_data <- pathway_data[
    prevalence >= 0.10,
]


cat(
    "After prevalence filtering:",
    nrow(pathway_data),
    "pathways\n"
)


#############################################################
# Save filtered pathway matrix
#############################################################

write.csv(
    pathway_data,
    "results/metacardis_filtered_pathways.csv"
)


#############################################################
# Save analysis metadata
#############################################################

write.csv(
    metadata,
    "results/metacardis_analysis_metadata.csv"
)


#############################################################
# Save final sample list
#############################################################

write.table(
    colnames(pathway_data),
    "results/metacardis_analysis_samples.txt",
    row.names = FALSE,
    col.names = FALSE,
    quote = FALSE
)


#############################################################
# Summary
#############################################################

cat("\n=====================================\n")
cat("Preparation completed\n")
cat("=====================================\n")

cat(
    "Final samples:",
    ncol(pathway_data),
    "\n"
)

cat(
    "Final pathways:",
    nrow(pathway_data),
    "\n"
)


cat("\nGroup distribution:\n")
print(
    table(metadata$study_condition)
)
