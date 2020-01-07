#' randoMForestModel
#' @title Random Forest Model
#' @description Build Random Forest Model.
#' @param eqn formula
#' @param df data.frame
#' @importFrom randomForest randomForest
#' @return rf model
#' @export
#' @author Jayachandra N
#' @examples
#' randomForestModel( Species ~ .,  iris)
randomForestModel <- function(eqn, df){
  randomForest::randomForest(eqn, data = df, importance = TRUE)
}
