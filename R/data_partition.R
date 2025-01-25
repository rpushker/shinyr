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

  training_row_index <- sample(seq_len(nrow(df)), train_data_size * nrow(df))

  training_data <- df[training_row_index, ]

  test_data  <- df[-training_row_index, ]

  list(Test = test_data, Train = training_data)

}
