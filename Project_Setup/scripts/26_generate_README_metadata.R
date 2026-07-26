############################################################
# 26_generate_README_metadata.R
# Generate Project Metadata Documentation
# GitHub Reproducibility File
############################################################


############################################################
# DIRECTORIES
############################################################


project_dir <- "HMP2_T2D_Microbiome_Analysis"


dir.create(
paste0(project_dir,"/metadata"),
recursive=TRUE,
showWarnings=FALSE
)



############################################################
# CREATE ANALYSIS METADATA
############################################################


metadata <- data.frame(

Field=c(

"Project",
"Study objective",
"Cohort",
"Microbiome data type",
"Clinical traits analyzed",
"Statistical framework",
"Association method",
"Multiple testing correction",
"Visualization tools",
"Programming language"

),


Description=c(

"Microbiome signatures associated with Type 2 Diabetes metabolic traits",

"Identify microbial species associated with metabolic dysfunction markers",

"Human Microbiome Project 2 (HMP2)",

"Species-level gut microbiome abundance profiles",

"HbA1c, Glucose, Triglycerides, HDL, LDL",

"Multivariate microbial association analysis",

"MaAsLin2",

"Benjamini-Hochberg FDR correction",

"ggplot2, ggraph, pheatmap, UpSetR",

"R"

)

)



write.csv(

metadata,

paste0(
project_dir,
"/metadata/analysis_metadata.csv"
),

row.names=FALSE

)



############################################################
# CREATE WORKFLOW DESCRIPTION
############################################################


workflow_text <- c(

"HMP2 Type 2 Diabetes Microbiome Analysis",

"",

"Workflow:",

"1. Metadata preparation",

"2. Microbiome abundance preprocessing",

"3. Clinical trait extraction",

"4. MaAsLin2 association testing",

"5. Significant microbial feature identification",

"6. Hub species ranking",

"7. Functional annotation",

"8. Network visualization",

"9. Publication-quality figures and tables",

"",

"Main outputs:",

"- Species-trait association tables",

"- Hub microbial species",

"- Microbiome metabolic networks",

"- Publication figures"

)



writeLines(

workflow_text,

paste0(
project_dir,
"/metadata/workflow_summary.txt"
)

)



############################################################
# CREATE SOFTWARE LIST
############################################################


software <- data.frame(

Tool=c(

"R",
"MaAsLin2",
"ggplot2",
"dplyr",
"tidyr",
"ggraph",
"igraph",
"pheatmap",
"UpSetR"

),

Purpose=c(

"Statistical computing",

"Microbial association modelling",

"Visualization",

"Data manipulation",

"Data reshaping",

"Network visualization",

"Network analysis",

"Heatmap visualization",

"Intersection visualization"

)

)



write.csv(

software,

paste0(
project_dir,
"/metadata/software_used.csv"
),

row.names=FALSE

)



############################################################
# FINAL MESSAGE
############################################################


cat(
"\nMetadata files generated successfully\n"
)


print(

list.files(
paste0(project_dir,"/metadata")
)
)
