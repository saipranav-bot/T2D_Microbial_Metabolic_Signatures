#############################################################
# 10b_species_summary.R
#
# Summarize microbial species contribution
#############################################################

library(dplyr)


cat("\n=====================================\n")
cat("Species contribution summary\n")
cat("=====================================\n\n")


species <- read.csv(
    "results/microbial_species_contributors.csv"
)



summary <- species %>%
    group_by(
        species
    ) %>%
    summarise(

        pathway_count = n(),

        mean_log2FC = mean(
            log2FC,
            na.rm=TRUE
        ),

        max_log2FC = max(
            log2FC,
            na.rm=TRUE
        ),

        mean_FDR = mean(
            FDR,
            na.rm=TRUE
        ),

        importance_score = sum(
            importance_score,
            na.rm=TRUE
        ),

        categories = paste(
            unique(category),
            collapse=";"
        )

    ) %>%
    arrange(
        desc(importance_score)
    )


write.csv(
    summary,
    "results/species_contribution_summary.csv",
    row.names=FALSE
)



cat(
"Unique species:",
nrow(summary),
"\n\n"
)


cat("Top species:\n")

print(
head(summary,20)
)
