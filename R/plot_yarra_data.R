#' Plot Yarra River water quality by parameter and decade
#'
#' Creates a grouped boxplot comparing 1990s vs 2020s for each parameter.
#' This is a simple visualization version for inclusion in the package.
#'
#' @return A ggplot object
#' @export
plot_yarra_data <- function() {
  yarra_wq_clean |>
    dplyr::mutate(
      Year = lubridate::year(Datetime),
      Period = dplyr::case_when(
        Year >= 1990 & Year <= 1999 ~ "1990s",
        Year >= 2020 & Year <= 2025 ~ "2020s",
        TRUE ~ NA_character_
      )
    ) |>
    dplyr::filter(!is.na(Period)) |>
    dplyr::mutate(Period = factor(Period, levels = c("1990s","2020s"))) |>
    ggplot2::ggplot(ggplot2::aes(x = Period, y = Value, fill = Period)) +
    ggplot2::geom_boxplot(outlier.alpha = 0.4) +
    ggplot2::facet_wrap(~ Parameter, scales = "free_y") +
    ggplot2::labs(
      title = "Yarra River water quality comparison (1990s vs 2020s)",
      x = NULL,
      y = NULL
    ) +
    ggplot2::theme_minimal(base_size = 13) +
    ggplot2::theme(legend.position = "none")
}

