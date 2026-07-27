#!/usr/bin/env Rscript

library(grid)

cat("\n=====================================\n")
cat("Figure 7: Integrated microbiome-metabolic model\n")
cat("=====================================\n")


outdir <- "corrected/figures/Figure7_Model"

dir.create(
  outdir,
  recursive = TRUE,
  showWarnings = FALSE
)


box <- function(txt,x,y,w=0.25,h=0.08,fill="white"){

grid.roundrect(
 x=x,
 y=y,
 width=w,
 height=h,
 r=unit(0.02,"npc"),
 gp=gpar(
 fill=fill,
 col="black",
 lwd=1.5
 )
)

grid.text(
 txt,
 x=x,
 y=y,
 gp=gpar(
 fontsize=10,
 fontface="bold"
 )
)

}



arrow_down <- function(y1,y2){

grid.lines(
 x=c(0.5,0.5),
 y=c(y1,y2),
 arrow=arrow(
 type="closed",
 length=unit(0.12,"inches")
 ),
 gp=gpar(lwd=2)
)

}



arrow_horizontal <- function(x1,x2,y){

grid.lines(
 x=c(x1,x2),
 y=c(y,y),
 arrow=arrow(
 type="closed",
 length=unit(0.12,"inches")
 ),
 gp=gpar(lwd=1.5)
)

}



plot_model <- function(){


grid.newpage()


grid.text(
"Integrated Microbiome–Metabolic Model of Type 2 Diabetes",
0.5,
0.94,
gp=gpar(
fontsize=15,
fontface="bold"
)
)


grid.text(
"Functional pathway disruption linking gut microbiome changes to T2D",
0.5,
0.90,
gp=gpar(
fontsize=10
)
)



# Central axis

box(
"Gut microbiome\nalteration",
0.5,
0.78,
fill="#D9EAF7"
)


arrow_down(
0.73,
0.65
)


box(
"Microbial metabolic\npathway changes",
0.5,
0.58,
fill="#FFF2CC"
)


arrow_down(
0.53,
0.45
)


box(
"Metabolic signatures\nTCA | FAO | Lipids",
0.5,
0.38,
fill="#FCE4D6"
)


arrow_down(
0.33,
0.22
)


box(
"Type 2 diabetes\nphenotype",
0.5,
0.15,
fill="#F4CCCC"
)



# Left mechanism

box(
"Species contributors\nand dysbiosis",
0.18,
0.58,
w=0.22,
fill="#EADCF8"
)

arrow_horizontal(
0.29,
0.37,
0.58
)



# Right mechanism

box(
"Functional enrichment\nand pathway rewiring",
0.82,
0.58,
w=0.22,
fill="#EADCF8"
)

arrow_horizontal(
0.63,
0.71,
0.58
)



grid.text(
"MetaCardis metagenomic analysis framework",
0.5,
0.05,
gp=gpar(
fontsize=9,
fontface="italic"
)
)


}



png(
paste0(outdir,
"/Figure7_integrated_model.png"),
width=2400,
height=1800,
res=300
)

plot_model()

dev.off()



pdf(
paste0(outdir,
"/Figure7_integrated_model.pdf"),
width=8,
height=6
)

plot_model()

dev.off()



cat("\nFigure 7 completed\n")
