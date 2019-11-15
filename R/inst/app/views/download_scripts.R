output$downloadFilteredData <- downloadHandler(
  filename = function() {
    paste("filtered_data_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    res <- filtered_data()
    write.csv(res, file, row.names = FALSE)
  }
)

output$downloadAboutDataTable <- downloadHandler(
  filename = function() {
    paste("About_data_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- initial_analysis()
    write.csv(x$Types, file, row.names = FALSE)
  }
)

output$downloadCorelationTable <- downloadHandler(
  filename = function() {
    paste("Corelation_table_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- initial_analysis()
    write.csv(x$cor_matrix, file, row.names = FALSE)
  }
)

output$downloadImputedTable <- downloadHandler(
  filename = function() {
    paste("imputed_table_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- imputed_data()
    write.csv(x, file, row.names = FALSE)
  }
)

output$k <- downloadHandler(
  filename = function() {
    paste("Summarized_table_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- summarized_data()
    write.csv(x, file, row.names = FALSE)
  }
)

output$impute_download_conditional <- renderUI({
  if(is.null(imputed_data()) | class(imputed_data()) != "data.frame") {
    return()
  } else {
    downloadBttn("downloadImputedTable",
                 "Download Imputed Data",
                 size = "sm",
                 color = "royal",
                 style = "stretch",
                 block = T)
  }
})

output$downloadTrainData <- downloadHandler(
  filename = function() {
    paste("Train_Data_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- data_sampling_regression()
    write.csv(x$Train, file, row.names = FALSE)
  }
)

output$downloadTestData <- downloadHandler(
  filename = function() {
    paste("Test_Data_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- data_sampling_regression()
    write.csv(x$Test, file, row.names = FALSE)
  }
)

output$downloadPredictions <- downloadHandler(
  filename = function() {
    paste("Predictions_", Sys.Date(), ".csv", sep = "")
  },

  content = function(file) {
    x <- res <- regression_validation()$Table
    write.csv(x$Test, file, row.names = FALSE)
  }
)
