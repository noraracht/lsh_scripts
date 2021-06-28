require(ggplot2); require(scales); require(reshape2); require(Hmisc)
library("readxl")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


df = read.csv('dros_distances_updatedGTDB4.csv')
print (df)

colnames(df)

df_filt = read.csv('lsh_gtdb_results_dros_queries.csv')


df_filt

# merge prct_matched and FP into single df
df$filtered_prct <- df_filt$prct_matched[match(df$sample, df_filt$sp)]
df


## maximum error reduction computation for drosophila
#df$error_dif = abs(df$err_lsh_GTDB) - abs(df$err_after_bbmerge)
#df$abs_err = abs(df$error_dif)
#column1b <- df$abs_err[which(!is.na(df$abs_err))]
#round(max(column1b),4)
#round(max(df$filtered_prct), 2)
#round(min(df$filtered_prct), 2)



ds2= df
ds2$d2 = 0

ds2[as.character(ds2$variable)<as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)<as.character(ds2$sample),"dist_after_bbmerge"]
ds2[as.character(ds2$variable)>as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)>as.character(ds2$sample),"dist_after_lsh_GTDB"]



ggplot(aes(fill=(d2-true_dist)/true_dist,
           x=variable,y=paste(sample,percent(filtered_prct/100, accuracy = 0.01),sep="\n")),
       data=ds2)+
  geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  scale_fill_gradient2(name="Relative error",label=percent)#+
#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("Drosophila_tile_plot_lsh_GTDB.pdf",width=9,height = 8)
#ggsave("Drosophila_tile_plot_kraken_BacArKraken.pdf",width=9,height = 8)
#ggsave("test.pdf",width=9,height = 8)



# without % filtered (simpliest plot)
ggplot(aes(fill=(d2-true_dist)/true_dist,
           x=variable,y=sample),
       data=ds2)+
  geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  scale_fill_gradient2(name="Relative error",label=percent)#+
#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("Drosophila_tile_plot_lsh_GTDB.pdf",width=9,height = 8)




# figure to add to supplement
qplot(abs(df$err_lsh_GTDB)-abs(df$err_kraken_GTDB_conf0.04))+
  theme_bw()+
  scale_x_continuous(labels = percent, name = expression(CONSULT-KRAKEN~error))+
  geom_vline(xintercept = 0, color = "red")
ggsave("Kraken_vs_LSH_delta_relative_error_lsh_GTDB.pdf",width=5,height = 4)



#tile plot without percent filtered + val in cells, compares before (after bbmerge) and after (after lsh)

ds2= df
ds2$d2 = 0
#ds2[as.character(ds2$variable)<as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)<as.character(ds2$sample),"dist_after_human"]
ds2[as.character(ds2$variable)<as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)<as.character(ds2$sample),"dist_after_bbmerge"]

ds2[as.character(ds2$variable)>as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)>as.character(ds2$sample),"dist_after_lsh_GTDB"]
#ds2[as.character(ds2$variable)>as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)>as.character(ds2$sample),"dist_after_kraken_GTDB"]
#ds2[as.character(ds2$variable)>as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)>as.character(ds2$sample),"dist_after_lsh_BacArchKraken"]
#ds2[as.character(ds2$variable)>as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)>as.character(ds2$sample),"dist_after_kraken_BacArchKraken"]

ggplot(aes(fill=(d2-true_dist)/true_dist,
           x=variable,y=sample),
       data=ds2)+
  geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  scale_fill_gradient2(name="Relative error",label=percent)+
  geom_text(aes(label = round((d2-true_dist)/true_dist, 2)), size = 3)#+
#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
#ggsave("Drosophila_tile_plot_krakrn_GTDB.pdf",width=9,height = 8)
#ggsave("Drosophila_tile_plot_kraken_BacArKraken_2.pdf",width=9,height = 8)
#ggsave("test.pdf",width=9,height = 8)





###### dot plot ###### 
df$filtered_prct.y <- df_filt$prct_matched[match(df$variable, df_filt$sp)]
df


ggplot(aes(color=abs(dist_after_bbmerge-true_dist)/true_dist,y=abs(dist_after_bbmerge-true_dist)/true_dist-abs(dist_after_lsh_GTDB-true_dist)/true_dist, 
           x=(filtered_prct+filtered_prct.y)/200),
       data=df)+
  geom_point(alpha=0.99)+geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(legend.position = c(.20,.77))+
  scale_color_continuous(name="Error before filtering",label=percent)+
  scale_y_continuous(labels=percent,name="Change in relative error after filtering")+
  scale_x_continuous(name=("Proportion filtered"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("Drosophila--proportion_filtered-delta_in_error_lsh_GTDB.pdf",width=5,height = 4)
#ggsave("Drosophila--proportion_filtered-delta_in_error_updated_conf0.05.pdf",width=5,height = 4)




####################  crinodea tile plot #################### 
df<-df[!(df$sample =="C079_Promachocrinus_kerguelensis"),]
df<-df[!(df$variable=="C079_Promachocrinus_kerguelensis"),]

# Create heatmap with ggplot2
ggp <- ggplot(df, aes(sample, variable)) +                          
  geom_tile(aes(fill = dist_after_kraken))+
  #geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  scale_fill_gradient(name="Distance",label=percent)#+
#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggp 

ggsave("Crinoidea_tile_plot.pdf",width=9,height = 8)

                           

#################### from previous paper #################### 
# command used for drosophila tile plot in E3_script_dros_real_noABS.R
ds2= ds
ds2$d2 = 0
ds2[as.character(ds2$s1)<as.character(ds2$s2),"d2"] =ds2[as.character(ds2$s1)<as.character(ds2$s2),"bk_cleaned"]
ds2[as.character(ds2$s1)>as.character(ds2$s2),"d2"] =ds2[as.character(ds2$s1)>as.character(ds2$s2),"ak_cleaned"]

ggplot(aes(fill=(d2-fna_dist)/fna_dist, 
           x=paste(s1,percent(C_sequences_prct.x/100),sep="\n"),y=paste(s2,percent(C_sequences_prct.y/100),sep="\n")),
       data=ds2)+
  geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  scale_fill_gradient2(name="Relative error",label=percent)#+
scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("Drosophila_tile_plot.pdf",width=9,height = 8)



#new_df = merge(df, mean_fp, by=c("DB", "METHOD"))
#merge(table1, table2[, c("pid", "col2")], by="pid")
#new_df