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
g1 = g1 + ggtitle("Box plot of Miles / Gallon (MPG) ratio \n against Transmission Type.")
g1 = g1 + theme(legend.position=c(0.95,0.3), legend.justification=c(1,1)) 
g2 = ggplot(mtcars, aes(x=mpg, fill=am)) + geom_density(alpha=0.5)
g2 = g2 + coord_flip() + theme(legend.position="none") + labs(title="\n Density")
grid.arrange(g1,g2,ncol=2,nrow=1,widths=c(4,2))

# Fit
fit <- lm(mpg~factor(am), data=mtcars)
summary(fit)

# T-test
t.test(mpg~factor(am),data=mtcars)

# Analysing further correlations:
require(GGally)
g = ggpairs(mtcars[, !(names(mtcars) %in% c("am"))] , lower=list(continuous="smooth"))

# new fit
fit2 <- lm(mpg ~ factor(am) + cyl, data=mtcars)
summary(fit2)

# now with more variables:
fit3 <- lm(mpg ~ factor(am) + cyl + disp + wt, data=mtcars)
summary(fit3)
#anova(fit2,fit3)

# and removing disp that seems not so relevant:
fit4 <- lm(mpg ~ factor(am) + cyl + wt, data=mtcars)
summary(fit4)

# final fit including all variables:
par(mfrow=c(2,2))
fit5 <- lm(mpg ~ ., data=mtcars)
summary(fit5)
plot(fit5)


