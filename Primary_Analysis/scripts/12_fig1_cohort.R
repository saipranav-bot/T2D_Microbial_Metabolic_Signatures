library(ggplot2)
library(dplyr)

meta <- read.csv(
"results/metacardis_T2D_control_metadata.csv",
row.names = 1
)

meta$group <- factor(
meta$study_condition,
levels = c("control","T2D")
)

summary <- meta %>%
count(group)

p <- ggplot(summary,
aes(x = group,
    y = n,
    fill = group)) +

geom_col(width = 0.65,
         color = "black",
         linewidth = 0.5) +

geom_text(aes(label = n),
          vjust = -0.5,
          size = 6,
          fontface = "bold") +

scale_fill_manual(values = c(
"control" = "#4DBBD5",
"T2D" = "#E64B35"
)) +

labs(
title = "MetaCardis Cohort Distribution",
subtitle = "Type 2 Diabetes vs Healthy Controls",
x = NULL,
y = "Number of Participants"
) +

theme_classic(base_size = 18) +

theme(
legend.position = "none",

plot.title = element_text(
size = 22,
face = "bold",
hjust = 0.5,
margin = margin(b = 8)
),

plot.subtitle = element_text(
size = 15,
hjust = 0.5,
margin = margin(b = 18)
),

axis.title.y = element_text(size = 18),

axis.text = element_text(
size = 16,
face = "bold"
),

plot.margin = margin(
25,
20,
20,
20
)
) +

expand_limits(y = max(summary$n) * 1.12)

ggsave(
"figures/Figure1_Cohort/cohort_size.png",
p,
width = 7,
height = 6,
dpi = 600,
bg = "white"
)

ggsave(
"figures/Figure1_Cohort/cohort_size.pdf",
p,
width = 7,
height = 6,
bg = "white"
)
