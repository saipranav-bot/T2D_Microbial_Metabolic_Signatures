#!/usr/bin/env Rscript

library(dplyr)
library(ggplot2)
library(stringr)
library(ggrepel)


cat("\n=====================================\n")
cat("Figure 5: Indexed Species Pathway Network\n")
cat("=====================================\n")


outdir <- "corrected/figures/Figure5_Species_Network"

dir.create(
    outdir,
    recursive = TRUE,
    showWarnings = FALSE
)


# Load data

data <- read.csv(
    "corrected/results/microbial_species_contributors.csv",
    check.names = FALSE
)



# Top species

top_species <- data %>%
    group_by(species) %>%
    summarise(
        score=max(importance_score),
        .groups="drop"
    ) %>%
    arrange(desc(score)) %>%
    slice_head(n=10) %>%
    pull(species)



# Top pathways

top_pathways <- data %>%
    group_by(pathway) %>%
    summarise(
        score=max(importance_score),
        .groups="drop"
    ) %>%
    arrange(desc(score)) %>%
    slice_head(n=5) %>%
    pull(pathway)



plot_data <- data %>%
    filter(
        species %in% top_species,
        pathway %in% top_pathways
    )



# Clean names

plot_data <- plot_data %>%
    mutate(

        species_label =
            str_replace(species,".*__",""),

        pathway_label =
            str_replace(pathway,".*: ",""),

        pathway_label =
            str_wrap(pathway_label, width=28),

        species_label =
            str_wrap(species_label, width=20)

    )



# Positions

species_df <- data.frame(
    label=unique(plot_data$species_label)
)

species_df$x <- 1
species_df$y <- seq(
    length(species_df$label),
    1
)



pathway_df <- data.frame(
    label=unique(plot_data$pathway_label)
)

pathway_df$x <- 4
pathway_df$y <- seq(
    length(pathway_df$label),
    1
)



# Edges

edges <- plot_data %>%
    select(
        species_label,
        pathway_label,
        importance_score
    ) %>%
    left_join(
        species_df,
        by=c("species_label"="label")
    ) %>%
    rename(
        x1=x,
        y1=y
    ) %>%
    left_join(
        pathway_df,
        by=c("pathway_label"="label")
    ) %>%
    rename(
        x2=x,
        y2=y
    )



# Plot

p <- ggplot()



p <- p +
geom_curve(
    data=edges,
    aes(
        x=x1,
        y=y1,
        xend=x2,
        yend=y2,
        linewidth=importance_score
    ),
    curvature=0.15,
    alpha=0.35
)



p <- p +
geom_point(
    data=species_df,
    aes(x,y),
    size=9,
    color="#1b9e77"
)



p <- p +
geom_point(
    data=pathway_df,
    aes(x,y),
    size=9,
    color="#d95f02"
)



p <- p +
geom_text(
    data=species_df,
    aes(
        x=x-0.15,
        y=y,
        label=label
    ),
    hjust=1,
    size=3.8
)



p <- p +
geom_text(
    data=pathway_df,
    aes(
        x=x+0.15,
        y=y,
        label=label
    ),
    hjust=0,
    size=3.8
)



p <- p +

scale_linewidth(
    range=c(0.2,1.2)
) +

coord_cartesian(
    xlim=c(-1,6),
    ylim=c(0,12),
    clip="off"
) +

labs(
    title="Microbial Species Driving T2D-Associated Metabolic Pathways",
    linewidth="Importance"
) +

theme_void() +

theme(

plot.title =
element_text(
size=16,
face="bold",
hjust=0.5
),

plot.margin =
margin(
30,80,30,80
)

)



# Save

ggsave(
file.path(
outdir,
"Figure5_indexed_species_pathway_network.png"
),
p,
width=14,
height=10,
dpi=600,
bg="white"
)


ggsave(
file.path(
outdir,
"Figure5_indexed_species_pathway_network.pdf"
),
p,
width=14,
height=10
)


cat("\n=====================================\n")
cat("Figure 5 completed\n")
cat("Species:",length(top_species),"\n")
cat("Pathways:",length(top_pathways),"\n")
cat("=====================================\n")
