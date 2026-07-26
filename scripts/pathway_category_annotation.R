library(dplyr)

# Read final network edges
edges <- read.csv(
"results/final_network_edges.csv",
stringsAsFactors = FALSE
)

# Create pathway category
edges$Category <- "Other metabolism"

edges$Category[grepl(
"VALSYN|LYSINE|ARGININE|TRP|AMINO",
edges$Pathway_clean,
ignore.case = TRUE
)] <- "Amino acid metabolism"


edges$Category[grepl(
"RIBONUCLEOTIDE|PURINE|AMINOIMIDAZOLE|GUANOSINE|UMP|NUCLEOTIDE|ADENINE",
edges$Pathway_clean,
ignore.case = TRUE
)] <- "Nucleotide metabolism"


edges$Category[grepl(
"COA|ACETYL|FATTY|LIPID|CDP",
edges$Pathway_clean,
ignore.case = TRUE
)] <- "Lipid and cofactor metabolism"


edges$Category[grepl(
"PYRUVATE|GLYCOL|TCA|FERMENTATION",
edges$Pathway_clean,
ignore.case = TRUE
)] <- "Energy metabolism"


# Save annotated table
write.csv(
edges,
"results/final_network_annotated.csv",
row.names = FALSE
)

# Show category counts
print(table(edges$Category))
