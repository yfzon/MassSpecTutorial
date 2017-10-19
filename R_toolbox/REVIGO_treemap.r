

# A treemap R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","freqInDbPercent","abslog10pvalue","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0009611","response to wounding",2.056,1.7181,0.767,0.000,"response to wounding"),
c("GO:0042060","wound healing",1.314,1.7339,0.771,0.559,"response to wounding"),
c("GO:0006952","defense response",3.096,1.5487,0.763,0.624,"response to wounding"),
c("GO:0006955","immune response",27.347,2.2341,0.887,0.153,"response to wounding"),
c("GO:0006953","acute-phase response",0.088,1.3618,0.797,0.421,"response to wounding"),
c("GO:0010743","regulation of macrophage derived foam cell differentiation",0.071,5.6021,0.674,0.000,"regulation of macrophage derived foam cell differentiation"),
c("GO:0045596","negative regulation of cell differentiation",1.429,1.6338,0.694,0.577,"regulation of macrophage derived foam cell differentiation"),
c("GO:0018149","peptide cross-linking",0.099,1.5458,0.892,0.029,"peptide cross-linking"),
c("GO:0010883","regulation of lipid storage",0.088,3.6234,0.525,0.049,"regulation of lipid storage"),
c("GO:0042632","cholesterol homeostasis",0.149,1.3837,0.729,0.357,"regulation of lipid storage"),
c("GO:0051674","localization of cell",2.570,1.3529,0.735,0.369,"regulation of lipid storage"),
c("GO:0015671","oxygen transport",0.154,1.8439,0.747,0.200,"regulation of lipid storage"),
c("GO:0048870","cell motility",2.570,1.3529,0.697,0.266,"regulation of lipid storage"),
c("GO:0015669","gas transport",0.161,1.7037,0.746,0.268,"regulation of lipid storage"),
c("GO:0034377","plasma lipoprotein particle assembly",0.024,1.8784,0.785,0.056,"plasma lipoprotein particle assembly"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$abslog10pvalue <- as.numeric( as.character(stuff$abslog10pvalue) );
stuff$freqInDbPercent <- as.numeric( as.character(stuff$freqInDbPercent) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
pdf( file="revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
tmPlot(
	stuff,
	index = c("representative","description"),
	vSize = "abslog10pvalue",
	type = "categorical",
	vColor = "representative",
	title = "REVIGO Gene Ontology treemap",
	inflate.labels = FALSE,      # set this to TRUE for space-filling group labels - good for posters
	lowerbound.cex.labels = 0,   # try to draw as many labels as possible (still, some small squares may not get a label)
	bg.labels = "#CCCCCCAA",     # define background color of group labels
												       # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
	position.legend = "none"
)

dev.off()
