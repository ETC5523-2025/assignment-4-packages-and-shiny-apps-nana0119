#' water quality measurements from Victorian Department of Energy, Environment, and Climate Action.
#'
#' A cleaned dataset used by the Shiny app.
#'
#' @format A data frame with 888 rows and 14 variables:
#' \describe{
#'   \item{Site ID}{Year of record}
#'   \item{industry}{Industry factor}
#'   \item{revenue}{Revenue (BRL)}
#'   \item{net_profit}{Net profit (BRL)}
#'
#' }
#' @source Bureau van Dijk Osiris (2018–2021), cleaned in data-raw/cleaned_data.R
"yarra_wq_clean"


#' Yarra River Water Quality Data (Cleaned)
#'
#' A dataset of water quality observations from the Yarra River,
#' comparing pre-pandemic (1990s) and recent decades (2020s).
#'
#' @format A data frame with 888 rows and 14 variables:
#' \describe{
#'   \item{Datetime}{Date and time of water sampling.}
#'   \item{Parameter}{Type of measurement ("pH", "Turbidity", "Salinity as EC@25").}
#'   \item{Value}{Measured numeric value of the parameter.}
#'   \item{Unit}{Measurement unit, e.g., NTU or mg/L.}
#'   \item{Site}{Sampling location.}
#'   \item{Source}{Data source, e.g., EPA Victoria.}
#' }
#' @source [Environment Protection Authority Victoria](https://data.water.vic.gov.au/WMIS/), cleaned in data-raw/cleaned_data.R
"yarra_wq_clean"

