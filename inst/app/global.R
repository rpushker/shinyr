library(shinyr)
library(dplyr)
library(shiny)
library(shinydashboard)

dependency_report <- getLibraryReport(
  c('data.table',
    "shinydashboard", 
    "shiny", 
    "plotly", 
    "htmlwidgets",
    "shinyWidgets", 
    "corrplot", 
    "wordcloud", 
    "DT", 
    "SnowballC", 
    "tidytext", 
    "factoextra",
    'e1071',
    'GGally',
    'tidyr'
    )
)
