
#' make_var
#' @param prefix prefix character
#' @param var character to convert
#' @param suffix suffix character
#' @return variable
#' @export
#' @examples
#' \dontrun{
#' make_var("", "Jay", "")
#' make_var("", "Incredible_India", "")
#' }
make_var <- function(prefix, var, suffix) {
  as.symbol(paste0(prefix, var, suffix))
}

