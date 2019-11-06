output$xaxis_col_3d <- renderUI({
  # dat <- iris
  dat <- filtered_data_dyn()
  selectInput(inputId = "xaxis_col_3d", label = "Select X axis", multiple = FALSE, choices = names(dat))
})

output$yaxis_col_3d <- renderUI({
  # dat <- iris
  dat <- filtered_data_dyn()
  selectInput(inputId = "yaxis_col_3d", label = "Select Y axis", multiple = FALSE, choices = names(dat))
})
output$zaxis_col_3d <- renderUI({
  # dat <- iris
  dat <- filtered_data_dyn()
  selectInput(inputId = "zaxis_col_3d", label = "Select z axis", multiple = FALSE, choices = names(dat))
})

output$color_plot_type_3d <- renderUI({
  dat <- filtered_data_dyn()
  selectInput(inputId = "color_column_3d", label = "Group/Color", multiple = FALSE, choices = names(dat))
})

output$plot_type_3d <- renderUI({
  radioButtons(inputId = "plot_type_3d", label = "Select Plot type", choices = c("Scatter", "Line"), selected = "Scatter", inline = TRUE)
})


output$plot_me_3d <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) == input$xaxis_col_3d)
  col_pos_y <- which(names(dat) == input$yaxis_col_3d)
  col_pos_z <- which(names(dat) == input$zaxis_col_3d)
  color_pos <- which(names(dat) == input$color_column_3d)


  if(input$plot_type_3d == "Scatter") {
    p <- plot_ly(data = dat, x = dat[,col_pos_x], y = dat[,col_pos_y], z = dat[,col_pos_z], color = dat[,color_pos], type = "scatter3d") %>% layout(xaxis = list(title = input$xaxis_col), yaxis = list(title = input$yaxis_col), zaxis = list(title = input$zaxis_col) )
  }
  # if(input$plot_type == "Bar") {
  #   p <- plot_ly(data = dat, x = dat[,col_pos_x], y = dat[,col_pos_y], z = dat[,col_pos_z],type = 'bar', color = dat[,color_pos])  %>% layout(xaxis = list(title = input$xaxis_col), yaxis = list(title = input$yaxis_col))
  # }
  if(input$plot_type == "Line") {
    p <- plot_ly(data = dat, x = dat[,col_pos_x], y = dat[,col_pos_y], z = dat[,col_pos_z], color = dat[,color_pos], type = "scatter3d", mode = "lines") %>% layout(xaxis = list(title = input$xaxis_col), yaxis = list(title = input$yaxis_col), zaxis = list(title = input$zaxis_col) )
  }
  p
})
