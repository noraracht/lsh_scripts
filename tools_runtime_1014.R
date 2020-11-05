require(ggplot2); require(scales)
library("readxl")
library(plotrix)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

#df <- read_excel("tools_runtime_1030_in_paper.xlsx")
df <- read_excel("tools_runtime_1104_in_paper.xlsx")
#print (df)
head (df)
colnames(df)

df$threads<-as.factor(df$query_set)
df$tool <- factor(df$tool, levels=c("CLARK", "CLARK-S", "Bowtie", "CONSULT", "Kraken"))

#df = df[!df$query_set=="TOL",]

##   #4393c3 - good color 

#2c7bb6
query_set_labs <- c("1" = "Drosophila", "2" = "TOL")

#iris$Species = as.character(iris$Species)
df$query_set[df$query_set == "Dros"] = "Drosophila"


ggplot(data = df, aes(x=tool, y = time_min, group = threads))+
  geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  #facet_grid(((V1+1)*1000000000)~query_set, scales="free_x",shrink = TRUE)+
  facet_grid(~query_set,)+
  geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line(mapping = aes(x = df$tool, y = df$memory_G), color = "black", linetype = 2) + 
  theme_classic()+
  #theme_minimal()+
  scale_x_discrete(name = "")+
  #scale_color_brewer(palette = "Dark2")+
  scale_fill_manual(values=c("#4393c3", "#4393c3"), name="")+
  theme(axis.text.x=element_text(angle=45, hjust=1))+
  scale_y_continuous(name = "Running time (min)", trans = "log10", sec.axis = sec_axis(~./1, name = "Memory (G)"))+
  #ylab(expression(-log[10]))+
  theme(legend.position = "none")
#text(label= df$time_min)
ggsave("tools_runtime_black.pdf",width=5,height = 4)


########## combined graph that was removed from paper ########## 

ggplot(df, aes(x=tool, y = time_min, group = threads))+
  geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line(mapping = aes(x = df$tool, y = df$memory_G), color = "black", linetype = "dashed") + 
  theme_classic()+
  #theme_minimal()+
  scale_x_discrete(name = "")+
  #scale_color_brewer(palette = "Dark2")+
  scale_fill_manual(values=c("#0571b0", "#ca0020"), name="", labels=c("Drosophila","TOL"))+
  theme(axis.text.x=element_text(angle=45, hjust=1))+
  scale_y_continuous(name = "Running time (min)", trans = "log10", sec.axis = sec_axis(~./1, name = "Memory (G)"))+
  #ylab(expression(-log[10]))+
  theme(legend.position = c(0.5,-0.22), legend.margin=margin(t = -0.1, unit='cm'), legend.direction="horizontal")
#text(label= df$time_min)
ggsave("tools_runtime.pdf",width=5,height = 4)






###################################################################
# results on multiple threads, TOL 10MB queries


df <- read_excel("tools_runtime_1004.xlsx")
#print (df)
head (df)
colnames(df)


#"#2166ac", "#b2182b"
#"#0571b0", "#ca0020"

df$threads<-as.factor(df$threads)
df$tool <- factor(df$tool, levels=c("CLARK", "CLARK-S", "Bowtie", "CONSULT", "Kraken"))

ggplot(df, aes(x=tool, y = time_min, group = threads))+
  geom_bar(aes(fill = threads), stat="identity", position=position_dodge())+
  geom_text(aes(label=round(time_min)), position=position_dodge(width=0.9), vjust=-0.25, size=3)+
  geom_line(mapping = aes(x = df$tool, y = df$memory_G), color = "black", linetype = "dashed") + 
  theme_classic()+
  #theme_minimal()+
  scale_x_discrete(name = "")+
  #scale_color_brewer(palette = "Dark2")+
  scale_fill_manual(values=c("#0571b0", "#ca0020"), name="", labels=c("1 thread","24 threads"))+
  theme(axis.text.x=element_text(angle=45, hjust=1))+
  scale_y_continuous(name = "Running time (min)", trans = "log10", sec.axis = sec_axis(~./1, name = "Memory (G)"))+
  #ylab(expression(-log[10]))+
  theme(legend.position = c(0.5,-0.22), legend.margin=margin(t = -0.1, unit='cm'), legend.direction="horizontal")
  #text(label= df$time_min)
ggsave("tools_runtime.pdf",width=5,height = 4)




