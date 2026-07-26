#################################################
# 04_extract_t2d_control.R
# Extract MetaCardis T2D vs Control cohort
#################################################

library(dplyr)

metadata <- read.csv(
    "results/metacardis_metadata.csv",
    row.names = 1
)

# Select T2D and control only
meta_t2d <- metadata %>%
    filter(
        study_condition %in% c("T2D", "control")
    )


cat("Samples selected:\n")
print(table(meta_t2d$study_condition))


# Save selected metadata

write.csv(
    meta_t2d,
    "results/metacardis_T2D_control_metadata.csv"
)


# Extract sample IDs

samples <- rownames(meta_t2d)

write.table(
    samples,
    "results/metacardis_T2D_control_samples.txt",
    row.names = FALSE,
    col.names = FALSE,
    quote = FALSE
)


cat("\nSaved T2D-control cohort\n")
