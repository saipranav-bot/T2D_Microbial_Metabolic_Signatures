#################################################
# 06_differential_pathways.R
# T2D vs Control microbial pathway analysis
#################################################

library(dplyr)


cat("Loading data...\n")


pathways <- read.csv(
    "results/metacardis_filtered_pathways.csv",
    row.names = 1,
    check.names = FALSE
)


metadata <- read.csv(
    "results/metacardis_analysis_metadata.csv",
    row.names = 1
)


group <- metadata$study_condition


cat("\nGroups:\n")
print(table(group))


#################################################
# Differential testing
#################################################

results <- data.frame(
    pathway = rownames(pathways),
    log2FC = NA,
    pvalue = NA
)


for(i in seq_len(nrow(pathways))){

    values <- as.numeric(pathways[i, ])

    t2d_values <- values[group == "T2D"]
    control_values <- values[group == "control"]


    # log2 fold change

    results$log2FC[i] <-
        log2(
            (mean(t2d_values)+1e-6) /
            (mean(control_values)+1e-6)
        )


    # Wilcoxon test

    results$pvalue[i] <-
        wilcox.test(
            t2d_values,
            control_values
        )$p.value
}


#################################################
# Multiple testing correction
#################################################

results$FDR <- p.adjust(
    results$pvalue,
    method = "BH"
)


results <- results %>%
    arrange(FDR)


write.csv(
    results,
    "results/metacardis_differential_pathways.csv",
    row.names = FALSE
)


cat("\nTop significant pathways:\n")

print(
    head(results,20)
)


cat("\nSaved differential results\n")
