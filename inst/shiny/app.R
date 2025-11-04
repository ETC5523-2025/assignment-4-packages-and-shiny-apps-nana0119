# inst/shiny/app.R
library(shiny)
library(ggplot2)
library(dplyr)
library(lubridate)
library(bslib)
library(yarrawater)

ui <- fluidPage(
  theme = bs_theme(bootswatch = "flatly"),
  titlePanel("Yarra River Water Quality Explorer"),
  includeCSS("www/style.css"),
  sidebarLayout(
    sidebarPanel(
      helpText("Explore how Yarra River water quality changed between the 1990s and 2020s."),
      selectInput("parameter", "Select Parameter:",
                  choices = NULL),
      helpText(
        "‘Parameter’ represents the specific type of water-quality measurement collected at monitoring sites, ",
        "Each parameter reflects a different aspect of water condition and environmental change."
      ),
      helpText(
        "The boxplot visualises how the selected parameter changes across decades. ",
        "Each box summarises all observations within a decade: the line in the middle is the median (typical value), ",
        "the box height shows the middle 50% of the data (inter-quartile range), and the whiskers extend to most of the remaining data. ",
        "Individual points outside the whiskers represent outliers — unusually high or low measurements."
      ),
      helpText(
        "When you compare decades, a shift in the median line indicates a long-term increase or decrease in that parameter. ",
        "Narrower boxes mean the readings became more stable (less variation), ",
        "while wider boxes mean the data fluctuated more. ",
        "For example, if the pH median in the 2020s is higher than in the 1990s, the river water has become slightly more alkaline over time."
      )
    ),

    mainPanel(
      plotOutput("plot"),
      br(),
      p("This dashboard uses the cleaned Yarra River water quality dataset (yarra_wq_clean)
         included in the yarrawater package.")
    )
  )
)

server <- function(input, output, session) {


  data("yarra_wq_clean", package = "yarrawater")


  observe({
    params <- sort(unique(yarra_wq_clean$Parameter))
    updateSelectInput(session, "parameter",
                      choices = params,
                      selected = params[1])
  })


  output$plot <- renderPlot({
    req(input$parameter)

    yarra_wq_clean |>
      mutate(
        Year = year(Datetime),
        Period = case_when(
          Year >= 1990 & Year <= 1999 ~ "1990s",
          Year >= 2020 & Year <= 2025 ~ "2020s",
          TRUE ~ NA_character_
        )
      ) |>
      filter(!is.na(Period), Parameter == input$parameter) |>
      mutate(Period = factor(Period, levels = c("1990s","2020s"))) |>
      ggplot(aes(x = Period, y = Value, fill = Period)) +
      geom_boxplot(outlier.alpha = 0.4) +
      labs(
        title = paste(input$parameter, "in 1990s vs 2020s"),
        x = "Period",
        y = input$parameter
      ) +
      theme_minimal(base_size = 13)
  })
}


shinyApp(ui, server)

