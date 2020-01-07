#' shineMe
#' @title shineMe
#' @description An R shiny app for shinyr UI.
#' @author Jayachandra N
#' @return shiny UI page
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
#' @title Plot Cor
#' @description Plot correlation plot
#' @param cor_dat Corelation matrix
#' @param my_method method to plot, for example: circle
#' @importFrom corrplot corrplot
#' @return Corelation plot
#' @export
#' @author Jayachandra N
#' examples
#' cor_dat <- cor(mtcars)
#' plotCor(cor_dat, "circle")
plotCor <- function(cor_dat, my_method) {
  corrplot::corrplot(cor_dat, method = my_method) # A single line function?
}
