library(genoPlotR)


#Reading Mauve Backbone Files into genoPlotR format
CLafvsIshi1a_file="./CLafvsIshi-1-a.backbone"
CLafvsIshi1a_bbone <- read_mauve_backbone(CLafvsIshi1a_file, ref=2)
CLafvsIshi1a_bbone$dna_segs[[1]]$col <- "transparent"
CLafvsIshi1a_bbone$dna_segs[[1]]$fill <- "transparent"
CLafvsIshi1a_bbone$comparisons[[1]]$col <- "azure2"

#Reading Ishi-1-a annotation file into genoPlotR format
Ishi1a_annotation_table <- read.csv("./Ishi-1-a_annotation_genoplotR.csv", header=F)
colnames(Ishi1a_annotation_table) <- c("Gene","Strand","start","end","annotation","color")
Ishi1a_annotation_df <- data.frame(name=Ishi1a_annotation_table$Gene, start=Ishi1a_annotation_table$start, end=Ishi1a_annotation_table$end, strand=Ishi1a_annotation_table$Strand,col=Ishi1a_annotation_table$color)
Ishi1a_annotation_dnaseg <- dna_seg(Ishi1a_annotation_df,fill = Ishi1a_annotation_df$col)

#Reading Mauve Backbone Files into genoPlotR format
Ishi1avsCLamRC_file="./Ishi-1-avsCLamRC.backbone"
Ish1avsCLamRC_bbone <- read_mauve_backbone(Ishi1avsCLamRC_file, ref=2)
Ish1avsCLamRC_bbone$dna_segs[[2]]$col <- "transparent"
Ish1avsCLamRC_bbone$dna_segs[[2]]$fill <- "transparent"
Ish1avsCLamRC_bbone$comparisons[[1]]$col <- "azure2"

#Joining all dna sequences and comparisons into singe object
bbone_dnasegs <- list(CLafvsIshi1a_bbone$dna_segs[[1]],Ishi1a_annotation_dnaseg,Ish1avsCLamRC_bbone$dna_segs[[2]])
names(bbone_dnasegs) <- c("CLaf","Ishi-1-a", "CLam")
bbone_comparisons <- list(CLafvsIshi1a_bbone$comparisons[[1]],Ish1avsCLamRC_bbone$comparisons[[1]])

#Plot
pdf("../Final_Figures_and_Tables/Figure4ClafvsIshi-1-avsCLam_genoPlotR.pdf", height=3, width=5)
plot_gene_map(dna_segs=bbone_dnasegs, 
              comparisons=bbone_comparisons, dna_seg_scale =T)
dev.off()

