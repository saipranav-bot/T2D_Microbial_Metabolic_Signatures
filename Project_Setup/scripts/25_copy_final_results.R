############################################################
# 25_copy_final_results.R
# Final Results Organization
# GitHub / Publication Packaging
############################################################


############################################################
# DIRECTORIES
############################################################


project_dir <- "HMP2_T2D_Microbiome_Analysis"


source_dir <- "HMP2_T2D_Publication_Results"


final_results <- paste0(
project_dir,
"/results"
)


dir.create(
paste0(final_results,"/Figures"),
recursive=TRUE,
showWarnings=FALSE
)


dir.create(
paste0(final_results,"/Tables"),
recursive=TRUE,
showWarnings=FALSE
)


dir.create(
paste0(final_results,"/R_objects"),
recursive=TRUE,
showWarnings=FALSE
)



############################################################
# COPY FIGURES
############################################################


file.copy(

from=paste0(
source_dir,
"/Figures"
),

to=paste0(
final_results,
"/Figures"
),

recursive=TRUE,

overwrite=TRUE

)



############################################################
# COPY TABLES
############################################################


file.copy(

from=paste0(
source_dir,
"/Tables"
),

to=paste0(
final_results,
"/Tables"
),

recursive=TRUE,

overwrite=TRUE

)



############################################################
# COPY R OBJECTS
############################################################


file.copy(

from=paste0(
source_dir,
"/R_objects"
),

to=paste0(
final_results,
"/R_objects"
),

recursive=TRUE,

overwrite=TRUE

)



############################################################
# FINAL CHECK
############################################################


cat(
"\n========== FINAL FIGURES ==========\n"
)


print(
list.files(
paste0(final_results,"/Figures")
)
)



cat(
"\n========== FINAL TABLES ==========\n"
)


print(
list.files(
paste0(final_results,"/Tables")
)
)



cat(
"\n========== FINAL OBJECTS ==========\n"
)


print(
list.files(
paste0(final_results,"/R_objects")
)
)



cat(
"\n===== PROJECT READY FOR GITHUB =====\n"
)
