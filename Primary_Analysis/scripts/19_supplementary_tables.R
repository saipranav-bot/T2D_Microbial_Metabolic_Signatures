#!/usr/bin/env Rscript


library(dplyr)
library(openxlsx)



outdir <- "results/supplementary"


dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)




# =====================================================
# Supplementary Table S1
# Differential microbial pathways
# =====================================================


diff <- read.csv(
"results/metacardis_differential_pathways.csv",
check.names=FALSE
)



diff <- diff %>%

filter(
!is.na(FDR)
) %>%

arrange(
FDR,
desc(abs(log2FC))
) %>%

mutate(

Rank = row_number(),

Direction = ifelse(
log2FC > 0,
"Enriched in T2D",
"Depleted in T2D"
),

Significance = case_when(

FDR < 0.001 ~ "***",

FDR < 0.01 ~ "**",

FDR < 0.05 ~ "*",

TRUE ~ "ns"

)

) %>%

select(
Rank,
pathway,
log2FC,
pvalue,
FDR,
Direction,
Significance
)




# Workbook

wb1 <- createWorkbook()


addWorksheet(
wb1,
"Differential pathways"
)



writeData(
wb1,
"Differential pathways",
diff
)



freezePane(
wb1,
"Differential pathways",
firstRow=TRUE
)



setColWidths(
wb1,
"Differential pathways",
cols=1:ncol(diff),
widths="auto"
)



saveWorkbook(

wb1,

file.path(
outdir,
"Supplementary_Table_S1_Differential_Pathways.xlsx"
),

overwrite=TRUE

)





# =====================================================
# Supplementary Table S2
# Microbial contributors
# =====================================================



species <- read.csv(
"results/microbial_species_contributors.csv",
check.names=FALSE
)



species <- species %>%

filter(
!is.na(FDR)
) %>%

arrange(
FDR,
desc(abs(log2FC))
) %>%

mutate(

Rank=row_number(),

Direction=ifelse(
log2FC > 0,
"T2D associated",
"Control associated"
),

Significance=case_when(

FDR < 0.001 ~ "***",

FDR < 0.01 ~ "**",

FDR < 0.05 ~ "*",

TRUE ~ "ns"

)

) %>%

select(
Rank,
everything(),
Direction,
Significance
)





wb2 <- createWorkbook()


addWorksheet(
wb2,
"Microbial contributors"
)



writeData(
wb2,
"Microbial contributors",
species
)



freezePane(
wb2,
"Microbial contributors",
firstRow=TRUE
)



setColWidths(
wb2,
"Microbial contributors",
cols=1:ncol(species),
widths="auto"
)



saveWorkbook(

wb2,

file.path(
outdir,
"Supplementary_Table_S2_Microbial_Contributors.xlsx"
),

overwrite=TRUE

)





# =====================================================
# Summary
# =====================================================


cat(
"Supplementary tables generated successfully\n"
)


cat(
"Table S1:",
nrow(diff),
"pathways\n"
)


cat(
"Table S2:",
nrow(species),
"microbial associations\n"
)
