
#' getType
#' @title Get Type
#' @param vec A vector of any choice, to detect between numeric or character
#' @author Jayachandra N
#' @return type of the given vector
#' @export
#' @examples
#' getType(iris$Species)
#' getType(as.factor(c(1,0,1,1,0,NA,1, NULL)))
#' getType(as.factor(c(1, NULL,0,1,1,0,1,'a')))
#' getType(c(1,2,3,4, NA))
#' getType(letters[1:4])
getType <- function(vec) {
  cls <- class(vec)
  if (cls == "character") {
    return("character")
  }

  if (cls == "numeric" | cls == "integer") { # WARNING: Should be || not |
    return("numeric")
  }

  if (cls == "factor") {
    tryCatch({
      y <- y[!is.null(y)]
      y <- y[!is.na(y)]
      y <- y[y != ""]
      y <- y[y != " "]
      y <- y[y != "NULL"]
      y <- y[y != "NA"]

      x <- sum(is.na(as.numeric(levels(y))))

      if (x == 0) {
        return("numeric")
      } else {
        return("character")
      }
    },

    error = function(cond) {
      return("character")
    })
  }
}

#' getTypeOfColumns
#' @author Jayachandra N
#' @param df data frame
#' @return Data frame of column name and it's type
#' @export
#' @examples
#' getTypeOfColumns(mtcars)
#' getTypeOfColumns(iris)
getTypeOfColumns <- function(df) {
  # df <- iris
  res <- lapply(names(df), FUN = function(x) {
    getType(df[[x]])
  })
  names(res) <- names(df)
  res <- as.data.frame(do.call("rbind", res))
  res$column <- names(df)
  res <- res[, c(2, 1)]
  row.names(res) <- NULL
  names(res) <- c("Column", "Type")
  return(res)
}
