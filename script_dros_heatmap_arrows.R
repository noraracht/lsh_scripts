require(ggplot2); require(scales); require(reshape2); require(Hmisc)
library("readxl")
library(dplyr)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()


#df = read.csv('dros_distances_updatedGTDB4.csv')
#df_filt = read.csv('lsh_gtdb_results_dros_queries-3.csv')







## maximum error reduction computation for drosophila
#df$error_dif = abs(df$err_lsh_GTDB) - abs(df$err_after_bbmerge)
#df$abs_err = abs(df$error_dif)
#column1b <- df$abs_err[which(!is.na(df$abs_err))]
#round(max(column1b),4)
#round(max(df$filtered_prct), 2)
#round(min(df$filtered_prct), 2)




ggplot2df= read.csv('dros_distances_updatedGTDB4.csv')
head (ggplot2df)

ggplot2df = ggplot2df[, which(names(ggplot2df) %in% c('sample', "variable", "err_after_bbmerge", "err_lsh_GTDB"))]

ggplot2df$sample = gsub("Drosophila_virilis", "droVir", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_persimilis", "droPer", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_eugracilis", "droEug", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_mauritiana", "droMau", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_sechellia", "droSec", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_willistoni", "droWil", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_yakuba", "droYak", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_erecta", "droEre", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_pseudoobscura", "droPse", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_mojavensis", "droMoj", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_ananassae", "droAna", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_biarmipes", "droBia", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_simulans", "droSim", ggplot2df$sample)
ggplot2df$sample = gsub("Drosophila_bipectinata", "droBip", ggplot2df$sample)


ggplot2df$variable = gsub("Drosophila_virilis", "droVir", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_persimilis", "droPer", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_eugracilis", "droEug", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_mauritiana", "droMau", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_sechellia", "droSec", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_willistoni", "droWil", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_yakuba", "droYak", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_erecta", "droEre", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_pseudoobscura", "droPse", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_mojavensis", "droMoj", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_ananassae", "droAna", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_biarmipes", "droBia", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_simulans", "droSim", ggplot2df$variable)
ggplot2df$variable = gsub("Drosophila_bipectinata", "droBip", ggplot2df$variable)






names(ggplot2df)[names(ggplot2df) == 'variable'] <- 'variableone'

ggplot2df_uniq= ggplot2df[!duplicated(t(apply(ggplot2df[c("sample", "variableone")], 1, sort))), ]
nrow(ggplot2df_uniq)
head(ggplot2df_uniq)
ggplot2df_uniq = ggplot2df_uniq[!(ggplot2df_uniq$sample==ggplot2df_uniq$variableone),]



ggplot2df_uniq$dros_combo <- paste(ggplot2df_uniq$sample, "-", ggplot2df_uniq$variableone)

drops <- c("sample","variableone")
ggplot2df_uniq = ggplot2df_uniq[ , !(names(ggplot2df_uniq) %in% drops)]

ggplot2df_uniq
#ggplot2df_uniq <-ggplot2df_uniq[order(ggplot2df_uniq$err_after_bbmerge),]

# Sort by vector name [z] then [x]
ggplot2df_uniq = ggplot2df_uniq[with(ggplot2df_uniq, order(ggplot2df_uniq$err_after_bbmerg, ggplot2df_uniq$err_lsh_GTDB )),]

ggplot2df_uniq$sp <- 1:nrow(ggplot2df_uniq) 

df <- ggplot2df_uniq %>% 
  mutate(direction = ifelse(abs(err_after_bbmerge) - abs(err_lsh_GTDB) > 0, "Up", "Down" ))%>%
  melt(id = c("sp", "dros_combo", "direction"))



names(df)
df


g1 <- ggplot(df, aes(x=as.factor(sp), y = value, color = variable,)) + 
  #geom_point(size=1) + 
  geom_path(aes(color = direction, group = sp), arrow=arrow(angle = 10, length = unit(0.1, "inches"),  type = "open"))+
  theme_classic()+
  geom_hline(yintercept=0.0, color='grey', linetype="dashed", size = 0.4)+
  labs(y= "Change in relative error", x = "")+
  theme(axis.text.x = element_text(angle = 45, vjust = 1.0, hjust=1.0, size=5),)+
  theme(legend.position = c(0.9,.15), legend.spacing.y = unit(0.05, 'cm'), legend.margin=margin(t = 0.1, unit='cm'),)+
  scale_color_manual(name="", values = c("#f4a582", "#0571b0"), labels = c("Up", "Down") )+
  scale_x_discrete(labels=c(df$dros_combo))
g1

ggsave("contam3.pdf",width=6,height = 5)







###example###
ggplot2df <- read.table(text = "question y2015 y2016
q1 90 50
                 q2 80 60
                 q3 70 90
                 q4 90 60
                 q5 30 20", header = TRUE)


df <- ggplot2df %>% 
  mutate(direction = ifelse(y2016 - y2015 > 0, "Up", "Down"))%>%
  melt(id = c("question", "direction"))

df

g1 <- ggplot(df, aes(x=question, y = value, color = variable, group = question )) + 
  geom_point(size=4) + 
  geom_path(aes(color = direction), arrow=arrow())

g1


###example###




#new_df = merge(df, mean_fp, by=c("DB", "METHOD"))
#merge(table1, table2[, c("pid", "col2")], by="pid")
#new_df