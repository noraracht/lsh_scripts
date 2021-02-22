require(ggplot2); require(scales)
library("readxl")
library(RColorBrewer)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


# 1 panel combined plot, used in proposal
df <- read_excel("Tol_all_kmers_bin_comp_lsh_kraken_noViral.xlsx")

#TOL with custom taxonomy
#df <- read_excel("Tol_all_kmers_bin_comp_lsh_kraken_noViral_customTax.xlsx")

#print (df)
head (df)
colnames(df)
#df$bin <- as.factor(df$bin)

ggplot(df, aes(x=bin, y = recall), group = tool) +
  geom_point(aes(color = tool))+
  geom_line(aes(color = tool))+
  scale_color_manual(values=c("#9ecae1", "#3182bd"), name="", labels=c("Kraken","LSH"))+
  #geom_smooth(method="lm", se=F)+
  #theme_bw()+
  theme_classic()+
  #coord_cartesian(xlim=c(0,7))+
  scale_y_continuous(name="Recall", labels = scales::percent_format(accuracy = 1))+
  scale_x_continuous(breaks = 0:4, name="Distance to the closest match (%)", 
                     labels=c("0", "(0-5]", "(5-15]", '(15-25]', '>25'), limits = c(NA, 4.7),)+
  theme(legend.position = c(0.14,0.18),)+
  #scale_color_brewer(name="tool", palette = "Blues")+
  geom_text(aes(label=paste(percent(round(FP,4)),"FP"),), data=df[df$bin == 4 ,], 
            size=3,nudge_x = 0.5, nudge_y = 0.0)

ggsave("Recall_per_tool_lsh_vs_kraken.pdf",width=5,height = 4)



# color updated to DARK2
ggplot(df, aes(x=bin, y = recall), group = tool) +
  geom_point(aes(color = tool))+
  geom_line(aes(color = tool))+
  #scale_color_manual(name="", labels=c("Kraken","LSH"))+
  #geom_smooth(method="lm", se=F)+
  #theme_bw()+
  theme_classic()+
  #coord_cartesian(xlim=c(0,7))+
  scale_y_continuous(name="Recall", labels = scales::percent_format(accuracy = 1))+
  scale_x_continuous(breaks = 0:4, name="Distance to the closest match (%)", 
                     labels=c("0", "(0-5]", "(5-15]", '(15-25]', '>25'), limits = c(NA, 4.7),)+
  theme(legend.position = c(0.14,0.18),)+
  scale_color_brewer(name="tool", palette="Dark2", labels=c("Kraken","LSH"))+
  #scale_fill_discrete(name = " ", labels=c("Kraken","LSH"))+
  #scale_fill_manual(name="", labels=c("Kraken","LSH"))+
  #scale_color_brewer(name="tool", palette = "Blues")+
  theme(legend.title = element_blank())+
  geom_text(aes(label=paste(percent(round(FP,4)),"FP"),), data=df[df$bin == 4 ,], 
            size=3,nudge_x = 0.5, nudge_y = 0.0)

ggsave("Recall_per_tool_lsh_vs_kraken_dark2.pdf",width=5,height = 4)





# added clark to comparison


# 1 panel combined plot, used in paper
df <- read_excel("Tol_all_kmers_bin_comp_lsh_kraken_clark_0904.xlsx")


ggplot(df, aes(x=bin, y = recall), group = tool) +
  geom_point(aes(color = tool))+
  geom_line(aes(color = tool))+
  #scale_color_manual(name="", labels=c("Kraken","LSH"))+
  #geom_smooth(method="lm", se=F)+
  #theme_bw()+
  theme_classic()+
  #coord_cartesian(xlim=c(0,7))+
  scale_y_continuous(name="Recall", labels = scales::percent_format(accuracy = 1))+
  scale_x_continuous(breaks = 0:4, name="Distance to the closest match (%)", 
                     labels=c("0", "(0-5]", "(5-15]", '(15-25]', '>25'), limits = c(NA, 4.7),)+
  theme(legend.position = c(0.14,0.2),)+
  scale_color_brewer(name="tool", palette="Dark2", labels=c("Bowtie", "CLARK", "Kraken","LSH"))+
  #scale_fill_discrete(name = " ", labels=c("Kraken","LSH"))+
  #scale_fill_manual(name="", labels=c("Kraken","LSH"))+
  #scale_color_brewer(name="tool", palette = "Blues")+
  theme(legend.title = element_blank())+
  geom_text(aes(label=paste(percent(round(FP,4)),"FP"),), data=df[df$bin == 4 ,], 
            size=3.0, nudge_x = 0.5, nudge_y = ifelse(df[df$bin == 4 ,]$tool == 'kraken', 0.01, -0.01),)

ggsave("Recall_per_tool_lsh_kraken_clark_bowtie_dark2.pdf",width=5,height = 4)



#### 1 panel combined plot, used in paper 
# correct 10M queries with LSH and TOL db build with v17.1

df <- read_excel("Tol_all_kmers_bin_comp_lsh_kraken_clark_clarkS_0914.xlsx")

#TOL with custom taxonomy for Kraken
#df <- read_excel("Tol_all_kmers_bin_comp_lsh_kraken_clark_clarkS_0914_customTax.xlsx")



#library(RColorBrewer)
my_palette = c(brewer.pal(9, "RdBu")[c(1,2, 3, 7, 9)])
my_palette

