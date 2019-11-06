#' shineMe
#' @author Jayachandra N
#' @return shiny ui page
#' @export
#' @import shiny
#' @import shinydashboard
#' @examples
#' \dontrun{
#' shineMe()
#' }
shineMe <- function(){
  shiny::runApp(system.file(package = "shinyr", "app"))
}

#' plotCor
#'
#' @param cor_dat Corelation matrix
#' @param my_method method to plot Example: circle
#' @importFrom corrplot corrplot
#' @return Corelation plot
#' @export
plotCor <- function(cor_dat, my_method) {
  corrplot::corrplot(cor_dat, method = my_method)
}

