library(dplyr)

results <- read.csv(
    "results/ranked_metabolic_signatures.csv"
)


key <- results %>%
    filter(
        category != "Other"
    ) %>%
    arrange(
        category,
        desc(abs(log2FC))
    )


write.csv(
    key,
    "results/key_T2D_metabolic_signatures.csv",
    row.names = FALSE
)


cat("Key pathways:\n")
print(
    key %>% select(
        pathway,
        category,
        direction,
        log2FC,
        FDR
    ) %>% head(50)
)
