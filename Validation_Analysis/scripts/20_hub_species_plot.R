############################################################
# 20_hub_species_plot.R
# Figure 2: Top hub microbiome species
############################################################


library(ggplot2)
library(dplyr)
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



############################################################
# LOAD HUB DATA
############################################################


hub_species <- read.csv(

file.path(

table_dir,

"Table3_hub_species.csv"

)

)



############################################################
# SELECT TOP HUB SPECIES
############################################################


top_hubs <- hub_species %>%

arrange(

desc(traits_count),

best_qvalue

) %>%

head(20)



############################################################
# ORDER SPECIES
############################################################


top_hubs$feature <- factor(

top_hubs$feature,

levels = rev(top_hubs$feature)

)



############################################################
# HUB SPECIES BARPLOT
############################################################


p <- ggplot(

top_hubs,

aes(

x=traits_count,

y=feature

)

)+


geom_col(

fill="darkgreen"

)+


theme_bw()+


labs(

title="Top Hub Microbiome Species",

x="Number of associated metabolic traits",

y="Microbial species"

)+


theme(

axis.text.y = element_text(

size=9

),

plot.title = element_text(

face="bold",

size=14

)

)



############################################################
# SAVE FIGURE
############################################################


ggsave(

file.path(

figure_dir,

"Figure2_top_hub_species.pdf"

),

p,

width=9,

height=7

)



############################################################
# CHECK
############################################################


print(p)


cat("\n===== HUB SPECIES FIGURE COMPLETE =====\n")
