
#' getMostRepeatedValue
#' @param vec Vector to calculate most repeated values
#' @return most repeated values in the given set of values
#' @export
#' @examples
#' \dontrun{
#' getMostRepeatedValue(c(1,2,3,3,3,2))
#' getMostRepeatedValue(c("R", "R", "Python", "Python", "R"))
#' }
getMostRepeatedValue <- function(vec) {
  x <- as.data.frame(table(vec))
  y <- x[x$Freq == max(x$Freq), ]$vec
  sample_index <- sample(1:length(y), 1)
  return(y[sample_index])
}
