library(igraph)
library(ggraph)
library(tidygraph)
library(dplyr)
library(ggplot2)

edges <- read.csv("results/final_network_annotated.csv")

# Top 10 species
top_species <- edges %>%
  count(Species, sort=TRUE) %>%
  head(10) %>%
  pull(Species)

# Top 15 pathways
top_pathways <- edges %>%
  count(Pathway_clean, sort=TRUE) %>%
  head(15) %>%
  pull(Pathway_clean)

# Filter edges
hub_edges <- edges %>%
  filter(
    Species %in% top_species,
    Pathway_clean %in% top_pathways
  )

# Nodes
nodes <- data.frame(
  name=c(
    unique(hub_edges$Species),
    unique(hub_edges$Pathway_clean)
  ),
  type=c(
    rep("Species", length(unique(hub_edges$Species))),
    rep("Pathway", length(unique(hub_edges$Pathway_clean)))
  )
)

# Graph
g <- tbl_graph(
  nodes=nodes,
  edges=data.frame(
    from=hub_edges$Species,
    to=hub_edges$Pathway_clean,
    rho=hub_edges$rho
  ),
  directed=FALSE
)

pdf(
"results/T2D_top_hub_network.pdf",
width=12,
height=10
)

ggraph(g, layout="fr") +

geom_edge_link(
aes(width=rho),
alpha=0.5
) +

geom_node_point(
aes(size=centrality_degree(),
color=type)
) +

geom_node_text(
aes(label=name),
size=3,
repel=TRUE
) +

scale_edge_width(range=c(0.3,2)) +

theme_void()

dev.off()
