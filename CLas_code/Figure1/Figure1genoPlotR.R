library(genoPlotR)


##Figure 1a 
##Ishi-1-a vs FL17 vs SC1

#Reading Mauve Backbone Files into genoPlotR format
bbone_file="./Ishi-1-avsFL17united.backbone"
bbone <- read_mauve_backbone(bbone_file, ref=2)
bbone$comparisons[[1]]$col <- "azure2"
bbone_file2="./FL17unitedvsSC1Flip.backbone"
bbone2 <- read_mauve_backbone(bbone_file2, ref=2)
bbone2$comparisons[[1]]$col <- "azure2"

#Saving backbone comparisons
comparisons <- list(bbone$comparisons[[1]],bbone2$comparisons[[1]])

#FL17-a annotation
FL17.a_annotation_table <- read.csv("./FL17-a_annotation_genoplotR.csv", header=F)
colnames(FL17.a_annotation_table) <- c("Gene","Strand","start","end","annotation","color")
FL17.a_df <- data.frame(name=FL17.a_annotation_table$Gene, start=FL17.a_annotation_table$start, end=FL17.a_annotation_table$end, strand=FL17.a_annotation_table$Strand,col=FL17.a_annotation_table$color)
FL17.a <- dna_seg(FL17.a_df,fill=FL17.a_df$col)
FL17.b <- data.frame(name="FL17-b", start=65788, end=80865, strand=1,col="transparent",fill="transparent",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
FL17.c <- data.frame(name="FL17-c", start=80866, end=94285, strand=1,col="transparent",fill="transparent",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
FL17_dnaseg <- rbind(FL17.a,FL17.b,FL17.c)

#Ishi-1-a annotation
Ishi.1.a_annotation_table <- read.csv("./Ishi-1-a_annotation_genoplotR.csv", header=F)
colnames(Ishi.1.a_annotation_table) <- c("Gene","Strand","start","end","annotation","color")
Ishi.1.a_df <- data.frame(name=Ishi.1.a_annotation_table$Gene, start=Ishi.1.a_annotation_table$start, end=Ishi.1.a_annotation_table$end, strand=Ishi.1.a_annotation_table$Strand,col=Ishi.1.a_annotation_table$color)
Ishi.1.a_dnaseg <- dna_seg(Ishi.1.a_df,fill = Ishi.1.a_df$col)

#SC1 "annotation" (sequence structure)
SC1_df <- data.frame(name="SC1", start=1, end=40048, strand="+",col="transparent")
SC1_df_annotation <- data.frame(name=c("","0","end"), start=c(0,2148,40048), end=c(0,2148,40048), strand=c("+","+","+"),col=c("black","black","red"))
SC1_df <- rbind(SC1_df,SC1_df_annotation)
SC1_dnaseg <- dna_seg(SC1_df,fill = SC1_df$col)

dna_segs <- list(Ishi.1.a_dnaseg,FL17_dnaseg,SC1_dnaseg)
names(dna_segs) <- c("Ishi-1-a", "FL17","SC1")

#FL17 and SC1 notes
anots <- list(NULL,annotation(x1=c(0,65788,80865), x2=c(65788,80865,94285), text=c("FL17-a","FL17-b","FL17-c")),annotation(x1=c(2148,40048), text=c("0","37,900")))

pdf("../Final_Figures_and_Tables/Figure1-a.pdf", width=7, height = 3)
plot_gene_map(dna_segs = dna_segs,
              comparisons = comparisons, dna_seg_label_cex = 0.8, dna_seg_scale=c(T,T,F),annotations = anots, annotation_cex = 0.7, annotation_height = 0.7)

dev.off()

##Figure 1b 
##Ishi-1-a vs AHCA1 vs P-JXGC-3

#Reading Mauve Backbone Files into genoPlotR format
bbone_file="./Ishi-1-avsAHCA1extended.backbone"
bbone <- read_mauve_backbone(bbone_file, ref=2)
bbone$comparisons[[1]]$col <- "azure2"

bbone_file2="AHCA1extendedvsP-JXGC-3Flip.backbone"
bbone2 <- read_mauve_backbone(bbone_file2, ref=2, filter_low=0)
bbone2$comparisons[[1]]$col <- "azure2"

comparisons <- list(bbone$comparisons[[1]],bbone2$comparisons[[1]])

#AHCA1-a annotation
AHCA1.a_annotation_table <- read.csv("./AHCA1-a_annotation_genoplotR.csv", header=F)
colnames(AHCA1.a_annotation_table) <- c("Gene","Strand","start","end","annotation","color")
AHCA1.a_df <- data.frame(name=AHCA1.a_annotation_table$Gene, start=AHCA1.a_annotation_table$start, end=AHCA1.a_annotation_table$end, strand=AHCA1.a_annotation_table$Strand,col=AHCA1.a_annotation_table$color)
AHCA1.a_dnaseg <- dna_seg(AHCA1.a_df,fill=AHCA1.a_df$col)
gap <- data.frame(name="gap", start=65901, end=80903, strand=1,col="peachpuff3",fill="peachpuff3",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
gap1 <- data.frame(name="gap1", start=62880, end=64772, strand=1,col="peachpuff3",fill="peachpuff3",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
gap2 <- data.frame(name="gap2", start=83430, end=85235, strand=1,col="peachpuff3",fill="peachpuff3",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
gap3 <- data.frame(name="gap3", start=86223, end=87777, strand=1,col="peachpuff3",fill="peachpuff3",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
gap4 <- data.frame(name="gap3", start=88557, end=89095, strand=1,col="peachpuff3",fill="peachpuff3",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
rest <- data.frame(name="rest", start=65901, end=97961, strand=1,col="transparent",fill="transparent",lty=1,lwd=1,pch=8,cex=1,gene_type="blocks")
AHCA1_dnaseg <- rbind(AHCA1.a_dnaseg,rest,gap,gap1,gap2,gap3,gap4)

#P-JXGC-3 "annotation" (sequence structure)
P.JXGC.3_df <- data.frame(name="P-JXGC-3", start=1, end=31450, strand="+",col="transparent")
P.JXGC.3_df_annotation <- data.frame(name=c("","0","end"), start=c(0,2550,31450), end=c(0,2550,31450), strand=c("+","+","+"),col=c("black","black","red"))
P.JXGC.3_df <- rbind(P.JXGC.3_df,P.JXGC.3_df_annotation)
P.JXGC.3_dnaseg <- dna_seg(P.JXGC.3_df,fill =P.JXGC.3_df$col)

dna_segs <- list(Ishi.1.a_dnaseg,AHCA1_dnaseg,P.JXGC.3_dnaseg)
names(dna_segs) <- c("Ishi-1-a", "AHCA1","P-JXGC-3")

#AHCA1 and P-JXGC-3 notes
anots <- list(NULL,annotation(x1=0,x2=60800, text="AHCA1-a"),annotation(x1=c(2550,31450), text=c("0","28,900")))

pdf("../Final_Figures_and_Tables/Figure1b.pdf", width=7, height = 3)
plot_gene_map(dna_segs = dna_segs,
              comparisons = comparisons, dna_seg_label_cex = 0.8, dna_seg_scale=c(T,T,F),annotations = anots, annotation_cex = 0.7, annotation_height = 0.7)

dev.off()