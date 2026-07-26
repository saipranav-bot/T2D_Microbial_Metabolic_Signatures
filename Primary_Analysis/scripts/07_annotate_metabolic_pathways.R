library(dplyr)

results <- read.csv(
    "results/metacardis_differential_pathways.csv"
)


results$category <- "Other"


results$category[
grepl(
"BCAA|VAL|LEU|ILE|amino",
results$pathway,
ignore.case = TRUE)
] <- "Insulin_resistance"


results$category[
grepl(
"LPS|lipopolysaccharide|peptidoglycan",
results$pathway,
ignore.case = TRUE)
] <- "Inflammation"


results$category[
grepl(
"butyrate|acetate|propionate|SCFA",
results$pathway,
ignore.case = TRUE)
] <- "SCFA"


results$category[
grepl(
"TMA|choline|carnitine|bile",
results$pathway,
ignore.case = TRUE)
] <- "Cardiometabolic"


write.csv(
results,
"results/metabolic_pathway_annotation.csv",
row.names = FALSE
)


print(
table(results$category)
)
