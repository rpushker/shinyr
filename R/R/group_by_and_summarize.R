
#' groupByandSumarize
#'
#' @param df data frame
#' @param grp_col column name to group
#' @param summarise_col column name to summarize
#' @param FUN function to summarize
#' @return summarized table
#' @export
#' @import dplyr
#' @importFrom stats median
#' @examples
#' \dontrun{
#' groupByandSumarize(mtcars, grp_col = c("am"), summarise_col = "hp", FUN = "mean")
#' }
groupByandSumarize <- function(df, grp_col, summarise_col, FUN = mean) {
  x <- make_var("", summarise_col, "")

  new_col_name <- paste0(FUN, "_of_", summarise_col, "_by_", grp_col)
  new_col <- make_var("", new_col_name, "")
  x <- df[[grp_col]] %>% unique()


  if(FUN == "mean") {
    # res <- df %>% group_by_(grp_col) %>%
    #   summarize( !!new_col := mean(!!x, na.rm = T))
    y <- lapply(1:length(x), FUN = function(i) {
      s <- df[df[[grp_col]] %in% x[i],]
      mean(s[[summarise_col]], na.rm = TRUE)
    })
    name <- names(df)[which(names(df) == grp_col)]
    res <- data.frame(a = x, b = do.call(c, y))
    names(res) <- c(name, new_col_name)
  }
  if(FUN == "median") {
    # res <- df %>% group_by_(grp_col) %>%
    #   summarize( !!new_col := median(!!x, na.rm = T))
    y <- lapply(1:length(x), FUN = function(i) {
      s <- df[df[[grp_col]] %in% x[i],]
      median(s[[summarise_col]], na.rm = TRUE)
    })
    name <- names(df)[which(names(df) == grp_col)]
    res <- data.frame(a = x, b = do.call(c, y))
    names(res) <- c(name, new_col_name)
  }
  if(FUN == "min") {
    # res <- df %>% group_by_(grp_col) %>%
    #   summarize( !!new_col := min(!!x, na.rm = T))
    y <- lapply(1:length(x), FUN = function(i) {
      s <- df[df[[grp_col]] %in% x[i],]
      min(s[[summarise_col]], na.rm = TRUE)
    })
    name <- names(df)[which(names(df) == grp_col)]
    res <- data.frame(a = x, b = do.call(c, y))
    names(res) <- c(name, new_col_name)
  }
  if(FUN == "max") {
    # res <- df %>% group_by_(grp_col) %>%
    #   summarize( !!new_col := max(!!x, na.rm = T))
    y <- lapply(1:length(x), FUN = function(i) {
      s <- df[df[[grp_col]] %in% x[i],]
      max(s[[summarise_col]], na.rm = TRUE)
    })
    name <- names(df)[which(names(df) == grp_col)]
    res <- data.frame(a = x, b = do.call(c, y))
    names(res) <- c(name, new_col_name)
  }
  if(FUN == "sum") {
    # res <- df %>% group_by_(grp_col) %>%
    #   summarize( !!new_col := sum(!!x, na.rm = T))
    y <- lapply(1:length(x), FUN = function(i) {
      s <- df[df[[grp_col]] %in% x[i],]
      sum(s[[summarise_col]], na.rm = TRUE)
    })
    name <- names(df)[which(names(df) == grp_col)]
    res <- data.frame(a = x, b = do.call(c, y))
    names(res) <- c(name, new_col_name)
  }
  return(res)
}

