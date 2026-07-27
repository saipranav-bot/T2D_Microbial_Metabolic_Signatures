library(ggplot2)
library(dplyr)

dir.create("figures/Figure2_PCA",
           recursive = TRUE,
           showWarnings = FALSE)

# Load pathway data
pathway <- read.csv(
  "results/metacardis_filtered_pathways.csv",
  row.names = 1,
  check.names = FALSE
)

# Load metadata
meta <- read.csv(
  "results/metacardis_T2D_control_metadata.csv",
  row.names = 1
)

# Match samples
common <- intersect(colnames(pathway), rownames(meta))

pathway <- pathway[, common]
meta <- meta[common, ]

# PCA
pca <- prcomp(
  t(pathway),
  scale. = TRUE
)

variance <- round(
  100 * (pca$sdev^2 / sum(pca$sdev^2)),
  2
)

plot_df <- data.frame(
  PC1 = pca$x[,1],
  PC2 = pca$x[,2],
  Group = factor(
    meta$study_condition,
    levels = c("control","T2D")
  )
)

cols <- c(
  control = "#4C97D8",
  T2D = "#D84C3F"
)

p <- ggplot(
  plot_df,
  aes(
    PC1,
    PC2,
    colour = Group,
    fill = Group
  )
) +

stat_ellipse(
  geom = "polygon",
  alpha = 0.15,
  linewidth = 0
) +

geom_point(
  size = 2.0,
  alpha = 0.70
) +

scale_colour_manual(values = cols) +
scale_fill_manual(values = cols) +

labs(
  title = "PCA",
  x = paste0("PC1 (", variance[1], "%)"),
  y = paste0("PC2 (", variance[2], "%)")
) +

theme_classic(base_size = 15) +

theme(

plot.title = element_text(
  size = 14,
  face = "bold",
  hjust = 0.5
),

axis.title = element_text(
  size = 14,
  face = "bold"
),

axis.text = element_text(
  size = 12
),

legend.position = "right",

legend.title = element_blank(),

legend.text = element_text(
  size = 12
),

plot.margin = margin(
  15,
  15,
  15,
  15
)

)

ggsave(
  "figures/Figure2_PCA/PCA.pdf",
  p,
  width = 8,
  height = 6
)

ggsave(
  "figures/Figure2_PCA/PCA.png",
  p,
  width = 8,
  height = 6,
  dpi = 600
)

cat("Figure 2 completed\n")
