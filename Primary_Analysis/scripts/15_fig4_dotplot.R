#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)
library(stringr)


cat("\n=====================================\n")
cat("Figure 4: Metabolic pathway dot plot\n")
cat("=====================================\n")


outdir <- "corrected/figures/Figure4_Dotplot"

dir.create(
  outdir,
  recursive = TRUE,
  showWarnings = FALSE
)



# Load data

diff <- read.csv(
  "corrected/results/metacardis_differential_pathways.csv",
  check.names = FALSE
)



# Remove unwanted pathways

diff <- diff %>%
  filter(
    !grepl("UNINTEGRATED", pathway, ignore.case = TRUE)
  )



# Select top 10 significant pathways

top <- diff %>%
  arrange(FDR) %>%
  slice_head(n = 10)



# Clean pathway names

top <- top %>%
  mutate(
    pathway_clean = str_replace(
      pathway,
      ".*: ",
      ""
    ),
    
    pathway_clean = str_wrap(
      pathway_clean,
      width = 35
    ),
    
    significance = -log10(FDR)
  )



# Correct ordering

top$pathway_clean <- factor(
  top$pathway_clean,
  levels = rev(top$pathway_clean)
)



# Dot plot

p <- ggplot(
  top,
  aes(
    x = log2FC,
    y = pathway_clean
  )
) +

geom_point(
  aes(
    size = significance,
    colour = log2FC
  ),
  alpha = 0.9
) +


scale_colour_gradient2(
  low = "#2166AC",
  mid = "white",
  high = "#B2182B",
  midpoint = 0
) +


scale_size_continuous(
  range = c(5,14)
) +


labs(
  title = "Top Differential Microbial Metabolic Pathways in T2D",
  x = "log2 Fold Change",
  y = NULL,
  size = "-log10(FDR)",
  colour = "log2FC"
) +


theme_classic(
  base_size = 14
) +


theme(
  
  plot.title = element_text(
    size = 16,
    face = "bold",
    hjust = 0.5
  ),
  
  axis.text.y = element_text(
    size = 11,
    colour = "black"
  ),
  
  axis.text.x = element_text(
    size = 11
  ),
  
  axis.title.x = element_text(
    size = 13,
    face = "bold"
  ),
  
  legend.title = element_text(
    size = 11,
    face = "bold"
  ),
  
  legend.text = element_text(
    size = 10
  ),
  
  plot.margin = margin(
    20,
    30,
    20,
    20
  )
)



# Save

ggsave(
  paste0(outdir,
         "/Figure4_metabolic_dotplot.png"),
  p,
  width = 10,
  height = 7,
  dpi = 600,
  bg = "white"
)


ggsave(
  paste0(outdir,
         "/Figure4_metabolic_dotplot.pdf"),
  p,
  width = 10,
  height = 7
)



cat("\n=====================================\n")
cat("Figure 4 completed\n")
cat("Pathways:", nrow(top), "\n")
cat("=====================================\n")
