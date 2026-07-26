library(ggplot2)
library(dplyr)


meta <- read.csv(
"results/metacardis_T2D_control_metadata.csv",
row.names=1
)


meta$group <- meta$study_condition


summary <- meta %>%
count(group)


print(summary)


p <- ggplot(
summary,
aes(
x=group,
y=n
)
)+
geom_col(width=0.6)+
theme_classic(base_size=16)+
labs(
title="MetaCardis T2D-Control Cohort",
x="Disease Group",
y="Number of Samples"
)


ggsave(
"figures/Figure1_Cohort/cohort_size.pdf",
p,
width=6,
height=5
)


ggsave(
"figures/Figure1_Cohort/cohort_size.png",
p,
width=6,
height=5,
dpi=600
)


cat("Figure 1 completed\n")
