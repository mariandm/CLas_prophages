#This script must be run from the folder CLas_code
#This script contains all code needed to run figures and tables using preprocesed data (alignments and homology search).
#Each Figure Folder is self contained (it has the elements required to obtain the figure)
#You can get the figures from raw data (running alignments and homology search) using the script: RunFiguresExtended.sh

#Figure 1
#Raw Data Fig1a: Sequences Ishi-1-a, FL17-a,b,c, SC1 genome as integrated, and Ishi-1-a, FL17-a, annotation
#Raw Data Fig1b: Sequences Ishi-1-a, AHCA1 extended, P-JXGC-3 genome as integrated, and Ishi-1-a, AHCA1-a, annotation

cd Figure1

#genoplotR
Rscript ./Figure1genoplotR.R

cd ..


#Figure2
#Raw Data: GeneMarkS CDS predictions of predicted sequences and NCBI prophage genomes

cd Figure2

#Generating heatmap and dendograms
Rscript ./Figure2_HeatmapHomologous_T4cut.R

cd ..

#Figure 3
#Raw Data: Ishi-1-a annotation

cd Figure3

Rscript Figure3_Ishi-1-a_annotation_genoplotR.R

cd ..

#Figure 4
#Raw Data: Sequence Ishi-1-a sequence, CLaf genome, CLam genome reverse complemented, Ishi-1-a annotation

cd Figure4

Rscript ./Figure4ClafvsIshi-1-avsCLam_genoPlotR.R

cd ..

#Table 4
#Raw Data: Predicted prophage sequences, Representative phages genomes, "all" file: All sequences name, "repre" file: Representative phages names

cd Table4

Rscript ./BLASTvaluesEvaluation.R
perl -pe 's/\n/\\\\\\hline\n/g' Table4_RepresentativevsAll.ltx > tmp; mv tmp Table4_RepresentativevsAll.ltx
mv Table4_RepresentativevsAll.ltx ../Final_Figures_and_Tables

cd ..

#Table 5
#Raw Data: Predicted prophage sequences, "all" and "repre" file: All sequences names

cd Table5

Rscript ./BLASTvaluesEvaluation.R
perl -pe 's/\n/\\\\\\hline\n/g' Table5_NewTypevsNewType_coverage.ltx > tmp; mv tmp Table5_NewTypevsNewType_coverage.ltx
mv Table5_NewTypevsNewType_coverage.ltx ../Final_Figures_and_Tables

cd ..

#Suppl. Table 1
#Raw Data: Predicted prophage sequences, "all" and "repre" file: All sequences names. Only the Type 4 part of AHCA1-a and FL17-a was used. 

cd Suppl.Table1

Rscript ./BLASTvaluesEvaluation.R
perl -pe 's/\n/\\\\\\hline\n/g' Suppl.Table1_T4vsT4.ltx > tmp; mv tmp Suppl.Table1_T4vsT4.ltx
mv Suppl.Table1_T4vsT4.ltx ../Final_Figures_and_Tables

cd ..
