#################################################
# 04_extract_t2d_control.R
# Extract MetaCardis Control vs T2D cohort
#################################################

library(dplyr)

# Load metadata
metadata <- read.csv(
    "results/metacardis_metadata.csv",
    row.names = 1
)

# The T2D-vs-control cohort is defined by the curated
# `study_condition` field ("control" vs "T2D"), which yields the
# 1192-sample cohort used by the downstream analysis and figures.
meta_control_t2d <- metadata %>%
    filter(
        study_condition %in% c("control", "T2D")
    )


cat("Samples selected:\n")
print(table(meta_control_t2d$study_condition))


# Save the cohort metadata under the filename used downstream

write.csv(
    meta_control_t2d,
    "results/metacardis_T2D_control_metadata.csv"
)


# Extract sample IDs

samples <- rownames(meta_control_t2d)


write.table(
    samples,
    "results/metacardis_T2D_control_samples.txt",
    row.names = FALSE,
    col.names = FALSE,
    quote = FALSE
)


cat("\nSaved Control vs T2D cohort\n")
