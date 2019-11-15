#' confmatrix
#' @title Conf Matrix
#' @description Calculates a cross-tabulation of observed and predicted classes with associated statistics.
#' @author Jayachandra N
#' @param actuals a numeric vector
#' @param preds a numeric vector
#' @return A table same as caret::ConfusionMatrix
#' @export
#' @importFrom caret confusionMatrix
#' @examples
#' confmatrix(c(1,1,1,0), c(1,1,0,0))
confmatrix <- function(actuals, preds) {
  caret::confusionMatrix(as.factor(preds), as.factor(actuals))
}
