
#' import randomForest
#' import mlbench
#' import caret
#' import e1071

#' randomForestCaret <- function(eqn, df) {
#'    # Load Dataset
#'   dataset <- df
#'   x <- dataset[,1:(ncol(df)-1)]
#'   y <- dataset[,ncol(df)]
#'
#'   #10 folds repeat 3 times
#'   control <- trainControl(method='repeatedcv',
#'                           number=10,
#'                           repeats=3)
#'   #Metric compare model is Accuracy
#'   metric <- "Accuracy"
#'   #Number randomely variable selected is mtry
#'   mtry <- sqrt(ncol(x))
#'   tunegrid <- expand.grid(.mtry=mtry)
#'   rf_default <- train(eqn,
#'                       data=dataset,
#'                       method='rf',
#'                       metric='Accuracy',
#'                       tuneGrid=tunegrid,
#'                       trControl=control)
#'   print(rf_default)
#' }
