library(shinyr)
library(dplyr)

check_and_install <- function(packs) {
  for(i in 1:length(packs)) {
    if(packs[i] %in% row.names(installed.packages())) {
      library(packs[i], character.only = TRUE)
    } else {
      x <- packs[i]
      status[i] <- c(packs[i],install.packages(x))
    }
  }
}

getLibraryReport <- function(packages) {
  report <- list()
  for(i in 1:length(packages)){
    if(packages[i] %in% row.names(installed.packages())) {
      report[[i]] <- c(packages[i], "Installed")
    } else {
      report[[i]] <- c(packages[i], "Not installed")
    }
  }
  report <- as.data.frame(do.call('rbind', report))
  names(report) <- c('Package', "Status")
  return(report)
}


check_and_install(
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
    'GGally'
    )
)




# library(shinydashboard)
# library(shiny)
# library(dplyr)
# library(plotly)
# library(htmlwidgets)
# library(shinyWidgets)
# library(corrplot)
# library(wordcloud)
# library(shinyr)
# library(DT)
# library(SnowballC)
# library(tidytext)
