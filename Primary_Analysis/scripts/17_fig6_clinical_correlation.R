#!/usr/bin/env Rscript

library(ggplot2)
library(dplyr)
library(stringr)


cat("\n=====================================\n")
cat("Figure 6: Integrated pathway signature dot plot\n")
cat("=====================================\n")


outdir <- "corrected/figures/Figure6_Pathway_Signatures"

dir.create(
  outdir,
  recursive = TRUE,
  showWarnings = FALSE
)


# Load data

data <- read.csv(
  "corrected/results/ranked_metabolic_signatures.csv",
  check.names = FALSE
)


# Remove unwanted pathways

data <- data %>%
  filter(
    !grepl("UNINTEGRATED", pathway, ignore.case = TRUE)
  )


# Select top 15 significant pathways

top <- data %>%
  arrange(FDR) %>%
  slice_head(n = 15)


# Prepare labels

top <- top %>%
  mutate(
    pathway_short = str_replace(
      pathway,
      ".*: ",
      ""
    ),
    pathway_short = str_wrap(
      pathway_short,
      width = 45
    ),
    neglogFDR = -log10(FDR)
  )


top$pathway_short <- factor(
  top$pathway_short,
  levels = rev(top$pathway_short)
)



# Plot

p <- ggplot(
  top,
  aes(
    x = log2FC,
    y = pathway_short,
    size = neglogFDR,
    colour = direction
  )
) +

geom_point(
  alpha = 0.85
) +

scale_size_continuous(
  range = c(4,12)
) +

scale_colour_manual(
  values = c(
    "T2D_enriched"="#B2182B",
    "Control_enriched"="#2166AC"
  )
) +

labs(
  title="Top microbial metabolic signatures associated with T2D",
  x="log2 Fold Change",
  y=NULL,
  size="-log10(FDR)",
  colour="Direction"
) +

theme_classic(
  base_size=14
) +

theme(
  plot.title = element_text(
    size=16,
    face="bold",
    hjust=0.5
  ),

  axis.text.y = element_text(
    size=11
  ),

  legend.position="right",

  plot.margin=margin(
    20,20,20,20
  )
)



ggsave(
  paste0(
    outdir,
    "/Figure6_pathway_signature_dotplot.png"
  ),
  p,
  width=10,
  height=8,
  dpi=600,
  bg="white"
)


ggsave(
  paste0(
    outdir,
    "/Figure6_pathway_signature_dotplot.pdf"
  ),
  p,
  width=10,
  height=8
)


cat("\n=====================================\n")
cat("Figure 6 completed\n")
cat("Pathways plotted:", nrow(top), "\n")
cat("=====================================\n")
