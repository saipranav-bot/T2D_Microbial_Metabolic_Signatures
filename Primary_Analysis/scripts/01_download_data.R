# =============================================================
# 01_download_data.R
# Retrieve the MetaCardis gut-metagenomic pathway-abundance dataset
# (curatedMetagenomicData) used throughout this analysis, and cache it
# locally so downstream scripts can run offline.
#
# Dataset: 2022-10-19.MetaCardis_2020_a.pathway_abundance
# (T2D / control faecal metagenomes)
# =============================================================

library(curatedMetagenomicData)
library(SummarizedExperiment)

cat("=====================================\n")
cat(" Downloading MetaCardis pathway data\n")
cat("=====================================\n\n")

dataset <- "2022-10-19.MetaCardis_2020_a.pathway_abundance"

res <- curatedMetagenomicData(dataset, dryrun = FALSE)

if (length(res) == 0) {
  stop("Dataset not available from curatedMetagenomicData: ", dataset)
}

se <- res[[1]]

cat("Dataset loaded:\n")
print(se)

dir.create("results", showWarnings = FALSE)

write.csv(
  as.data.frame(colData(se)),
  "results/metacardis_metadata.csv"
)

write.csv(
  assay(se),
  "results/metacardis_pathway_abundance.csv"
)

cat("\nSaved to results/:\n")
cat("  metacardis_metadata.csv\n")
cat("  metacardis_pathway_abundance.csv\n")
cat("\nNext: Rscript scripts/02_load_metacardis.R\n")
