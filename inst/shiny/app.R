
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
      h3("Controls"),
      helpText("Select a parameter to explore how Yarra River water quality changed between the 1990s and 2020s."),
      selectInput("parameter", "Parameter:", choices = NULL),
      br(),
      h4("Guide"),
      helpText("The boxplot compares decades. The middle line is the median; the box shows the middle 50% of the data; and points outside are outliers."),
      helpText("A shift in the median shows long-term change. Narrow boxes mean less variation; wider boxes mean more.")
    ),

    mainPanel(
      h2("Distribution by Decade"),
      plotOutput("plot", height = 420),
      br(),
      h3("Dataset"),
      p("This app uses the cleaned dataset (yarra_wq_clean) included in the yarrawater package.")
    )
  )
)

server <- function(input, output, session) {
  data("yarra_wq_clean", package = "yarrawater")

  # update parameter choices
  observe({
    params <- sort(unique(yarra_wq_clean$Parameter))
    updateSelectInput(session, "parameter", choices = params, selected = params[1])
  })

  # render plot
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
      mutate(Period = factor(Period, levels = c("1990s", "2020s"))) |>
      ggplot(aes(x = Period, y = Value, fill = Period)) +
      geom_boxplot(outlier.alpha = 0.4) +
      labs(
        title = paste(input$parameter, "in 1990s vs 2020s"),
        x = "Period",
        y = input$parameter
      ) +
      theme_minimal(base_size = 13) +
      theme(legend.position = "none")
  })
}

shinyApp(ui, server)

