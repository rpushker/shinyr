#' missing_count
#' @title Missing Count
#' @description Count the number of missing values in a vector.
#' @param x vector
#' @return Number of missing values in the given set of values
#' @export
#' @author Jayachandra N
#' @examples
#' missing_count(c(1,2,3))
#' missing_count(c(NA, 1, NA, "NULL", ""))
missing_count <- function(x) {
  count <- sum(is.na(x)) + sum(is.null(x)) +
    sum(na.omit(x == "NA" | x == "" | x == "NULL"))

  return(count)
}
