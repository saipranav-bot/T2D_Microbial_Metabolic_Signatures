#!/usr/bin/env Rscript

library(grid)



outdir <- "figures/Figure7_Model"

dir.create(
  outdir,
  recursive = TRUE,
  showWarnings = FALSE
)



# =====================================================
# Helper functions
# =====================================================


draw_box <- function(
  text,
  x,
  y,
  width=0.28,
  height=0.10
){

grid.roundrect(

x=x,

y=y,

width=width,

height=height,

r=unit(0.02,"npc"),

gp=gpar(
fill="white",
col="black",
lwd=1.4
)

)


grid.text(

text,

x=x,

y=y,

gp=gpar(
fontsize=10,
fontface="bold"
)

)

}



draw_arrow <- function(
y1,
y2
){

grid.lines(

x=c(0.5,0.5),

y=c(y1,y2),

arrow=arrow(
type="closed",
length=unit(0.12,"inches")
),

gp=gpar(
lwd=1.5
)

)

}





# =====================================================
# Main plotting function
# =====================================================


create_figure <- function(){


grid.newpage()



# -------------------------------
# Title
# -------------------------------


grid.text(

"Integrated Microbiome-Metabolic Model of Type 2 Diabetes",

x=0.5,

y=0.94,

gp=gpar(
fontsize=13,
fontface="bold"
)

)




# -------------------------------
# Central biological flow
# -------------------------------



draw_box(

"Gut Microbiome\nAlterations",

0.5,

0.78

)



draw_arrow(
0.71,
0.64
)




draw_box(

"Microbial Metabolic\nPathway Dysregulation",

0.5,

0.58,

width=0.32

)



draw_arrow(
0.51,
0.44
)




draw_box(

"Inflammation\nInsulin Resistance\nMetabolic Stress",

0.5,

0.38,

width=0.32

)



draw_arrow(
0.31,
0.17
)




draw_box(

"Type 2 Diabetes\nPhenotype",

0.5,

0.11

)




# -------------------------------
# Left annotation
# -------------------------------



grid.text(

"Key metabolic signatures",

x=0.15,

y=0.62,

gp=gpar(
fontsize=11,
fontface="bold"
)

)



grid.text(

paste(
"BCAA metabolism\n",
"Lipid metabolism\n",
"Peptidoglycan biosynthesis\n",
"Inflammatory pathways"
),

x=0.15,

y=0.43,

just="left",

gp=gpar(
fontsize=9
)

)





# -------------------------------
# Right annotation
# -------------------------------



grid.text(

"Potential microbial drivers",

x=0.85,

y=0.62,

gp=gpar(
fontsize=11,
fontface="bold"
)

)



grid.text(

paste(
"Escherichia coli\n",
"Bacteroides spp.\n",
"Pathway contributors"
),

x=0.85,

y=0.43,

just="left",

gp=gpar(
fontsize=9
)

)





# Footer


grid.text(

"MetaCardis cohort | Integrated pathway-level analysis",

x=0.5,

y=0.04,

gp=gpar(
fontsize=8,
fontface="italic"
)

)


}




# =====================================================
# PNG
# =====================================================


png(

file.path(
outdir,
"Fig7_integrated_model.png"
),

width=3000,

height=2400,

res=300,

bg="white"

)


create_figure()

dev.off()





# =====================================================
# PDF
# =====================================================


cairo_pdf(

file.path(
outdir,
"Fig7_integrated_model.pdf"
),

width=10,

height=8

)


create_figure()


dev.off()



cat(
"Figure 7 completed successfully\n"
)
