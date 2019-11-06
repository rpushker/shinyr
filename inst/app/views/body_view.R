
output$about_data <- renderUI({
  x <- initial_analysis()
  box(infoBox(title = "Rows", value =  x$Rows, subtitle = "Total rows"),
      infoBox(title = "Columns",
              value =  x$Columns,
              subtitle = "Total columns"), title = "Dimention", width = 12)
})


output$cor_matrix_data <- DT::renderDataTable({
  x <- initial_analysis()
  DT::datatable(x$cor_matrix, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

output$cor_plot_style <- renderUI({
  selectInput(inputId = "cor_style", label = "Plot style", choices = c("circle", "square", "number", "ellipse", "shade", "color", "pie"), selected = "square")
})



output$cor_matrix_plot <- renderPlot({
  x <- initial_analysis()
  y <- x$cor_matrix
  plotCor(as.matrix(y), my_method = input$cor_style)
})


output$full_data <- DT::renderDataTable({
  # req(input$file1)
  req(input$Analyze)
  my_data <- readFile()
  DT::datatable(my_data,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

output$filtered_data <- DT::renderDataTable({
  # req(input$file1)
  req(input$Analyze)
  my_data <- filtered_data_dyn()
  DT::datatable(filtered_data_dyn(),
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

output$Col_details <- DT::renderDataTable({

  req(input$Analyze)
  x <- initial_analysis()

  DT::datatable(x$Types,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE))
})

output$table <- renderUI({
  req(input$Analyze)
  res <- filtered_data_dyn()
  if(is.data.frame(res) && nrow(res) > 0) {
    fluidRow(
      tabBox(
        title = "Data insights", width = 12,
        tabPanel("Full data", fluidPage(DT::dataTableOutput("full_data"))),
        tabPanel("Filtered data", fluidPage(DT::dataTableOutput("filtered_data"), downloadBttn("downloadFilteredData",
                                                                                               "Download Filtered Data",
                                                                                               size = "sm",
                                                                                               color = "royal",
                                                                                               style = "stretch",
                                                                                               block = T))),
        tabPanel("About data", uiOutput("about_data"),
                 DT::dataTableOutput("Col_details"), downloadBttn("downloadAboutDataTable",
                                                                  "Download",
                                                                  size = "sm",
                                                                  color = "royal",
                                                                  style = "stretch",
                                                                  block = T)),
        tabPanel("Corelation Table",
                 DT::dataTableOutput("cor_matrix_data"), downloadBttn("downloadCorelationTable",
                                                                      "Download Corelation Table",
                                                                      size = "sm",
                                                                      color = "royal",
                                                                      style = "stretch",
                                                                      block = T)),
        tabPanel("Impute",
                 uiOutput("impute_ui"),
                 DT::dataTableOutput("imputed_data_table"), uiOutput("impute_download_conditional")),
        tabPanel("Group_by & Summarise", uiOutput("summarize_ui"), downloadBttn("downloadSummarizedTable",
                                                                                "Download Summarized Table",
                                                                                size = "sm",
                                                                                color = "royal",
                                                                                style = "stretch",
                                                                                block = T))
      ),
      tabBox(
        title = "Exploratory analysis", width = 12,
        tabPanel("Corelation Plot",
                 uiOutput("cor_plot_style"),
                 plotOutput("cor_matrix_plot")),
        tabPanel("word cloud",
                 uiOutput("cols"),
                 sliderInput("freq",
                             "Minimum Frequency:",
                             min = 1,  max = 50, value = 15),
                 sliderInput("max",
                             "Maximum Number of Words:",
                             min = 1,  max = 300,  value = 100),
                 plotOutput("plot")),
        tabPanel("1 Dimensional",
                 box(uiOutput("width_of_tables"), width = 6),
                 box(width = 6, uiOutput("xaxis_col_1d")),
                 uiOutput("single_dimention_plot_ui")),
        tabPanel("2 Dimensional",
                 box(uiOutput("xaxis_col"), width = 4),
                 box(uiOutput("yaxis_col"), width =4),
                 box(uiOutput("color_plot_type"), width =4),
                 uiOutput("plot_type"),
                 plotlyOutput("plot_me")),
        tabPanel("3 Dimensional",
                 box(uiOutput("xaxis_col_3d"), width = 3),
                 box(uiOutput("yaxis_col_3d"), width =3),
                 box(uiOutput("zaxis_col_3d"), width =3),
                 box(uiOutput("color_plot_type_3d"), width =3),
                 uiOutput("plot_type_3d"), plotlyOutput("plot_me_3d"))

      ),
      tabBox(title = "Predictive Analysis", width = 12,
             tabPanel("Supervised Learning",
                      box(
                        uiOutput("set_seed_regression"),
                        uiOutput("train_data_set_size"),
                        uiOutput("regression_predictor_cols"),
                        uiOutput("regression_dependent_variable_col"),
                        uiOutput("possible_models_to_train"),
                        uiOutput("regression_build_action"),
                        textOutput("regression_model_build_status_text"),
                        uiOutput("regression_validate_method"),
                        uiOutput("file_to_predict_regression"),
                        width = 6),
                      box(title = "Model details" , footer = "click on build to update this section",
                          verbatimTextOutput("regression_model_summary"), width = 6),
                      fluidPage(
                        tabBox(
                          tabPanel("Train Data", DT::dataTableOutput("regression_train_data"),
                                   downloadBttn("downloadTrainData", "Download Train Data", size = "sm", color = "royal", style = "stretch", block = T)),
                          tabPanel("Test Data", DT::dataTableOutput("regression_test_data"),
                                   downloadBttn("downloadTestData", "Download Test Data", size = "sm", color = "royal", style = "stretch", block = T)),
                          tabPanel("The model", uiOutput("model_details")),
                          tabPanel("Model validation", DT::dataTableOutput("regression_validation_table"),
                                   downloadBttn("downloadPredictions", "Download Predictions", size = "sm", color = "royal", style = "stretch", block = T)),
                          tabPanel("Confusion Matrix", uiOutput("conf")),
                          tabPanel("Predicted v/s Actuals plot", plotlyOutput("regression_validation_plot")),
                          width = 12))
             )
             # tabPanel("Unsupervised Learning", uiOutput("clustering_view"))
      )
    )
  } else {
    h1("Please upload the data in table format")
    # return()
  }
})

