############################################################
# 27_create_project_tree.R
# Generate Project Directory Structure Report
############################################################


############################################################
# SETTINGS
############################################################


project_dir <- "HMP2_T2D_Microbiome_Analysis"


output_file <- paste0(
project_dir,
"/metadata/project_structure.txt"
)



############################################################
# FUNCTION TO CREATE TREE
############################################################


create_tree <- function(path, prefix=""){

items <- list.files(
path,
full.names=TRUE,
all.files=FALSE
)


output <- c()


for(i in seq_along(items)){

item <- items[i]

name <- basename(item)


if(dir.exists(item)){

output <- c(
output,
paste0(
prefix,
"|-- ",
name,
"/"
)
)


output <- c(
output,
create_tree(
item,
paste0(prefix,"|   ")
)
)


}else{


output <- c(
output,
paste0(
prefix,
"|-- ",
name
)
)


}

}


return(output)

}



############################################################
# GENERATE TREE
############################################################


tree_output <- c(

paste0(
project_dir,
"/"
),

create_tree(
project_dir
)

)



############################################################
# SAVE
############################################################


writeLines(

tree_output,

output_file

)



cat(
"\nProject structure saved:\n"
)

cat(
output_file,
"\n"
)
