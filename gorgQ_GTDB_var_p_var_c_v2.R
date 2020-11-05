require(ggplot2); require(scales)
library("readxl")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


# 1 panel combined plot, used in proposal
#d = read.csv('combined_gorg_v1_results_incomplete_c1.csv')
#d = read.csv('combined_gorg_v1_results_var_p.csv')
d = read.csv('combined_gorg_v1_results_var_p_extended.csv')
head (d)
colnames(d)

#ggplot(aes(x=prct_not_matched/100,color=method,linetype=db),data=d[d$db!= "tol_tree_clust",])+stat_ecdf()+
  #facet_wrap(~db)+
#  theme_bw()+theme(legend.position = c(.89,.28), legend.margin=margin(t = 0.1, unit='cm'), )+
#  scale_x_continuous(labels=function(x) percent(1-x),name="Percent matched")+
#  scale_y_continuous(name="ECDF (percent of query genomes)",labels=percent)+
#  scale_color_brewer(palette = "Dark2",name="",labels=c("Kraken","LSH"))+scale_linetype_manual(values=c(1,3,4),name="",labels=c("GTDB","Kraken","TOL"))
#ggsave("contam_p4c1.pdf",width=5,height = 4)




# compute mean values based on percent matched per DB per tool
mean_d <- aggregate(d$prct_matched, 
                    by = list(DB = d$db, METHOD = d$method, P = d$p, C = d$c), 
                    FUN = mean)
mean_d = mean_d[mean_d$DB!= "tol_tree_clust",]

# replace "us" with "lsh" in method columns
mean_d$METHOD <- as.character(mean_d$METHOD) 
mean_d$METHOD[mean_d$METHOD == "us"] <- "lsh"
mean_d$METHOD <- as.character(mean_d$METHOD)

mean_d


# read FP results for corresponding datasets
#fp = read.csv('/Users/admin/Documents/local_sens_hash/cpp_results/test_sw/var_p_GTDB_GORGqueries_CONSULT_only/fp/combined_10M_FP_plants_results_var_p_var_c.csv')
fp = read.csv('/Users/admin/Documents/local_sens_hash/cpp_results/test_sw/var_p_GTDB_GORGqueries_CONSULT_only/fp/combined_10M_FP_plants_results_var_p_var_c_extended.csv')
mean_fp <- aggregate(fp$prct_matched, 
                     by = list(DB = fp$db, METHOD = fp$method, P = fp$p, C = fp$c), 
                     FUN = mean)
mean_fp = mean_fp[mean_fp$DB!= "refseq",]
mean_fp

# merge prct_matched and FP into single df
new_df = merge(mean_d, mean_fp, by=c("DB", "METHOD", "P", "C"))
new_df


#create ROC plot
mean_d$P <- as.character(mean_d$P)
mean_d$C <- as.character(mean_d$C)



p<-ggplot(new_df, aes(x=x.y/100, y=x.x/100))+
  geom_point(aes(shape = factor(C), colour = factor(P)), size = 2)+
  geom_line(aes(color = factor(P)))+
  theme_bw()+
  theme(legend.position = c(.76,.20), legend.margin=margin(t = 0.1, unit='cm'), )+
  #coord_cartesian(ylim=c(0,1))+
  scale_y_continuous(name="True positive rate", labels = scales::percent_format(accuracy = 1), limits = c(0.4, NA))+
  scale_x_continuous(name="False positive rate", labels = scales::percent_format(accuracy = 1.0) )+
  #scale_color_brewer(palette = "Dark2", name=expression(~italic(k-mers)~' matched'), labels=c(">= 1",">= 2"))+
  scale_color_brewer(palette = "Dark2", name=expression(~italic(m)), labels=c("3","4", "5", "6"))+
  scale_shape_manual(values=c(16, 15, 17, 8), name=expression(~italic(c)), labels=c("1","2", "3", "4"))+
  guides(colour = guide_legend(order = 2, label.direction = "horizontal", ncol = 4), shape = guide_legend(order = 1, reverse=FALSE, label.direction = "horizontal", ncol = 4))+
  theme(plot.margin=unit(c(0.2, 0.45, 0.1, 0.2),"cm"))
p
ggsave(plot=p, "ROC_var_p_var_c_gorgQ_GTDB_LSH_extended.pdf",width=5,height = 4)

new_df

#limits = c(0.03, 0.15)




# clark comparison
d = read.csv('clark_kraken_lsh_gorg_queries_1x.csv')
head (d)
colnames(d)

ggplot(aes(x=prct_not_matched/100,color=method),data=d)+stat_ecdf()+
  #facet_wrap(~db)+
  theme_bw()+theme(legend.position = c(.13,.84), legend.margin=margin(t = -0.4, unit='cm'),)+
  scale_x_continuous(labels=function(x) percent(1-x),name="Percent matched")+
  scale_y_continuous(name="ECDF (percent of query genomes)",labels=percent)+
  scale_color_brewer(palette = "Dark2",name="",labels=c("Clark", "Kraken","LSH"))
ggsave("clark_kraken_lsh_gorg.pdf",width=5,height = 4)



# bowtie comparison
d = read.csv('bowtie_kraken_lsh_tol_db_gorg_queries_1x.csv')
head (d)
colnames(d)

ggplot(aes(x=prct_not_matched/100,color=method),data=d)+stat_ecdf()+
  #facet_wrap(~db)+
  theme_bw()+theme(legend.position = c(.13,.84), legend.margin=margin(t = -0.4, unit='cm'),)+
  scale_x_continuous(labels=function(x) percent(1-x),name="Percent matched")+
  scale_y_continuous(name="ECDF (percent of query genomes)",labels=percent)+
  scale_color_brewer(palette = "Dark2",name="", labels=c("Bowtie", "Kraken","LSH"))
ggsave("bowtie_kraken_lsh_gorg.pdf",width=5,height = 4)




#
#legend.box.margin=margin(-10,-10,-10, -10)


# 4 panel plot
d = read.csv('combined_gorg_v1_results.csv')
ggplot(aes(x=prct_not_matched/100,color=method),data=d)+stat_ecdf()+facet_wrap(~db)+
  theme_bw()+scale_x_continuous(labels=percent)



# Loading
# xlsx files
#df <- read_excel("kraken_bl_10Mqueries.xlsx")
#print (df)



#getwd()
#setwd('/Users/admin/Documents/local_sens_hash')
