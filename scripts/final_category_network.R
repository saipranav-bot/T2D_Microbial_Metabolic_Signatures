library(igraph)
library(ggraph)
library(tidygraph)
library(dplyr)
library(ggplot2)

edges <- read.csv("results/final_network_annotated.csv")

# create nodes
species_nodes <- data.frame(
  name = unique(edges$Species),
  type = "Species"
)

pathway_nodes <- data.frame(
  name = unique(edges$Pathway_clean),
  type = "Pathway"
)

nodes <- rbind(species_nodes, pathway_nodes)

# edge table
edges2 <- edges %>%
  select(Species, Pathway_clean, rho, Category)

colnames(edges2) <- c("from","to","rho","Category")

# graph
g <- tbl_graph(
  nodes = nodes,
  edges = edges2,
  directed = FALSE
)

# plot

pdf(
"results/T2D_category_bipartite_network.pdf",
width=12,
height=10
)

ggraph(g, layout="fr") +

geom_edge_link(
aes(width=rho),
alpha=0.4
) +

geom_node_point(
aes(
color=type,
size=centrality_degree()
)
) +

geom_node_text(
aes(label=name),
size=2.5,
repel=TRUE
) +

scale_edge_width(range=c(0.2,2)) +

theme_void()

dev.off()
