library(ggplot2)
path.running <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/running_time.txt"

data <- read.delim(path.running, header = F, col.names = c('batch', 'pl', 'alu', 'ali'))
data.pl <- data[, c(1,2)]
colnames(data.pl) <- c('batch', 'time')
data.pl$type <- 'Rand-R'
data.alu <- data[, c(1,3)]
colnames(data.alu) <- c('batch', 'time')
data.alu$type <- 'Unc-R'
data.ali <- data[, c(1,4)]
colnames(data.ali) <- c('batch', 'time')
data.ali$type <- 'Inf-R'
data <- rbind(data.pl, data.alu, data.ali)
data$type <- factor(data$type, levels = c('Rand-R', 'Unc-R', 'Inf-R'))
data$batch <- factor(data$batch, levels = c('2', '5', '10', '25', '50', '100'))

ggplot(data, aes(x=batch, y=time, fill=type)) +
  geom_bar(stat = "identity", position=position_dodge(), width = .5) +
  xlab("Batch size") +
  ylab("Running time") +
  coord_flip() +
  scale_fill_grey() +
  theme(legend.title=element_blank(), legend.justification = c(1,1), legend.position = c(1,1), 
        legend.background = element_rect(size = .2, colour = "black"),
        legend.key = element_rect(size = 5),
        legend.key.size = unit(2.2, 'lines'),
        panel.border = element_rect(color = "black", size = .2, fill = NA),
        legend.text = element_text(size = 40),
        axis.title = element_text(size = 40),
        axis.text = element_text(size = 40)
  )