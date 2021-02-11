require(ggplot2); require(scales); require(reshape2); require(Hmisc)
library("readxl")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()



# dotplot
df = read.csv('combined_horizontal_mitoZ_filt_unfilt_full.csv')
#df = df[(df$gene_x) == "ND1",]
df
colnames(df)
dim(df)




ggplot(df, aes(x=len_lrgst_mito_node_y,
               y=len_lrgst_mito_node_x,
               colour=as.character(group_x), shape = as.character(Publicly.Available.Species_x))) +
  geom_point(alpha = 0.7, size = 2.4)+
  #geom_smooth(se=F,method="lm",color="red")+
  #theme_light()+
  #theme_bw()+
  theme_classic()+
  #theme(axis.line = element_line(colour = "black"),
  #      panel.grid.major = element_blank(),
  #      panel.grid.minor = element_blank(),
  #      panel.border = element_blank(),
  #      panel.background = element_blank()) +
  #theme(legend.position = c(.20,.77))+
  scale_color_manual(name="Sample group", labels = c('unassembled', 'medium quality', 'good quality'), values = c("#0571b0", "#f4a582", "#ca0020"))+
  scale_shape_discrete(name="Species in db", labels = c('no', 'yes'))+
  scale_y_continuous(name="Filtered (bp)", )+
  scale_x_continuous(name="Not filtered (bp)")+
  geom_hline(color="black",linetype=2, yintercept = 16000, size=0.3)+
  geom_vline(color="black",linetype=2, xintercept = 16000, size=0.3)+
  geom_abline(slope=1, size = 0.3, color = "grey")+
  #theme(legend.text=element_text(size=10), legend.title=element_text(size=10))+
  theme(legend.position="none")

ggsave("mito_contig_len_dots.pdf",width=3,height = 3)



ggplot(df, aes(x=total_genes_mito_node_y,
               y=total_genes_mito_node_x,
               colour=as.character(group_x), shape = as.character(Publicly.Available.Species_x))) +
  geom_point(alpha = 0.7, size = 2.4)+
  #geom_smooth(se=F,method="lm",color="red")+
  #theme_light()+
  #theme_bw()+
  theme_classic()+
  #theme(axis.line = element_line(colour = "black"),
  #      panel.grid.major = element_blank(),
  #      panel.grid.minor = element_blank(),
  #      panel.border = element_blank(),
  #      panel.background = element_blank()) +
  #theme(legend.position = c(.20,.77))+
  scale_color_manual(name="Sample group", labels = c('unassembled', 'medium quality', 'good quality'), values = c("#0571b0", "#f4a582", "#ca0020"))+
  scale_shape_discrete(name="Species in db", labels = c('no', 'yes'))+
  scale_y_continuous(name="Filtered", )+
  scale_x_continuous(name="Not filtered")+
  geom_hline(color="black",linetype=2, yintercept = 37, size=0.3)+
  geom_vline(color="black",linetype=2, xintercept = 37, size=0.3)+
  geom_abline(slope=1, size = 0.3, color = "grey")+
  #theme(legend.text=element_text(size=10), legend.title=element_text(size=10))+
  theme(legend.position="none")

ggsave("mito_gene_dots.pdf",width=3,height = 3)



# get only legend
ggplot(df, aes(x=total_genes_mito_node_y,
               y=total_genes_mito_node_x,
               colour=as.character(group_x), shape = as.character(Publicly.Available.Species_x))) +
  geom_point(alpha = 0.7, size = 2.4)+
  #geom_smooth(se=F,method="lm",color="red")+
  #theme_light()+
  #theme_bw()+
  theme_classic()+
  #theme(axis.line = element_line(colour = "black"),
  #      panel.grid.major = element_blank(),
  #      panel.grid.minor = element_blank(),
  #      panel.border = element_blank(),
  #      panel.background = element_blank()) +
  #theme(legend.position = c(.20,.77))+
  scale_color_manual(name="Sample group", labels = c('Unassembled', 'Poor', 'Good'), values = c("#0571b0", "#f4a582", "#ca0020"))+
  scale_shape_discrete(name="Species in db", labels = c('no', 'yes'))+
  scale_y_continuous(name="Filtered", )+
  scale_x_continuous(name="Not filtered")+
  geom_hline(color="black",linetype=2, yintercept = 37, size=0.3)+
  geom_vline(color="black",linetype=2, xintercept = 37, size=0.3)+
  geom_abline(slope=1, size = 0.3, color = "grey")+
  theme(legend.text=element_text(size=10), legend.title=element_text(size=10))
  #theme(legend.position="none")

ggsave("legend_mito.pdf",width=3,height = 3)


# big heatmap 


#df without danish original samples, only filt and unfilt
#df = read.csv('combined_mitoZ_filt_unfilt_full.csv')

#df with danish original samples + ours filt and unfilt
df = read.csv('combined_mitoZ_filt_unfilt_originalDanish_full.csv')


levels(df$condition) = list("Filtered"="filt" , "Not filtered"="unfilt", "Original"="original")
df$group=as.factor(df$group)
levels(df$group) = list("Unassmbled" = "1", "Poor" =  "2", "Good" ="3" )
head (df)

colnames(df)


#ds2 = df[as.character(df$condition) == "unfilt",]
ds2 = df


