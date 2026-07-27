#################################################
# 04_extract_t2d_control.R
# Extract MetaCardis Healthy vs T2D cohort
#################################################

library(dplyr)

# Load metadata
metadata <- read.csv(
    "results/metacardis_metadata.csv",
    row.names = 1
)

# Select true healthy and T2D samples
meta_healthy_t2d <- metadata %>%
    filter(
        disease %in% c("healthy", "T2D")
    )


cat("Samples selected:\n")
print(table(meta_healthy_t2d$disease))


# Save corrected metadata

write.csv(
    meta_healthy_t2d,
    "results/metacardis_healthy_T2D_metadata.csv"
)


# Extract sample IDs

samples <- rownames(meta_healthy_t2d)


write.table(
    samples,
    "results/metacardis_healthy_T2D_samples.txt",
    row.names = FALSE,
    col.names = FALSE,
    quote = FALSE
)


cat("\nSaved Healthy vs T2D cohort\n")
