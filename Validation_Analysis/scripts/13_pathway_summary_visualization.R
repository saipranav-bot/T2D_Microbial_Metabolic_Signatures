############################################################
# 13_pathway_summary_visualization.R
# Figure 4: Microbial functional pathway summary
############################################################


library(dplyr)
library(ggplot2)
library(readr)



############################################################
# PATHS
############################################################


project_dir <- "~/t2dmeta/HMP2_T2D_Microbiome_Analysis"


table_dir <- file.path(
project_dir,
"results/Tables"
)


figure_dir <- file.path(
project_dir,
"results/Figures"
)



dir.create(
figure_dir,
showWarnings = FALSE,
recursive = TRUE
)



############################################################
# LOAD FUNCTIONAL SUMMARY
############################################################


functional_summary <- read.csv(

file.path(
table_dir,
"functional_category_summary.csv"
)

)



############################################################
# ORDER CATEGORIES
############################################################


functional_summary <- functional_summary %>%

arrange(
desc(species_count)
) %>%

mutate(

functional_category=factor(

functional_category,

levels=rev(functional_category)

)

)



############################################################
# FIGURE 4
############################################################


p <- ggplot(

functional_summary,

aes(

x=species_count,

y=functional_category

)

)+


geom_col(

fill="darkgreen"

)+


geom_text(

aes(
label=species_count
),

hjust=-0.2,

size=4

)+


theme_bw()+


labs(

title="Microbial Functional Categories Associated With T2D Traits",

x="Number of Associated Species",

y="Functional Category"

)+


theme(

plot.title=element_text(

face="bold",

size=14

),

axis.text.y=element_text(

size=10

)

)+


scale_x_continuous(

expand=expansion(
mult=c(0,0.15)
)

)



############################################################
# SAVE FIGURE
############################################################


ggsave(

file.path(

figure_dir,

"Figure4_microbial_pathways.pdf"

),

p,

width=10,

height=7

)



############################################################
# SAVE OBJECT
############################################################


save(

p,

functional_summary,

file=file.path(

project_dir,

"results/R_objects/Figure4_pathway_summary.RData"

)

)



cat("\n===== FIGURE 4 COMPLETE =====\n")

cat(
"Saved Figure4_microbial_pathways.pdf\n"
)
