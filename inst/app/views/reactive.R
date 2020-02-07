package_report <- reactive({
  getLibraryReport(
    unique(c('data.table',
      "shinydashboard", 
      "shiny", 
      "plotly", 
      "htmlwidgets",
      "shinyWidgets", 
      "corrplot", 
      "wordcloud", 
      "DT", 
      "factoextra",
      'e1071',
      'GGally',
      "dplyr", "shiny", "shinydashboard", "tm", "wordcloud", "corrplot",
      "randomForest", "RColorBrewer", "DMwR", "caret", "nnet", 'plotly'
    ))
  )
})

output$package_report <- DT::renderDataTable({
  
  x <- package_report()
  DT::datatable(x, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

readFile <- reactive({
  if(input$data_to_use_id == "Use examples") {
    
    description <- input$example_data
    
    x <- valid_sets()
    
    y <- get(x[x$Title == description, ] %>% 
               unique() %>% 
               .[,"Item"] %>% 
               na.omit %>% 
               as.character())
    
    y <- as.data.frame(y)
    

  } else {
    
    input_file <- input$file1
    
    input_file_path <- input_file$datapath
    
    x <- read.csv(input_file_path, header = TRUE)
    
    y <- as.data.frame(x)
    
  }
  
  return(y)
  
})

filtered_data <- reactive({
  
  req(input$Analyze)
  
  my_data <- readFile()
  
  my_inputs <- input$cols_to_analyze

  all_possible_inputs <- names(my_data)
  
  matching <- all_possible_inputs %in% my_inputs
  
  cols_to_filter <- all_possible_inputs[matching]
  
  temp <- my_data
  
  for(j in 1:length(cols_to_filter)) {
    
    col <- my_data[ ,my_inputs[j]]
    
    if(is.character(col)) {
      temp <- temp[temp[,cols_to_filter[j]] %in% input[[cols_to_filter[j]]], ]
    } else if(is.numeric(col)) {
      temp <- temp[temp[,cols_to_filter[j]] >= input[[cols_to_filter[j]]][1], ]
      temp <- temp[temp[,cols_to_filter[j]] <= input[[cols_to_filter[j]]][2], ]
    }
  }
  
  return(temp)
})

filtered_data_dyn <- reactive({
  filtered_data()
})


modified_data <- reactive({
  summarized_data()
})

initial_analysis <- reactive({
  temp <- readFile()
  getDataInsight(temp)
})

observeEvent(input$Analyze,{
  readFile()
})

