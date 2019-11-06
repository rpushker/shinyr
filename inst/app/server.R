shinyServer(function(input, output, session) {

  # Sourcing from project directory
  source("views/sidebar_view.R", local = TRUE)
  source("views/1d_plot_view.R", local = TRUE)
  source("views/3d_plot_view.R", local = TRUE)
  source("views/2d_plot_view.R", local = TRUE)
  source("views/reactive.R", local = TRUE)
  source("views/body_view.R", local = TRUE)
  source("views/word_cloud_view.R", local = TRUE)
  source("views/SL.R", local = TRUE)
  source("views/USL.R", local = TRUE)
  source("views/data_manipulation.R", local = TRUE)
  source("views/download_scripts.R", local = TRUE)

  # Sourcing from package installation
  # source(system.file(package = "shinyr", "app/views/sidebar_view.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/1d_plot_view.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/3d_plot_view.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/2d_plot_view.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/reactive.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/body_view.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/word_cloud_view.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/SL.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/data_manipulation.R"), local = TRUE)
  # source(system.file(package = "shinyr", "app/views/download_scripts.R"), local = TRUE)
})
