require(ggplot2); require(scales); require(reshape2); require(Hmisc)
library("readxl")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#d = read.csv('total_var.csv')
d = read.csv('total_var_parameter_setting_1026.csv')

require(Hmisc)

ld = d[,c(3,8:11,2,17)]
ld
names(ld) <- c("Recall","k","l","b","t","Memory (disk)","% k-mer")

latex(round(ld,3),file = "parameter-setting.tex", rowname = NULL)
