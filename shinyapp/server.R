library(shiny)
library(miniUI)
premierleague <- premierleague 


server <- function(input, output) {
    model1 <- lm(points_per_game ~ expected_goals, data=premierleague)

    model1pred <- reactive({
      xGInput <- input$sliderxG
      predict(model1, newdata=data.frame(expected_goals = xGInput))
    })
    
    output$plot1 <- renderPlot({
        xGInput <- input$sliderxG
        plot(
          premierleague$expected_goals, premierleague$points_per_game, 
          xlab="Expected Goals (xG)", ylab="Points Per Game", 
          bty="n", pch=16, col="#7573F7", xlim= c(0,1.5), ylim = c(0, 16)
        )
        
        if(input$showModel1){
          abline(model1, col="#36FE48", lwd=2)
        }
     
        points(xGInput, model1pred(), col="#BF1CF0", pch=16, cex=2)
        
        legend(
          "topright", legend = c("Model 1 Prediction"),
          col = c("#BF1CF0"), lty = 1, lwd = 2, bty = "n"
        )
      })
        
        output$pred1 <- renderText({
          paste("Oredicted Points Per Game:", round(model1pred(), 0))
        })
        
        # Display player information when a point is clicked
        output$player_info <- renderPrint({
          req(input$plot_click)  
          click <- input$plot_click
          distances <- sqrt((premierleague$expected_goals - click$x)^2 +
                              (premierleague$points_per_game - click$y)^2)
          nearest_index <- which.min(distances)
          premierleague$name[nearest_index]
        })
      }
        
   
  

