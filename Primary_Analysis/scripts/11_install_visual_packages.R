packages <- c(
"ggplot2",
"dplyr",
"tidyr",
"pheatmap",
"RColorBrewer",
"ggrepel",
"vegan",
"patchwork",
"igraph",
"ggraph"
)

install <- packages[
!packages %in% installed.packages()[,"Package"]
]

if(length(install)>0){
install.packages(install)
}

cat("All packages ready\n")
