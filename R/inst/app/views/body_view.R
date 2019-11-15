
output$body_page <- renderUI({
  req(input$Analyze)
  res <- filtered_data_dyn()
  if(is.data.frame(res) && nrow(res) > 0) {
    fluidPage(
      # Basic Stats
      tabBox(
        title = "Data insights", width = 12,
        tabPanel("Full data", 
                 fluidPage(DT::dataTableOutput("full_data"))),
        tabPanel("Filtered data", 
                 fluidPage(DT::dataTableOutput("filtered_data"),
                           downloadBttn("downloadFilteredData",
                                        "Download Filtered Data",
                                        size = "sm",
                                        color = "royal",
                                        style = "stretch",
                                        block = T))),
        tabPanel("About data", 
                 uiOutput("about_data"),
                 DT::dataTableOutput("Col_details"), 
                 downloadBttn("downloadAboutDataTable",
                              "Download",
                              size = "sm",
                              color = "royal",
                              style = "stretch",
                              block = T)),
        tabPanel("Corelation Table",
                 DT::dataTableOutput("cor_matrix_data"),
                 downloadBttn("downloadCorelationTable",
                              "Download Corelation Table",
                              size = "sm",
                              color = "royal",
                              style = "stretch",
                              block = T)),
        tabPanel("Impute",
                 uiOutput("impute_ui"),
                 DT::dataTableOutput("imputed_data_table"), 
                 uiOutput("impute_download_conditional")),
        tabPanel("Group_by & Summarise", 
                 uiOutput("summarize_ui"),
                 downloadBttn("downloadSummarizedTable",
                              "Download Summarized Table",
                              size = "sm",
                              color = "royal",
                              style = "stretch",
                              block = T))
      ),
      
      ## Exploratory analysis
      tabBox(
        title = "Exploratory analysis", width = 12,
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
      
      ## Predictive analysis view
      tabBox(title = "Predictive Analysis", width = 12,
             tabPanel("Dimensionality reduction"),
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
                      box(title = "Model details" , 
                          footer = "click on build to update this section",
                          verbatimTextOutput("regression_model_summary"), 
                          width = 6),
                      fluidPage(
                        tabBox(
                          tabPanel("Train Data", 
                                   DT::dataTableOutput("regression_train_data"),
                                   downloadBttn("downloadTrainData", 
                                                "Download Train Data", 
                                                size = "sm", 
                                                color = "royal", 
                                                style = "stretch", 
                                                block = T)),
                          tabPanel("Test Data", 
                                   DT::dataTableOutput("regression_test_data"),
                                   downloadBttn("downloadTestData", 
                                                "Download Test Data", 
                                                size = "sm", 
                                                color = "royal",
                                                style = "stretch",
                                                block = T)),
                          tabPanel("The model", uiOutput("model_details")),
                          tabPanel("Model validation", 
                                   DT::dataTableOutput("regression_validation_table"),
                                   downloadBttn("downloadPredictions", 
                                                "Download Predictions", 
                                                size = "sm", 
                                                color = "royal",
                                                style = "stretch", 
                                                block = T)),
                          tabPanel("Confusion Matrix", 
                                   uiOutput("conf")),
                          tabPanel("Predicted v/s Actuals plot", 
                                   plotlyOutput("regression_validation_plot")),
                          width = 12))
             ),
             tabPanel("Unsupervised Learning", 
                      fluidPage(
                        uiOutput("Cluster_analysis_inputs_ui"), 
                        uiOutput('cluster_analysis_ui'),
                        uiOutput("clustering_status")))
      ),
      box(DT::dataTableOutput('package_report'), width = 12, title = "Required packages and status")
    )

    
  } else {
    
    h4("Please upload the data in table format")
    
  }
  
})

