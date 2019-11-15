#' detectClass
#' @title Detect Class
#' @description Detects class of given objects
#' @author Jayachandra N
#' @param x a vector
#' @return type of the vector
#' @export
#' @examples
#' detectClass(c(1,2,3))
#' detectClass(c("a","b"))
#' detectClass(iris$Species)
detectClass <- function(x) {
  char <- is.character(x)
  num <- is.numeric(x) | is.integer(x)
  fac <- is.factor(x)
  if(char){
    x <- "character"
  } else if(num) {
    x <- "numeric"
  } else if(fac){
    x <- "factor"
  }
  return(x)
}
