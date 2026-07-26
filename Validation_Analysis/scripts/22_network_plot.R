############################################################
# 22_network_plot.R
# Microbiome–Metabolic Trait Network Visualization
# Visualization only
############################################################


library(dplyr)
library(igraph)
library(ggraph)
library(ggplot2)



############################################################
# PATHS
############################################################


base_dir <- "HMP2_T2D_Publication_Results"

figure_dir <- paste0(
base_dir,
"/Figures"
)



############################################################
# LOAD RESULTS
############################################################


load(
"HMP2_FINAL_MAASLIN2_RESULTS.RData"
)



############################################################
# CREATE NETWORK EDGES
############################################################


network_edges <- combined_results %>%

mutate(

from = feature,

to = clinical_trait,

direction = ifelse(
coef > 0,
"Positive",
"Negative"
),

weight = abs(coef)

) %>%

select(
from,
to,
coef,
qval,
direction,
weight
)



############################################################
# CREATE NETWORK NODES
############################################################


species_nodes <- combined_results %>%

select(
feature
) %>%

distinct() %>%

rename(
id = feature,
label = feature
) %>%

mutate(
type="Species"
)



trait_nodes <- combined_results %>%

select(
clinical_trait
) %>%

distinct() %>%

rename(
id = clinical_trait,
label = clinical_trait
) %>%

mutate(
type="Metabolic_trait"
)



network_nodes <- bind_rows(
species_nodes,
trait_nodes
)



############################################################
# DEGREE CALCULATION
############################################################


temp_graph <- graph_from_data_frame(
network_edges,
vertices = network_nodes,
directed = FALSE
)



degree_table <- data.frame(

id = V(temp_graph)$name,

degree = degree(temp_graph)

)



network_nodes <- network_nodes %>%

left_join(
degree_table,
by="id"
)



############################################################
# CREATE GRAPH
############################################################


g <- graph_from_data_frame(

network_edges,

vertices = network_nodes,

directed = FALSE

)



############################################################
# SAVE NETWORK FIGURE
############################################################


pdf(

paste0(
figure_dir,
"/Figure5_microbiome_trait_network.pdf"
),

width=14,

height=12

)



ggraph(
g,
layout="fr"
)+


geom_edge_link(

aes(
color=direction,
width=weight
),

alpha=0.5

)+



scale_edge_color_manual(

values=c(
Positive="firebrick",
Negative="steelblue"
)

)+



geom_node_point(

aes(
color=type,
size=degree
)

)+



geom_node_text(

aes(
label=
ifelse(
type=="Metabolic_trait" |
degree>=5,
label,
""
)
),

size=4,

fontface="bold",

repel=TRUE

)+



scale_color_manual(

values=c(
Species="darkgreen",
Metabolic_trait="orange"
)

)+



scale_size_continuous(

range=c(3,10)

)+



theme_void()+



labs(

title=
"Microbiome–Metabolic Trait Association Network",

color="Node type",

edge_color="Association",

size="Connectivity"

)



dev.off()



cat(
"Figure5 network completed\n"
)
