library(gplots)

#PresenceMatrix <- read.table("./presence_matrix_all_T4cut.csv",header=T, sep=",", check.names = F)
PresenceMatrix <- read.table("./presence_matrix.csv",header=T, sep=",", check.names = F)

#Sequences from the same strain classified as the same Type are joined
PresenceMatrix[,"FL17-b,c"] = PresenceMatrix[,"FL17-b"] + PresenceMatrix[,"FL17-c"]
PresenceMatrix[,"TX2351-b,d"] = PresenceMatrix[,"TX2351-b"] + PresenceMatrix[,"TX2351-d"]
PresenceMatrix[,"FL17-b"]<-NULL
PresenceMatrix[,"FL17-c"]<-NULL
PresenceMatrix[,"TX2351-b"]<-NULL
PresenceMatrix[,"TX2351-d"]<-NULL

#Short unclassified sequences are excluded from the study
PresenceMatrix[,"TX2351-c"]<-NULL
PresenceMatrix[,"TX1712-c"]<-NULL
PresenceMatrix[,"YCPsy-c"]<-NULL
PresenceMatrix[,"YCPsy-d"]<-NULL


PresenceMatrix <- data.matrix(PresenceMatrix[,-1])

#Chanhing code names to graph names for AHCA1-a and FL17-a
colnames(PresenceMatrix) <- gsub("FL17-a-T4","FL17-a (Fragment)",colnames(PresenceMatrix))
colnames(PresenceMatrix) <- gsub("AHCA1-a-T4","AHCA1-a (Fragment)",colnames(PresenceMatrix))

#Assigning colors according to sequence classification
T1 <- c("psy62-b","FL17-b,c","YCPsy-b","TX1712-b","YNJS7C-b","gxpsy-c","SC1","P-SGCA5-1","TX2351-a")
T2 <- c("TX2351-b,d","SC2","FP2","gxpsy-b","P-HHCA1-2","A4-b")
T3 <- c("YNJS7C-c","P-JXGC-3")
T4 <- c("SGCA5-a","HHCA1-a","AHCA1-a (Fragment)","FL17-a (Fragment)","psy62-c","Ishi-1-a","TX1712-a","YNJS7C-a","A4-a","gxpsy-a","JXGC-a","YCPsy-a")
T1index <- match(T1,colnames(PresenceMatrix))
T2index <- match(T2,colnames(PresenceMatrix))
T3index <- match(T3,colnames(PresenceMatrix))
T4index <- match(T4,colnames(PresenceMatrix))
color <- replace(colnames(PresenceMatrix),T1index,"Red")
color <- replace(color,T2index,"Blue")
color <- replace(color,T3index,"seagreen")
color <- replace(color,T4index,"gold")


#Plotting heatmap
pdf( '../Final_Figures_and_Tables/Figure2_PangenomeHeatmap.pdf', height=8, width = 9)
heatmap.2(PresenceMatrix, dendrogram = 'col',
          col=c("seashell","tan1"), 
          key=FALSE, keysize=1.0, symkey=FALSE, density.info='none',
          trace='none',
          sepcolor='black', sepwidth=c(0.3,0.05),
          scale="none",cexRow=.01,cexCol=1.7,
          labCol = colnames(PresenceMatrix),
          labRow = rep(" ",nrow(PresenceMatrix)),
          ColSideColors=color,
          hclustfun=function(c){hclust(c, method='average')},
          lmat=rbind(c(5,4,0), c(0,1,0), c(3,2,0)), 
          lhei=c(0.2, 0.04, 1), lwid = c(.2,5,0.8),
          margins = c(15,3)
)
legend("topright",legend=c("Type 1","Type 2","Type 3","Type 4"),
       fill=c("red","blue","seagreen","gold"), border=T, bty="o", y.intersp = 1, cex=1)
dev.off()

