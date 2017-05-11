library(ggplot2)
path.running.all <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/running_time/"

data <- read.delim(paste0(path.running.all,'PL.txt'), header = F, col.names = c('iter', 't1', 't2', 'total'))
data.t1 <- data[, c(1,2)]
colnames(data.t1) <- c('iter', 'time')
data.t1$type <- 't1'
data.t2 <- data[, c(1,3)]
colnames(data.t2) <- c('iter', 'time')
data.t2$type <- 't2'
data.total <- data[, c(1,4)]
colnames(data.total) <- c('iter', 'time')
data.total$type <- 'total'
data <- rbind(data.t1, data.t2, data.total)
data$type <- factor(data$type, levels = c('t1', 't2', 'total'))

ggplot(data, aes(x=iter, y=time, group=type)) +
  geom_line(aes(linetype=type, color=type)) +
  geom_point(aes(shape=type, color=type)) +
  xlab("Iterations") +
  ylab("Running time (s) log10-scale") +
  scale_y_log10() + 
  theme(legend.title=element_blank(), legend.justification = c(1,0.5), legend.position = c(1,0.5), 
        legend.background = element_rect(size = .2, colour = "black"),
        legend.key = element_rect(size = 5),
        legend.key.size = unit(2.2, 'lines'),
        panel.border = element_rect(color = "black", size = .2, fill = NA),
        legend.text = element_text(size = 40),
        axis.title = element_text(size = 40),
        axis.text = element_text(size = 40)
  )