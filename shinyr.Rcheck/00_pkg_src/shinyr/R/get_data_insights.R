#' getDataInsight
#' @title get Data Insights
#' @description Get detailed insights about the data like number of rows, columns and some basic statistics such as mean
#' @author Jayachandra N
#' @param temp data frame
#' @return list of details of data
#' @export
#' @importFrom stats median sd IQR cor
#' @examples
#' getDataInsight(mtcars)
#' getDataInsight(iris)
getDataInsight <- function(temp) {

  number_of_columns <- ncol(temp)

  number_of_rows <- nrow(temp)

  df <- data.frame(Column = "Char", Type = "Char", missing = "G")

  y <- do.call(rbind, lapply(names(temp), FUN=function(x) {

    mean <- ifelse(is.numeric(temp[[x]]), round(mean(temp[[x]], na.rm = TRUE), digits = 2), NA)

    median <- ifelse(is.numeric(temp[[x]]), round(stats::median(temp[[x]], na.rm = TRUE), digits = 2), NA)

    sd <- ifelse(is.numeric(temp[[x]]), round(stats::sd(temp[[x]], na.rm = TRUE), digits = 2), NA)

    variance <- ifelse(is.numeric(temp[[x]]), round(stats::var(temp[[x]], na.rm = TRUE), digits = 2), NA)

    max <- ifelse(is.numeric(temp[[x]]), max(temp[[x]], na.rm = TRUE), NA)

    min <- ifelse(is.numeric(temp[[x]]), min(temp[[x]], na.rm = TRUE), NA)

    IQR <- ifelse(is.numeric(temp[[x]]), IQR(temp[[x]], na.rm =TRUE), NA)

    levels <- paste(unique(temp[[x]]), collapse = ",")

    c(Column=x,
      Class=class(temp[[x]]),
      Missing = missing_count(temp[[x]]),
      Max = max,
      Min = min,
      Mean = mean,
      Median = median,
      SD = sd,
      Variance = variance,
      Unique_items = levels)

  }))

  if(length(getnumericCols(temp)) == 0) {
    cor_mat <- NULL
  } else {
    cor_mat <- as.data.frame(stats::cor(temp[ ,getnumericCols(temp)] %>% na.omit()))
  }

  return(list(Rows = number_of_rows, Columns = number_of_columns, Types = y, cor_matrix = cor_mat))

}


