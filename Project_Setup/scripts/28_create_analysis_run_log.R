############################################################
# 28_create_analysis_run_log.R
# Analysis Execution Log Generator
# Reproducibility Documentation
############################################################


############################################################
# PATHS
############################################################


project_dir <- "HMP2_T2D_Microbiome_Analysis"


metadata_dir <- paste0(
project_dir,
"/metadata"
)


dir.create(
metadata_dir,
recursive=TRUE,
showWarnings=FALSE
)



############################################################
# ANALYSIS PIPELINE ORDER
############################################################


pipeline <- data.frame(

Step=c(
1,
2,
3,
4,
5,
6,
7,
8,
9,
10,
11,
12,
13,
14,
15,
16,
17,
18,
19,
20,
21,
22,
23,
24,
25,
26,
27,
28
),


Script=c(

"01_metadata_preparation.R",

"02_microbiome_preprocessing.R",

"03_maaslin2_HbA1c.R",

"04_maaslin2_Glucose.R",

"05_maaslin2_Triglycerides.R",

"06_maaslin2_HDL.R",

"07_maaslin2_LDL.R",

"08_combine_maaslin_results.R",

"09_biological_interpretation.R",

"10_hub_species_ranking.R",

"11_network_generation.R",

"12_final_tables.R",

"13_fig1_trait_species_counts.R",

"14_fig2_hub_species.R",

"15_fig3_heatmap.R",

"16_fig4_pathways.R",

"17_fig5_network.R",

"18_integrated_model.R",

"20_hub_species_plot.R",

"21_heatmap.R",

"22_network_plot.R",

"23_upset_plot.R",

"24_session_info.R",

"25_copy_final_results.R",

"26_generate_README_metadata.R",

"27_create_project_tree.R",

"28_create_analysis_run_log.R"

)

)



############################################################
# ADD TIMESTAMP
############################################################


pipeline$execution_time <- Sys.time()


pipeline$status <- "Completed"



############################################################
# SAVE LOG
############################################################


write.csv(

pipeline,

paste0(
metadata_dir,
"/analysis_run_log.csv"
),

row.names=FALSE

)



############################################################
# TEXT LOG
############################################################


log_text <- c(

"HMP2 T2D Microbiome Analysis Run Log",

paste0(
"Generated: ",
Sys.time()
),

"",

"Completed workflow:",

paste(
pipeline$Step,
pipeline$Script,
pipeline$status,
sep=" | "
)

)



writeLines(

log_text,

paste0(
metadata_dir,
"/analysis_run_log.txt"
)

)



cat(
"\nAnalysis run log created successfully\n"
)
