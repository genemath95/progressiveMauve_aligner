# Author: Mathew Gene
# Original ggplot code contributed by Jennifer Guthrie
# Date: June 7th, 2019

# Uses command-line progressiveMauve backbone output to create segment graph

print("segment-plot-batch.R script initialized.")

# Load necessary package
library(ggplot2)
library(dplyr)

# Set working directory
setwd("/Users/mathewgene/Documents/rstudio/entFM-phos")

# Run script for only .csv files
all_files <- list.files()
my_files <- grep("*.csv", all_files, value=T)

# Create segement plot for each .csv file
for(i in my_files){
  plasmid_name = tools::file_path_sans_ext(i)
  fp <- paste("/Users/mathewgene/Documents/rstudio/entFM-phos/", i, sep = "")
  output <- paste("/Users/mathewgene/Documents/rstudio/entFM-phos/", plasmid_name, ".png", sep = "")
  
  # Import data
  mydata <- read.csv(fp, header = TRUE, na.strings=c("","NA"), stringsAsFactors=FALSE)
  
  # Arrange data to only plot regions in the isolate that have plasmid homology
  mydata <- mydata %>%
    filter(seq1_leftend != 0) %>%
    as.data.frame()
  
  # Plot
  ggplot(mydata, aes(x = seq0_leftend, xend = seq0_rightend, y = Isolate_ID, yend = Isolate_ID)) + 
    geom_segment(aes(color = Isolate_ID),position = position_dodge(width = 0.2), size = 3, show.legend = F) +
    ggtitle(plasmid_name) +
    theme(panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          axis.line.x = element_line(colour = "black"),
          axis.ticks = element_blank(),
          axis.text.y = element_text(size=2),
          plot.title = element_text(hjust = 0.5, size = 40))
  
  # Save plot to png
  ggsave(output, width = 16, height = 22, units = "in", limitsize = FALSE) 
  
  # Output progress to console
  message <- paste(plasmid_name, "segment plot finished.", sep = " ")
  print(message)
}

print("Script complete. :)")


