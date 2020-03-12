shinyServer(function(input, output, session) {
  # options(shiny.maxRequestSize=40*1024^2) # Enable this line if you data > 5MB & < 40MB

  output$dependency_report_initial <- shiny::renderTable(
    dependency_report
  )
  
  output$body_page_conditional <- renderUI({
    required_packages <- dependency_report[dependency_report$Status == 'Not installed', ]
    if(nrow(required_packages) > 0) {
     fluidPage(box(width = 12, title = "Dependencies not satisfied", 
                   h3("Please install following packages to use full functionality of the dashboard"),
                   shiny::tableOutput('dependency_report_initial'))
     ) 
    } else {
      library(shinyr)
      library(shinydashboard)
      library(shiny)
      library(dplyr)
      library(plotly)
      library(htmlwidgets)
      library(shinyWidgets)
      library(corrplot)
      library(wordcloud)
      library(DT)
      library(GGally)
      library(e1071)
      library(factoextra)
      library(FactoMineR)
      library(wordcloud)
      library(data.table)
      library(nnet)
      library(randomForest)
      library(caret)
      library(DMwR)
      library(RColorBrewer)
      
      ###-------- Sourcing from project directory---->
      # source("views/sidebar_view.R", local = TRUE)
      # source("views/1d_plot_view.R", local = TRUE)
      # source("views/3d_plot_view.R", local = TRUE)
      # source("views/2d_plot_view.R", local = TRUE)
      # source("views/reactive.R", local = TRUE)
      # source("views/body_view.R", local = TRUE)
      # source("views/word_cloud_view.R", local = TRUE)
      # source("views/Supervised_Learning.R", local = TRUE)
      # source("views/UnSupervised_Learning.R", local = TRUE)
      # source("views/dimentionality_reduction.R", local = TRUE)
      # source("views/data_manipulation.R", local = TRUE)
      # source("views/download_scripts.R", local = TRUE)
      
      ###-------Sourcing from package installation------->
      source(system.file(package = "shinyr", "app/views/sidebar_view.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/1d_plot_view.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/3d_plot_view.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/2d_plot_view.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/reactive.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/body_view.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/word_cloud_view.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/Supervised_Learning.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/UnSupervised_Learning.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/dimentionality_reduction.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/data_manipulation.R"), local = TRUE)
      source(system.file(package = "shinyr", "app/views/download_scripts.R"), local = TRUE)
      uiOutput("body_page")
    }
  })
})
