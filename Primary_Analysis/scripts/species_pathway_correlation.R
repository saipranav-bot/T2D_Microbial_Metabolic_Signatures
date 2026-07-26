library(Hmisc)
library(dplyr)

# Load normalized abundance matrix
mat <- read.delim(
  "results/maaslin2_T2D_control/features/filtered_data_norm_transformed.tsv",
  check.names = FALSE
)

rownames(mat) <- mat$feature
mat$feature <- NULL

# Load significant species
species <- read.csv("results/top_species.csv")$feature

# Load significant pathways
pathways <- read.csv("results/pathway_associations.csv")$feature

# Keep only features present
species <- intersect(species, colnames(mat))
pathways <- intersect(pathways, colnames(mat))

cat("Species:", length(species), "\n")
cat("Pathways:", length(pathways), "\n")

results <- data.frame()

for(sp in species){

  for(pw in pathways){

    tmp <- suppressWarnings(
      cor.test(
        mat[[sp]],
        mat[[pw]],
        method="spearman"
      )
    )

    results <- rbind(
      results,
      data.frame(
        Species=sp,
        Pathway=pw,
        rho=tmp$estimate,
        p=tmp$p.value
      )
    )
  }
}

results$FDR <- p.adjust(results$p,"BH")

write.csv(
  results,
  "results/species_pathway_correlations.csv",
  row.names=FALSE
)

sig <- subset(results,FDR<0.05)

write.csv(
  sig,
  "results/species_pathway_correlations_significant.csv",
  row.names=FALSE
)

cat("Total correlations:",nrow(results),"\n")
cat("Significant:",nrow(sig),"\n")
