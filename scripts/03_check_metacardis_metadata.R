#################################################
# 03_check_metacardis_metadata.R
#################################################

library(dplyr)

metadata <- read.csv(
    "results/metacardis_metadata.csv",
    row.names = 1
)

cat("Metadata dimensions:\n")
print(dim(metadata))

cat("\nColumn names:\n")
print(colnames(metadata))


cat("\nFirst samples:\n")
print(head(metadata))


cat("\nPossible disease columns:\n")

for(col in colnames(metadata)){
    
    values <- unique(metadata[[col]])
    
    if(length(values) < 20){
        cat("\n", col, ":\n")
        print(values)
    }
}
