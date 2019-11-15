#' splitAndGet
#' @author Jayachandra N
#' @param x string to split into words
#' @return List of worrds
#' @export
#' @examples
#' \dontrun{
#' splitAndGet("R programming is awesome!")
#' }
splitAndGet <- function(x) {

  lapply(strsplit(x, " "), c)

}
