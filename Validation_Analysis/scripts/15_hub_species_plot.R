############################################################
# 15_hub_species_plot.R
# Figure 2: Top hub microbiome species
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


object_dir <- file.path(
project_dir,
"results/R_objects"
)



############################################################
# LOAD HUB TABLE
############################################################


hub_species <- read.csv(

file.path(
table_dir,
"Table3_hub_species.csv"
)

)



############################################################
# SELECT TOP HUBS
############################################################


top_hubs <- hub_species %>%

arrange(

desc(traits_count),

best_qvalue

) %>%

head(20)



top_hubs$feature <- factor(

top_hubs$feature,

levels=rev(top_hubs$feature)

)



############################################################
# FIGURE 2
############################################################


p <- ggplot(

top_hubs,

aes(

x=traits_count,

y=feature

)

)+


geom_col(

fill="steelblue"

)+


geom_text(

aes(

label=traits_count

),

hjust=-0.2,

size=4

)+


theme_bw()+


labs(

title="Top Hub Microbial Species Associated With Metabolic Traits",

x="Number of Associated Clinical Traits",

y="Species"

)+


theme(

plot.title=element_text(

face="bold",

size=14

),

axis.text.y=element_text(

size=9

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

"Figure2_top_hub_species.pdf"

),

p,

width=10,

height=8

)



############################################################
# SAVE OBJECT
############################################################


save(

p,

top_hubs,

file=file.path(

object_dir,

"Figure2_hub_species_plot.RData"

)

)



cat("\n===== FIGURE 2 COMPLETE =====\n")

cat(
"Saved Figure2_top_hub_species.pdf\n"
)
