library(shinyr)
library(dplyr)
library(shiny)
library(shinydashboard)

dependency_report <- getLibraryReport(
  c('data.table',
    'shinyr',
    "shinydashboard", 
    "shiny", 
    "corrplot",
    "wordcloud",
    "plotly", 
    'dplyr',
    "htmlwidgets",
    "shinyWidgets", 
    "corrplot", 
    "wordcloud", 
    "DT", 
    "factoextra",
    'e1071',
    'GGally',
    'tidyr',
    'RColorBrewer',
    'caret', 'nnet', 'DMwR', 'randomForest'
    )
)
