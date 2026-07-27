#!/usr/bin/env Rscript

library(dplyr)
library(tidyr)
library(ggplot2)
library(ComplexHeatmap)
library(circlize)
library(pheatmap)



outdir <- "figures/Figure6_Clinical"

dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)



# =====================================================
# Load data
# =====================================================

diff <- read.csv(
"results/metacardis_differential_pathways.csv",
check.names=FALSE
)


meta <- read.csv(
"results/metacardis_T2D_control_metadata.csv",
check.names=FALSE
)


pathway <- read.csv(
"results/metacardis_pathway_abundance.csv",
check.names=FALSE
)




# =====================================================
# PANEL A
# Differential pathways
# =====================================================


top_diff <- diff %>%

filter(
!grepl(
"UNINTEGRATED",
pathway
)
) %>%

arrange(FDR) %>%

slice_head(n=20)



top_diff$short_pathway <-

gsub(
"_",
" ",
substr(
top_diff$pathway,
1,
55
)
)


top_diff$short_pathway <-

factor(
top_diff$short_pathway,
levels=
rev(top_diff$short_pathway)
)



p1 <- ggplot(

top_diff,

aes(
x=short_pathway,
y=log2FC
)

)+

geom_col(
fill="#B2182B"
)+

coord_flip()+

theme_classic()+

labs(

title="Top T2D-associated microbial pathways",

x=NULL,

y="log2 Fold Change"

)



ggsave(

paste0(
outdir,
"/Fig6A_differential_pathways.png"
),

p1,

width=8,

height=6,

dpi=600,

bg="white"

)



ggsave(

paste0(
outdir,
"/Fig6A_differential_pathways.pdf"
),

p1,

width=8,

height=6,

device=cairo_pdf

)




# =====================================================
# Prepare abundance matrix
# =====================================================


rownames(pathway) <- pathway[,1]

pathway <- pathway[,-1]


pathway <- as.data.frame(t(pathway))


pathway$sample_id <- rownames(pathway)



merged <- inner_join(

pathway,

meta,

by="sample_id"

)



# select pathways

keep <- intersect(

top_diff$pathway,

colnames(merged)

)



heat <- merged[,keep]



rownames(heat) <- merged$sample_id



heat <- as.matrix(heat)



# scale

heat <- scale(heat)




# =====================================================
# PANEL B
# Pathway heatmap
# =====================================================


annotation <- data.frame(

Disease =
merged$study_condition

)


rownames(annotation)<-

merged$sample_id



png(

paste0(
outdir,
"/Fig6B_pathway_heatmap.png"
),

width=2600,

height=3000,

res=300

)



pheatmap(

t(heat),

annotation_col=annotation,

cluster_cols=TRUE,

cluster_rows=TRUE,

show_colnames=FALSE,

fontsize_row=8,

color=colorRampPalette(
c(
"#2166AC",
"white",
"#B2182B"
)
)(100),

main=
"T2D-associated microbial pathway abundance"

)



dev.off()



pdf(

paste0(
outdir,
"/Fig6B_pathway_heatmap.pdf"
),

width=10,

height=12

)



pheatmap(

t(heat),

annotation_col=annotation,

cluster_cols=TRUE,

cluster_rows=TRUE,

show_colnames=FALSE,

fontsize_row=8,

color=colorRampPalette(
c(
"#2166AC",
"white",
"#B2182B"
)
)(100),

main=
"T2D-associated microbial pathway abundance"

)



dev.off()




# =====================================================
# PANEL C
# Clinical correlation
# =====================================================


clinical <- merged[,c(
"BMI",
"hba1c"
)]



cor_mat <- cor(

merged[,keep],

clinical,

method="spearman",

use="complete.obs"

)



rownames(cor_mat)<-

gsub(
"_",
" ",
substr(
rownames(cor_mat),
1,
40
)
)



png(

paste0(
outdir,
"/Fig6C_clinical_correlation.png"
),

width=1600,

height=1800,

res=300,

bg="white"

)



pheatmap(

cor_mat,

cluster_rows=TRUE,

cluster_cols=FALSE,

display_numbers=TRUE,

number_format="%.2f",

color=colorRampPalette(
c(
"#2166AC",
"white",
"#B2182B"
)
)(100),

main=
"Pathway association with clinical traits"

)



dev.off()



cat(
"Figure 6 completed successfully\n"
)
