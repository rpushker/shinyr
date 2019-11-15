
output$about_data <- renderUI({
  
  x <- initial_analysis()
  
  box(
    title = "Dimention", 
    width = 12,
    infoBox(title = "Rows", 
              value =  x$Rows, 
              subtitle = "Total rows"),
    infoBox(title = "Columns",
            value =  x$Columns,
            subtitle = "Total columns")
    )
  
})


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
              choices = c("circle", "square", "number", "ellipse", "shade", "color", "pie"), 
              selected = "square")
  
})



output$cor_matrix_plot <- renderPlot({
  
  x <- initial_analysis()
  
  y <- x$cor_matrix
  
  plotCor(as.matrix(y), my_method = input$cor_style)
  
})


output$full_data <- DT::renderDataTable({
  
  req(input$Analyze)
  
  my_data <- readFile()
  
  DT::datatable(my_data,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE)
                )
  
})

output$filtered_data <- DT::renderDataTable({
  
  req(input$Analyze)
  
  my_data <- filtered_data_dyn()
  
  DT::datatable(filtered_data_dyn(),
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE)
                )
})

output$Col_details <- DT::renderDataTable({
  
  req(input$Analyze)
  x <- initial_analysis()
  
  DT::datatable(x$Types,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE)
                )
})

output$impute_function <- renderUI({
  
  res <- filtered_data_dyn()
  
  if(is.character(res[,input$impute_column])) {
    
    selectInput("impute_function", 
                label = "Select function to impute", 
                choices = c("Most repeated", "reset"), 
                selected = "Most repeated")
  } else {
    
    selectInput("impute_function", 
                label = "Select function to impute", 
                choices = c("mean",
                            "median", 
                            "min", 
                            "max", 
                            "reset"), 
                selected = NULL)
  }
  
})

output$impute_column <- renderUI({
  
  res <- readFile()
  
  count <- apply(res, 2, FUN = function(x){
      missing_count(x)
    }) %>% as.data.frame()
  
  count$col <- row.names(count)
  
  row.names(count) <- NULL

  count <- count[count$. >= 1,]
  
  chs <- count$col
  
  selectInput("impute_column", 
              label = "Select a column to impute", 
              choices = chs, 
              selected = chs[1])
})


output$impute_action <- renderUI({
  actionButton("impute", "Impute")
})

output$imputed_data_table <- DT::renderDataTable({
  
  x <- imputed_data()
  # x <- modified_data()
  
  DT::datatable(x, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})


output$impute_ui <- renderUI({
  
  res <- readFile()
  
  count <- apply(res, 2, FUN = function(x){missing_count(x)}) %>% as.data.frame()
  
  count$col <- row.names(count)
  
  row.names(count) <- NULL

  count <- count[count$. >= 1,]
  
  chs <- count$col
  
  if(length(chs) >=1){
    
    fluidPage(
      box(
        uiOutput("impute_column"), 
        br(), 
        uiOutput("impute_function"), 
        br(), 
        uiOutput("impute_action")
        )
      )
    
  } else {
    
    span(h2("The data does not contain any missing values"), style="color:blue")
    
  }
  
})

## Group By and Summarize code -----

output$use_data_for_summarize <- renderUI({
  
  radioButtons(inputId = "data_for_summarize", 
               label = "Data to summarize", 
               choices = c("Full data", 
                           "Filtered data"), 
               selected = "Full data")
  
})

output$group_by_cols <- renderUI({
  
  res <- filtered_data_dyn()
  
  selectInput("group_by_cols", 
              label = "Select column for group by",
              choices = names(res), 
              selected = names(res)[1], 
              multiple = FALSE)
  
})

output$summarize_cols <- renderUI({
  
  res <- filtered_data_dyn()
  
  x <- getnumericCols(res)
  
  selectInput("summarise_cols", 
              label = "Select a column to summarize",
              choices = x,
              selected = x)
})

output$group_and_summase_function <- renderUI({
  
  selectInput("summarised_group_function",
              "Summarise by", 
              choices = c("mean", "median", "sum", "max", "min"),
              selected = "mean")
  
})
output$group_summarise_action <- renderUI({
  
  actionButton("Group_summarise", "Group and Summarise")
  
})

output$grp_and_sumarize <-  renderUI({
  
  fluidRow(
    uiOutput("group_by_cols"),
    br(),
    uiOutput("summarize_cols"),
    br(),
    # uiOutput("summarised_new_col_name"),
    br(),
    uiOutput("group_and_summase_function"),
    br(),
    uiOutput("group_summarise_action")
    )
})


output$summarized_data_table <- renderTable({
  x <- summarized_data()
  # knitr::kable(x)
  x
})

output$summarize_ui <- renderUI({
  fluidPage(
    
    column(width = 6,
           uiOutput("use_data_for_summarize"),
           uiOutput("group_by_cols"),
           uiOutput("summarize_cols"),
           # uiOutput("summarised_new_col_name"),
           uiOutput("group_and_summase_function"),
           uiOutput("group_summarise_action")
           ),
    
    column(width = 6, 
           tableOutput("summarized_data_table")
           )
  )
  
})


summarized_data <- reactive({

  if(input$data_for_summarize == "Full data") {
    
    my_data <- readFile()
    
  } else {
    
    my_data <- filtered_data_dyn()
    
  }
  
  my_data <- groupByandSumarize(df = my_data, 
                                grp_col = input$group_by_cols, 
                                summarise_col = input$summarise_cols, 
                                FUN = input$summarised_group_function)
  return(my_data)
  
})


output$download_filtered_data <- downloadHandler(
  
  filename = function() {
    
    paste("Assay_File", Sys.Date(), ".csv", sep = "")
    
  },
  
  content = function(file) {
    
    x <- filtered_data()
    
    assayinput <- read.csv("AssayFile.csv", 
                           header = TRUE,
                           stringsAsFactors = FALSE)
    
    write.csv(x, file, row.names = FALSE)
  }

)

