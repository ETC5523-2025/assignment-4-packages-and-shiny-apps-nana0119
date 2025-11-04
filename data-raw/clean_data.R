## code to prepare `yarrariver` dataset goes here

library(readr)
library(dplyr)
library(readxl)
## Read data
SW_Metadata <- read_csv("data-raw/SW Metadata.csv")
yarra_wq <- read_excel("data-raw/yarra_wq.xls")


# convert the datetime to date
yarra_wq$Date <- as.Date(yarra_wq$Datetime)

# display full month names
yarra_wq$Month <- month(yarra_wq$Datetime, label = TRUE, abbr=FALSE)

# display full weekday names
yarra_wq$Weekday <- wday(yarra_wq$Datetime, label = TRUE, abbr=FALSE)

# display the hour
yarra_wq$Hour <- hour(yarra_wq$Datetime)

# filter the data by site id = 229143, date after 1990-01-01
yarra_wq_clean <- yarra_wq %>%
  filter(`Site ID` == 229143) %>%
  filter(Date >= as.Date("1990-01-01"))

yarra_wq_clean <- yarra_wq_clean %>%
  filter(Parameter %in% c("Salinity as EC@25",
                          "Water Temperature",
                          "pH",
                          "Turbidity")) %>%
  filter(Quality != 180)


usethis::use_data(yarra_wq_clean, overwrite = TRUE)
