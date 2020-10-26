require(ggplot2); require(scales)
library("readxl")
library(plotrix)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

df <- read_excel("tools_runtime_1026_in_paper.xlsx")
#print (df)
head (df)
colnames(df)

df$threads<-as.factor(df$query_set)
df$tool <- factor(df$tool, levels=c("CLARK", "CLARK-S", "Bowtie", "CONSULT", "Kraken"))

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




