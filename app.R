#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(stylo)
library(stringr)
library(tm)
source("nextWordPrediction.R")

ui <- shinyUI(
  navbarPage(
    "Data Science Captone Project",
    theme = "bootstrap.css",
    tabPanel(
      "Application",
      titlePanel(HTML(
        "<center>Next Word Prediction Application</center>"
      )),
      fluidRow(column(3),
               column(
                 6,
                 tags$div(
                   textInput("text",
                             label = h3("Enter your text here:")),
                   hr(),
                   h4(HTML("The predicted next word:")),
                   tags$span(style = "color:darkblue", tags$strong(tags$h3(
                     textOutput("predictedWord")
                   ))),
                   verbatimTextOutput("text"),
                   align = "center"
                 )
               ),
               column(3))
    ),
    tabPanel("About",
             fluidRow(
               column(2,
                      p("")),
               column(8,
                      includeMarkdown("about.md")),
               column(2,
                      p(""))
             ))
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  wordPrediction <- reactive({
    textInput <- cleanInput(input$text)
    wordCount <- length(textInput)
    wordPrediction <- nextWordPrediction(wordCount, textInput)
  })

  output$predictedWord <- renderPrint(wordPrediction())
  output$enteredWords <- renderText({
    input$text
  }, quoted = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)
