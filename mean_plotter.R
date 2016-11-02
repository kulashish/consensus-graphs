library(ggplot2)
path.corel <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Corel5k/"
path.enron <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Enron/"
path.medical <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Medical/"
path.slashdot <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Slashdot/"

all_plotter(path.enron)
all_plotter(path.medical)
all_plotter(path.slashdot)
all_plotter(path.corel)

all_plotter <- function(path) {
  pl <- read.delim(paste0(path, "PL.txt"), header = F, col.names = c('iter', 'mean', 'stddev'))
  pl$type <- "PL"
  alu <- read.delim(paste0(path, "ALU.txt"), header = F, col.names = c('iter', 'mean', 'stddev'))
  alu$type <- "AL-U"
  #ali <- read.delim(paste0(path, "ALI.txt"), header = F, col.names = c('iter', 'mean', 'stddev'))
  ali <- read.delim(paste0(path, "ALI.txt"), header = F, col.names = c('iter', 'mean'))
  ali$stddev <- rep(0, nrow(ali))
  ali$type <- "AL-I"
  data <- rbind(pl, alu, ali)
  mean_plot(data)
}

mean_plot <- function(data){
data$stderr <- data$stddev / sqrt(3)
ggplot(data, aes(x=iter, y=mean, colour = type)) + 
  geom_errorbar(aes(ymin=mean-stderr, ymax=mean+stderr), width=.1) +
  geom_line() +
  geom_point(aes(shape = type)) +
  xlab("Number of training instances") +
  ylab("micro-F1") +
  theme(legend.title=element_blank())
}

