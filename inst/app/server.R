shinyServer(function(input, output, session) {
  
  # options(shiny.maxRequestSize=40*1024^2) # Enable this line if you data > 5MB & < 40MB

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

})
