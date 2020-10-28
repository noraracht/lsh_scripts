require(ggplot2); require(scales)
library("readxl")
library(plotrix)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

df <- read.csv("combo_t_vertical.csv")
#print (df)
head (df)
colnames(df)

df$tag<-as.factor(df$tag)

ggplot(df, aes(x=df$total, y =df$kmers_in_map, color=df$tag))+
  #geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  #geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line(size = 0.6)+
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



df$threads<-as.factor(df$query_set)
df$tool <- factor(df$tool, levels=c("CLARK", "CLARK-S", "Bowtie", "CONSULT", "Kraken"))


