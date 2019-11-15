#' getCoefficients
#' @title Get Coefficients
#' @description Get coefficients from the model summary
#' @param model lm model
#' @author Jayachandra N
#' @return data.frame of coeffcients
#' @export
#' @examples
#'  model <- lm(Sepal.Length ~ ., iris) # A linear regression model
#'  getCoefficients(model)
getCoefficients <- function(model) {
  x <- summary(model)
  y <- x$coefficients
  x <- data.frame(Col = row.names(y), y)
  return(x)
}


