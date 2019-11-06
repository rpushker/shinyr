#' confmatrix
#' @author Jayachandra N
#' @param actuals factor
#' @param preds factor
#' @return table
#' @export
#' @importFrom caret confusionMatrix
#' @examples
#' \dontrun{
#' confmatrix(c(1,1,1,0), c(1,1,0,0))
#' }
confmatrix <- function(actuals, preds) {
  caret::confusionMatrix(as.factor(preds), as.factor(actuals))
}
