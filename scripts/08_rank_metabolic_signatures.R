library(dplyr)

results <- read.csv(
    "results/metabolic_pathway_annotation.csv"
)


results <- results %>%
    filter(FDR < 0.05)


results$direction <- ifelse(
    results$log2FC > 0,
    "T2D_enriched",
    "Control_enriched"
)


results <- results %>%
    arrange(desc(abs(log2FC)))


write.csv(
    results,
    "results/ranked_metabolic_signatures.csv",
    row.names = FALSE
)


cat("Significant pathways:\n")
print(nrow(results))


cat("\nDirection summary:\n")
print(table(results$direction))


cat("\nCategory summary:\n")
print(table(results$category))
