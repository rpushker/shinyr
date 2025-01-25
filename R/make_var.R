#' make_var
#' @title Make Var
#' @description Make a variable from a given character vector.
#' @param prefix prefix character
#' @param var character to convert
#' @param suffix suffix character
#' @return variable
#' @author Jayachandra N
#' @export
#' @examples
#' make_var("", "Jay", "")
#' make_var("", "Incredible_India", "")
make_var <- function(prefix, var, suffix) {
  as.symbol(paste0(prefix, var, suffix))
}
