library(dplyr)

edges <- read.csv(
"results/network_edges_clean_pathways.csv",
stringsAsFactors=FALSE
)

species_deg <- read.csv(
"results/clean_species_hubs.csv"
)

pathway_deg <- read.csv(
"results/clean_pathway_hubs.csv"
)

top_species <- head(species_deg$Node,15)
top_pathways <- head(pathway_deg$Node,15)

final_edges <- edges %>%
filter(
Species %in% top_species &
Pathway_clean %in% top_pathways
) %>%
select(
Species,
Pathway_clean,
rho,
p,
FDR
) %>%
arrange(desc(abs(rho)))

write.csv(
final_edges,
"results/final_network_edges.csv",
row.names=FALSE
)

