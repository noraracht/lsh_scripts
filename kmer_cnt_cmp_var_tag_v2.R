require(ggplot2); require(scales)
library("readxl")
library(plotrix)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()



########### combined tag 0 and tag 2 plot already in  paper ###########

df <- read.csv("t0_nodups_imbalance.txt", sep= ' ', header = FALSE)
df$tag = 0
df2 <- read.csv("t2_nodups_imbalance.txt", sep = ' ', header = FALSE)
df2$tag = 2
combo_df <- rbind(df, df2)


ggplot(aes(x=V2, y= V4), data = combo_df) +
  geom_bar(stat = "identity", position = "dodge")+
  facet_grid(((V1+1)*1000000000)~tag, scales="free_x",shrink = TRUE)+
  theme_bw()+
  scale_y_continuous(name = "Percentage of rows with columns filled (%)")+
  scale_x_continuous(name = "Columns")
  
ggsave("imbalance_tag2_v2_tag2_tag0.pdf",width=4,height = 8)

############################################################################



########### imbalance facet plot, previous version of plot above ###########

df <- read.csv("t0_nodups_imbalance.txt", sep= ' ', header = FALSE)

#df <- read.csv("t2_nodups_imbalance.txt", sep = ' ', header = FALSE)


ggplot(aes(x=V1, y= V4,color = as.factor(V2)), data = df) +
  geom_bar(stat = "identity", position = "dodge")
ggsave("temp_tag2.pdf",width=5,height = 4)


ggplot(aes(x=V2, y= V4), data = df) +
  geom_bar(stat = "identity", position = "dodge")+
  facet_wrap(~((V1+1)*1000000000))+
  theme_bw()+
  scale_y_continuous(name = "Percentage of rows with columns filled (%)")+
  scale_x_continuous(name = "Columns")

ggsave("imbalance_tag2_v2.pdf",width=5,height = 4)

############################################


#### sigs vs lines read

df0 <- read.csv("new_t0_sparse_vals.txt", sep= ' ', header = FALSE)
df1<- read.csv("new_t1_sparse_vals.txt", sep= ' ', header = FALSE)
df2<- read.csv("new_t2_sparse_vals.txt", sep= ' ', header = FALSE)
df3<- read.csv("new_t3_sparse_vals.txt", sep= ' ', header = FALSE)

df <-do.call("rbind", list(df0, df1, df2, df3))
#df <- rbind(df0, df1, df2, df3)
#print (df)
head (df)
colnames(df)

colnames(df) <- c("tag", "kmers_in_map", "l_0", "l_1", "lines_read")
df$l0_l1 = df$l_0 + df$l_1

#write.csv(df,"test_rbind.csv", row.names = FALSE)

df$tag<-as.factor(df$tag)

######## plot for encoding vs kmers read #######

ggplot(df, aes(x=lines_read, y =kmers_in_map, color = tag))+
  #geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  #geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line()+
  geom_abline(slope=1, linetype = 2)+
  #geom_abline(slope=2, linetype = 2)+
  #geom_hline(yintercept = 2*7*2^30, linetype = 2)+
  geom_hline(yintercept = 2^33, linetype = 2)+
  theme_classic()+
  #theme_minimal()+
  #scale_y_continuous(name = "Lookup table occupancy")+
  scale_y_continuous(name = "Encoding array occupancy")+
  scale_color_brewer(palette = "Dark2")+
  labs(color='tag size')+
  #scale_fill_manual(values=c("#0571b0", "#ca0020"), name="", labels=c("Drosophila","TOL"))+
  #theme(axis.text.x=element_text(angle=45, hjust=1))
  scale_x_continuous(name=expression(~italic(k)~'-mers read'),)+
  #scale_y_continuous(name=expression(k-mers~read), )+
  #scale_y_continuous(name="kmers read")+
  #ylab(expression(-log[10]))+
  theme(legend.position = c(0.85, 0.25))
#text(label= df$time_min)
ggsave("encoding_occupancy.pdf",width=5,height = 4)





######### plot for total sigs array #########


ggplot(df, aes(x=lines_read, y =l0_l1, color = tag))+
  #geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  #geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line()+
  #geom_abline(slope=1, linetype = 2)+
  geom_abline(slope=2, linetype = 2)+
  geom_hline(yintercept = 2*7*2^30, linetype = 2)+
  #geom_hline(yintercept = 2^33, linetype = 2)+
  theme_classic()+
  #theme_minimal()+
  scale_y_continuous(name = "Lookup table occupancy")+
  #scale_y_continuous(name = "Encoding array occupancy")+
  scale_color_brewer(palette = "Dark2")+
  labs(color='tag size')+
  #scale_fill_manual(values=c("#0571b0", "#ca0020"), name="", labels=c("Drosophila","TOL"))+
  #theme(axis.text.x=element_text(angle=45, hjust=1))
  scale_x_continuous(name=expression(~italic(k)~'-mers read'),)+
  #scale_y_continuous(name=expression(k-mers~read), )+
  #scale_y_continuous(name="kmers read")+
  #ylab(expression(-log[10]))+
  theme(legend.position = c(0.85, 0.25))
#text(label= df$time_min)
ggsave("lookup_map_occupancy.pdf",width=5,height = 4)


##### not been used ##### 


df$threads<-as.factor(df$query_set)
df$tool <- factor(df$tool, levels=c("CLARK", "CLARK-S", "Bowtie", "CONSULT", "Kraken"))


df$tag<-as.factor(df$tag)

ggplot(df, aes(x=df$total, y =df$kmers_in_map, color=df$tag))+
  #geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  #geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line(size = 0.6)+
  geom_abline(slope=2)+
  theme_classic()+
  #theme_minimal()+
  scale_x_continuous(name = "total signature count")+
  scale_color_brewer(palette = "Dark2")+
  labs(color='tag size')+
  #scale_fill_manual(values=c("#0571b0", "#ca0020"), name="", labels=c("Drosophila","TOL"))+
  #theme(axis.text.x=element_text(angle=45, hjust=1))
  scale_y_continuous(name = "kmer count in map", limits = c(0.0, NA))+
  #ylab(expression(-log[10]))+
  theme(legend.position = c(0.85, 0.25))
#text(label= df$time_min)
ggsave("tags_kmers_in_DB.pdf",width=5,height = 4)


round(((7*60+15.649 + 5*60+43.002 + 5*60+35.160 + 7*60+44.494))/127110, 4)


