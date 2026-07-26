############################################################
# Combine MaAsLin2 Results
# Project: HMP2 T2D Microbiome Analysis
############################################################


library(dplyr)


############################################################
# PATHS
############################################################


results_dir <-
"Validation_Analysis/results"


output_file <-
"Validation_Analysis/tables/HMP2_all_trait_maaslin2_results.csv"


############################################################
# TRAIT RESULT DIRECTORIES
############################################################


traits <- list(

HbA1c =
"HMP2_HbA1c_Maaslin2_final",

Glucose =
"HMP2_glucose_Maaslin2_final",

Triglycerides =
"HMP2_triglycerides_Maaslin2_final",

HDL =
"HMP2_HDL_Maaslin2_final",

LDL =
"HMP2_LDL_Maaslin2_final"

)



############################################################
# READ RESULTS
############################################################


all_results <- list()


for(trait in names(traits)){


file_path <- file.path(
results_dir,
traits[[trait]],
"all_results.tsv"
)


if(file.exists(file_path)){


cat("Reading:", trait, "\n")


data <- read.csv(
file_path,
sep="\t",
check.names=FALSE
)


data$Trait <- trait


all_results[[trait]] <- data


}else{


warning(
paste(
"Missing result:",
trait
)
)


}


}



############################################################
# COMBINE
############################################################


combined_results <- bind_rows(
all_results
)



############################################################
# FILTER SIGNIFICANT ASSOCIATIONS
############################################################


significant_results <- combined_results %>%

filter(
qval < 0.05
)



############################################################
# SAVE
############################################################


dir.create(
dirname(output_file),
recursive=TRUE,
showWarnings=FALSE
)


write.csv(

combined_results,

gsub(
".csv",
"_all.csv",
output_file
),

row.names=FALSE

)



write.csv(

significant_results,

output_file,

row.names=FALSE

)



############################################################
# SUMMARY
############################################################


cat(
"\nTotal associations:",
nrow(combined_results),
"\nSignificant associations:",
nrow(significant_results),
"\nSaved:",
output_file,
"\n"
)
