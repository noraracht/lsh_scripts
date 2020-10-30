require(ggplot2); require(scales)
library("readxl")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()



d = read.csv('compare_gorg_kraken_vs_lsh_matched.csv')
head (d)
colnames(d)

## script to generate histogram for % matched comparison between CONSULT and Kraken
## GTDB DB, gorg queries
qplot(us.kraken,data=d,binwidth=0.1)+
  theme_classic()+
  xlab("CONSULT- Kraken")

ggplot(data=d, aes(d$us.kraken)) + 
  geom_histogram(binwidth = 0.1)+
  theme_classic()+labs(x=expression(CONSULT - KRAKEN), y="Sample count")
ggsave("prct_match_difference_hist.pdf",width=5,height = 4)
  





# Loading
# xlsx files
#df <- read_excel("kraken_bl_10Mqueries.xlsx")
#print (df)



#getwd()
#setwd('/Users/admin/Documents/local_sens_hash')

#d = d[d$db!= "tol_tree_clust",]
#d = subset(d, d$db != "tol_tree_clust")
#d2 = d[!d$db == "tol_tree_clust", ]
#mean_d = tapply(d$prct_matched, list(d$db, d$method), mean)
#mean_d <- mean_d[-c(4),]  # removed raw with tol_tree_clust
