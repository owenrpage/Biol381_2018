View(iris3)
library(ggplot2)
library(patchwork)
g1 <- ggplot(data=iris, mapping=aes(x=Sepal.Width, y=Petal.Length, color=Species))+
  geom_smooth(method="lm", se=FALSE)+
  theme_void(base_size=30, base_family="serif")+
  
  #geom_density()
g1
