library(igraph)
library(dplyr)

edges <- read.csv(
"results/network_edges_filtered.csv",
stringsAsFactors=FALSE
)

g <- graph_from_data_frame(edges, directed=FALSE)

degree_table <- data.frame(
Node=names(degree(g)),
Degree=degree(g)
)

# Species nodes
species <- degree_table %>%
filter(grepl("UNINTEGRATED", Node))

species <- species %>%
arrange(desc(Degree))

# Pathway nodes
pathways <- degree_table %>%
filter(!grepl("UNINTEGRATED", Node))

pathways <- pathways %>%
arrange(desc(Degree))

write.csv(
species,
"results/species_hubs.csv",
row.names=FALSE
)

write.csv(
pathways,
"results/pathway_hubs.csv",
row.names=FALSE
)
