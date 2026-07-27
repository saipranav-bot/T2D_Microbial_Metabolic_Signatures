#################################################
# 12_fig1_cohort.R
# Figure 1: MetaCardis cohort distribution
#################################################

library(ggplot2)
library(dplyr)


cat("\n=====================================\n")
cat("Figure 1: Cohort distribution\n")
cat("=====================================\n\n")


#################################################
# Load metadata
#################################################

meta <- read.csv(
    "corrected/results/metacardis_T2D_control_metadata.csv",
    row.names = 1
)


#################################################
# Prepare groups
#################################################

meta$group <- factor(
    meta$study_condition,
    levels = c("control","T2D")
)


summary <- meta %>%
    count(group)


print(summary)



#################################################
# Plot
#################################################

p <- ggplot(
    summary,
    aes(
        x = group,
        y = n,
        fill = group
    )
) +

geom_col(
    width = 0.6,
    color = "black",
    linewidth = 0.5
) +


geom_text(
    aes(label = n),
    vjust = -0.8,
    size = 7,
    fontface = "bold"
) +


scale_fill_manual(
    values = c(
        "control" = "#4DBBD5",
        "T2D" = "#E64B35"
    )
) +


labs(
    title = "MetaCardis Cohort Distribution",
    subtitle = "Type 2 Diabetes vs Healthy Controls",
    x = NULL,
    y = "Number of Participants"
) +


theme_classic(
    base_size = 20
) +


theme(

    legend.position = "none",

    plot.title = element_text(
        size = 24,
        face = "bold",
        hjust = 0.5
    ),

    plot.subtitle = element_text(
        size = 17,
        hjust = 0.5
    ),

    axis.title.y = element_text(
        size = 20,
        face = "bold"
    ),

    axis.text = element_text(
        size = 18,
        face = "bold"
    ),

    plot.margin = margin(
        t = 40,
        r = 40,
        b = 40,
        l = 40
    )

) +


expand_limits(
    y = max(summary$n) * 1.20
)



#################################################
# Save
#################################################

ggsave(
    "corrected/figures/Figure1_Cohort/cohort_size.png",
    p,
    width = 8,
    height = 7,
    dpi = 600,
    bg = "white"
)


ggsave(
    "corrected/figures/Figure1_Cohort/cohort_size.pdf",
    p,
    width = 8,
    height = 7,
    bg = "white"
)


cat("\n=====================================\n")
cat("Figure 1 completed\n")
cat("=====================================\n")
