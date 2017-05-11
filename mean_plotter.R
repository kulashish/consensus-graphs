library(ggplot2)
path.corel <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/Corel5k/"
#path.enron <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Enron/"
#path.medical <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Medical/"
#path.slashdot <- "/Users/ashish/Documents/personal/phd/aistats submission/Graphs_data/Slashdot/"
path.mediamill <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/mediamill/"
path.human <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/human_labeled/"

rel.medical <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/rel_vs_norel/medical.txt"
rel.enron <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/rel_vs_norel/enron.txt"
rel.flags <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/rel_vs_norel/flags.txt"

#all_plotter(path.enron)
#all_plotter(path.medical)
#all_plotter(path.slashdot)
all_plotter(path.corel)
all_plotter(path.mediamill)
all_plotter(path.human)

line_plotter(rel.medical)
line_plotter(rel.enron)
line_plotter(rel.flags)

line_plotter <- function(path) {
  data <- read.delim(path, header = F, col.names = c('iter', 'PL_norel', 'AL-U_norel', 'AL-I_norel', 'PL_rel', 'AL-U_rel', 'AL-I_rel'))
  size <- length(data$iter)
  norel.pl <- data[, c(1, 2)]
  colnames(norel.pl) <- c('iter', 'f')
  norel.pl$type <- rep("Rand-NR", size)
  norel.alu <- data[, c(1, 3)]
  colnames(norel.alu) <- c('iter', 'f')
  norel.alu$type <- rep("Unc-NR", size)
  norel.ali <- data[, c(1, 4)]
  colnames(norel.ali) <- c('iter', 'f')
  norel.ali$type <- rep("Inf-NR", size)
  rel.pl <- data[, c(1, 5)]
  colnames(rel.pl) <- c('iter', 'f')
  rel.pl$type <- rep("Rand-R", size)
  rel.alu <- data[, c(1, 6)]
  colnames(rel.alu) <- c('iter', 'f')
  rel.alu$type <- rep("Unc-R", size)
  rel.ali <- data[, c(1, 7)]
  colnames(rel.ali) <- c('iter', 'f')
  rel.ali$type <- rep("Inf-R", size)
  data <- rbind(norel.pl, norel.alu, norel.ali, rel.pl, rel.alu, rel.ali)
  data$type <- factor(data$type, levels = c("Rand-NR","Unc-NR","Inf-NR", "Rand-R", "Unc-R", "Inf-R"))
  line_plot(data)
}

all_plotter <- function(path) {
  pl <- read.delim(paste0(path, "PL.txt"), header = F, col.names = c('iter', 'mean', 'stddev'))
  pl$type <- "Rand-R"
  alu <- read.delim(paste0(path, "ALU.txt"), header = F, col.names = c('iter', 'mean', 'stddev'))
  alu$type <- "Unc-R"
  ali <- read.delim(paste0(path, "ALI.txt"), header = F, col.names = c('iter', 'mean', 'stddev'))
  #ali <- read.delim(paste0(path, "ALI.txt"), header = F, col.names = c('iter', 'mean'))
  #ali$stddev <- rep(0, nrow(ali))
  ali$type <- "Inf-R"
  data <- rbind(pl, alu, ali)
  mean_plot(data)
}

mean_plot <- function(data){
  data$type <- factor(data$type, levels = c("Rand-R", "Unc-R", "Inf-R"))
data$stderr <- data$stddev / sqrt(3)
ggplot(data, aes(x=iter, y=mean, colour = type)) + 
  geom_errorbar(aes(ymin=mean-stderr, ymax=mean+stderr), width=.1) +
  geom_line() +
  geom_point(aes(shape = type)) +
  xlab("Number of training instances") +
  ylab("micro-F1") +
  theme(legend.title=element_blank(), legend.justification = c(1,0), legend.position = c(1,0), 
        legend.background = element_rect(size = .2, colour = "black"),
        legend.key = element_rect(size = 5),
        legend.key.size = unit(2.2, 'lines'),
        panel.border = element_rect(color = "black", size = .2, fill = NA),
        legend.text = element_text(size = 40),
        axis.title = element_text(size = 40),
        axis.text = element_text(size = 40)
  )
}

line_plot <- function(data) {
 ggplot(data, aes(x=iter, y=f, group=type)) +
    geom_line(aes(linetype=type, color=type)) +
    geom_point(aes(shape=type, color=type)) +
    xlab("Number of training instances") +
    ylab("micro-F1") +
    theme(legend.title=element_blank(), legend.justification = c(1,0), legend.position = c(1,0), 
          legend.background = element_rect(size = .2, colour = "black"),
          legend.key = element_rect(size = 5),
          legend.key.size = unit(2.2, 'lines'),
          panel.border = element_rect(color = "black", size = .2, fill = NA),
          legend.text = element_text(size = 40),
          axis.title = element_text(size = 40),
          axis.text = element_text(size = 40)
          )
}
