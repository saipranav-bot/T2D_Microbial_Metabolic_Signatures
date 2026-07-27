#############################################################
# 06_differential_pathways.R
# Differential pathway analysis:
# MetaCardis T2D vs Control
#
# Input:
#   metacardis_filtered_pathways.csv
#   metacardis_analysis_metadata.csv
#
# Output:
#   metacardis_differential_pathways.csv
#############################################################


library(dplyr)


cat("\n=====================================\n")
cat("Differential pathway analysis\n")
cat("T2D vs Control\n")
cat("=====================================\n\n")


#############################################################
# Load pathway abundance
#############################################################

pathway_data <- read.csv(
    "results/metacardis_filtered_pathways.csv",
    row.names = 1,
    check.names = FALSE
)


#############################################################
# Load metadata
#############################################################

metadata <- read.csv(
    "results/metacardis_analysis_metadata.csv",
    row.names = 1,
    check.names = FALSE
)


cat("Pathways loaded:", nrow(pathway_data), "\n")
cat("Samples loaded:", ncol(pathway_data), "\n\n")


#############################################################
# Match samples
#############################################################

common_samples <- intersect(
    colnames(pathway_data),
    rownames(metadata)
)


pathway_data <- pathway_data[, common_samples]

metadata <- metadata[common_samples, ]


cat("Matched samples:", length(common_samples), "\n\n")


#############################################################
# Define groups
#############################################################

group <- metadata$study_condition


print(table(group))


if(!all(c("T2D","control") %in% unique(group))){
    stop("T2D and control groups not found")
}



#############################################################
# Differential analysis
#############################################################

results <- data.frame(
    pathway = rownames(pathway_data),
    control_mean = NA,
    T2D_mean = NA,
    log2FC = NA,
    p_value = NA
)


for(i in seq_len(nrow(pathway_data))){


    values <- as.numeric(pathway_data[i, ])


    control_values <- values[group == "control"]

    t2d_values <- values[group == "T2D"]


    control_mean <- mean(
        control_values,
        na.rm = TRUE
    )


    t2d_mean <- mean(
        t2d_values,
        na.rm = TRUE
    )


    results$control_mean[i] <- control_mean

    results$T2D_mean[i] <- t2d_mean


    # pseudo-count avoids log(0)

    results$log2FC[i] <-
        log2(
            (t2d_mean + 1e-10) /
            (control_mean + 1e-10)
        )


    test <- wilcox.test(
        t2d_values,
        control_values,
        exact = FALSE
    )


    results$p_value[i] <- test$p.value

}



#############################################################
# Multiple testing correction
#############################################################

results$FDR <- p.adjust(
    results$p_value,
    method = "BH"
)



#############################################################
# Sort by significance
#############################################################

results <- results %>%
    arrange(FDR)



#############################################################
# Save results
#############################################################

write.csv(
    results,
    "results/metacardis_differential_pathways.csv",
    row.names = FALSE
)



#############################################################
# Save significant pathways
#############################################################

significant <- results %>%
    filter(FDR < 0.05)


write.csv(
    significant,
    "results/metacardis_significant_pathways.csv",
    row.names = FALSE
)



#############################################################
# Summary
#############################################################

cat("\n=====================================\n")
cat("Analysis completed\n")
cat("=====================================\n\n")


cat(
    "Total pathways tested:",
    nrow(results),
    "\n"
)


cat(
    "Significant pathways (FDR <0.05):",
    nrow(significant),
    "\n\n"
)


cat("Top pathways:\n")

print(
    head(results,10)
)
