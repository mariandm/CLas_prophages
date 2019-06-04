#This script classifies BLAST values as either high, medium or low given some thresholds that vary according to the sequence lenght and position in blast (either query or target)

#Reading bp number for each sequence and bidirectional blast table
bp_count <- read.csv("./bp_count.csv",header=F,row.names=1)
blast <- read.csv("./BlastTable.csv",header=F,row.names=1)
blast <- data.frame(blast[,-ncol(blast)])

#Remove multiple headers rownames
rows<-rownames(blast)[4:nrow(blast)]
#Initialize a modified_values repository
modified_values <- rep(NA,length(rows))

#For each column of blast change values from factor to numeric
for(col in blast){
  col <- as.character(col)
  values <- as.numeric(col[4:length(col)])
  
  #If the value is identity there's only one set of threshold
  if(col[3]=="I"){
    #Conditions:
    values <- replace(values,values >= 95, "\\cellcolor{high}")
    values <- replace(values,95 > values & values >=85, "\\cellcolor{medium}")
    values <- replace(values,values < 85, "\\cellcolor{low}")
    modified_values <- cbind(modified_values,values)
  }
  
  #If the value is coverage there are two sets of thresholds 
  else{ 
    #Check the bp length of the aligned sequences
    if(col[2]=="Target"){
      Target <- bp_count[col[1],]
      Query <- bp_count[rows,]
    }
    else{ #Query
      Query <- bp_count[col[1],]
      Target <- bp_count[rows,]
    }
  
    #If Query Length <= Target Length use strict threshold values
    values <- replace(values, Query<=Target & as.numeric(values) >= 90, "\\cellcolor{high}")
    values <- replace(values, Query<=Target & 90 > as.numeric(values) & as.numeric(values) >=75, "\\cellcolor{medium}")
    values <- replace(values, Query<=Target & as.numeric(values) < 75, "\\cellcolor{low}")

    #If Query Length > Target Length use lax threshold values
    values <- replace(values, Query>Target & as.numeric(values) >= 33, "\\cellcolor{high}")
    values <- replace(values, Query>Target & 33 > as.numeric(values) & as.numeric(values)>=20, "\\cellcolor{medium}")
    values <- replace(values, Query>Target & as.numeric(values) < 20, "\\cellcolor{low}")
    
    modified_values <- cbind(modified_values,values)
  }
}
modified_values <- modified_values[,-1]
#Pasting classification and value
modified_values <- matrix(paste(as.matrix(modified_values),as.matrix(blast[-c(1,2,3),])),ncol=ncol(blast))
rownames(modified_values) <- rows
colnames(modified_values) <- colnames(blast)
modified_values <- rbind(blast[c(1,2,3),],modified_values)

write.table(modified_values,"./Table4_RepresentativevsAll.ltx",quote = F,na = " ",col.names = FALSE,sep=" & ")

