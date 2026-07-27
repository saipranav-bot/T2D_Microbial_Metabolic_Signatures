#############################################################
# 07_annotate_metabolic_pathways.R
# Annotate MetaCyc metabolic pathways
# MetaCardis T2D vs Control
#############################################################

library(dplyr)


cat("\n=====================================\n")
cat("Metabolic pathway annotation\n")
cat("=====================================\n\n")


#############################################################
# Load differential pathways
#############################################################

results <- read.csv(
    "results/metacardis_differential_pathways.csv",
    stringsAsFactors = FALSE
)


#############################################################
# Create pathway categories
#############################################################

results <- results %>%
    mutate(
        category = case_when(

            grepl(
                "FATTY|FAO|LIPID|LIPIDATION|CHOLESTEROL|PHOSPHOLIPID",
                pathway,
                ignore.case = TRUE
            )
            ~ "Lipid metabolism",


            grepl(
                "GLYCOLYSIS|TCA|GLYOX|PYRUVATE|CARBOHYDRATE",
                pathway,
                ignore.case = TRUE
            )
            ~ "Carbohydrate metabolism",


            grepl(
                "AMINO|PEPTIDE|GLUTAMATE|BRANCHED",
                pathway,
                ignore.case = TRUE
            )
            ~ "Amino acid metabolism",


            grepl(
                "BUTYRATE|PROPIONATE|ACETATE|SCFA",
                pathway,
                ignore.case = TRUE
            )
            ~ "Short chain fatty acid metabolism",


            grepl(
                "BILE",
                pathway,
                ignore.case = TRUE
            )
            ~ "Bile acid metabolism",


            grepl(
                "NUCLEOTIDE|PURINE|PYRIMIDINE",
                pathway,
                ignore.case = TRUE
            )
            ~ "Nucleotide metabolism",


            TRUE
            ~ "Other"
        )
    )



#############################################################
# Save annotation
#############################################################

write.csv(
    results,
    "results/metabolic_pathway_annotation.csv",
    row.names = FALSE
)



#############################################################
# Summary
#############################################################

cat(
    "Annotated pathways:",
    nrow(results),
    "\n"
)


cat("\nCategory distribution:\n")

print(
    table(results$category)
)


cat("\n=====================================\n")
cat("Annotation completed\n")
cat("=====================================\n")
