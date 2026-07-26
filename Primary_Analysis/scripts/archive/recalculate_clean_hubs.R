library(igraph)
library(dplyr)

edges <- read.csv(
"results/network_edges_clean_pathways.csv",
stringsAsFactors=FALSE
)

# Create network using cleaned pathways
g <- graph_from_data_frame(
edges[,c("Species","Pathway_clean")],
directed=FALSE
)

degree_table <- data.frame(
Node=names(degree(g)),
Degree=degree(g)
)

# Separate species and pathways

species <- degree_table %>%
filter(grepl("UNINTEGRATED", Node)) %>%
arrange(desc(Degree))


pathways <- degree_table %>%
filter(!grepl("UNINTEGRATED", Node)) %>%
arrange(desc(Degree))


write.csv(
species,
"results/clean_species_hubs.csv",
row.names=FALSE
)

write.csv(
pathways,
"results/clean_pathway_hubs.csv",
row.names=FALSE
)
