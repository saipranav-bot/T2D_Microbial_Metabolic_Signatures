library(dplyr)

# Load pathway abundance
pathways <- read.csv(
    "results/metacardis_filtered_pathways.csv",
    check.names = FALSE
)

# First column contains pathway names
rownames(pathways) <- pathways[,1]

pathways <- pathways[,-1]


# Remove non biological features

remove <- c(
    "UNMAPPED",
    "UNINTEGRATED",
    "UNINTEGRATED|unclassified"
)

pathways <- pathways[
    !rownames(pathways) %in% remove,
]


# Transpose

features <- as.data.frame(t(pathways))


# Save

write.table(
    features,
    "results/maaslin2_features.tsv",
    sep="\t",
    quote=FALSE,
    row.names=TRUE
)


cat(
"Samples:",
nrow(features),
"\nPathways:",
ncol(features),
"\n"
)
