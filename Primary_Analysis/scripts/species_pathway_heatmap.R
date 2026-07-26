library(dplyr)
library(tidyr)
library(pheatmap)

# Read correlations
cor <- read.csv(
  "results/species_pathway_correlations_significant.csv"
)

# Keep strongest correlations
cor <- cor %>%
  arrange(desc(abs(rho))) %>%
  slice(1:200)

# Convert to matrix
mat <- cor %>%
  select(Species, Pathway, rho) %>%
  pivot_wider(
    names_from = Pathway,
    values_from = rho,
    values_fill = 0
  )

rownames(mat) <- mat$Species
mat$Species <- NULL

mat <- as.matrix(mat)

pdf(
  "results/species_pathway_heatmap.pdf",
  width = 12,
  height = 8
)

pheatmap(
  mat,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_colnames = FALSE,
  fontsize_row = 8,
  color = colorRampPalette(
    c("blue","white","red")
  )(100)
)

dev.off()
