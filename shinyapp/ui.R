library(shiny)
library(miniUI)
premierleague <- premierleague

fluidPage(
    titlePanel("Predict Points Per Game from xG"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderxG", "What is the xG of the player?", 0, 1.5, step = 0.01, value=1.5),
            checkboxInput("showModel1", "Show/Hide Model 1", value=TRUE),
        ),
        mainPanel(
            plotOutput("plot1", click="plot_click", hover="plot_hover", brush="plot_brush"),
            h3("Predicted Points Per Game from Model 1:"),
            textOutput("pred1"),
            h3("Player Information:"),
            verbatimTextOutput("player_info")
        )
    )
)
