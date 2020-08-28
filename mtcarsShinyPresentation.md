mtcarsShinyPresentation1
========================================================
author: KKher
date: 28/08/2020
autosize: true



Introduction
========================================================
I intend by this App to show the capacity of Shiny App.

data used is mtcars dataset, it is built-in RStudio. mtcars data comes from the 1974 Motor Trend magazine. The data includes fuel consumption data, and ten aspects of car design for then-current car models.

What User can do
- See distribution of mpg Vs. cyl per transmission type, and you can add box/violin plot
- See structure of our data and you can view its summary
- See coefficients of linear model for mpg against all vairables, and as an example, plotted mpg against wt, where you see fitted line for any selection of points you chose

mgp Vs. cyl & am
========================================================


```r
library(shiny)
data("mtcars")
library(plotly)
library(ggplot2)
mtcars$cyl <- as.factor(mtcars$cyl)
p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=am)) + 
             geom_dotplot(binaxis='y', stackdir='center',
                          stackratio=1.5, dotsize=1.2, stroke=1, 
                          position=position_dodge(0.8))
p
```

![plot of chunk cars](mtcarsShinyPresentation1-figure/cars-1.png)

Interactive plot
========================================================


```r
g <- ggplot(mtcars, aes(x=wt,y=mpg)) + 
            labs(y = "Milage per Gallon", x = "Weight", main = "mtcars Data") +
            geom_point()
g
```

![plot of chunk lmPlot](mtcarsShinyPresentation1-figure/lmPlot-1.png)

Application:
========================================================
My application can be tried and found through this [link](https://kkher.shinyapps.io/mtcarsShinyApp/?_ga=2.218082134.1740965407.1598637125-1292790713.1598637125)

