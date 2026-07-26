library(dplyr)

edges <- read.csv(
"results/network_edges_filtered.csv",
stringsAsFactors=FALSE
)

# Remove species annotation from pathway names
edges$Pathway_clean <- gsub(
"\\.g__.*",
"",
edges$Pathway
)

# Replace dots with spaces
edges$Pathway_clean <- gsub(
"\\.",
" ",
edges$Pathway_clean
)

write.csv(
edges,
"results/network_edges_clean_pathways.csv",
row.names=FALSE
)
