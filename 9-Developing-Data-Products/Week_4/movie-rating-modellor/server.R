#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(ggplot2)

server <- function(input, output) {

      movies <- na.omit(read.csv("movies.csv"))
            
      # Regression output
      output$summary <- renderPrint({
            fit <- lm(movies[,input$outcome] ~ movies[,input$indepvar])
            names(fit$coefficients) <- c("Intercept", input$indepvar)
            summary(fit)
      })
      
      # Data output
      output$tbl = DT::renderDataTable({
            fit <- lm(movies[,input$outcome] ~ movies[,input$indepvar])
            
            adjr2 <- round(summary(fit)$adj.r.squared, 3)
            
            pred.fit <- predict(fit, movies)
            resid.fit <- movies[,input$outcome] - pred.fit
            rmse.fit <- sqrt(mean(resid.fit^2))
            
            pearsonr <- cor(movies[,input$outcome], movies[,input$indepvar])
            
            DT::datatable(data = data.frame("Adj_R_Sq" = adjr2,
                                            "RMSE" = round(rmse.fit, 3),
                                            "AIC" = round(AIC(fit), 3),
                                            "Pearson_R" = round(pearsonr, 3)), 
                          options = list(lengthChange = FALSE))
      })
      
      
      # Scatterplot output
      output$scatterplot <- renderPlot({
            
            p <- ggplot(movies, aes_string(x = input$indepvar, y = input$outcome)) + 
                  geom_point(shape = 21, size = 5, alpha = 0.5) +
                  theme_bw() +
                  theme(axis.title = element_text(size = 16, face = "bold"), 
                        axis.text = element_text(size = 14), legend.position = "bottom",
                        legend.text = element_text(size = 16), 
                        legend.title = element_text(size = 18, face = "italic"),
                        strip.text = element_text(size = 16))
            
            if (input$smooth)
                  
                  p <- p + geom_smooth(method = "lm", size = 1.2, alpha = 0.2)
            
            if (input$color != 'None')
                  p <- p + aes_string(fill = input$color)
            
            print(p)
            
      }, height=400)
      
      # Residual plot output
      output$residualplot <- renderPlot({
            
            fit <- lm(movies[,input$outcome] ~ movies[,input$indepvar])
            par(mfrow = c(2,2))
            plot(fit, which = 1:4)
            
      }, height=400)
      
}

