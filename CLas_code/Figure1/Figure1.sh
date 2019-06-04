#Figure 1

#Mauve Alignments
/Applications/Mauve.app/Contents/MacOS/progressiveMauve ../sequences/Ishi-1-a.fasta FL17_united.fasta --output Ishi-1-avsFL17united.alignment --backbone-output Ishi-1-avsFL17united.backbone

/Applications/Mauve.app/Contents/MacOS/progressiveMauve FL17_united.fasta SC1FLIP.GCA_000901995.1_ViralProj181990_genomic.fna --output FL17unitedvsSC1Flip.alignment --backbone-output FL17unitedvsSC1Flip.backbone

/Applications/Mauve.app/Contents/MacOS/progressiveMauve ../sequences/Ishi-1-a.fasta AHCA1_extended.fasta --output Ishi-1-avsAHCA1extended.alignment --backbone-output Ishi-1-avsAHCA1extended.backbone

/Applications/Mauve.app/Contents/MacOS/progressiveMauve AHCA1_extended.fasta P_JXGC_3FLIP.GCA_002620145.1_ASM262014v1_genomic.fna --output AHCA1extendedvsP-JXGC-3Flip.alignment --backbone-output AHCA1extendedvsP-JXGC-3Flip.backbone

#genoPlotR
Rscript ./Figure1genoplotR.R

