require(ggplot2); require(scales)
library("readxl")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


# 1 panel combined plot, used in proposal
d1 = read.csv('roc_p3c0.csv')
d1$condition <- as.character(d1$condition)
d1$condition[d1$condition == '0'] <- '0.00'


#d2 = read.csv('roc_p3c1.csv')
d3 = read.csv('roc_p4c0.csv')


d4 = read.csv('roc_p4c1.csv')



d5 = read.csv('roc_p3c0_stdTax.csv')
d5
d5$METHOD <- as.character(d5$METHOD)
d5$METHOD[d5$METHOD == "kraken"] <- "kraken_std"
#d2 = read.csv('roc_p3c1.csv')
d6 = read.csv('roc_p4c0_stdTax.csv')
d6$METHOD <- as.character(d6$METHOD)
d6$METHOD[d6$METHOD == "kraken"] <- "kraken_std"
d6
d7 = read.csv('roc_p4c1_stdTax.csv')
d7$METHOD <- as.character(d7$METHOD)
d7$METHOD[d7$METHOD == "kraken"] <- "kraken_std"
d7


head (d)
colnames(d)

new_df
new_df <- do.call("rbind", list(d1, d3, d4, d5, d6, d7))

new_df <- new_df[new_df$METHOD != "lsh", ]
new_df <- new_df[new_df$DB != "kraken_std_bact_arch", ]
new_df <- new_df[new_df$condition != 0.04, ]


new_df =new_df[new_df$condition!="0.01",]
#new_df =new_df[new_df$condition!="p4c0",]


new_df

new_df$conditionb=new_df$condition



#keyheight = unit(0.2, 'inch')
#keyheight = unit(0.2, 'inch')


mean_d$METHOD <- as.character(mean_d$METHOD)


new_df
new_df$conditionb <- as.character(new_df$conditionb)


#install.packages("ggrepel")
library(ggrepel)
ggplot(new_df, aes(x=x.y/100, y=x.x/100))+
  geom_point(aes(color = METHOD, shape=DB),alpha=0.99)+
  geom_line(aes(group = interaction(DB,METHOD), color = METHOD))+
  theme_bw()+
  theme(legend.position = c(.63,.20), legend.direction = "horizontal",legend.margin=margin(t = 0.0, unit='cm'), legend.box.just = "right", legend.title=element_text(size=9), )+
  #coord_cartesian(ylim=c(0,1))+
  scale_y_continuous(breaks = c(0.0, 0.2, 0.4, 0.6, 0.8), name="True positive rate", labels = scales::percent_format(accuracy = 1), limits = c(0.0, NA))+
  scale_x_continuous(name="False positive rate", labels = scales::percent_format(accuracy = 1.0) )+
  scale_color_brewer(palette = "Dark2", name="Taxonomy", labels= c("Modified","Original"))+#, labels = c("0.00","p3c1","0.01","p3c2", "0.02","p4c1", "0.05","p4c2"))+
  scale_linetype_manual(values=c(2, 1),labels = c("GTDB","TOL"))+
  scale_size_manual(name="",values=c(0.5,1,1.5,2,1.5))+
  scale_shape_manual(name="", labels= c("GTDB","TOL"), values = c(19, 15), )+
  geom_text_repel(aes(label=conditionb), size=2,nudge_y = -0.0050, nudge_x = 0.0030)+
  #geom_text(data=new_df[new_df$conditionb == "p4c2",], aes(label=conditionb), size=2,nudge_y = -0.015,nudge_x = 0.0020)+
  guides(colour = guide_legend(order = 3, ncol=2), linetype = guide_legend(order = 1, reverse=FALSE, label.direction = "horizontal"), shape = guide_legend(order = 2, label.direction = "horizontal"))+
  theme(plot.margin=unit(c(0.2, 0.30, 0.1, 0.10),"cm"))
ggsave("ROC_kraken_std_cust_tax.pdf",width=5*0.9,height = 4*0.9)


#new_df$condition <- ifelse(new_df$METHOD == "kraken", "0.00", "p3c0")
#write.csv(new_df,"/Users/admin/Documents/local_sens_hash/cpp_results/test_sw/ROC_GTDB_gorg_combo_p3p4/roc_p3c0.csv", row.names = FALSE)


#limits = c(0.03, 0.15)







# obsolete
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

#d = d[d$db!= "tol_tree_clust",]
#d = subset(d, d$db != "tol_tree_clust")
#d2 = d[!d$db == "tol_tree_clust", ]
#mean_d = tapply(d$prct_matched, list(d$db, d$method), mean)
#mean_d <- mean_d[-c(4),]  # removed raw with tol_tree_clust
