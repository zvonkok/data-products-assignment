library(shiny)
library(ggplot2movies)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Dataset Options"),

  sidebarPanel(
    strong("Genre"),
    checkboxInput("action", "Action", TRUE),
    checkboxInput("animation", "Animation", TRUE),
    checkboxInput("comedy", "Comedy", TRUE),
    checkboxInput("drama", "Drama", TRUE),
    checkboxInput("documentary", "Documentary", TRUE), 
    checkboxInput("romance", "Romance", TRUE),
    checkboxInput("short", "Short", TRUE),
    checkboxInput("none", "None", TRUE),
    sliderInput("year", "Year of release", 
                min(movies$year), max(movies$year), 
                value = c(min(movies$year), max(movies$year))),
    sliderInput("length", "Length in minutes", 
                min(movies$length), max(movies$length), 
                value = c(min(movies$length), max(movies$length))),
    sliderInput("budget", "Total budget in US Dollars ", 
                min(movies$budget, na.rm=TRUE), max(movies$budget, na.rm=TRUE), 
                value = c(min(movies$budget, na.rm=TRUE), max(movies$budget, na.rm=TRUE))),
    sliderInput("rating", "Average IMDB user rating", 
                min(movies$rating, na.rm=TRUE), max(movies$rating, na.rm=TRUE), 
                value = c(min(movies$rating, na.rm=TRUE), max(movies$rating, na.rm=TRUE))),
    sliderInput("votes", "Number of IMDB users who rated this movie", 
                min(movies$votes, na.rm=TRUE), max(movies$votes, na.rm=TRUE), 
                value = c(min(movies$votes, na.rm=TRUE), max(movies$votes, na.rm=TRUE)))
    
      ),
  
  
  
  mainPanel(
    
    h1("IMDB Movie Ratings Exloratory Analysis"),
    p("Before predicting or regression one has to examine the data. This shiny app helps to do a exploratory analysis on the movie"),
    p("dataset from the ggplot2 package. Select or deselect any option on the left panel to reduce the dataset by chosen factors. "),
    plotOutput("plot0"),
    plotOutput("plot1"),
    plotOutput("plot2")
    
  )
))
