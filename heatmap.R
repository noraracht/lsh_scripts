
require(ggplot2);require(reshape2)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


my_df <- read.csv(file = 'genes_per_20_contigs_fotheatmap.csv', stringsAsFactors = TRUE)
names(my_df)[3] <- "s-rRNA"
names(my_df)[4] <- "l-rRNA"

my_df

ggplot(aes(y=variable,x=sample,
           fill=factor(value),label=value),
       data=melt(my_df))+
  geom_tile()+facet_wrap(~condition)+theme_classic()+
  scale_fill_brewer(palette = 1,name="contig",na.value = "red")+
  theme(axis.text.x = element_text(angle=10))+xlab("")+ylab("")+
  geom_text()+
  ggsave("missing-genes.pdf",width=8,height = 4)




#########
ggplot(aes(y=variable,x=sample,
           fill=factor(value), label=value),
       data=melt(read.csv('genes_per_20_contigs_fotheatmap.csv')))+
  geom_tile()+facet_wrap(~condition)+theme_classic()+
  scale_fill_brewer(palette = 1,name="contig",na.value = "red")+
  theme(axis.text.x = element_text(angle=10))+xlab("")+ylab("")+
  ggsave("missing-genes.pdf",width=8,height = 4)
