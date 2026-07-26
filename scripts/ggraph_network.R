library(igraph)
library(ggraph)
library(tidygraph)
library(ggplot2)
library(dplyr)

edges <- read.csv(
  "results/network_edges_filtered.csv",
  stringsAsFactors = FALSE
)

# create graph
g <- graph_from_data_frame(
  edges,
  directed = FALSE
)

# calculate degree
V(g)$degree <- degree(g)

# classify nodes
V(g)$type <- ifelse(
  grepl("PWY|GLY|VAL|FAO|TCA|BIOSYN|METAB", V(g)$name),
  "Pathway",
  "Species"
)

# convert
net <- as_tbl_graph(g)

pdf(
"results/T2D_species_pathway_network.pdf",
width=12,
height=10
)

ggraph(net, layout="fr") +
  geom_edge_link(
    aes(width=abs(rho)),
    alpha=0.4
  ) +
  geom_node_point(
    aes(
      size=degree,
      color=type
    )
  ) +
  geom_node_text(
    aes(label=name),
    repel=TRUE,
    size=3
  ) +
  theme_void()

dev.off()
