#############################################################
# Figure 3: Volcano plot of metabolic pathways
#############################################################

library(ggplot2)
library(dplyr)
library(ggrepel)

cat("\n=====================================\n")
cat("Figure 3: Volcano plot\n")
cat("=====================================\n")


# Create output folder
dir.create(
    "corrected/figures/Figure3_Volcano",
    recursive = TRUE,
    showWarnings = FALSE
)


#############################################################
# Load data
#############################################################

data <- read.csv(
    "corrected/results/metabolic_pathway_annotation.csv",
    check.names = FALSE
)


cat("Total pathways:", nrow(data), "\n")


#############################################################
# Prepare statistics
#############################################################

data <- data %>%
    mutate(
        negLogFDR = -log10(FDR),

        significance = case_when(

            FDR < 0.05 &
            log2FC > 1 ~ "T2D enriched",

            FDR < 0.05 &
            log2FC < -1 ~ "Control enriched",

            TRUE ~ "Not significant"
        )
    )


#############################################################
# Select top pathways for labels
#############################################################

label_data <- data %>%
    filter(
        significance != "Not significant"
    ) %>%
    arrange(
        FDR
    ) %>%
    head(15)


#############################################################
# Colors
#############################################################

cols <- c(
    "T2D enriched" = "#D73027",
    "Control enriched" = "#4575B4",
    "Not significant" = "grey75"
)



#############################################################
# Plot
#############################################################

p <- ggplot(
    data,
    aes(
        x = log2FC,
        y = negLogFDR,
        colour = significance
    )
) +

geom_point(
    size = 2.8,
    alpha = 0.75
) +


geom_vline(
    xintercept = c(-1,1),
    linetype = "dashed",
    linewidth = 0.5
) +

geom_hline(
    yintercept = -log10(0.05),
    linetype = "dashed",
    linewidth = 0.5
) +


geom_text_repel(
    data = label_data,

    aes(
        label = pathway
    ),

    size = 3.5,

    max.overlaps = 20,

    box.padding = 0.5,

    point.padding = 0.3,

    min.segment.length = 0
) +


scale_colour_manual(
    values = cols
) +


labs(

    title = "Differential Metabolic Pathway Signatures in T2D",

    subtitle =
    "Top significant pathways labelled",

    x =
    "log2 Fold Change (T2D / Control)",

    y =
    "-log10(FDR)",

    colour =
    "Pathway status"

) +


theme_classic(
    base_size = 16
) +


theme(

    plot.title =
        element_text(
            size = 20,
            face = "bold",
            hjust = 0.5
        ),

    plot.subtitle =
        element_text(
            size = 13,
            hjust = 0.5
        ),

    axis.title =
        element_text(
            size = 15,
            face = "bold"
        ),

    axis.text =
        element_text(
            size = 13
        ),

    legend.position =
        "right",

    legend.title =
        element_blank(),

    legend.text =
        element_text(
            size = 12
        ),

    plot.margin =
        margin(
            30,
            40,
            30,
            30
        )
)



#############################################################
# Save
#############################################################

ggsave(
    "corrected/figures/Figure3_Volcano/volcano_plot.png",

    p,

    width = 12,

    height = 9,

    dpi = 600,

    bg = "white"
)


ggsave(
    "corrected/figures/Figure3_Volcano/volcano_plot.pdf",

    p,

    width = 12,

    height = 9
)



#############################################################
# Summary
#############################################################

cat("\nSignificance summary:\n")

print(
    table(data$significance)
)


cat("\nTop labelled pathways:\n")

print(
    label_data %>%
        select(
            pathway,
            log2FC,
            FDR
        )
)


cat("\n=====================================\n")
cat("Figure 3 completed\n")
cat("=====================================\n")
