#' multinomial
#'
#' @param eqn formula to build model
#' @param df data frame
#'
#' @return model
#' @export
#' @importFrom nnet multinom
#' @examples
#' \dontrun{
#' multinomial( Species ~ .,  iris)
#' }
multinomial <- function(eqn, df) {
  nnet::multinom(formula = eqn, data = df)
}
