############################################################
# Hub Species Analysis
# Project: HMP2 T2D Microbiome Analysis
############################################################


library(dplyr)


############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
  project_dir,
  "Validation_Analysis/tables"
)


figure_dir <- file.path(
  project_dir,
  "Validation_Analysis/figures"
)


misc_dir <- file.path(
  project_dir,
  "Validation_Analysis/results/misc"
)


dir.create(
  table_dir,
  recursive = TRUE,
  showWarnings = FALSE
)


dir.create(
  figure_dir,
  recursive = TRUE,
  showWarnings = FALSE
)


dir.create(
  misc_dir,
  recursive = TRUE,
  showWarnings = FALSE
)



############################################################
# LOAD COMBINED MAASLIN2 RESULTS
############################################################


combined_results <- read.csv(
  file.path(
    table_dir,
    "HMP2_all_trait_maaslin2_results.csv"
  ),
  check.names = FALSE
)


cat(
  "Loaded associations:",
  nrow(combined_results),
  "\n"
)



############################################################
# FILTER SIGNIFICANT ASSOCIATIONS
############################################################


significant_results <- combined_results %>%
  filter(
    qval < 0.05
  )


cat(
  "Significant associations:",
  nrow(significant_results),
  "\n"
)



############################################################
# HUB SPECIES RANKING
############################################################


hub_species <- significant_results %>%
  
  group_by(feature) %>%
  
  summarise(
    
    Traits_Associated = n_distinct(Trait),
    
    Mean_Effect = mean(
      coef,
      na.rm = TRUE
    ),
    
    Best_qvalue = min(
      qval,
      na.rm = TRUE
    ),
    
    Total_Associations = n(),
    
    .groups = "drop"
    
  ) %>%
  
  arrange(
    Best_qvalue
  )



############################################################
# SAVE HUB SPECIES TABLE
############################################################


write.csv(
  hub_species,
  file.path(
    table_dir,
    "hub_species_ranking.csv"
  ),
  row.names = FALSE
)



write.csv(
  hub_species,
  file.path(
    table_dir,
    "Table3_hub_species.csv"
  ),
  row.names = FALSE
)



############################################################
# SAVE TOP HUB SPECIES
############################################################


top_hubs <- hub_species %>%
  
  slice_head(
    n = 20
  )


write.csv(
  top_hubs,
  file.path(
    table_dir,
    "top20_hub_species.csv"
  ),
  row.names = FALSE
)



############################################################
# SAVE R OBJECT
############################################################


save(
  hub_species,
  significant_results,
  file =
    file.path(
      misc_dir,
      "hub_species_analysis.RData"
    )
)



############################################################
# SUMMARY
############################################################


cat(
  "\nHub species analysis completed\n"
)


cat(
  "Top hubs saved:",
  file.path(
    table_dir,
    "top20_hub_species.csv"
  ),
  "\n"
)


cat(
  "R object saved:",
  file.path(
    misc_dir,
    "hub_species_analysis.RData"
  ),
  "\n"
)
