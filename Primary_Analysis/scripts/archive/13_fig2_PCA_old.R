library(ggplot2)
library(dplyr)


pathway <- read.csv(
"results/metacardis_filtered_pathways.csv",
row.names=1,
check.names=FALSE
)


meta <- read.csv(
"results/metacardis_T2D_control_metadata.csv",
row.names=1
)


common <- intersect(
colnames(pathway),
rownames(meta)
)


pathway <- pathway[,common]
meta <- meta[common,]


cat("Samples used:",length(common),"\n")


# transpose
x <- t(pathway)


pca <- prcomp(
x,
scale.=TRUE
)


pca_df <- data.frame(
PC1=pca$x[,1],
PC2=pca$x[,2],
Group=meta$study_condition
)


variance <- round(
100*(pca$sdev^2/sum(pca$sdev^2))[1:2],
1
)


p <- ggplot(
pca_df,
aes(
PC1,
PC2,
color=Group
)
)+
geom_point(
size=3,
alpha=0.8
)+
theme_classic(base_size=16)+
labs(
title="Functional Microbiome Pathway PCA",
x=paste0("PC1 (",variance[1],"%)"),
y=paste0("PC2 (",variance[2],"%)")
)


ggsave(
"figures/Figure2_PCA/PCA.pdf",
p,
width=7,
height=6
)


ggsave(
"figures/Figure2_PCA/PCA.png",
p,
width=7,
height=6,
dpi=600
)


cat("Figure 2 completed\n")