ggplot(df, aes(x=bin, y = recall), group = tool) +
  geom_point(aes(color = tool))+
  geom_line(aes(color = tool), size = 0.6)+
  #scale_color_manual(name="", labels=c("Kraken","LSH"))+
  #geom_smooth(method="lm", se=F)+
  #theme_bw()+
  theme_classic()+
  #coord_cartesian(xlim=c(0,7))+
  scale_y_continuous(name="Recall", labels = scales::percent_format(accuracy = 1), limits = c(0, 1),)+
  scale_x_continuous(breaks = 0:4, name="Distance to the closest match (%)", 
                     labels=c("0", "(0-5]", "(5-15]", '(15-25]', '>25'), limits = c(0, 4.7),)+
  theme(legend.position = c(0.14,0.23),)+
  #scale_color_brewer(name="tool", palette="Dark2", labels=c("Bowtie", "CLARK", "CLARKS", "Kraken","LSH"))+
  scale_colour_manual(name="tool", values=my_palette, labels=c("Bowtie", "CLARK", "CLARK-S", "Kraken","CONSULT"))+
  #scale_fill_discrete(name = " ", labels=c("Kraken","LSH"))+
  #scale_fill_manual(name="", labels=c("Kraken","LSH"))+
  #scale_color_brewer(name="tool", palette = "Blues")+
  theme(legend.title = element_blank())+
  geom_text(aes(label=paste(percent(round(FP,4)),"FP"),), data=df[df$bin == 4 ,], 
            size=3.0, nudge_x = 0.5, nudge_y = ifelse(df[df$bin == 4 ,]$tool == 'kraken', 0.01, -0.01),)

ggsave("Recall_per_tool_lsh_kraken_clark_clarkS_bowtie_dark2.pdf",width=5,height = 4)


#### for presentation, plot with kraken vs consult ####
colnames(df)
my_small_df <- subset(df , tool == "us" | tool == "kraken")
my_small_palette = c(brewer.pal(9, "RdBu")[c(7, 9)])

ggplot(my_small_df, aes(x=bin, y = recall), group = tool) +
  geom_point(aes(color = tool))+
  geom_line(aes(color = tool), size = 0.6)+
  #scale_color_manual(name="", labels=c("Kraken","LSH"))+
  #geom_smooth(method="lm", se=F)+
  #theme_bw()+
  theme_classic()+
  #coord_cartesian(xlim=c(0,7))+
  scale_y_continuous(name="Recall", labels = scales::percent_format(accuracy = 1), limits = c(0, 1),)+
  scale_x_continuous(breaks = 0:4, name="Distance to the closest match (%)", 
                     labels=c("0", "(0-5]", "(5-15]", '(15-25]', '>25'), limits = c(0, 4.7),)+
  theme(legend.position = c(0.14,0.23),)+
  scale_colour_manual(name="tool", values=my_small_palette, labels=c("Kraken","CONSULT"))+
  theme(legend.title = element_blank())+
  geom_text(aes(label=paste(percent(round(FP,4)),"FP"),), data=my_small_df[my_small_df$bin == 4 ,], 
            size=3.0, nudge_x = 0.5, nudge_y = ifelse(df[df$bin == 4 ,]$tool == 'kraken', 0.01, -0.01),)

ggsave("Recall_per_tool_lsh_kraken_clark_clarkS_bowtie_dark2_twolines.pdf",width=5,height = 4)

install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()

#%in% c(4,4)& r$k %in% c(28,32,35) & (r$bin==9)

# multi line comment: cmd+shift+c ot ctrl+shift+c

# gplot(aes(x=as.factor(bin),group=interaction(confidence_level,k),size=(confidence_level),color=(k)),
#       data=r[r$confidence_level %in% c(0,0.05)& r$k %in% c(28,32,35),])+
#   geom_line(aes(y=recall))+ geom_point(aes(y=recall,group=1))+
#   #geom_line(aes(y=FPR,linetype="FPR"))+ geom_point(aes(y=FPR,group=1))+
#   scale_size_continuous(name=expression(alpha),range = c(0.9,0.4),breaks=unique(r$confidence_level))+
#   scale_shape(name=expression(alpha))+
#   #scale_linetype_manual(name="",values=c(1,3))+
#   scale_x_discrete(name="Distance to the closest match (M)",labels=c("0","(0-1]","(1-2]","(2-3]","(3-5]","(5-10]","(10-15]","(15-20]","(20-25]",">25"))+
#   theme_classic() +theme(panel.border  = element_rect(fill=NA,size = 1),axis.text.x = element_text(angle=45,hjust = 1,vjust=1),
#                          legend.box.background =  element_rect(linetype = 2), legend.position = c(.34,.2),legend.direction = "horizontal", legend.margin = margin(.0,10,.0,5), legend.spacing.y = unit(.5,"pt") )+
#   scale_y_continuous(name="Recall",labels=percent
#                      #, sec.axis = sec_axis(~.*1, name = "FPR", labels = percent, breaks = c(0.007,0.048,0.086,.539))
#   )+
#   scale_color_gradient(guide="legend",high="#01237c",low = "#85AACB", breaks=c(28,32,35),name=expression(k))+
#   coord_cartesian(xlim=c(1,11))+
#   geom_text(aes(label=paste(percent(round(FPR,2)),"FP"),y=recall),
#             data=r[r$confidence_level %in% c(0,0.05)& r$k %in% c(28,32,35) & (r$bin==9),],
#             size=2.8,  nudge_y = .01, nudge_x = .84,show.legend = F)
# ggsave("Recall-FPR.pdf",width = 4.2*0.95, height = 4.2*0.95)