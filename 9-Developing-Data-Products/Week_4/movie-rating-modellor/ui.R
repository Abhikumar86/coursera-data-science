#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
      titlePanel("Movies Rating Modeller"),
      sidebarLayout(
            sidebarPanel(
                  
                  selectInput(inputId = "outcome", label = h3("Response"),
                              choices = list("IMDB Rating" = "imdb_rating",
                                             "Critics Score" = "critics_score",
                                             "Audience Score" = "audience_score"), 
                              selected = 1),
                  
                  selectInput("indepvar", label = h3("Predictor"),
                              choices = list("Runtime" = "runtime",
                                             "IMDB Rating" = "imdb_rating",
                                             "IMDB Votes" = "imdb_num_votes",
                                             "Critics Score" = "critics_score",
                                             "Audience Score" = "audience_score"), 
                              selected = 1),
                  
                  checkboxInput(inputId = "smooth", label = "Smooth"),
                  
                  selectInput(inputId = "color", label = h3("Color"), 
                              choices = list("None" = "None", 
                                             "Critics Rating" = "critics_rating",
                                             "Audience Rating" = "audience_rating"), 
                              selected = 1)
            ),
            
            mainPanel(
                  h4("How to use this App?"),
                  p("1. Select your Response and Predictor variable"),
                  p("2. Check Smooth If you want to fit a linear smooth line"),
                  p("3. Select color to visualise the distribution among the varible"),
                  p("4. Analyse the scatterplot and linear regression model"),
                  
                  br(),
                  
                  tabsetPanel(type = "tabs",
                              tabPanel("Scatterplot", plotOutput("scatterplot")), # Plot
                              tabPanel("Model Summary", verbatimTextOutput("summary")), # Regression output
                              tabPanel("Model Accuracy", DT::dataTableOutput('tbl')), # Data as datatable
                              tabPanel("Model Diagnostics", plotOutput("residualplot")) # Plot
                              
                              
                  )
            )
      ))