#' valid_sets
#' @title Valid Sets
#' @description Get a list of all datasets available as data.frame in R 
#' @author Pushker Ravindra
#' @author Jayachandra N
#' @param package package name to fetch inbuilt data sets example:  "datasets"
#' @param cols numeric to specify condition on how many columns should data frame have
#' @return data frame all available datasets of class data frame
#' @export
#' @importFrom utils data
#' @examples
#' valid_sets()
valid_sets <- function(package = NULL, cols = NULL) {
  data_sets <- utils::data()$results

  if(is.null(package)) {
    data_sets <- data_sets[data_sets[,"Package"] == "datasets", ]
  } else {
    data_sets <- data_sets[data_sets[,"Package"] == package, ]
  }

  if(is.null(cols)) {
    col <- 3
  } else{
    col <- cols
  }
  data_sets <- as.data.frame(data_sets) 
  data_sets <- na.omit(data_sets)
  
  valid_dset <- lapply(1:nrow(data_sets), FUN = function(j){
   
    tryCatch(
      {
        dset <- get(as.character(data_sets[,"Item"][j]))
        condition_isdf <- "data.frame" %in% class(dset)
        condition_hasNcols <- ncol(as.data.frame(dset)) >= col
        
        if( condition_isdf && condition_hasNcols){
          return(as.character(data_sets[,"Item"][j]))
        } else {
          return(NA)
        }
        
      },
      
      error=function(cond) {
        return(NA)
      })
  })
  
  y <- do.call(c, na.omit(valid_dset))
  y <- y[!is.na(y)]
  x <- data_sets[as.character(data_sets$Item) %in%y,]
  
  return(x)
}
