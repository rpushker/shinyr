
output$xaxis_col_1d <- renderUI({
  # dat <- iris
  dat <- filtered_data_dyn()
  x <- do.call("rbind", lapply(names(dat), FUN = function(x){c(x, class(dat[[x]]))})) %>% as.data.frame()
  names(x) <- c("name", "type")
  x <- x[x$type %in% c("integer", "numeric", "factor", "character"), ]$name %>% as.vector()
  # x <- c("All_columns", x)
  selectInput(inputId = "xaxis_col_1d", label = "Select column/s", multiple = TRUE, choices = x, selected = x[1])
})

output$plot_type_1d <- renderUI({
  radioButtons("plot_type_1d", label = "Plot type", choices = c("Box", "Histogram", "Pie"))
})

output$width_of_tables <- renderUI({
  radioButtons("plot_size", "Plot Size", choices = c("Medium", "Large"), selected = "Medium", inline = TRUE)
})

output$plot_color <- renderUI({
selectInput("plot_color", "Plot Colors", choices = c("green", "red", "yellow", "purple", "pink"))
})

output$single_dimension_plot_box <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  p <- plotly::plot_ly()
  for(j in 1:length(col_pos_x)) {
    p <- plotly::add_boxplot(p, data = dat, y = dat[,col_pos_x[j]],
                           type = "box",
                           name = paste0(input$xaxis_col_1d[j]))
  }
  p
})


output$single_dimension_plot_pie <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  temp_df <- table(dat[,col_pos_x]) %>% as.data.frame()
  names(temp_df) <- c("Label", "count")
  p <- plotly::plot_ly(data = temp_df, labels = temp_df$Label, values = temp_df$count) %>%
      add_pie(hole = 0.5) %>%
      layout(showlegend = TRUE, title = paste("Count of ", input$xaxis_col_1d),
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  p
})

output$single_dimension_plot_pie_ui <- renderUI({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  if(length(col_pos_x) == 1) {
    box(width = 6, plotlyOutput("single_dimension_plot_pie"), title = "Pie chart", collapsible = TRUE)
  } else{
    return()
  }
})

output$single_dimension_plot_histogram <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  p <- plotly::plot_ly()
  for(j in 1:length(col_pos_x)) {
    p <- plotly::add_histogram(p, data = dat, y = dat[,col_pos_x[j]],
                           type = "histogram",
                           name = paste0(input$xaxis_col_1d[j]))
  }
  p
})

output$single_dimension_plot_histogram_ui <- renderUI({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  dat <- dat[,col_pos_x]
  x <- lapply(1:length(iris), FUN = function(x){
    class(iris[,x])
  }) %>% do.call('c',.)
  if(length(unique(x)) >=2 && ((grepl("character", unique(x)) && grepl("numeric", unique(x))) ||(grepl("character", unique(x)) && grepl("numeric", unique(x)))) ){
    return()
  } else {
    box(width = 6, plotlyOutput("single_dimension_plot_histogram"), title = "Histogram", collapsible = TRUE)
  }
})

output$single_dimension_plot_scatter <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  f <- list(
    family = "Courier New, monospace",
    size = 18,
    color = "black"
  )
  x <- list(
    title = "Index",
    titlefont = f
  )
  y <- list(
    title = paste0(input$xaxis_col_1d),
    titlefont = f
  )
  p <- plotly::plot_ly()
  for(j in 1:length(col_pos_x)) {
    p <- plotly::add_trace(p, data = dat, y = dat[,col_pos_x[j]],
                           type = "scatter",
                           name = paste0(input$xaxis_col_1d[j]))
  }
  p <- p %>% plotly::layout(xaxis = x, yaxis = y)
  p
})

output$single_dimension_plot_line <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) %in% input$xaxis_col_1d)
  # print(col_pos_x)

  f <- list(
    family = "Courier New, monospace",
    size = 18,
    color = "black"
  )
  x <- list(
    title = "Index",
    titlefont = f
  )
  y <- list(
    title = paste0(input$xaxis_col_1d),
    titlefont = f
  )
  p <- plotly::plot_ly()
  for(j in 1:length(col_pos_x)) {
    p <- plotly::add_trace(p, data = dat, y = dat[,col_pos_x[j]],
                           type = "scatter", mode = "line",
                           name = paste0(input$xaxis_col_1d[j]))
  }
  p <- p %>% plotly::layout(xaxis = x, yaxis = y)
  p
})

# output$cor_plot_column_inputs <- renderUI({
#   dat <- filtered_data_dyn()
#   dat <- iris
#   x <- getTypeOfColumns(dat)
#   
#   total_numeric_columns <- sum(x$Type %in% 'numeric')
#   threshold <- 2
#   
#   if(total_numeric_columns >= threshold) {
#     x <- x[x$Column == 'numeric', ]
#   } 
#   
#   shiny::selectInput(inputId = "corplot_input_cols", 
#                      label = "Select Columns to calculate correlation", 
#                      choices = x$Column, multiple = TRUE)
# })

