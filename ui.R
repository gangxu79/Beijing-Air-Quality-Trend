#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Beijing Air Quality Trend between 2008 and 2016"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Select the year of the Beijing air quality for stacked bar plot with day count in figure 1."),
      selectInput("year",
                   "Year:",
                   list("2008" = 2008,
                        "2009" = 2009,
                        "2010" = 2010,
                        "2011" = 2011,
                        "2012" = 2012,
                        "2013" = 2013,
                        "2014" = 2014,
                        "2015" = 2015,
                        "2016" = 2016)),
      hr(),
      helpText("Select air quality category to plot the ratio of the days in the current year in figure 2."),
      checkboxInput(inputId = "E_obs",
                    label = strong("Excellent"),
                    value = TRUE),
      checkboxInput(inputId = "G_obs",
                    label = strong("Good"),
                    value = TRUE),
      checkboxInput(inputId = "L_obs",
                    label = strong("Lightly Polluted"),
                    value = TRUE),
      checkboxInput(inputId = "M_obs",
                    label = strong("Moderately Polluted"),
                    value = TRUE),
      checkboxInput(inputId = "H_obs",
                    label = strong("Heavily Polluted"),
                    value = TRUE),
      checkboxInput(inputId = "S_obs",
                    label = strong("Severely Polluted"),
                    value = TRUE)
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("Plot1"),
       plotOutput("Plot2")
    )
  )
))
