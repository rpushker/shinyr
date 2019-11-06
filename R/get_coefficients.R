#' getCoefficients
#'
#' @param model lm model
#' @author Jayachandra N
#' @return data.frame of coeffcients
#' @export
#' @examples
#' \dontrun{
#'  x <- lm(Sepal.Length ~ ., iris)
#'  getCoefficients(x)
#' }
getCoefficients <- function(model) {
  x <- summary(model)
  y <- x$coefficients
  x <- data.frame(Col = row.names(y), y)
  return(x)
}


