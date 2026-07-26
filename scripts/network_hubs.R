library(igraph)
library(dplyr)

edges <- read.csv(
  "results/network_edges_filtered.csv",
  stringsAsFactors = FALSE
)

g <- graph_from_data_frame(
  edges,
  directed = FALSE
)

# Calculate node degree
degree_table <- data.frame(
  Node = names(degree(g)),
  Degree = degree(g)
)

# Sort highest degree
degree_table <- degree_table %>%
  arrange(desc(Degree))

write.csv(
  degree_table,
  "results/network_node_degree.csv",
  row.names = FALSE
)

# Top 25 hubs
write.csv(
  head(degree_table,25),
  "results/top25_network_hubs.csv",
  row.names = FALSE
)
