#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(tidyr)
library(igraph)
library(ggraph)


# =====================================================
# Output directory
# =====================================================

outdir <- "figures/Figure5_Species_Network"

dir.create(
  outdir,
  recursive = TRUE,
  showWarnings = FALSE
)



# =====================================================
# Publication theme
# =====================================================

pub_theme <- function(){

theme_classic(base_size = 10) +

theme(

text = element_text(
family="sans"
),

plot.title = element_text(
size=12,
face="bold",
hjust=0.5
),

axis.text = element_text(
size=8,
color="black"
),

axis.title = element_text(
size=10,
face="bold"
),

legend.text = element_text(
size=8
),

legend.title = element_text(
size=9
),

plot.background = element_rect(
fill="white",
color=NA
)

)

}



# =====================================================
# Load data
# =====================================================


ranked <- read.csv(
"results/ranked_metabolic_signatures.csv",
check.names=FALSE
)


species <- read.csv(
"results/microbial_species_contributors.csv",
check.names=FALSE
)




# =====================================================
# PANEL A
# =====================================================


top_pathways <- ranked %>%

filter(
!grepl(
"UNINTEGRATED",
pathway,
ignore.case=TRUE
)
) %>%

arrange(FDR) %>%

slice_head(n=15)



top_pathways <- top_pathways %>%

mutate(

short_pathway =
gsub(
"_",
" ",
substr(pathway,1,55)
),

short_pathway =
factor(
short_pathway,
levels=rev(short_pathway)
)

)



p1 <- ggplot(

top_pathways,

aes(

x=short_pathway,

y=log2FC,

fill=direction

)

)+

geom_col(
width=0.75
)+

coord_flip()+

labs(

title="Top T2D-associated metabolic pathways",

x=NULL,

y="log2 Fold Change",

fill=NULL

)+

pub_theme()



ggsave(

paste0(outdir,"/Fig5A_pathways.pdf"),

p1,

width=8,

height=6,

device=cairo_pdf,

bg="white"

)



ggsave(

paste0(outdir,"/Fig5A_pathways.png"),

p1,

width=8,

height=6,

dpi=600,

bg="white"

)




# =====================================================
# PANEL B
# =====================================================


top_species <- species %>%

separate(

species,

into=c(
"genus",
"species_name"
),

sep="\\.s__",

fill="right"

)%>%

mutate(

species_name=
ifelse(
is.na(species_name),
genus,
species_name
)

)%>%

group_by(species_name)%>%

summarise(

meanFC =
mean(log2FC,na.rm=TRUE),

pathways=n()

)%>%

arrange(desc(meanFC))%>%

slice_head(n=15)



top_species$species_name <-

factor(

top_species$species_name,

levels=rev(top_species$species_name)

)



p2 <- ggplot(

top_species,

aes(

x=species_name,

y=meanFC

)

)+


geom_col(

width=0.75,

fill="#4C78A8"

)+


coord_flip()+


labs(

title="Microbial species contributing to T2D signatures",

x=NULL,

y="Mean log2 Fold Change"

)+


pub_theme()



ggsave(

paste0(outdir,"/Fig5B_species.pdf"),

p2,

width=8,

height=6,

device=cairo_pdf,

bg="white"

)



ggsave(

paste0(outdir,"/Fig5B_species.png"),

p2,

width=8,

height=6,

dpi=600,

bg="white"

)




# =====================================================
# PANEL C NETWORK
# =====================================================


network <- species %>%

filter(

FDR < 0.05

)%>%

arrange(FDR)%>%

slice_head(n=60)%>%

select(

species,

pathway

)



nodes <- data.frame(

name =
unique(
c(
network$species,
network$pathway
)

)

)



nodes$type <- ifelse(

nodes$name %in% network$species,

"Species",

"Pathway"

)



g <- graph_from_data_frame(

network,

vertices=nodes,

directed=FALSE

)




network_plot <- ggraph(

g,

layout="fr"

)+


geom_edge_link(

alpha=0.25,

linewidth=0.5

)+


geom_node_point(

aes(color=type),

size=5

)+


geom_node_text(

aes(label=name),

size=2.2,

repel=TRUE,

max.overlaps=Inf

)+


scale_color_manual(

values=c(

Species="#1B9E77",

Pathway="#D95F02"

)

)+


theme_void()+


theme(

legend.position="bottom",

plot.background = element_rect(

fill="white",

color=NA

),

panel.background = element_rect(

fill="white",

color=NA

)

)+


ggtitle(

"Microbial species-metabolic pathway network"

)




ggsave(

paste0(outdir,"/Fig5C_network.pdf"),

network_plot,

width=10,

height=8,

device=cairo_pdf,

bg="white"

)



ggsave(

paste0(outdir,"/Fig5C_network.png"),

network_plot,

width=10,

height=8,

dpi=600,

bg="white"

)



cat(
"\nFigure 5 completed successfully\n"
)
