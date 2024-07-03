#!/usr/bin/env Rscript
library(circlize)
library(pals)

args <- commandArgs(trailingOnly=TRUE)

print("Command line arguments: [Input Edgelist .csv] [Output Circos Positive .png] [Output Circos Negative .png]")
print(paste(args[1], args[2], args[3]), sep="\t")

# RUN CHORD DIAGRAM
build_chordDiagram <- function(matr) {
  # matr must have columns Node1, Node2, and a third column containing the
  # number of edges between Node1 and Node2 (named either Positive or Negative)
  num_colors <- length(union(unique(matr$Node1), unique(matr$Node2)))
  print(paste("Building circos plot with ", num_colors, " classes"))
  colors <- c()
  if (num_colors <= length(cols25())) {
    colors <- head(cols25(), num_colors)
  } else {
    # why are you using a circos plot with more than 20 categories thats insane... honestly 20 is already crazy
    colors <- rainbow(num_colors)
  }
  chordDiagram(matr, annotationTrack = "grid", preAllocateTracks = 1, grid.col = colors)
  circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
    xlim = get.cell.meta.data("xlim")
    ylim = get.cell.meta.data("ylim")
    sector.name = get.cell.meta.data("sector.index")
    circos.text(mean(xlim), ylim[1] + .2, sector.name, facing = "clockwise", niceFacing = TRUE, adj = c(0, 0.5), cex=.6)
    circos.axis(h = "top", labels.cex = 0.5, major.tick.length = mm_y(1), sector.index = sector.name, track.index = 2)
  }, bg.border = NA)
}

replacement_mapping <- c("Bacillariophyta" = "1Bacillariophyta",
                         "Alphaproteobacteria" = "2Alphaproteobacteria",
                         "Gammaproteobacteria" = "3Gammaproteobacteria",
                         "Syndiniales" = "4Syndiniales", 
                         "Bacteroidia" = "5Bacteroidia",
                         "Dinoflagellata" = "6Dinoflagellata")

swapped_mapping <- setNames(names(replacement_mapping), replacement_mapping)

# Function to replace strings based on the mapping
replace_strings <- function(strings, mapping) {
  sapply(strings, function(x) {
    if (x %in% names(mapping)) {
      return(mapping[[x]])
    } else {
      return(x)  # Return the original string if no replacement is found
    }
  })
}


# Read edgelist
edgelist_data = read.csv(args[1])
positive_matr = edgelist_data[-c(4)]
negative_matr = edgelist_data[-c(3)]

# Example usage
positive_matr$Node1 <- replace_strings(positive_matr$Node1, replacement_mapping)
positive_matr$Node2 <- replace_strings(positive_matr$Node2, replacement_mapping)
negative_matr$Node1 <- replace_strings(negative_matr$Node1, replacement_mapping)
negative_matr$Node2 <- replace_strings(negative_matr$Node2, replacement_mapping)


# v4 positive chordDiagram
png(args[2],width=9,height=9,units="in",res=900)
positive_matr <- positive_matr[order(positive_matr[, "Node1"], positive_matr[, "Node2"]), ]
positive_matr$Node1 <- replace_strings(positive_matr$Node1, swapped_mapping)
positive_matr$Node2 <- replace_strings(positive_matr$Node2, swapped_mapping)
positive_matr$Node1 = substr(positive_matr$Node1, 1, 10)
positive_matr$Node2 = substr(positive_matr$Node2, 1, 10)
build_chordDiagram(positive_matr)
dev.off()

# v4 negative chordDiagram
png(args[3],width=9,height=9,units="in",res=900)
negative_matr <- negative_matr[order(negative_matr[, "Node1"], negative_matr[, "Node2"]), ]
negative_matr$Node1 <- replace_strings(negative_matr$Node1, swapped_mapping)
negative_matr$Node2 <- replace_strings(negative_matr$Node2, swapped_mapping)
negative_matr$Node1 = substr(negative_matr$Node1, 1, 10)
negative_matr$Node2 = substr(negative_matr$Node2, 1, 10)
build_chordDiagram(negative_matr)
dev.off()

