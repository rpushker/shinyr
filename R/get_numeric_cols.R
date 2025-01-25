#' getnumericCols
#' @title Get Numeric Cols
#' @description Get all columns which are numeric.
#' @author Jayachandra N
#' @param dat data frame
#' @export
#' @import dplyr
#' @return Character vector of names of numeric columns of given data frame
#' @examples
#' getnumericCols(iris)
#' getnumericCols(mtcars)
getnumericCols <- function(dat) {
  x <- as.data.frame(do.call("rbind",
                             lapply(names(dat),
                                    FUN = function(x) {
                                      c(x, class(dat[[x]]))
                                    })))

  names(x) <- c("name", "type")
  x <- x[x$type %in% c("integer", "numeric"), ]$name %>% as.vector()
  return(x)
}

#' getcharacterCols
#' @title Get Character Cols
#' @description Get character columns.
#' @author Jayachandra N
#' @param dat data frame
#' @return A Character vector of names of numeric columns of a given data frame
#' @export
#' @import dplyr
#' @examples
#' getcharacterCols(iris)
#' getcharacterCols(mtcars)
getcharacterCols <- function(dat) {
  x <- do.call("rbind",
               lapply(names(dat),
                      FUN = function(x) {
                        c(x, class(dat[[x]]))})) %>% as.data.frame()

  names(x) <- c("name", "type")

  x <- x[x$type %in% c("character", "factor"), ]$name %>% as.vector()

  return(x)
}
