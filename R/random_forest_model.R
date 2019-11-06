#' randoMForestModel
#' @param eqn formula
#' @param df data.frame
#' @importFrom randomForest randomForest
#' @return rf model
#' @export
#' @examples
#' \dontrun{
#' #' mod <- randomForestModel( Species ~ .,  iris)
#' }
randomForestModel <- function(eqn, df){
  randomForest::randomForest(eqn, data = df, importance = TRUE)
}
