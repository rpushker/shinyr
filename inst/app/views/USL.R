as_valid_set_for_clustering <- function(x){
  dat <- x
  dat <- na.omit(dat)
  res <- lapply(names(dat), FUN = function(x) {

    cls <- class(dat[,x])

    if(cls == "factor"){
      numOrchar <- grepl("a-zA-Z", x)
      if(numOrchar) {
        cls <- "numeric"
      } else {
        cls <- "character"
      }
    }
    cls
  }) %>% unlist
  return(res)
}

as_valid_set_for_clustering(iris)

output$clustering_view <- renderUI({
  dat <- filtered_data_dyn()
  cls <- as_valid_set_for_clustering(dat)
  numeric_col_index <- which(cls %in% "numeric")
  if(length(numeric_col_index) >= 2) {
    selectInput("input_cols_for_kmeans_clustering", label = "SelectInput cols", choices = names(dat)[numeric_col_index], selected = names(dat)[numeric_col_index])
  } else {
    h1("Data does not meet the requirements for clustering")
  }
})
