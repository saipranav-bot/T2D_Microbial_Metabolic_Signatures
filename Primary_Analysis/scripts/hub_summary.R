library(dplyr)

edges <- read.csv("results/final_network_annotated.csv")

# Species degree
species_summary <- edges %>%
  group_by(Species) %>%
  summarise(
    Connections = n(),
    Mean_rho = mean(rho),
    Categories = paste(unique(Category), collapse="; ")
  ) %>%
  arrange(desc(Connections))

write.csv(
  species_summary,
  "results/species_hub_summary.csv",
  row.names=FALSE
)


# Pathway degree
pathway_summary <- edges %>%
  group_by(Pathway_clean) %>%
  summarise(
    Connections = n(),
    Mean_rho = mean(rho),
    Category = paste(unique(Category), collapse="; ")
  ) %>%
  arrange(desc(Connections))

write.csv(
  pathway_summary,
  "results/pathway_hub_summary.csv",
  row.names=FALSE
)
