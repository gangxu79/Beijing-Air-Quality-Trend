#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$Plot1 <- renderPlot({
    
    # Distribution of days with different air quality for each year
    theyear <- input$year
    current <- subset(avg_air, Year == theyear)
    p <- ggplot() + geom_bar(aes(x = factor(Month), fill = pollution), 
                             data = current)
    p <- p + ggtitle(paste("Distribution of days with different air quality in ", theyear))
    p <- p + xlab("Month") + ylab("Number of days")
    p <- p + scale_fill_manual(name = "Air quality", values = pollcolor)
    p

  })

  output$Plot2 <- renderPlot({

    trend <- group_by(avg_air, Year)
    C1 <- summarise(trend, Percentage = length(which(pollution == "Excellent"))/n()*100, Pollution = "Excellent")
    C2 <- summarise(trend, Percentage = length(which(pollution == "Good"))/n()*100, Pollution = "Good")
    C3 <- summarise(trend, Percentage = length(which(pollution == "Lightly Polluted"))/n()*100, Pollution = "Lightly Polluted")
    C4 <- summarise(trend, Percentage = length(which(pollution == "Moderately Polluted"))/n()*100, Pollution = "Moderately Polluted")
    C5 <- summarise(trend, Percentage = length(which(pollution == "Heavily Polluted"))/n()*100, Pollution = "Heavily Polluted")
    C6 <- summarise(trend, Percentage = length(which(pollution == "Severely Polluted"))/n()*100, Pollution = "Severely Polluted")
    
    trend <- NULL
    pollcolor2 <- NULL
    if (input$E_obs)
    {
      trend <- rbind(trend,C1)
      pollcolor2 <- cbind(pollcolor2, pollcolor[1])
    }
    if (input$G_obs)
    {
      trend <- rbind(trend,C2)
      pollcolor2 <- cbind(pollcolor2, pollcolor[2])
    }
    if (input$L_obs)
    {
      trend <- rbind(trend,C3)
      pollcolor2 <- cbind(pollcolor2, pollcolor[3])
    }
    if (input$M_obs)
    {
      trend <- rbind(trend,C4)
      pollcolor2 <- cbind(pollcolor2, pollcolor[4])
    }
    if (input$H_obs)
    {
      trend <- rbind(trend,C5)
      pollcolor2 <- cbind(pollcolor2, pollcolor[5])
    }
    if (input$S_obs)
    {
      trend <- rbind(trend,C6)
      pollcolor2 <- cbind(pollcolor2, pollcolor[6])
    }
    
    trend$Pollution <- factor(trend$Pollution, levels = c("Excellent",                                               
                                                          "Good",
                                                          "Lightly Polluted",
                                                          "Moderately Polluted",
                                                          "Heavily Polluted",
                                                          "Severely Polluted"))
    
    p2 <- ggplot(data = trend, aes(x = Year, y = Percentage, color = Pollution))
    p2 <- p2 + geom_point(size = 5) + geom_line()
    p2 <- p2 + xlab("Year") + ylab("Percentage of days")
    p2 <- p2 +scale_colour_manual(name = "Air quality", values = pollcolor2)
    p2 <- p2 + ggtitle("The percentage trend of days in current year for 6 air quality categories")
    p2
  })
})