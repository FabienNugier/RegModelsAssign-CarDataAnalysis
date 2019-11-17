# Loading data
data(mtcars)

# Basic exploration
head(mtcars)
summary(mtcars[,c("mpg","am")])

# Modifying the data
mtcars$am <- factor(mtcars$am, levels=c(0,1), labels=c("A","M"))

# First plot of the data
library(ggplot2)
library(gridExtra)
g1 = ggplot(data=mtcars, aes(x=am,y=mpg, fill=am)) + geom_boxplot()
g1 = g1 + scale_x_discrete("Transmission") + scale_y_continuous("Miles / gallon")
g1 = g1 + ggtitle("Box plot of Miles / Gallon (MPG) ratio agains Transmission Type.")
g1 = g1 + theme(legend.position=c(0.95,0.3), legend.justification=c(1,1)) 
g2 = ggplot(mtcars, aes(x=mpg, fill=am)) + geom_density(alpha=0.5)
g2 = g2 + coord_flip() + theme(legend.position="none") + labs(title="Density")
grid.arrange(g1,g2,ncol=2,nrow=1,widths=c(4,2))

# ideas for after
# par(mfrow=c(2,2))
# fit <- lm(mpg ~ ., data=mtcars) ; plot(fit)