
output$data_to_use <- renderUI({
  radioButtons(inputId = "data_to_use_id", label = "Input Data", choices = c("Use examples", "Upload"))
})

output$input_data <- renderUI({
  if(input$data_to_use_id == "Upload") {
    fileInput("file1", "Upload a csv file", multiple = FALSE,
              accept = c("text/csv","text/comma-separated-values,text/plain", ".csv"))
  } else {
    chs <- as.character(na.omit(unique(valid_sets()[,"Title"])))
    selectInput("example_data", 
                label = "Use Example Dataset", 
                choices = chs,
                selected = "Motor Trend Car Road Tests",
                multiple = FALSE)
  }

})

output$columns_to_analyze <- renderUI({
  # req(input$file1 | input$example_data)
  my_data <- readFile()
  # if(is.null(input$file1) & is.null(input$example_data)) {
  #   return()
  # } else{
    pickerInput(inputId = "cols_to_analyze",
                label = "Columns to create filter",
                choices = names(my_data),
                multiple = TRUE,
                selected = names(my_data))
  # }

})

output$analyze_action_bttn <- renderUI({
  # req(input$file1 | input$example_data)
  actionBttn("Analyze", "Build UI")
})


output$filters <- renderUI({

  req(input$Analyze)
  my_data <- readFile()
  selected_cols <- input$cols_to_analyze

  labels <- lapply(1:length(selected_cols), FUN = function(x){
    selected_cols[x]
  })

  ids <- lapply(1:length(selected_cols), FUN = function(x){
    paste0(selected_cols[x])
  })

  choices <- lapply(1:length(selected_cols), FUN = function(x){
    unique(my_data[ ,selected_cols[x]])
  })
  lapply(1:length(labels), function(i) {
    output[[labels[[i]]]] <- renderUI({
      col <- my_data[ ,selected_cols[i]]
      if(is.character(col) | is.factor(col)) {
        pickerInput(ids[[i]],
                    label = labels[[i]],
                    choices = choices[[i]],
                    selected = choices[[i]],
                    multiple = TRUE)
      } else if(is.numeric(col)) {
        sliderInput(ids[[i]],
                    label = labels[[i]],
                    min = min(col, na.rm = TRUE),
                    max = max(col, na.rm = TRUE),
                    value = c(min(col, na.rm = TRUE), max(col, na.rm = TRUE)))
      }

    })
  })

  lapply(1:length(labels), function(i) {
    uiOutput(labels[[i]])
  })

})
