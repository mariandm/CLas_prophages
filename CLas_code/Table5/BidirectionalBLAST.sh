#This script runs bidirectional blasts and parses it into a table, runs a Rscript that evaluates values and returns a latex table
#The script cleans temporal files

#Make sure the reservoir file is empty
touch blast.out; rm blast.out

#Two direction BLAST
while read repre; do while read all; do blastn -query sequences/$repre.fasta  -subject sequences/$all.fasta -outfmt "6 qseqid sseqid qcovs pident" | head -1 >> blast.out; done < all; done < repre; while read repre; do while read all; do blastn -query sequences/$all.fasta  -subject sequences/$repre.fasta -outfmt "6 qseqid sseqid qcovs pident" | head -1 >> blast.out; done < all; done < repre; 
perl -pe 's/\t/,/g' blast.out > tmp; mv tmp blast.out

#Changing table structure 
while read all; do while read repre;do a1=$(grep "${all},${repre}" blast.out | head -1 | cut -f3 -d ",");a2=$(grep "${all},${repre}" blast.out | head -1 | cut -f4 -d ","); b1=$(grep "${repre},${all}" blast.out | head -1| cut -f3 -d ",");b2=$(grep "${repre},${all}" blast.out | head -1| cut -f4 -d ","); echo "$all,$a1,$a2,$b1,$b2"; done < repre; done < all > tmp; while read all; do almost=$(grep $all tmp | cut -f2-5 -d "," | perl -pe 's/\n/,/g'); echo "$all,$almost"; done < all > tmp2; 
echo -e "Column,A4-a,A4-a,A4-a,A4-a,gxpsy-a,gxpsy-a,gxpsy-a,gxpsy-a,HHCA1-a,HHCA1-a,HHCA1-a,HHCA1-a,Ishi-1-a,Ishi-1-a,Ishi-1-a,Ishi-1-a,JXGC-a,JXGC-a,JXGC-a,JXGC-a,psy62-c,psy62-c,psy62-c,psy62-c,TX1712-a,TX1712-a,TX1712-a,TX1712-a,YCPsy-a,YCPsy-a,YCPsy-a,YCPsy-a,YNJS7C-a,YNJS7C-a,YNJS7C-a,YNJS7C-a,SGCA5-a,SGCA5-a,SGCA5-a,SGCA5-a,AHCA1-a,AHCA1-a,AHCA1-a,AHCA1-a,FL17-a,FL17-a,FL17-a,FL17-a,\nBpos,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,Target,Target,Query,Query,\nValueType,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I,C,I," > tmp3; cat tmp3 tmp2 > BlastTable.csv

#cleaning temporal files
rm blast.out tmp*

#Getting bp count of every sequence
while read all; do bp=$(head -2 sequences/$all.fasta | tail -1 | wc -m|perl -pe 's/^\s+//g'); echo "$all,$bp"; done < all > bp_count.csv

Rscript ./BLASTvaluesEvaluation.R

#Final parsing of ValueEvaluationTable
perl -pe 's/\n/\\\\\\hline\n/g' Table5_NewTypevsNewType_coverage.ltx > tmp; mv tmp Table5_NewTypevsNewType_coverage.ltx

mv Table5_NewTypevsNewType_coverage.ltx ../Final_Figures_and_Tables