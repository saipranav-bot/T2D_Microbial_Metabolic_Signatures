#!/usr/bin/env Rscript

library(dplyr)
library(ComplexHeatmap)
library(circlize)
library(grid)

############################################################
## INPUT FILES
############################################################

pathway_file <- "results/metacardis_pathway_abundance.csv"
meta_file <- "results/metacardis_T2D_control_metadata.csv"
diff_file <- "results/metacardis_differential_pathways.csv"

############################################################
## LOAD DATA
############################################################

pathway <- read.csv(pathway_file, check.names = FALSE, stringsAsFactors = FALSE)
meta <- read.csv(meta_file, stringsAsFactors = FALSE)
diff <- read.csv(diff_file, stringsAsFactors = FALSE)

colnames(pathway)[1] <- "pathway"

############################################################
## CLEAN HTML SYMBOLS & WRAP TEXT
############################################################

clean_names <- function(x) {
  x <- gsub("&beta;", "beta", x)
  x <- gsub("&alpha;", "alpha", x)
  x <- gsub("&gamma;", "gamma", x)
  return(x)
}

# Wrap text at 40 characters to keep right margin clean
wrap_text <- function(x, width = 40) {
  sapply(x, function(s) paste(strwrap(s, width = width), collapse = "\n"))
}

pathway$pathway <- clean_names(pathway$pathway)
diff$pathway <- clean_names(diff$pathway)

############################################################
## REMOVE UNWANTED PATHWAYS
############################################################

pathway <- pathway %>%
  filter(
    !is.na(pathway),
    pathway != "",
    !pathway %in% c("UNMAPPED", "UNINTEGRATED")
  ) %>%
  distinct(pathway, .keep_all = TRUE)

############################################################
## CREATE MATRIX
############################################################

mat <- pathway[, -1]
rownames(mat) <- pathway$pathway
mat <- as.matrix(
  data.frame(
    lapply(mat, as.numeric),
    row.names = rownames(mat)
  )
)

############################################################
## TOP 10 SIGNIFICANT PATHWAYS
############################################################

top_pathways <- diff %>%
  filter(FDR < 0.05) %>%
  arrange(FDR) %>%
  slice(1:10) %>%
  pull(pathway)

top_pathways <- intersect(top_pathways, rownames(mat))
mat <- mat[top_pathways, ]

# Apply line wrapping to pathway labels
rownames(mat) <- wrap_text(rownames(mat), width = 40)

cat("Top significant pathways:", nrow(mat), "\n")

############################################################
## MATCH METADATA
############################################################

common <- intersect(colnames(mat), meta$subject_id)
mat <- mat[, common]
meta <- meta %>% filter(subject_id %in% common)

group <- meta$study_condition
names(group) <- meta$subject_id
group <- group[colnames(mat)]
keep <- group %in% c("control", "T2D")

mat <- mat[, keep]
group <- factor(group[keep], levels = c("control", "T2D"))

############################################################
## Z-SCORE ACROSS ALL SAMPLES
############################################################

mat_z <- t(scale(t(mat)))

# Cap extreme Z-scores at -3 and +3
mat_z[mat_z > 3] <- 3
mat_z[mat_z < -3] <- -3

############################################################
## ANNOTATIONS
############################################################

col_anno <- HeatmapAnnotation(
  Group = group,
  col = list(Group = c("control" = "#4DAF4A", "T2D" = "#E41A1C")),
  annotation_name_side = "left"
)

############################################################
## OUTPUT DIRECTORY
############################################################

dir.create("figures/Figure4_Heatmap", recursive = TRUE, showWarnings = FALSE)

############################################################
## PLOT FUNCTION
############################################################

draw_my_heatmap <- function() {
  ht <- Heatmap(
    mat_z,
    name = "Z-score",
    
    # Clustering & Splitting
    cluster_rows = TRUE,
    cluster_columns = TRUE, 
    show_column_dend = FALSE,
    column_split = group,
    
    # Annotations
    top_annotation = col_anno,
    show_column_names = FALSE,
    
    # Row aesthetics (Reduced to 7pt, plain weight)
    row_names_side = "right", 
    row_dend_side = "left",
    row_dend_width = unit(1.0, "cm"),
    row_names_gp = gpar(fontsize = 7, fontface = "plain"),
    
    # Titles
    column_title = "Top 10 Differential Metabolic Pathways",
    column_title_gp = gpar(fontsize = 14, fontface = "bold"),
    
    # Legend settings
    heatmap_legend_param = list(
      title_gp = gpar(fontsize = 9, fontface = "bold"),
      labels_gp = gpar(fontsize = 8),
      direction = "horizontal"
    ),
    
    # Colors
    col = colorRamp2(
      c(-2, 0, 2),
      c("#2166AC", "white", "#B2182B")
    )
  )
  
  # Added 25mm padding to right edge to prevent text truncation
  draw(
    ht, 
    heatmap_legend_side = "bottom", 
    annotation_legend_side = "bottom",
    merge_legend = TRUE,
    padding = unit(c(5, 25, 5, 5), "mm")
  )
}

############################################################
## PDF & PNG GENERATION
############################################################

pdf("figures/Figure4_Heatmap/Figure4_metabolic_heatmap.pdf", width = 12, height = 7)
draw_my_heatmap()
dev.off()

png("figures/Figure4_Heatmap/Figure4_metabolic_heatmap.png", width = 3600, height = 2100, res = 400)
draw_my_heatmap()
dev.off()

cat("Figure 4 completed successfully\n")
