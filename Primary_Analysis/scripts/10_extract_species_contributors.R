#############################################################
# 10_extract_species_contributors.R
#
# Extract microbial species contributing to T2D metabolic
# pathway alterations
#
# Input:
#   metacardis_analysis_pathway_abundance.csv
#   ranked_metabolic_signatures.csv
#
# Output:
#   microbial_species_contributors.csv
#############################################################


library(dplyr)
library(stringr)


cat("\n=====================================\n")
cat("Extracting microbial species contributors\n")
cat("=====================================\n\n")



#############################################################
# Load significant pathways
#############################################################

pathway_results <- read.csv(
    "results/ranked_metabolic_signatures.csv"
)


key_pathways <- pathway_results %>%
    filter(
        FDR < 0.05,
        category != "Other"
    ) %>%
    select(
        pathway,
        category,
        direction,
        log2FC,
        FDR
    )



cat(
"Significant biological pathways:",
nrow(key_pathways),
"\n\n"
)



#############################################################
# Load original species-resolved abundance
#############################################################

abundance <- read.csv(
    "results/metacardis_analysis_pathway_abundance.csv",
    row.names = 1,
    check.names = FALSE
)



cat(
"Original pathway features:",
nrow(abundance),
"\n"
)



#############################################################
# Identify species-level pathways
#############################################################

species_features <- data.frame(
    feature = rownames(abundance)
)



species_features <- species_features %>%
    filter(
        grepl("\\|g__", feature)
    )



cat(
"Species pathway features:",
nrow(species_features),
"\n\n"
)



#############################################################
# Extract pathway and species
#############################################################

species_table <- species_features %>%
    mutate(

        pathway = str_remove(
            feature,
            "\\|g__.*"
        ),

        species = str_extract(
            feature,
            "g__.*"
        )

    )



#############################################################
# Match significant pathways
#############################################################

species_table <- species_table %>%
    inner_join(
        key_pathways,
        by="pathway"
    )



#############################################################
# Remove duplicates
#############################################################

species_table <- species_table %>%
    distinct()



#############################################################
# Importance score
#############################################################

species_table <- species_table %>%
    mutate(

        importance_score =
            abs(log2FC) *
            (-log10(FDR))

    ) %>%
    arrange(
        desc(importance_score)
    )



#############################################################
# Save
#############################################################

write.csv(
    species_table,
    "results/microbial_species_contributors.csv",
    row.names = FALSE
)



#############################################################
# Summary
#############################################################

cat("\n=====================================\n")
cat("Extraction completed\n")
cat("=====================================\n\n")


cat(
"Species-linked pathway entries:",
nrow(species_table),
"\n"
)


cat(
"Unique species:",
length(unique(species_table$species)),
"\n\n"
)



cat("Top contributors:\n")

print(
head(
species_table,
20
)
)
