library(igraph)
library(ggraph)
library(tidygraph)
library(ggplot2)
library(dplyr)

# Load network
edges <- read.csv(
  "results/network_edges_filtered.csv",
  stringsAsFactors = FALSE
)

# Build graph
g <- graph_from_data_frame(
  edges,
  directed = FALSE
)

# Calculate degree
deg <- degree(g)

# Keep top 50 nodes
top_nodes <- names(sort(deg, decreasing = TRUE))[1:50]

# Filter edges where both nodes are hubs
edges_hub <- edges %>%
  filter(
    Species %in% top_nodes &
    Pathway %in% top_nodes
  )

# Create hub graph
g_hub <- graph_from_data_frame(
  edges_hub,
  directed = FALSE
)

# Node information
V(g_hub)$degree <- degree(g_hub)

V(g_hub)$type <- ifelse(
  grepl("PWY|GLY|VAL|FAO|TCA|BIOSYN|METAB", V(g_hub)$name),
  "Pathway",
  "Species"
)

net <- as_tbl_graph(g_hub)

pdf(
"results/T2D_hub_network.pdf",
width=12,
height=10
)

ggraph(net, layout="fr") +
  geom_edge_link(
    aes(width=1),
    alpha=0.3
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
