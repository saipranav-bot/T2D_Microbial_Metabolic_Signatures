library(curatedMetagenomicData)
library(SummarizedExperiment)

cat("Loading MetaCardis pathway abundance only...\n")

meta <- curatedMetagenomicData(
    "2022-10-19.MetaCardis_2020_a.pathway_abundance",
    dryrun = FALSE
)

cat("Dataset loaded\n")

se <- meta[[1]]

print(se)

dir.create("results", showWarnings = FALSE)

metadata <- as.data.frame(colData(se))
pathway_matrix <- assay(se)

write.csv(
    metadata,
    "results/metacardis_metadata.csv"
)

write.csv(
    pathway_matrix,
    "results/metacardis_pathway_abundance.csv"
)

cat("\nSaved successfully\n")
