#' getMostRepeatedValue
#' @title Get Most Repeated Value
#' @description get most repeated value in a given vector.
#' @param vec Vector to calculate most repeated values
#' @return most repeated values in the given set of values
#' @author Jayachandra N
#' @export
#' @examples
#' getMostRepeatedValue(c(1,2,3,3,3,2))
#' getMostRepeatedValue(c("R", "R", "Python", "Python", "R"))
getMostRepeatedValue <- function(vec) {
  x <- as.data.frame(table(vec))
  y <- x[x$Freq == max(x$Freq), ]$vec
  sample_index <- sample(seq_along(length(y)), 1)
  return(y[sample_index]) # Returning as factor. Should it be character?
}
