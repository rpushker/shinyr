
library(DT)

output$regression_predictor_cols <- renderUI({
  res <- filtered_data_dyn()
  chs <- getnumericCols(res)
  chs <- names(res)
  selectInput(inputId = "regression_predictor", label = "Select Predictors/Indipendent variables", choices = chs, multiple = TRUE, selected = chs[1:(length(chs)-1)])
})

output$regression_dependent_variable_col <- renderUI({
  res <- filtered_data_dyn()
  chs <- getnumericCols(res)
  chs <- names(res)
  selectInput(inputId = "regression_dependent_variable", label = "Select Dependent Variable", choices = chs, multiple = FALSE, selected = chs[length(chs)])
})

output$set_seed_regression <- renderUI({
  textInput(inputId = "set_seed", label = "Set seed",
            value = 777)
})

output$train_data_set_size <- renderUI({
  textInput(inputId = "train_data_set_size_regression", label = "Train data size in pecentage", value = 80)
})

output$possible_models_to_train <- renderUI({

  req(input$regression_dependent_variable)

  res <- filtered_data_dyn()
  dep_col <- res[,input$regression_dependent_variable]
  unique_items <- length(unique(dep_col))
  
  if(detectClass(dep_col) == "numeric" && unique_items <= 4) {
    
    radioButtons(inputId = "Model_type",
                 label = "Choose model type",
                 choices = c("Linear Regression",
                             "Logistic Regression",
                             "Random Forest"),
                 selected = "Linear Regression")
    
  } else if(detectClass(dep_col) == "numeric" && unique_items > 5){
    
    radioButtons(inputId = "Model_type", 
                 label = "Choose model type",
                 choices = c("Linear Regression"),
                 selected = "Linear Regression")
    
  }  else if(detectClass(dep_col) %in% c("character", "factor")) {
    
    radioButtons(inputId = "Model_type",
                 label = "Choose model type",
                 choices = c("Logistic Regression", 
                             "Random Forest"),
                 selected = "Logistic Regression")
    
  }

})

output$regression_build_action <- renderUI({
  actionBttn(inputId = "regression_build", label = "Train model")
})



# dataPartition(iris, 80)
data_sampling_regression <- reactive({
  req(input$set_seed)
  set.seed(as.numeric(input$set_seed))
  res <- filtered_data_dyn()
  dataPartition(df = res, train_data_perc = input$train_data_set_size_regression)
})

output$regression_train_data <- DT::renderDataTable({
  x <- data_sampling_regression()
  DT::datatable(x$Train,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE))
})

output$regression_test_data <- DT::renderDataTable({
  req(data_sampling_regression())
  x <- data_sampling_regression()
  DT::datatable(x$Test,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE))
})


regression_model <- eventReactive(input$regression_build, {
  req(input$regression_dependent_variable)
  req(input$regression_predictor)
  validate(need(!is.null(input$regression_predictor) && !is.null(input$regression_dependent_variable),
                "please select Dependent and Indipendent variables and click on 'Build Model' button"))
  res <- filtered_data_dyn()
  res <- na.omit(res)
  
  items <- length(unique(res[,input$regression_dependent_variable]))
  eqn <-   as.formula(paste(input$regression_dependent_variable,
                            paste(input$regression_predictor, collapse=" + "),
                            sep=" ~ "))
  if(input$Model_type == "Linear Regression") {
    mod <- lm(formula = eqn, data = res)
  } else if(input$Model_type == "Logistic Regression") {
    dependent_variable <- input$regression_dependent_variable
    res[,dependent_variable] <- factor(res[,dependent_variable],
                                       levels = unique(res[,dependent_variable]))
    if(items == 2) {
      mod <- glm(formula = eqn, family = binomial(link = "logit"), data = res)
    } else if(items > 2) {
      mod <- multinomial(eqn, df = res)
    }
  } else if(input$Model_type == "Random Forest") {
    missing_values_count <- missing_count(res)
    if(missing_values_count > 0) {
      mod <- "Please remove all Missing values from data"
    } else {
      eqn <-   as.formula(paste(input$regression_dependent_variable,
                                paste(input$regression_predictor, collapse=" + "),
                                sep=" ~ "))
      dependent_variable <- input$regression_dependent_variable
      res[,dependent_variable] <- factor(res[,dependent_variable], levels = unique(res[,dependent_variable]))
      res <- na.omit(res)
      mod <- caret::train(eqn, res)
    }

  }
  return(mod)
})

