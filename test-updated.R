require(ggplot2)
require(scales)
SL = 32
p = 3

f = function(x,k,l,SL) { 1 - (1 - (1 - x/SL)^k)^l }

K = function(l,p,alpha,L) {round(log(1-(1-alpha)^(1/l))/log(1-p/L));}

K(4,2,0.95,10)

alpha=0.95
ggplot(data.frame(x = c(1, 3*p)), aes(x)) + theme_classic()+
  mapply(function( L) {
    stat_function(fun = f, args = list(k = K(l=L,p=p,alpha=alpha,L=SL), l=L, SL=SL), aes(color=paste(L,K(l=L,p=p,alpha=alpha,L=SL),sep="/")))
  },L=c(7:14))+
  geom_vline(xintercept = p,color="black",linetype=2)+
  geom_hline(yintercept = alpha,color="black",linetype=2)+
  scale_color_brewer(palette = "Spectral",name="l/h")+ylab("probability of a match")+xlab("Hamming distance")+scale_linetype(name="l")
ggsave("clus-95.pdf",width=5,height = 4)

alpha=0.1
ggplot(data.frame(x = c(1, 3*p)), aes(x)) + theme_classic()+
  mapply(function( L) {
    stat_function(fun = f, args = list(k = K(l=L,p=p,alpha=alpha,L=SL), l=L, SL=SL), aes(color=paste(L,K(l=L,p=p,alpha=alpha,L=SL),sep="/")))
  },L=c(2:8))+
  geom_vline(xintercept = p,color="black",linetype=2)+
  geom_hline(yintercept = alpha,color="black",linetype=2)+
  scale_color_brewer(palette = "Spectral",name="l/h")+ylab("probability of a match")+xlab("Hamming distance")+scale_linetype(name="l")
ggsave("clus-10.pdf",width=5,height = 4)

alpha=0.1
ggplot(data.frame(x = c(1, 3*p)), aes(x)) + theme_classic()+
  mapply(function( L) {
    stat_function(fun = function(x,k,l,SL) (150-SL+1)*f(x,k,l,SL), args = list(k = K(l=L,p=p,alpha=alpha,L=SL), l=L, SL=SL), aes(color=paste(L,K(l=L,p=p,alpha=alpha,L=SL),sep="/")))
  },L=c(2:8))+
  geom_vline(xintercept = 4,color="black",linetype=2)+
  geom_hline(yintercept = 3,color="black",linetype=2)+
  scale_color_brewer(palette = "Dark2",name="l/k")+ylab("probability of a match")+xlab("distance")+scale_linetype(name="l")



# used this one for presentation
alpha=0.1
ggplot(data.frame(x = c(1, 16)), aes(x)) + theme_classic()+
  mapply(FUN=function( L, K) {
    stat_function(fun = function(x,k,l,SL) (1+150-SL)*f(x,k,l,SL), 
                  args = list(k = K, l=L, SL=SL), 
                  aes(color=as.factor(L)))
  },L=rep(c(2, 1),each=5), K=c(15))+
  #geom_vline(xintercept = 3,color="black",linetype=2)+
  #geom_vline(xintercept = SL*0.4,color="black",linetype=2)+
  #geom_hline(yintercept = 90,color="black",linetype=2)+
  scale_y_continuous(lim=c(0.1,100))+
  scale_linetype_manual(values=c(1,2,3),name=expression(h))+
  scale_x_continuous(labels=function(x) paste(x,percent(x/SL),sep="\n"))+
  scale_color_manual(name="l",values = c("gray80", "black"))+
  ylab("Expected number of kmer matches per 150bp read")+
  xlab("Hamming distance")+
  stat_function(fun = function(x) (1+150-SL)*f(x,35-7,1,35)/2, color="blue",linetype=1)+
  geom_vline(xintercept = 3,color="red",linetype=3)+
  geom_vline(xintercept = 10,color="red",linetype=3)+
  theme(legend.position = "none")+
ggsave("exp-def.pdf",width=5,height = 4)


alpha=0.1
ggplot(data.frame(x = c(1, 16)), aes(x)) + theme_classic()+
  mapply(FUN=function( L, K) {
    stat_function(fun = function(x,k,l,SL) (1+150-SL)*f(x,k,l,SL), 
                  args = list(k = K, l=L, SL=SL), 
                  aes(color=as.factor(K)))
  },L=rep(c(2),each=5), K=c(15, 10, 6))+
  #geom_vline(xintercept = 3,color="black",linetype=2)+
  #geom_vline(xintercept = SL*0.4,color="black",linetype=2)+
  #geom_hline(yintercept = 90,color="black",linetype=2)+
  scale_y_continuous(lim=c(0.1,100))+
  #scale_linetype_manual(values=c(1,2,3),name=expression(h))+
  scale_x_continuous(labels=function(x) paste(x,percent(x/SL),sep="\n"))+
  scale_color_manual(name="l", values = c("grey50", "black", "grey80"))+
  ylab("Expected number of kmer matches per 150bp read")+
  xlab("Hamming distance")+
  #stat_function(fun = function(x) (1+150-SL)*f(x,35-7,1,35)/2, color="blue",linetype=1)+
  geom_vline(xintercept = 3,color="red",linetype=3)+
  geom_vline(xintercept = 10,color="red",linetype=3)+
  theme(legend.position = "none")+
  ggsave("exp-def2.pdf",width=5,height = 4)





ggplot(data.frame(x = c(1, 16)), aes(x)) + theme_classic()+
  mapply(FUN=function( L, K) {
    stat_function(fun = function(x,k,l,SL) (1+150-SL)*f(x,k,l,SL), 
                  args = list(k = K, l=L, SL=SL), 
                  aes(color=as.factor(L),linetype=as.factor(L)))
  },L=rep(c(2, 1),each=5), K=c(14))+
  #geom_vline(xintercept = 3,color="black",linetype=2)+
  #geom_vline(xintercept = SL*0.4,color="black",linetype=2)+
  #geom_hline(yintercept = 90,color="black",linetype=2)+
  scale_y_continuous(lim=c(0.1,100))+
  scale_linetype_manual(values=c(1,2,3),name=expression(h))+
  scale_x_continuous(labels=function(x) paste(x,percent(x/SL),sep="\n"))+
  scale_color_manual(name="l",values = c("black","gray80"))+
  ylab("Expected number of kmer matches per 150bp read")+
  xlab("Hamming distance")+
  stat_function(fun = function(x) (1+150-SL)*f(x,35-7,1,35)/2, color="blue",linetype=1)+
  geom_vline(xintercept = 3,color="red",linetype=3)+
  geom_vline(xintercept = 10,color="red",linetype=3)+
  theme(legend.position = "none")+
  ggsave("exp-def.pdf",width=5,height = 4)
