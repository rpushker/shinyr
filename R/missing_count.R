#' missing_count
#' @author Jayachandra N
#' @param x vector
#' @return Number of missing values in the given set of values
#' @export
#' @examples
#' \dontrun{
#' missing_count(c(1,2,3))
#' missing_count(c(NA, 1, NA, "NULL", ""))
#' }
missing_count <- function(x) {
  count <- sum(is.na(x)) + sum(is.null(x)) + sum(na.omit(x == "NA" | x == "" | x== "NULL"))
  return(count)
}
