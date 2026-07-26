library(dplyr)
library(stringr)

results <- read.csv(
    "results/ranked_metabolic_signatures.csv"
)

# Keep significant non-Other pathways

species_table <- results %>%
    filter(
        FDR < 0.05,
        category != "Other"
    ) %>%
    mutate(
        species = str_extract(
            pathway,
            "g__[^|]+"
        )
    ) %>%
    filter(!is.na(species)) %>%
    select(
        species,
        pathway,
        category,
        direction,
        log2FC,
        FDR
    ) %>%
    arrange(desc(abs(log2FC)))


write.csv(
    species_table,
    "results/microbial_species_contributors.csv",
    row.names = FALSE
)

cat("Species-linked pathways:\n")
print(head(species_table,50))
