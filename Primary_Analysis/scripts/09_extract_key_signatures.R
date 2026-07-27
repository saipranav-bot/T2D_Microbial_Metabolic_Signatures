#############################################################
# 09_extract_key_signatures.R
# Extract biologically relevant T2D metabolic signatures
#
# Input:
#   ranked_metabolic_signatures.csv
#
# Output:
#   key_T2D_metabolic_signatures.csv
#############################################################

library(dplyr)


cat("\n=====================================\n")
cat("Extracting key metabolic signatures\n")
cat("=====================================\n\n")


#############################################################
# Load ranked pathways
#############################################################

results <- read.csv(
    "results/ranked_metabolic_signatures.csv",
    stringsAsFactors = FALSE
)


cat("Total ranked pathways:", nrow(results), "\n\n")


#############################################################
# Remove non-informative categories
#############################################################

key <- results %>%
    filter(
        !category %in% c(
            "Other",
            NA
        )
    )


cat("Non-Other pathways:", nrow(key), "\n\n")


#############################################################
# Rank pathways
#############################################################

key <- key %>%
    arrange(
        category,
        desc(abs(log2FC)),
        FDR
    )


#############################################################
# Add importance score
#############################################################

key <- key %>%
    mutate(
        importance_score =
            abs(log2FC) * (-log10(FDR))
    ) %>%
    arrange(
        desc(importance_score)
    )


#############################################################
# Save complete key signature table
#############################################################

write.csv(
    key,
    "results/key_T2D_metabolic_signatures.csv",
    row.names = FALSE
)



#############################################################
# Save top 50 signatures
#############################################################

top50 <- key %>%
    head(50)


write.csv(
    top50,
    "results/top50_T2D_metabolic_signatures.csv",
    row.names = FALSE
)



#############################################################
# Summary
#############################################################

cat("=====================================\n")
cat("Key signature extraction completed\n")
cat("=====================================\n\n")


cat(
    "Key pathways extracted:",
    nrow(key),
    "\n\n"
)


cat("Category distribution:\n")
print(table(key$category))


cat("\nDirection distribution:\n")
print(table(key$direction))


cat("\nTop 20 pathways:\n")


print(
    key %>%
        select(
            pathway,
            category,
            direction,
            log2FC,
            FDR,
            importance_score
        ) %>%
        head(20)
)
