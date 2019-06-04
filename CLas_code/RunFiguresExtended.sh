#This script must be run from the folder CLas_code
#This script contains all code needed to run figures and tables from raw data (especified in each figure).
#Each Figure Folder is self contained (it has all elements required to obtain the figure)
#You can get the figures without running alignments and homology search using previously generated data with the script: RunFigures.sh
#Note: You may need to change the path for running mauve alignments in Figure 1 and 4 according to the localization of the progressiveMauve in your computer
#Note: The BidirectionalBLAST script for Table 4, 5 and S1 makes a temporal file cleaning

#Figure 1
#Raw Data Fig1a: Sequences Ishi-1-a, FL17-a,b,c, SC1 genome as integrated, and Ishi-1-a, FL17-a, annotation
#Raw Data Fig1b: Sequences Ishi-1-a, AHCA1 extended, P-JXGC-3 genome as integrated, and Ishi-1-a, AHCA1-a, annotation

cd Figure1

#Mauve Alignments
/Applications/Mauve.app/Contents/MacOS/progressiveMauve Ishi-1-a.fasta FL17_united.fasta --output Ishi-1-avsFL17united.alignment --backbone-output Ishi-1-avsFL17united.backbone
/Applications/Mauve.app/Contents/MacOS/progressiveMauve FL17_united.fasta SC1FLIP.GCA_000901995.1_ViralProj181990_genomic.fna --output FL17unitedvsSC1Flip.alignment --backbone-output FL17unitedvsSC1Flip.backbone

/Applications/Mauve.app/Contents/MacOS/progressiveMauve Ishi-1-a.fasta AHCA1_extended.fasta --output Ishi-1-avsAHCA1extended.alignment --backbone-output Ishi-1-avsAHCA1extended.backbone
/Applications/Mauve.app/Contents/MacOS/progressiveMauve AHCA1_extended.fasta P_JXGC_3FLIP.GCA_002620145.1_ASM262014v1_genomic.fna --output AHCA1extendedvsP-JXGC-3Flip.alignment --backbone-output AHCA1extendedvsP-JXGC-3Flip.backbone

#genoplotR
Rscript ./Figure1genoplotR.R

cd ..


#Figure2
#Raw Data: GeneMarkS CDS predictions of predicted sequences and NCBI prophage genomes

cd Figure2

get_homologues 
get_homologues.pl -d CDSprediction/ -A -c -t 0 -M -n 10
compare_clusters.pl -o sample_intersection -d CDSprediction_homologues/*axa_algOMCL_e0_/ -m
#parsing presence matrix
cut -f1,15-51 -d "," sample_intersection/pangenome_matrix_t0.tr.csv | perl -pe 's/\.faa//g' | perl -pe 's/\.gms\.out//g' > presence_matrix.csv

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

#Mauve Alignments
/Applications/Mauve.app/Contents/MacOS/progressiveMauve Ishi-1-a.fasta ./CLam.ReverseComplement.GCA_000350385.1.fasta --output Ishi-1-avsCLamRC.alignment --backbone-output Ishi-1-avsCLamRC.backbone
/Applications/Mauve.app/Contents/MacOS/progressiveMauve ./CLaf.GCA_001021085.1.fasta Ishi-1-a.fasta  --output CLafvsIshi-1-a.alignment --backbone-output CLafvsIshi-1-a.backbone

#genoplotR
Rscript ./Figure4ClafvsIshi-1-avsCLam_genoPlotR.R

cd ..

#Table 4
#Raw Data: Predicted prophage sequences, Representative phages genomes, "all" file: All sequences name, "repre" file: Representative phages names

cd Table4

./BidirectionalBLAST.sh
perl -pe 's/\n/\\\\\\hline\n/g' Table4_RepresentativevsAll.ltx > tmp; mv tmp Table4_RepresentativevsAll.ltx
mv Table4_RepresentativevsAll.ltx ../Final_Figures_and_Tables

cd ..

#Table 5
#Raw Data: Predicted prophage sequences, "all" and "repre" file: All sequences names

cd Table5

./BidirectionalBLAST.sh

cd ..

#Suppl. Table 1
#Raw Data: Predicted prophage sequences, "all" and "repre" file: All sequences names. Only the Type 4 part of AHCA1-a and FL17-a was used. 

cd Suppl.Table1

./BidirectionalBLAST.sh

cd ..
