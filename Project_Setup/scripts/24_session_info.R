############################################################
# 24_session_info.R
# Save computational environment information
# Reproducibility documentation
############################################################


############################################################
# CREATE OUTPUT DIRECTORY
############################################################


dir.create(
"HMP2_T2D_Microbiome_Analysis/results/R_objects",
recursive = TRUE,
showWarnings = FALSE
)



############################################################
# SAVE SESSION INFORMATION
############################################################


session_file <- paste0(
"HMP2_T2D_Microbiome_Analysis/results/R_objects/",
"session_info.txt"
)



sink(session_file)

cat(
"====================================================\n"
)

cat(
"HMP2 Type 2 Diabetes Microbiome Analysis\n"
)

cat(
"Computational Environment Information\n"
)

cat(
"====================================================\n\n"
)


sessionInfo()


sink()



############################################################
# SAVE INSTALLED PACKAGES
############################################################


packages <- installed.packages()[,c(
"Package",
"Version"
)]


write.csv(

packages,

"HMP2_T2D_Microbiome_Analysis/results/R_objects/installed_R_packages.csv",

row.names=FALSE

)



############################################################
# SAVE ANALYSIS OBJECTS
############################################################


if(
exists("combined_results")
){

save(

combined_results,

file=
"HMP2_T2D_Microbiome_Analysis/results/R_objects/final_combined_results.RData"

)

}



if(
exists("hub_species")
){

save(

hub_species,

file=
"HMP2_T2D_Microbiome_Analysis/results/R_objects/hub_species_results.RData"

)

}



cat(
"Session information saved successfully\n"
)
