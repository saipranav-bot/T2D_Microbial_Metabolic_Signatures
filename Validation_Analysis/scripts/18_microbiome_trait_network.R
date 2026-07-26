############################################################
# 18_microbiome_trait_network.R
# Figure 5: Microbiome–Metabolic Trait Association Network
############################################################


library(dplyr)
library(igraph)
library(ggraph)
library(ggplot2)



############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
project_dir,
"results/Tables"
)


figure_dir <- file.path(
project_dir,
"results/Figures"
)


object_dir <- file.path(
project_dir,
"results/R_objects"
)



############################################################
# LOAD DATA
############################################################


combined_results <- read.csv(

file.path(
table_dir,
"Table2_all_microbiome_associations.csv"
)

)



############################################################
# CREATE EDGES
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
# CREATE NODES
############################################################


species_nodes <- combined_results %>%

select(feature) %>%

distinct() %>%

rename(

id = feature,

label = feature

) %>%

mutate(

type="Species"

)



trait_nodes <- combined_results %>%

select(clinical_trait) %>%

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
# NODE CONNECTIVITY
############################################################


temp_graph <- graph_from_data_frame(

network_edges,

vertices = network_nodes,

directed = FALSE

)



node_degree <- data.frame(

id = V(temp_graph)$name,

connectivity = degree(temp_graph)

)



network_nodes <- network_nodes %>%

left_join(

node_degree,

by="id"

)



############################################################
# FINAL GRAPH
############################################################


g <- graph_from_data_frame(

network_edges,

vertices = network_nodes,

directed = FALSE

)



############################################################
# SAVE NETWORK FILES
############################################################


write.csv(

network_edges,

file.path(

table_dir,

"Cytoscape_network_edges.csv"

),

row.names=FALSE

)


write.csv(

network_nodes,

file.path(

table_dir,

"Cytoscape_network_nodes.csv"

),

row.names=FALSE

)



############################################################
# PLOT NETWORK
############################################################


pdf(

file.path(

figure_dir,

"Figure5_microbiome_trait_network.pdf"

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

size=connectivity

)

)+


geom_node_text(

aes(

label = ifelse(

type=="Metabolic_trait" |

connectivity >=5,

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

title="Microbiome–Metabolic Trait Association Network",

color="Node Type",

edge_color="Association",

size="Connectivity"

)



dev.off()



############################################################
# SAVE OBJECT
############################################################


save(

g,

network_edges,

network_nodes,

file=file.path(

object_dir,

"microbiome_trait_network.RData"

)

)



cat("\n===== NETWORK FIGURE COMPLETE =====\n")
