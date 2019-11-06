
readFile <- reactive({

  if(input$data_to_use_id == "Use examples") {
    description <- input$example_data
    x <- valid_sets()
    y <- get(x[x$Title == description, ] %>% unique() %>% .[,"Item"] %>% na.omit %>% as.character())
    y <- as.data.frame(y)

  } else {
    input_file <- input$file1
    input_file_path <- input_file$datapath
    x <- read.csv(input_file_path, header = TRUE, stringsAsFactors = FALSE)
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

imputed_data <- reactive({
  req(input$impute)
  my_data <- readFile()
  print(input$impute)
  if(input$impute == 1) {
    x <- imputeMyData(df = my_data, col = input$impute_column,
                 FUN = input$impute_function)
    y <<- x
    x <- y
  } else if(input$impute > 1) {
    if(input$impute_function == "reset") {
      x <- imputeMyData(df = my_data,
                        col = input$impute_column,
                        FUN = input$impute_function)
    } else {
      x <- imputeMyData(df = y,
                        col = input$impute_column,
                        FUN = input$impute_function)
    }

    y <<- x
    x <- y
  } else {
    x <- my_data
  }
  return(x)
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

