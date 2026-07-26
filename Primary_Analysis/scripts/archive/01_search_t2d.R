library(curatedMetagenomicData)

titles <- get(
    "resourceTitles",
    envir = asNamespace("curatedMetagenomicData")
)

patterns <- c(
    "Karlsson",
    "Qin",
    "Nielsen",
    "HMP_2019_t2d",
    "MetaCardis",
    "LeChatelier",
    "Zeevi"
)

for(p in patterns){

    cat("\n=============================\n")
    cat(p,"\n")
    cat("=============================\n")

    print(grep(p,titles,value=TRUE))
}