regression_validation <- reactive({
  validate(
    need(!is.null(regression_model()), "Please build the model first.")
  )
  mod <- regression_model()
  selectInput("validate_method", label = "Select data to validate the model", choices = c("Test data", "Upload new data"))

  if(input$validate_method == "Test data") {
    sampling_data <- data_sampling_regression()
    predictions <- predict(mod, sampling_data$Test[,input$regression_predictor])
    actuals <- sampling_data$Test[, input$regression_dependent_variable]
    pred <- data.frame(Actuals = actuals, Predictions = predictions)
    x <- cbind(Row_Id = 1:nrow(sampling_data$Test), pred)
    x <- pred
    p <- plot_ly(data = x, x = x$Row_Id, y = x$Actuals, type = "scatter",
                 name = "Actuals", mode = "line") %>%
      add_trace(y = x$Predictions, name = "Predictions", mode = "line")

  } else {

    data <- new_data_uploaded_to_predict()

    test <- data[,input$regression_predictor]
    predictions <- predict(mod, test)
    actuals <- data[ ,input$regression_dependent_variable]
    pred <- data.frame(Actuals = actuals, Predictions = predictions)
    x <- cbind(Row_Id = 1:nrow(data), pred)

    p <- plot_ly(data = x, x = x$Row_Id, y = x$Actuals, type = "scatter",
                 name = "Actuals", mode = "line") %>%
      add_trace(y = x$Predictions, name = "Predictions", mode = "line")
  }

  return(list(Table = pred, Plot = p))
})

output$conf <- renderUI({
  if(input$Model_type == "Linear Regression") {
    return()
  } else {
    verbatimTextOutput("confMatrix")
  }
})

output$confMatrix <- renderPrint({
  if(input$Model_type == "Linear Regression") {
    return()
  } else {
    mod <- regression_model()
    if(input$validate_method == "Test data") {
      sampling_data <- data_sampling_regression()
      predictions <- predict(mod, sampling_data$Test[,input$regression_predictor])
      actuals <- sampling_data$Test[, input$regression_dependent_variable]
      x <- confmatrix(preds = predictions, actuals = actuals)
    } else {
      data <- new_data_uploaded_to_predict()
      test <- data[,input$regression_predictor]
      predictions <- predict(mod, test)
      actuals <- data[ ,input$regression_dependent_variable]
      x <- confmatrix(preds = predictions, actuals = actuals)
    }

  }
  return(x)
})

output$regression_validation_table <- DT::renderDataTable({
  validate(
    need(!is.null(regression_model()) && !is.null(input$regression_predictor), "Please select the features and build/re-build the models")
  )
  res <- regression_validation()$Table
  DT::datatable(res,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE))
})

output$regression_validation_plot <- renderPlotly({
  validate(
    need(!is.null(regression_model()) && !is.null(input$regression_predictor), "Please select the features and build/re-build the models")
  )
  res <- regression_validation()$Plot
  res
})

output$regression_model_build_status_text <-  renderText({
  req(regression_model())
  mod <- regression_model()
  if(is.list(mod)) {
    return("Model buiuding finished!")
  }
})

output$regression_model_summary <- renderPrint({
  validate(need(!is.null(regression_model()) && !is.null(input$regression_predictor),
         "Please select the features and build/re-build the models"))
  req(regression_model())
  if(input$Model_type != "Linear Regression") {
    return(regression_model())
  } else {
    return(summary(regression_model()))
  }
})

output$linear_regression_model_details <- renderUI({
  fluidPage(DT::dataTableOutput("regression_coefficients_table"), br(),
            uiOutput("regression_model_info"), br(),
            DT::dataTableOutput("regression_model_metrics_interpretations"))
})

output$clasification_model_details <- renderPrint({
  mod <- regression_model()
  sampling_data <- data_sampling_regression()
  predictions <- predict(mod, sampling_data$Test[,input$regression_predictor])
  actuals <- sampling_data$Test[, input$regression_dependent_variable]
  x <- confmatrix(preds = predictions, actuals = actuals)
  x
})

output$model_details <- renderUI({
  if(input$Model_type == "Linear Regression") {
    uiOutput("linear_regression_model_details")
  } else if(input$Model_type == "Logistic Regression" | input$Model_type == "Random Forest") {
    verbatimTextOutput("clasification_model_details")
  }
})

