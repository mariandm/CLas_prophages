library(genoPlotR)

#Changing annotation table format to genoPlotR annotation format
AnnotationTable <- read.csv("./Ishi-1-a_annotation_genoplotR.csv", header=F)
colnames(AnnotationTable) <- c("Gene","Strand","start","end","annotation","color")
Ishi1_df <- data.frame(name=AnnotationTable$Gene, start=AnnotationTable$start, end=AnnotationTable$end, strand=AnnotationTable$Strand,col=AnnotationTable$color)
Ishi1_dnaseg <- dna_seg(Ishi1_df,fill =Ishi1_df$col)

#Hypothetical protein annotatios will not appear
anots <- gsub("hypothetical protein.*","",AnnotationTable$annotation)
anots <- gsub("DUF.*","",anots)

#Erasing repetitive annotation for fragmented proteins
anoto <- anots[c(-13,-17,-19)]
starto <- AnnotationTable$start[c(-13,-17,-19)]
endo <- rep(NA,length(starto))
endo[13-1] <- AnnotationTable$end[13]
endo[17-2] <- AnnotationTable$end[17]
endo[19-3] <- AnnotationTable$end[19]

#Plotting
pdf("../Final_Figures_and_Tables/Figure3_Ishi-1-a_annotation.pdf", width=7, height = 5)
plot_gene_map(dna_segs = c(Ishi1_dnaseg),main = "Ishi-1-a",annotations = annotation(x1=starto,x2=endo,text=anoto,rot=75))

dev.off()
