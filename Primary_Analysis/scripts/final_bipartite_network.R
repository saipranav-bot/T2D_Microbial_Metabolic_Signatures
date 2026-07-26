library(igraph)
library(ggraph)
library(tidygraph)
library(ggplot2)
library(dplyr)

edges <- read.csv(
"results/network_edges_clean_pathways.csv",
stringsAsFactors=FALSE
)

# Keep top species and pathways
species_deg <- read.csv("results/clean_species_hubs.csv")
pathway_deg <- read.csv("results/clean_pathway_hubs.csv")

top_species <- head(species_deg$Node,15)
top_pathways <- head(pathway_deg$Node,15)

# Filter network
edges2 <- edges %>%
filter(
Species %in% top_species &
Pathway_clean %in% top_pathways
)

# Graph
g <- graph_from_data_frame(
edges2[,c("Species","Pathway_clean")],
directed=FALSE
)

V(g)$degree <- degree(g)

V(g)$type <- ifelse(
grepl("UNINTEGRATED", V(g)$name),
"Species",
"Pathway"
)

net <- as_tbl_graph(g)

pdf(
"results/T2D_final_bipartite_network.pdf",
width=12,
height=10
)

ggraph(net, layout="fr") +
geom_edge_link(alpha=0.4) +
geom_node_point(
aes(size=degree, color=type)
) +
geom_node_text(
aes(label=name),
repel=TRUE,
size=3
) +
theme_void()

dev.off()