#ds2[ds2$sample == "SRR12432370", "is_found"]=NA

ds2$gene <- factor(ds2$gene, levels=unique(ds2$gene)) # good
#ds2$sample <- reorder(ds2$sample, -ds2$group)

#ds2$group <- as.numeric(ds2$group, levels=unique(ds2$group))
#ds2$sample <- ds2[order(as.numeric(ds2$group)), ]


ggplot(aes(fill=as.character(is_found),
           x=gene, y=reorder(sample, is_found)), 
       data=ds2)+#
  facet_grid(group~condition, scales ="free", space = "free_y")+
  geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  #scale_fill_discrete(name="Gene found", labels = c("no", "yes"))+
  scale_fill_manual(name="Gene found", labels = c("no", "yes"), values = c("#fddbc7","#2166ac"))+
  theme(legend.position="bottom")
  #scale_fill_gradient(name="Gene found")#+
  
#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("mito_filt_nitfilt_original_genes_heatmap.pdf",width=8,height = 6)
#ggsave("test.pdf",width=9,height = 8)







# heatmap individual unused

ds2 = df[as.character(df$condition) == "filt",]
ds2$gene <- factor(ds2$gene, levels=unique(ds2$gene)) # good
ds2$sample <- reorder(ds2$sample, -ds2$group)


#ds2$group <- as.numeric(ds2$group, levels=unique(ds2$group))
#ds2$sample <- ds2[order(as.numeric(ds2$group)), ]

ds2

ggplot(aes(fill=as.character(is_found),
           x=gene, y=sample),
       data=ds2)+#
  geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_light()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())+
  #scale_fill_discrete(name="Gene found", labels = c("no", "yes"))+
  scale_fill_manual(name="Gene found", labels = c("no", "yes"), values = c("#fddbc7","#2166ac"))
#scale_fill_gradient(name="Gene found")#+

#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("mito_filt_genes_heatmap.pdf",width=7,height = 6)
#ggsave("test.pdf",width=9,height = 8)






#bar graph unused

ds3 = df[(df$gene) == "ND1",]

colnames(ds3)

ds3$sample <- reorder(ds3$sample, -ds3$group)


dd = read.csv('/Users/admin/Documents/local_sens_hash/cpp_results/test_sw/inclusion_filt/annotation_danish/mitoZ/original_vs_filtered_mitoZ_vert.csv')
dd$sample <- reorder(dd$sample, -dd$total_genes_mito_node_x)

colnames(dd)

ggplot(aes(color=condition_x,
           x=sample, y=total_genes_mito_node_x, group = condition_x),
       data=dd)+
  #geom_bar(aes(fill = condition_x), position = "dodge", stat="identity")+
  geom_point(aes(fill = condition_x), stat="identity")+
  #geom_line(aes(colour=condition)) +
  geom_smooth(aes(group=condition_x), se=FALSE, stat = "smooth", method = "loess", span = 1.3, size = 0.1)+
  #geom_tile()+#geom_smooth(se=F,method="lm",color="red")+
  theme_classic()+
  theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1))+
  theme(axis.title.x=element_blank(), axis.title.y = element_blank())
  #scale_fill_discrete(name="Gene found", labels = c("no", "yes"))+
  #scale_fill_manual(name="Gene found", labels = c("no", "yes"), values = c("#f7f7f7","#0571b0"))
#scale_fill_gradient(name="Gene found")#+

#scale_y_continuous(labels=percent,name="Delta relative error after Kraken")+
#  scale_x_continuous(name=("Proportion filtered by Kraken"),labels=percent)+geom_hline(color="red",linetype=2,yintercept = 0)
ggsave("mito_genes_total_counts.pdf",width=9,height = 8)
#ggsave("test.pdf",width=9,height = 8)




############################################################################


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




#new_df = merge(df, mean_fp, by=c("DB", "METHOD"))
#merge(table1, table2[, c("pid", "col2")], by="pid")
#new_df


## maximum error reduction computation for drosophila
#df$error_dif = abs(df$err_lsh_GTDB) - abs(df$err_after_bbmerge)
#df$abs_err = abs(df$error_dif)
#column1b <- df$abs_err[which(!is.na(df$abs_err))]
#round(max(column1b),4)
#round(max(df$filtered_prct), 2)
#round(min(df$filtered_prct), 2)

#ds2= df
#ds2$d2 = 0
#ds2[as.character(ds2$variable)<as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)<as.character(ds2$sample),"dist_after_bbmerge"]
#ds2[as.character(ds2$variable)>as.character(ds2$sample),"d2"] =ds2[as.character(ds2$variable)>as.character(ds2$sample),"dist_after_lsh_GTDB"]

#summary(abs(df$err_lsh_BacArchKraken))
#summary(with(ds2[as.character(ds2$variable)>as.character(ds2$sample),], abs(d2-true_dist)/true_dist))
#head(ds2)

#ggplot(df, aes(x=subset(len_lrgst_mito_node, condition=='unfilt'),
#                     y=subset(len_lrgst_mito_node, condition=='filt'),)) +
#  geom_point(size=2, shape=19)

#ggplot(df, aes(x=len_lrgst_mito_node[condition=='unfilt'],
#               y=len_lrgst_mito_node[condition=='filt'],
#               colour=factor(df[(df$condition) == 'group'])))



