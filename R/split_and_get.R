#' splitAndGet
#' @title Split And Get
#' @description Split a string by space and get
#' @author Jayachandra N
#' @param x string to split into words
#' @return List of worrds
#' @export
#' @examples
#' splitAndGet("R programming is awesome!")
splitAndGet <- function(x) {

  lapply(strsplit(x, " "), c) # Why c? strsplit will return a list

}
