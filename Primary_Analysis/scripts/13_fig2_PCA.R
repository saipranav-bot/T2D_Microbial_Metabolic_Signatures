#################################################
# 13_fig2_PCA.R
# Figure 2: PCA of MetaCardis pathway profiles
#################################################

library(ggplot2)
library(dplyr)


cat("\n=====================================\n")
cat("Figure 2: PCA analysis\n")
cat("=====================================\n\n")


#################################################
# Create output folder
#################################################

dir.create(
    "corrected/figures/Figure2_PCA",
    recursive = TRUE,
    showWarnings = FALSE
)



#################################################
# Load pathway abundance
#################################################

pathway <- read.csv(
    "corrected/results/metacardis_filtered_pathways.csv",
    row.names = 1,
    check.names = FALSE
)


#################################################
# Load metadata
#################################################

meta <- read.csv(
    "corrected/results/metacardis_T2D_control_metadata.csv",
    row.names = 1
)



#################################################
# Match samples
#################################################

common <- intersect(
    colnames(pathway),
    rownames(meta)
)


pathway <- pathway[, common]

meta <- meta[common, ]


cat("Samples included:", length(common), "\n\n")



#################################################
# PCA
#################################################

pca <- prcomp(
    t(pathway),
    scale. = TRUE
)


variance <- round(
    100 * (pca$sdev^2 / sum(pca$sdev^2)),
    2
)


cat(
    "Variance explained:\n"
)

print(variance[1:5])



#################################################
# Prepare dataframe
#################################################

plot_df <- data.frame(
    PC1 = pca$x[,1],
    PC2 = pca$x[,2],
    Group = factor(
        meta$study_condition,
        levels=c("control","T2D")
    )
)


cat("\nGroup distribution:\n")
print(table(plot_df$Group))



#################################################
# PCA plot
#################################################

p <- ggplot(
    plot_df,
    aes(
        x = PC1,
        y = PC2,
        colour = Group
    )
) +


# confidence ellipse

stat_ellipse(
    aes(fill = Group),
    geom = "polygon",
    alpha = 0.12,
    colour = NA,
    level = 0.95
) +


geom_point(
    size = 2.8,
    alpha = 0.65
) +


scale_colour_manual(
    values=c(
        control="#377EB8",
        T2D="#E41A1C"
    )
) +


scale_fill_manual(
    values=c(
        control="#377EB8",
        T2D="#E41A1C"
    )
) +


labs(
    title="Principal Component Analysis",
    subtitle="MetaCardis metabolic pathway profiles",
    x=paste0(
        "PC1 (",
        variance[1],
        "% variance)"
    ),
    y=paste0(
        "PC2 (",
        variance[2],
        "% variance)"
    ),
    colour=NULL,
    fill=NULL
) +


theme_classic(
    base_size=18
) +


theme(

plot.title = element_text(
    size=24,
    face="bold",
    hjust=0.5
),

plot.subtitle = element_text(
    size=16,
    hjust=0.5
),

axis.title = element_text(
    size=20,
    face="bold"
),

axis.text = element_text(
    size=16,
    face="bold"
),

legend.position="right",

legend.text = element_text(
    size=15
),

plot.margin = margin(
    t=60,
    r=50,
    b=50,
    l=50
)

)



#################################################
# Save PNG
#################################################

ggsave(
    "corrected/figures/Figure2_PCA/PCA.png",
    p,
    width=9,
    height=8,
    dpi=600,
    bg="white"
)



#################################################
# Save PDF
#################################################

ggsave(
    "corrected/figures/Figure2_PCA/PCA.pdf",
    p,
    width=9,
    height=8,
    bg="white"
)



cat("\n=====================================\n")
cat("Figure 2 completed\n")
cat("=====================================\n")
