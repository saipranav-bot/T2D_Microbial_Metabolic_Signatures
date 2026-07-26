library(dplyr)
library(tidyr)
library(ComplexHeatmap)
library(circlize)


dir.create(
"figures/Figure6_Clinical",
recursive=TRUE,
showWarnings=FALSE
)


# -----------------------------
# Load pathway abundance
# -----------------------------

pathway <- read.csv(
"results/metacardis_pathway_abundance.csv",
check.names=FALSE
)


rownames(pathway) <- pathway[,1]
pathway <- pathway[,-1]


# transpose
pathway <- as.data.frame(t(pathway))
pathway$sample_id <- rownames(pathway)



# -----------------------------
# Load metadata
# -----------------------------

meta <- read.csv(
"results/metacardis_T2D_control_metadata.csv",
stringsAsFactors=FALSE
)

meta$sample_id <- meta$X



# -----------------------------
# Select top pathways
# -----------------------------

ranked <- read.csv(
"results/ranked_metabolic_signatures.csv"
)

top_paths <- ranked %>%
filter(!grepl("UNINTEGRATED", pathway)) %>%
arrange(FDR) %>%
slice_head(n=20) %>%
pull(pathway)



# keep common pathways

common_paths <- intersect(
top_paths,
colnames(pathway)
)


data <- pathway[,c(
"sample_id",
common_paths
)]


# merge metadata

merged <- inner_join(
data,
meta,
by="sample_id"
)


cat(
"Matched samples:",
nrow(merged),
"\n"
)



# -----------------------------
# Correlation
# -----------------------------

clinical <- merged[,c(
"BMI",
"hba1c"
)]


path_mat <- merged[,common_paths]


cor_matrix <- matrix(
NA,
nrow=ncol(path_mat),
ncol=ncol(clinical)
)

rownames(cor_matrix) <- colnames(path_mat)
colnames(cor_matrix) <- colnames(clinical)



for(i in 1:ncol(path_mat)){
for(j in 1:ncol(clinical)){

cor_matrix[i,j] <-
cor(
path_mat[,i],
clinical[,j],
method="spearman",
use="complete.obs"
)

}
}



# clean names

rownames(cor_matrix) <-
substr(
rownames(cor_matrix),
1,
45
)



# -----------------------------
# Plot
# -----------------------------

pdf(
"figures/Figure6_Clinical/Fig6_clinical_pathway_heatmap.pdf",
width=8,
height=10
)


Heatmap(
cor_matrix,
name="Spearman\nrho",
cluster_rows=TRUE,
cluster_columns=TRUE,
column_title=
"Clinical association of microbial pathways"
)


dev.off()


cat(
"Figure 6 completed successfully\n"
)
