library(ggplot2)
path.batchsize <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/batch_size_alu/"
path.batchsize.ali <- "/Users/kulkashi/Documents/PhD/ijcai/graphs_data/batch_size_ali/"
batch_plotter(path.batchsize.ali)

batch_plotter <- function(path) {
  alu.2 <- read.delim(paste0(path, "ALI-2.txt"), header = F, col.names = c('iter', 'f'))
  alu.2$type <- "Inf-R2"
  alu.5 <- read.delim(paste0(path, "ALI-5.txt"), header = F, col.names = c('iter', 'f'))
  alu.5$type <- "Inf-R5"
  alu.10 <- read.delim(paste0(path, "ALI-10.txt"), header = F, col.names = c('iter', 'f'))
  alu.10$type <- "Inf-R10"
  alu.25 <- read.delim(paste0(path, "ALI-25.txt"), header = F, col.names = c('iter', 'f'))
  alu.25$type <- "Inf-R25"
  alu.50 <- read.delim(paste0(path, "ALI-50.txt"), header = F, col.names = c('iter', 'f'))
  alu.50$type <- "Inf-R50"
  alu.100 <- read.delim(paste0(path, "ALI-100.txt"), header = F, col.names = c('iter', 'f'))
  alu.100$type <- "Inf-R100"
  data <- rbind(alu.2, alu.5, alu.10, alu.25, alu.50, alu.100)
  data$type <- factor(data$type, levels = c("Inf-R2","Inf-R5","Inf-R10", "Inf-R25", "Inf-R50", "Unc-R100"))
  line_plot(data)
}