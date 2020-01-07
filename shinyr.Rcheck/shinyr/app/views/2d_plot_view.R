output$xaxis_col <- renderUI({
  dat <- filtered_data_dyn()
  selectInput(inputId = "xaxis_col",
              label = "Select X axis",
              multiple = FALSE,
              choices = names(dat))
})

output$yaxis_col <- renderUI({
  dat <- filtered_data_dyn()
  selectInput(inputId = "yaxis_col",
              label = "Select Y axis",
              multiple = FALSE,
              choices = names(dat))
})

output$color_plot_type <- renderUI({
  dat <- filtered_data_dyn()
  selectInput(inputId = "color_column",
              label = "Group/Color",
              multiple = FALSE,
              choices = names(dat))
})

output$plot_type <- renderUI({
  radioButtons(inputId = "plot_type",
               label = "Select Plot type",
               choices = c("Bar", "Scatter", "Line"),
               selected = "Bar",
               inline = TRUE)
})


output$plot_me <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) == input$xaxis_col)
  col_pos_y <- which(names(dat) == input$yaxis_col)
  color_pos <- which(names(dat) == input$color_column)

  if(input$plot_type == "Scatter") {
    p <- plot_ly(data = dat,
                 x = dat[,col_pos_x],
                 y = dat[,col_pos_y],
                 type = 'scatter',
                 color = dat[,color_pos]) %>%
      layout(xaxis = list(title = input$xaxis_col),
             yaxis = list(title = input$yaxis_col))
  }
  if(input$plot_type == "Bar") {
    p <- plot_ly(data = dat,
                 x = dat[,col_pos_x],
                 y = dat[,col_pos_y],
                 type = 'bar',
                 color = dat[,color_pos])  %>%
      layout(xaxis = list(title = input$xaxis_col),
             yaxis = list(title = input$yaxis_col))
  }
  if(input$plot_type == "Line") {
    p <- plot_ly(data = dat,
                 x = dat[,col_pos_x],
                 y = dat[,col_pos_y],
                 mode = 'line',
                 type = "scatter",
                 color = dat[,color_pos])  %>%
      layout(xaxis = list(title = input$xaxis_col),
             yaxis = list(title = input$yaxis_col))
  }
  if(is.character(dat[,col_pos_x]) && is.character(dat[,col_pos_y])) {
    p <- plotly::plot_ly(data = dat, x = dat[,col_pos_x], y = dat[,col_pos_y])
  }
  p
})
