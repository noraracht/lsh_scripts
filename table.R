
d = read.csv('total_var.csv')

require(Hmisc)

ld = d[,c(3,8:11,2,17)]
ld
names(ld) <- c("Recall","k","l","b","t","Memory (disk)","% k-mer")

latex(round(ld,3),file = "parameter-setting.tex", rowname = NULL)
