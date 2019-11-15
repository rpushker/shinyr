#' dataPartition
#' @title Data Partition
#' @description Partition data for training and test
#' @author Jayachandra N
#' @param df data.frame which need to be devided into train and test subset
#' @param train_data_perc numeric value between 1 to 100
#' @return list of length 2 which contains Train data and Test data
#' @export
#' @examples
#' dataPartition(iris, 80)
dataPartition <- function(df, train_data_perc) {

  train_data_size <- as.numeric(train_data_perc) / 100

  trainingRowIndex <- sample(1:nrow(df), train_data_size * nrow(df))

  trainingData <- df[trainingRowIndex, ]

  testData  <- df[-trainingRowIndex, ]

  list(Test = testData, Train = trainingData)

}
