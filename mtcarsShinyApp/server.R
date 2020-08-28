#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
data("mtcars")
library(plotly)
library(ggplot2)


server <- function(input, output) {
    
    
    # generate str of data
    output$content1 <- renderPrint({
        
        str(mtcars)
    })
    
    output$mpgPlot <- renderPlot({
    
        mtcars$cyl <- as.factor(mtcars$cyl)
        mtcars$am <- as.factor(mtcars$am)
        
        p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=am)) + 
             geom_dotplot(binaxis='y', stackdir='center',
                          stackratio=1.5, dotsize=1.2, stroke=1, 
                          position=position_dodge(0.8))
        
        
        if(input$plottype=='Box')
            p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=am)) + 
                geom_boxplot()+
                geom_dotplot(binaxis='y', stackdir='center', 
                             position=position_dodge(0.8))
        else if(input$plottype=='Violin')
            p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=am)) + 
                geom_violin(trim = FALSE)+
                geom_dotplot(binaxis='y', stackdir='center', 
                             position=position_dodge(0.8))
        else
            p <- ggplot(mtcars, aes(x=cyl, y=mpg, fill=am)) + 
                geom_dotplot(binaxis='y', stackdir='center',
                             stackratio=1.5, dotsize=1.2, stroke=1, 
                             position=position_dodge(0.8))
        
        p
        
    })
    
    # Generate a summary of the dataset
    output$summary1 <- renderPrint({
        summary(mtcars)
    }) 
    
    
    lmmodel <- reactive({
        brushed_data <- brushedPoints(mtcars, input$brush1,
                                      xvar = "wt", yvar = "mpg")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(mpg ~ wt, data = brushed_data)
    })
    
    output$lmPlot <- renderPlot({
        p <- ggplot(mtcars, aes(x=wt,y=mpg)) + 
            labs(y = "Milage per Gallon", x = "Weight", main = "mtcars Data") +
            geom_point()
        if(!is.null(lmmodel())){
            p <- p + geom_abline(intercept = lmmodel()[[1]][1],
                                     slope=lmmodel()[[1]][2] , col="red")
        }
        p
    })
    
    output$intOut <- renderText({
        if(is.null(lmmodel())){
            "No Model Found"
        } else {
            lmmodel()[[1]][1]
        }
    })
    
    output$slopeOut <- renderText({
        if(is.null(lmmodel())){
            "No Model Found"
        } else {
            lmmodel()[[1]][2]
        }
    })
    
    output$model <- renderPrint({
        fit <- lm(mpg~.,data=mtcars)
        summary(fit)
    })
}