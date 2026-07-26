############################################################
# 31_final_project_validation.R
# Final Project Quality Control
# GitHub Readiness Check
############################################################


############################################################
# PROJECT PATH
############################################################


project_dir <- "HMP2_T2D_Microbiome_Analysis"



############################################################
# REQUIRED DIRECTORIES
############################################################


required_dirs <- c(

"scripts",

"data",

"results",

"results/Figures",

"results/Tables",

"results/R_objects",

"metadata"

)



############################################################
# CHECK DIRECTORIES
############################################################


cat(
"\n========== DIRECTORY CHECK ==========\n"
)


for(d in required_dirs){

path <- paste0(
project_dir,
"/",
d
)


if(dir.exists(path)){

cat(
"OK : ",
path,
"\n"
)

}else{

cat(
"MISSING : ",
path,
"\n"
)

}

}



############################################################
# REQUIRED FILES
############################################################


required_files <- c(

"README.md",

".gitignore",

"metadata/analysis_metadata.csv",

"metadata/software_used.csv",

"metadata/project_structure.txt",

"metadata/analysis_run_log.csv"

)



cat(
"\n========== FILE CHECK ==========\n"
)



for(f in required_files){


path <- paste0(
project_dir,
"/",
f
)


if(file.exists(path)){


cat(
"OK : ",
f,
"\n"
)


}else{


cat(
"MISSING : ",
f,
"\n"
)


}

}



############################################################
# RESULT COUNTS
############################################################


cat(
"\n========== RESULTS SUMMARY ==========\n"
)


fig_dir <- paste0(
project_dir,
"/results/Figures"
)


table_dir <- paste0(
project_dir,
"/results/Tables"
)


cat(
"Figures : ",
length(
list.files(fig_dir)
),
"\n"
)


cat(
"Tables  : ",
length(
list.files(table_dir)
),
"\n"
)



############################################################
# SCRIPT COUNT
############################################################


script_dir <- paste0(
project_dir,
"/scripts"
)


cat(
"Scripts : ",
length(
list.files(
script_dir,
pattern="\\.R$"
)
),
"\n"
)



############################################################
# SAVE VALIDATION REPORT
############################################################


validation <- c(

"HMP2 T2D Microbiome Analysis",

paste0(
"Validation completed: ",
Sys.time()
),

"",

paste0(
"Figures generated: ",
length(list.files(fig_dir))
),

paste0(
"Tables generated: ",
length(list.files(table_dir))
),

paste0(
"R scripts available: ",
length(list.files(script_dir, pattern="\\.R$"))
)

)



writeLines(

validation,

paste0(
project_dir,
"/metadata/final_validation_report.txt"
)

)



cat(
"\n===== PROJECT VALIDATION COMPLETE =====\n"
)
