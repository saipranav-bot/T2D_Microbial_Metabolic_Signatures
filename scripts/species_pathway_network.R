library(dplyr)

# Read significant correlations
cor <- read.csv(
  "results/species_pathway_correlations_significant.csv"
)

# Keep only strong correlations
network <- cor %>%
  filter(abs(rho) >= 0.70)

cat("Edges:", nrow(network), "\n")

write.csv(
  network,
  "results/network_edges.csv",
  row.names = FALSE
)

# Species degree
species_degree <- network %>%
  count(Species, name = "Degree") %>%
  arrange(desc(Degree))

write.csv(
  species_degree,
  "results/species_degree.csv",
  row.names = FALSE
)

# Pathway degree
pathway_degree <- network %>%
  count(Pathway, name = "Degree") %>%
  arrange(desc(Degree))

write.csv(
  pathway_degree,
  "results/pathway_degree.csv",
  row.names = FALSE
)

cat("Species hubs:", nrow(species_degree), "\n")
cat("Pathway hubs:", nrow(pathway_degree), "\n")
