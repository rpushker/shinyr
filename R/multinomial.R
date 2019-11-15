#' multinomial
#' @title Multinomial
#' @description Fit Multinomial Log-linear Models.
#' @param eqn formula to build model
#' @param df data frame
#' @return model
#' @export
#' @author Jayachandra N
#' @importFrom nnet multinom
#' @examples
#' multinomial( Species ~ .,  iris)
multinomial <- function(eqn, df) {
  nnet::multinom(formula = eqn, data = df)
}
