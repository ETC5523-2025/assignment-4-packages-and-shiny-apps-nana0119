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

  sidebarLayout(
    sidebarPanel(
      helpText("Explore how Yarra River water quality changed between the 1990s and 2020s."),
      selectInput("parameter", "Select Parameter:",
                  choices = NULL),
      helpText("‘Parameter’ shows the type of water measurement, such as pH or Turbidity."),
      helpText("The boxplot shows how measurements differ between decades.
                Narrower boxes mean less variation, while median shifts show long-term change.")
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

