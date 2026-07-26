library(ggplot2)
library(dplyr)
library(ggrepel)


data <- read.csv(
"results/metacardis_differential_pathways.csv",
check.names=FALSE
)


data$category <- ifelse(
data$FDR < 0.05 & data$log2FC > 0,
"T2D enriched",
ifelse(
data$FDR < 0.05 & data$log2FC < 0,
"Control enriched",
"Not significant"
)
)


# top pathways to label

labels <- data %>%
filter(FDR < 1e-10) %>%
arrange(FDR) %>%
head(10)


p <- ggplot(
data,
aes(
x=log2FC,
y=-log10(FDR),
color=category
)
)+

geom_point(
alpha=0.6,
size=2
)+

geom_text_repel(
data=labels,
aes(label=pathway),
size=3,
max.overlaps=10
)+

theme_classic(
base_size=16
)+

labs(
title="Differential Microbial Metabolic Pathways in T2D",
x="log2 Fold Change (T2D / Control)",
y="-log10(FDR)"
)


ggsave(
"figures/Figure3_Differential/volcano.pdf",
p,
width=9,
height=7
)


ggsave(
"figures/Figure3_Differential/volcano.png",
p,
width=9,
height=7,
dpi=600
)


cat("Figure 3 completed\n")
