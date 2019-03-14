library("shiny")
library("ggplot2")
library("leaflet")
library("dplyr")
library("tidyr")


source("data_analysis.R")
source("my_ui.R")
source("my_server.R")


shinyApp(ui = my_ui, server = my_server)
