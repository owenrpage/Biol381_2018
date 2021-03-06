
library(ggplot2)
library(patchwork)
library(ggthemes)
library(TeachingDemos)
char2seed("petrel and the porpoise")

g1 <- ggplot(data=iris, mapping=aes(x=Sepal.Width, y=Petal.Length, col=Species))+
  geom_smooth(method="lm", se=FALSE)+
  theme_economist_white(base_family="serif")+
  geom_point()+
  xlab("Sepal Width")+
  ylab('Petal Length')


g1


g2 <- ggplot(data=iris, mapping=aes(x=Species, y=Petal.Length, fill=Species))+
  theme_classic(base_family="serif")+
  geom_boxplot()+
  geom_point(position=position_jitter(width=0.2, height=0.7), color="grey30", alpha=0.4)
g2

g3 <- ggplot(data=iris, mapping=aes(x=Petal.Width, fill=Species))+
  geom_histogram(position='Dodge')+
  theme_economist(base_family="serif")
g3

g4 <- ggplot(data=iris, mapping=aes(x=Sepal.Length, y=Sepal.Width, color=Petal.Length))+
  geom_point()+
  scale_fill_brewer(palette="Blues")+
  theme_dark(base_family="serif")
g4


g2 + g3 + g1 +g4 + plot_layout(ncol=2, widths=c(1,2))

