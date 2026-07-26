library(dplyr)
library(ggplot2)
library(tidyr)
library(igraph)
library(ggraph)

dir.create("figures/Figure5_Species_Network",
           recursive = TRUE,
           showWarnings = FALSE)


# -------------------------------
# Load data
# -------------------------------

ranked <- read.csv(
"results/ranked_metabolic_signatures.csv",
check.names = FALSE
)

species <- read.csv(
"results/microbial_species_contributors.csv",
check.names = FALSE
)


# -------------------------------
# PANEL A
# Top metabolic pathways
# -------------------------------

top_pathways <- ranked %>%
  filter(!grepl("UNINTEGRATED", pathway)) %>%
  arrange(FDR) %>%
  slice_head(n=15)


top_pathways$short_pathway <-
  substr(top_pathways$pathway,1,45)


p1 <- ggplot(
  top_pathways,
  aes(
    x=reorder(short_pathway, log2FC),
    y=log2FC,
    fill=direction
  )
)+
geom_col()+
coord_flip()+
theme_bw()+
labs(
title="Top T2D-associated metabolic pathways",
x="Pathway",
y="log2 Fold Change"
)


ggsave(
"figures/Figure5_Species_Network/Fig5A_pathways.pdf",
p1,
width=8,
height=6
)



# -------------------------------
# PANEL B
# Species contributors
# -------------------------------

top_species <- species %>%
  separate(
    species,
    into=c("genus","species_name"),
    sep="\\.s__",
    fill="right"
  ) %>%
  mutate(
    species_name=
      ifelse(
        is.na(species_name),
        genus,
        species_name
      )
  ) %>%
  group_by(species_name) %>%
  summarise(
    meanFC=mean(log2FC),
    pathways=n()
  ) %>%
  arrange(desc(meanFC)) %>%
  slice_head(n=15)


p2 <- ggplot(
top_species,
aes(
x=reorder(species_name,meanFC),
y=meanFC
)
)+
geom_col()+
coord_flip()+
theme_bw()+
labs(
title="Microbial species contributing to T2D signatures",
x="Species",
y="Mean log2FC"
)


ggsave(
"figures/Figure5_Species_Network/Fig5B_species.pdf",
p2,
width=8,
height=6
)



# -------------------------------
# PANEL C
# Network
# -------------------------------

network <- species %>%
filter(FDR < 0.001) %>%
slice_head(n=40) %>%
select(species,pathway)


edges <- network

nodes <- data.frame(
name=c(edges$species,
       edges$pathway)
) %>%
distinct()


g <- graph_from_data_frame(
edges,
vertices=nodes,
directed=FALSE
)


pdf(
"figures/Figure5_Species_Network/Fig5C_network.pdf",
width=10,
height=8
)

ggraph(g, layout="fr")+
geom_edge_link(alpha=0.4)+
geom_node_point(size=3)+
geom_node_text(
aes(label=name),
size=3,
repel=TRUE
)+
theme_void()+
ggtitle(
"Microbial species–metabolic pathway network"
)

dev.off()


cat("Figure 5 completed successfully\n")
