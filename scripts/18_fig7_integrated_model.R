# ============================================================
# Figure 7: Integrated Microbiome-Metabolic-T2D Model
# ============================================================

library(grid)
library(gridExtra)

# Output directory
outdir <- "figures/Figure7_Model"
dir.create(outdir, recursive = TRUE, showWarnings = FALSE)

# Use Cairo PDF for embedded fonts
cairo_pdf(
  filename = file.path(outdir, "Fig7_integrated_model.pdf"),
  width = 10,
  height = 7
)

# Create canvas
grid.newpage()

# Title
grid.text(
  "Integrated Microbiome–Metabolic Model of Type 2 Diabetes",
  x = 0.5,
  y = 0.95,
  gp = gpar(fontsize = 18, fontface = "bold")
)

# Helper function for boxes
draw_box <- function(text, x, y, width = 0.18, height = 0.12,
                     fontsize = 11) {

  grid.roundrect(
    x = x,
    y = y,
    width = width,
    height = height,
    r = unit(0.02, "npc"),
    gp = gpar(
      fill = "white",
      col = "black",
      lwd = 1.5
    )
  )

  grid.text(
    text,
    x = x,
    y = y,
    gp = gpar(
      fontsize = fontsize,
      fontface = "bold"
    )
  )
}


# ------------------------------------------------------------
# Main biological flow
# ------------------------------------------------------------

# Microbiome layer
draw_box(
  "Gut Microbiome\nAlterations",
  0.5,
  0.78,
  width = 0.22
)

# Arrow
grid.lines(
  x = c(0.5,0.5),
  y = c(0.70,0.62),
  arrow = arrow(type="closed", length=unit(0.15,"inches")),
  gp=gpar(lwd=2)
)


# Metabolic pathways
draw_box(
  "Microbial Metabolic\nPathway Dysregulation",
  0.5,
  0.55,
  width = 0.28
)


grid.lines(
  x=c(0.5,0.5),
  y=c(0.47,0.39),
  arrow=arrow(type="closed", length=unit(0.15,"inches")),
  gp=gpar(lwd=2)
)


# Biological mechanisms
draw_box(
  "Inflammation\nInsulin Resistance\nMetabolic Stress",
  0.5,
  0.32,
  width=0.28
)


grid.lines(
  x=c(0.5,0.5),
  y=c(0.24,0.16),
  arrow=arrow(type="closed", length=unit(0.15,"inches")),
  gp=gpar(lwd=2)
)


# Disease phenotype
draw_box(
  "Type 2 Diabetes\nPhenotype",
  0.5,
  0.10,
  width=0.22
)



# ------------------------------------------------------------
# Side annotations
# ------------------------------------------------------------

grid.text(
  "Key metabolic signatures:",
  x=0.15,
  y=0.55,
  gp=gpar(fontsize=12,fontface="bold")
)

grid.text(
  paste(
    "• Branched-chain amino acid metabolism\n",
    "• Lipid metabolism\n",
    "• Peptidoglycan biosynthesis\n",
    "• Inflammatory pathways"
  ),
  x=0.15,
  y=0.40,
  just="left",
  gp=gpar(fontsize=10)
)


grid.text(
  "Potential microbial drivers:",
  x=0.85,
  y=0.55,
  gp=gpar(fontsize=12,fontface="bold")
)

grid.text(
  paste(
    "• Escherichia coli\n",
    "• Bacteroides spp.\n",
    "• Metabolic pathway contributors"
  ),
  x=0.85,
  y=0.40,
  just="left",
  gp=gpar(fontsize=10)
)


# Footer
grid.text(
  "MetaCardis cohort | Integrated pathway-level analysis",
  x=0.5,
  y=0.03,
  gp=gpar(fontsize=9, fontface="italic")
)


dev.off()

cat("Figure 7 completed successfully\n")
