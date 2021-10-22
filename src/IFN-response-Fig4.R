#--------------
# IFN-response-Fig4.R
#
# Source code to produce figures with molecular data from Molecular Therapy - Oncolytics manuscript
# "Molecular characterization of type I IFN-induced cytotoxicity in bladder cancer 
# cells reveals biomarkers of resistance" (Green et al, 2021)
#
# Robin Osterhout
# 10/22/2021
#--------------

#--------------
# Libraries
#--------------
library(tidyverse)
library(pheatmap)
library(RColorBrewer)

#--------------
# Data
#--------------
load("dependencies/Fig4A-PlotData.RData")

#--------------
# Figure 4A: Figure 4. Constitutive ISG expression is associated with resistance to INFα treatment. 
# RNAseq was performed on all cell lines following treatment with 40,000U/mL rhIFNα2b for 24 hours 
# (except for RT4 that received 10,000U/mL rhIFNα2b for 24 hours). Heatmap shows the top 50 genes 
# that discriminate between the ‘ISG-high’ and ‘ISG-low’ cell lines in untreated and IFNA-treated 
# conditions. ISG-high cell lines and treatment condition are indicated in color bars across the top 
# of the figure; ISG-high or ISG-low cell line samples are colored blue or red, respectively; 
# untreated or IFNA-treated samples are colored white or black, respectively
#--------------
if(!dir.exists("plots")){dir.create("plots")}
png(filename = "plots/Fig4A.png", width =6.5, height = 9, units = "in", res = 300)
pheatmap( fig4a_expression_matrix,
          show_rownames = TRUE, show_colnames = TRUE, 
          cluster_cols = FALSE, 
          treeheight_col = 0,
          treeheight_row = 0,
          color=colorRampPalette(c("navy", "yellow", "red"))(100),
          breaks = seq(0, +5, length = 101),
          annotation_col = fig4a_metadata[, c("Treatment", "ISG") ],
          annotation_colors = list(
            ISG = setNames(c("deepskyblue", "firebrick2"), levels(fig4a_metadata$ISG)),
            Treatment = setNames(c("black", "white"), levels(fig4a_metadata$Treatment))
          ),
          labels_col=gsub('_Untreated|_IFNA','',colnames(fig4a_expression_matrix)),
          cellwidth = 12
)
dev.off()
