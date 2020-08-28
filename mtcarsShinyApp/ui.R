#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Data Analyzer!"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
                h3("Data:"),
                h5("mtcars data set that is built-in to the R distribution. mtcars data comes from the 1974 Motor Trend magazine. The data includes fuel consumption data, and ten aspects of car design for then-current car models."),
                tags$hr(),
                h3("What you can do:"),
                h4("mpg Distribution:"),
                h5("See distribution of mpg Vs. cyl per transmission type, and you can add box/violon plot"),
                h4("mpg data Summary:"),
                h5("See structure of our data and you can view its summary"),
                h4("mpg Linear Model:"),
                h5("See coefficients of linear model for mpg against all vairables, 
                   and as an example, plotted mpg against wt, where you see fitted line for any selection of points you chose")
            
            ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("mpg Distribution",
                         h4("Here we see how mpg is distributed across different variables"),
                         plotOutput("mpgPlot"),
                         selectInput("plottype","Choose Add-on Plot:", c(None='.',"Box", "Violin"))
                ),
                tabPanel("Data Summary", 
                         h4("this is a summary of data used (mtcars dataset)"), 
                         verbatimTextOutput("content1"),
                         tags$hr(),
                         checkboxInput('summary','View summary of the dataset'),
                         conditionalPanel(condition = 'input.summary==true',
                                          h4("Summary"),
                                          verbatimTextOutput("summary1"))
                         ),
                tabPanel("Linear Model Fit", 
                         h3("Here are the best features for a Linear Model fit, to get mpg value"),
                         verbatimTextOutput('model'),
                         plotOutput("lmPlot", brush = brushOpts(id="brush1")),
                         h3("Slope:"),
                         textOutput("slopeOut"),
                         h3("Intecept:"),
                         textOutput("intOut")
                         )
            )
        )
    )
))
