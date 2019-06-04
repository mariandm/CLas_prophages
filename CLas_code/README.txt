#README
Each figure has its corresponding folder that contains all the files you need to generate the figures.
In each folder there is a Rscript to generate figures. 
You can run all Rscripts with previously generated data (alignments or homology search) by using RunFigures.sh
Nonetheless, the RunFiguresExtended.sh script has the code to generate figures from "raw data" (see RunFiguresExtended.sh documentation).
Both RunFigures.sh and RunFiguresExtended.sh must be run from the main folder "CLas_code"
The sequences folder contains the sequences used in the analysis obtained from PHASTER and Virsorter.
Output tables 4, 5 and Suppl. Table 1 are in latex format but do not contain code to immediatly run them.

#Required Rpackages:
genoPlotR(v0.8.9)
gplots(v3.0.1.1)

#Required programs: 
Mauve(http://darlinglab.org/mauve/mauve.html)
get_homologues(https://github.com/eead-csic-compbio/get_homologues)
BLAST+(https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download)