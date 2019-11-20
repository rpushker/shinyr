
output$body_page <- renderUI({
  req(input$Analyze)
  res <- filtered_data_dyn()
  if(is.data.frame(res) && nrow(res) > 0) {
    fluidPage(
      ## ------- Basic Stats-------->
      tabBox(
        title = "Insights", width = 12,
        tabPanel('About', 
                 fluidPage(
                   box(DT::dataTableOutput('package_report'), 
                       width = 12, 
                       title = "Required packages"))),
        # tabPanel("Full data", 
        #          fluidPage(DT::dataTableOutput("full_data"))),
        tabPanel("Data", 
                 fluidPage(DT::dataTableOutput("filtered_data"),
                           downloadBttn("downloadFilteredData",
                                        "Download Filtered Data",
                                        size = "sm",
                                        color = "royal",
                                        style = "stretch",
                                        block = T))),
        tabPanel("Summary", 
                 uiOutput("about_data"),
                 DT::dataTableOutput("Col_details"), 
                 downloadBttn("downloadAboutDataTable",
                              "Download",
                              size = "sm",
                              color = "royal",
                              style = "stretch",
                              block = T)),
        tabPanel("Correlations",
                 DT::dataTableOutput("cor_matrix_data"),
                 downloadBttn("downloadCorelationTable",
                              "Download Corelation Table",
                              size = "sm",
                              color = "royal",
                              style = "stretch",
                              block = T)),
        tabPanel("Imputation",
                 uiOutput("impute_ui"),
                 DT::dataTableOutput("imputed_data_table"), 
                 uiOutput("impute_download_conditional")),
        tabPanel("Pivot Table", 
                 uiOutput("summarize_ui"),
                 downloadBttn("downloadSummarizedTable",
                              "Download Summarized Table",
                              size = "sm",
                              color = "royal",
                              style = "stretch",
                              block = T))
      ),
      
      ## ------Exploratory data analysis------>
      
      tabBox(
        title = "Exploratory Data Analysis", width = 12,
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
      
      ##----------Predictive analysis --------------->
      
      tabBox(title = "Predictive Analysis", width = 12,
             tabPanel("Dimensionality Reduction",
                      uiOutput('pca_output_view')
                      ),
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
                      box(title = "Model Details" , 
                          footer = "click on build to update this section",
                          verbatimTextOutput("regression_model_summary"), 
                          width = 6),
                      fluidPage(
                        tabBox(
                          tabPanel("Training Data", 
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
                          tabPanel("The Model", uiOutput("model_details")),
                          tabPanel("Model Validation", 
                                   DT::dataTableOutput("regression_validation_table"),
                                   downloadBttn("downloadPredictions", 
                                                "Download Predictions", 
                                                size = "sm", 
                                                color = "royal",
                                                style = "stretch", 
                                                block = T)),
                          tabPanel("Confusion Matrix", 
                                   uiOutput("conf")),
                          tabPanel("Predictions v/s Actuals", 
                                   plotlyOutput("regression_validation_plot")),
                          width = 12))
             ),
             tabPanel("Unsupervised Learning", 
                      fluidPage(
                        uiOutput("Cluster_analysis_inputs_ui"), 
                        uiOutput('cluster_analysis_ui'),
                        uiOutput("clustering_status")))
      )
      # box(DT::dataTableOutput('package_report'), width = 12, title = "Required packages and status")
    )

    
  } else {
    
    h4("Please upload the data in table format")
    
  }
  
})

