#--------------
# IFN-response-Fig3.R
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
load("dependencies/Fig3A-PlotData.RData")

#--------------
# Figure 3A: Differential expression of interferon stimulated genes (ISGs) in bladder cancer cell lines. 
# RNAseq was performed on RT4 and J82 cells following treatment with rhIFNα2b at 1,000U/mL (1k) or 10,000U/mL (10k) for 4, 8 or 24 hours. 
# Heatmap shows top differentially expressed genes in the canonical interferon alpha response pathway. 
# ISGs are expressed at low levels in a sensitive cell line (RT4) and increase over time following treatment with INFα. 
# Non-responsive cell lines (e.g., J82) express ISGs constitutively (ISG-high). 
#--------------
if(!dir.exists("plots")){dir.create("plots")}
png(filename = "plots/Fig3A-IFNA-RT4-J82-heatmap.png", width = 6, height = 4, units = "in", res = 300)
pheatmap( fig3a_expression_matrix,
          show_colnames = FALSE, cluster_cols = FALSE,
          breaks = seq(0, +5, length = 101),
          color=colorRampPalette(c("navy", "yellow", "red"))(100),
          annotation_col = fig3a_metadata[, c("Cell line", "Time", "Treatment") ],
          annotation_colors = list(
            `Cell line` = setNames(c("steelblue3", "lightskyblue2"), levels(fig3a_metadata$`Cell line`)),
            Time = setNames(brewer.pal(nlevels(fig3a_metadata$Time), "YlGn"),
                            levels(fig3a_metadata$Time)),
            Treatment = setNames(c("white", "grey", "black"), levels(fig3a_metadata$Treatment))
          ),
          cellwidth = 12 # 9 works better within R
)
dev.off()