output$regression_validate_method <- renderUI({
  req(regression_model())
  if(is.null(regression_model())) {
    return()
  } else {
    selectInput("validate_method", label = "Select data to validate the model",
                choices = c("Test data", "Upload new data"))
  }
})

output$file_to_predict_regression <- renderUI({
  req(input$validate_method)
  if(is.null(input$validate_method) || input$validate_method  == "Test data") {
    return()
  } else {
    fileInput(inputId = "file_for_prediction_regression", label = "Upload a csv file")
  }
})

output$regression_coefficients_table <- DT::renderDataTable({
  mod <- regression_model()
  res <- getCoefficients(mod)

  brks <- quantile(res[,3], probs = seq(.05, .95, .05), na.rm = TRUE)
  clrs <- round(seq(255, 40, length.out = length(brks) + 1), 0) %>%
  {paste0("rgb(255,", ., ",", ., ")")}
  DT::datatable(res,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE)) %>%
    DT::formatStyle(names(res)[3], backgroundColor = styleInterval(brks, clrs))
})

output$regression_model_info <- renderUI({
  mod <- regression_model()

  validations <- regression_validation()
  acts <- validations$Table$Actuals
  preds <- validations$Table$Predictions

  res <- regressionModelMetrics(model = mod, actuals = acts, predictions = preds)
  fluidRow(infoBox("R Squared", value = res$r.squared, width = 4, fill = TRUE),
           infoBox("Adj R Squared", value = res$adj.r.squared, width = 4, fill = TRUE),
           infoBox("AIC", value = res$AIC, width = 4, fill = TRUE),
           infoBox("BIC", value = res$BIC, width = 4, fill = TRUE),
           infoBox("MSE", value    = res$MSE, width = 4, fill = TRUE),
           infoBox("RMSE", value = res$RMSE, width = 4, fill = TRUE),
           infoBox("MAE", value = res$MAE, width = 4, fill = TRUE),
           infoBox("MAPE", value = res$MAPE, width = 4, fill = TRUE),
           infoBox("Corelation", value = res$Corelation, width = 4,
                   fill = TRUE))
})

output$regression_model_metrics_interpretations <- DT::renderDataTable({
  res <- data.frame(Statistic = c("R-Squared",
                                  "Adj R squared",
                                  "F-Statistic",
                                  "Std. Error",
                                  "t-statistic",
                                  "AIC",
                                  "BIC",
                                  "MAPE (Mean absolute percentage error)",
                                  "MSE (Mean squared error)"),
                    Interpretation = c("Higher the better (> 0.70)",
                                       "Higher the better",
                                       "Higher the better",
                                       "Closer to zero the better",
                                       "Should be greater 1.96 for p-value to be less than 0.05",
                                       "Lower the better",
                                       "Lower the better",
                                       "Lower the better",
                                       "Lower the better"))
  DT::datatable(res,
                class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=FALSE,
                options = list(scrollX = TRUE, autoWidth = FALSE))
})

new_data_uploaded_to_predict <- reactive({
  req(input$validate_method)
  input_file <- input$file_for_prediction_regression
  input_file_path <- input_file$datapath
  x <- read.csv(input_file_path)
  return(x)
})

output$files_tar_button <- downloadHandler(
  filename <- function() {
    paste("inputFiles", "tar", sep=".")
  },

  content <- function(file) {
    tar(file, "input_files/")
  }
)


# delectColumnType <- function(df) {
#   df <- mtcars
#
#   detectMe <- function(x) {
#     char <- is.character(x)
#     num <- is.numeric(x)
#     fac <- is.factor(x)
#
#     fac <- if(char | num) {
#       length(unique(x)) <= 3
#     }
#
#   }
#
#
#   lapply(df, FUN = function(x) {
#     x
#   })
# }


# ## Multinomial regression
# # Load the data
# data("iris")
# # Inspect the data
# sample_n(iris, 3)
# # Split the data into training and test set
# set.seed(123)
# training.samples <- iris$Species %>%
#   createDataPartition(p = 0.8, list = FALSE)
# train.data  <- iris[training.samples, ]
# test.data <- iris[-training.samples, ]
#
# # Fit the model
# model <- nnet::multinom(Species ~., data = train.data)
# # Summarize the model
# summary(model)
# # Make predictions
# predicted.classes <- model %>% predict(test.data)
# head(predicted.classes)
# # Model accuracy
# mean(predicted.classes == test.data$Species)
