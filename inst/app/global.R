library(shinyr)

check_and_install <- function(packs) {
  for(i in 1:length(packs)) {
    if(packs[i] %in% row.names(installed.packages())) {
      library(packs[i], character.only = TRUE, logical.return = TRUE)
    } else {
      x <- packs[i]
      install.packages(x)
    }
  }
}

check_and_install(c("shinydashboard", "shiny", "plotly", "htmlwidgets", "shinyWidgets", "corrplot", "wordcloud", "DT", "SnowballC", "tidytext"))

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