output$cor_matrix_data <- DT::renderDataTable({
  
  x <- initial_analysis()
  
  DT::datatable(x$cor_matrix, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE)
  )
  
})

output$cor_plot_style <- renderUI({
  
  selectInput(inputId = "cor_style", 
              label = "Plot style",
              choices = sort(c("circle", 
                               "square", 
                               "number",
                               "ellipse",
                               "shade", 
                               "color", 
                               "pie")
              )
  )
  
})

output$cor_matrix_plot <- renderPlot({
  
  x <- initial_analysis()
  
  y <- x$cor_matrix
  
  plotCor(as.matrix(y), my_method = input$cor_style)
  
})

output$single_dimention_plot_ui <- renderUI({
  if(input$plot_size == "Medium") {
    fluidPage(
      box(width = 6, plotlyOutput("single_dimension_plot_box"), title = "Box plot", collapsible = TRUE),
      # box(width = 6, plotlyOutput("single_dimension_plot_pie"), title = "Pie Chart", collapsible = TRUE),
      uiOutput("single_dimension_plot_pie_ui"),
      box(width = 6, plotlyOutput("single_dimension_plot_histogram"), title = "Histogram", collapsible = TRUE),
      box(width = 6, plotlyOutput("single_dimension_plot_scatter"), title = "Scatter plot", collapsible = TRUE),
      box(width = 6, plotlyOutput("single_dimension_plot_line"), title = "Line plot", collapsible = TRUE),
      box(width = 6, title = 'correlation plot', 
          uiOutput("cor_plot_style"),
          plotOutput("cor_matrix_plot")),
      box(width = 6,title = 'word cloud',
          uiOutput("cols"),
          sliderInput("freq",
                      "Minimum Frequency:",
                      min = 1,  max = 50, value = 15),
          sliderInput("max",
                      "Maximum Number of Words:",
                      min = 1,  max = 300,  value = 100),
          plotOutput("plot"))
    )
  } else {
    fluidPage(
      box(width = 12, plotlyOutput("single_dimension_plot_box"), title = "Box plot", collapsible = TRUE),
      # box(width = 12, plotlyOutput("single_dimension_plot_pie"), title = "Pie Chart", collapsible = TRUE),
      uiOutput("single_dimension_plot_pie_ui"),
      box(width = 12, plotlyOutput("single_dimension_plot_histogram"), title = "Histogram", collapsible = TRUE),
      box(width = 12, plotlyOutput("single_dimension_plot_scatter"), title = "Scatter plot", collapsible = TRUE),
      box(width = 12, plotlyOutput("single_dimension_plot_line"), title = "Line plot", collapsible = TRUE),
      box(width = 12,title = 'word cloud',
          uiOutput("cols"),
          sliderInput("freq",
                      "Minimum Frequency:",
                      min = 1,  max = 50, value = 15),
          sliderInput("max",
                      "Maximum Number of Words:",
                      min = 1,  max = 300,  value = 100),
          plotOutput("plot")),
      box(width = 12, title = 'correlation plot', 
          uiOutput("cor_plot_style"),
          plotOutput("cor_matrix_plot"))
    )
  }
})



output$plot_me_1d <- renderPlotly({
  dat <- filtered_data_dyn()
  col_pos_x <- which(names(dat) == input$xaxis_col_1d)
  if(input$plot_type_1d == "Box") {
    if(input$xaxis_col_1d == "All_columns") {
      p <- plot_ly()
      for(i in 1:length(names(dat))) {
        p <- add_boxplot(p, y = dat[,i],
                         name = names(dat)[i])
      }
    } else {
      p <- plot_ly(y = dat[,col_pos_x], type = "box")
    }

  } else if(input$plot_type_1d == "Histogram") {
    if(input$xaxis_col_1d != "All_columns") {
      p <- plot_ly(y = dat[,col_pos_x], type = "histogram")
    } else {
      p <- plot_ly(alpha = 0.6)

      for(i in 1:length(names(dat))){
        p <- add_histogram(p, y =  dat[,i],
                           name = names(dat)[i])
      }
      p <- p %>% layout(barmode = "overlay")
    }
  } else if(input$plot_type_1d == "Pie") {
    if(input$xaxis_col_1d != "All_columns") {
      temp_df <- table(dat[,col_pos_x]) %>% as.data.frame()
      names(temp_df) <- c("Label", "count")
      p <- plotly::plot_ly(data = temp_df, labels = temp_df$Label, values = temp_df$count) %>%
        add_pie(hole = 0.5) %>%
        layout(showlegend = TRUE, title = paste("Count of ", input$xaxis_col_1d),
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    } else {
      p <- h1("Please select any one column")
    }

  }
  p
})
