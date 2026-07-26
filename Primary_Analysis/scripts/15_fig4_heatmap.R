#!/usr/bin/env Rscript

library(dplyr)
library(ComplexHeatmap)
library(circlize)
library(grid)


# ==========================================
# INPUT FILES
# ==========================================

pathway_file <- "results/metacardis_pathway_abundance.csv"
meta_file <- "results/metacardis_T2D_control_metadata.csv"


# ==========================================
# LOAD DATA
# ==========================================

pathway <- read.csv(
  pathway_file,
  check.names = FALSE,
  stringsAsFactors = FALSE
)


meta <- read.csv(
  meta_file,
  stringsAsFactors = FALSE
)


cat("Original pathways:", nrow(pathway), "\n")


# ==========================================
# FIX PATHWAY COLUMN
# ==========================================

colnames(pathway)[1] <- "pathway"


# remove unwanted entries

pathway <- pathway %>%
  filter(
    !is.na(pathway),
    pathway != "",
    !pathway %in% c(
      "UNMAPPED",
      "UNINTEGRATED"
    )
  )


# remove duplicate pathway names

pathway <- pathway %>%
  distinct(pathway, .keep_all = TRUE)



cat(
"After cleaning:",
nrow(pathway),
"\n"
)



# ==========================================
# CREATE MATRIX
# ==========================================

mat <- pathway[, -1]


rownames(mat) <- pathway$pathway


mat <- as.matrix(
  data.frame(
    lapply(
      mat,
      as.numeric
    ),
    row.names = rownames(mat)
  )
)



# ==========================================
# SELECT TOP VARIABLE PATHWAYS
# ==========================================

pathway_var <- apply(
  mat,
  1,
  var,
  na.rm = TRUE
)


top_pathways <- names(
  sort(
    pathway_var,
    decreasing = TRUE
  )[1:30]
)


mat <- mat[top_pathways, ]


cat(
"Selected pathways:",
nrow(mat),
"\n"
)



# ==========================================
# MATCH METADATA
# ==========================================


common_samples <- intersect(
  colnames(mat),
  meta$subject_id
)


mat <- mat[, common_samples]


meta <- meta %>%
  filter(
    subject_id %in% common_samples
)



cat(
"Matched samples:",
nrow(meta),
"\n"
)



# ==========================================
# DEFINE T2D CONTROL GROUP
# ==========================================


group <- meta$study_condition


names(group) <- meta$subject_id


group <- group[colnames(mat)]


# keep only T2D and control

keep <- group %in% c(
  "T2D",
  "control"
)


mat <- mat[, keep]

group <- group[keep]



cat(
"Final samples:",
ncol(mat),
"\n"
)



# ==========================================
# CREATE GROUP AVERAGE MATRIX
# ==========================================


control_mean <- rowMeans(
  mat[, group == "control"],
  na.rm = TRUE
)


t2d_mean <- rowMeans(
  mat[, group == "T2D"],
  na.rm = TRUE
)



heat <- cbind(
  Control = control_mean,
  T2D = t2d_mean
)



# ==========================================
# Z SCORE
# ==========================================

heat_z <- t(
  scale(
    t(heat)
  )
)



# ==========================================
# OUTPUT DIRECTORY
# ==========================================


dir.create(
  "figures/Figure4_Heatmap",
  recursive = TRUE,
  showWarnings = FALSE
)



# ==========================================
# SAVE FIGURE
# ==========================================


pdf(
  "figures/Figure4_Heatmap/Figure4_metabolic_heatmap.pdf",
  width = 8,
  height = 11
)



Heatmap(
  heat_z,

  name = "Z-score",

  cluster_rows = TRUE,

  cluster_columns = FALSE,


  column_title =
    "Microbial metabolic pathway alteration in T2D",


  row_names_gp =
    gpar(
      fontsize = 7
    ),


  column_names_gp =
    gpar(
      fontsize = 12
    ),


  col = colorRamp2(
    c(-2,0,2),
    c(
      "blue",
      "white",
      "red"
    )
  )

)



dev.off()



cat(
"Figure 4 completed successfully\n"
)
