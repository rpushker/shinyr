#' check_and_install
#' @title Check and Install
#' @description Check whether given packages are installed or not and if not installed install them
#' @param packs Vector of package names
#' @return data.frame, status of required packages and their installation status
#' @export 
#' @examples
#' check_and_install(c('dplyr', 'data.table'))
check_and_install <- function(packs) {
  for(i in 1:length(packs)) {
    flag <- requireNamespace(packs[i], quietly = TRUE)
    if(flag) {
      library(packs[i], character.only = TRUE)
    } else {
      x <- packs[i]
      utils::install.packages(x)
    }
  }
  return(getLibraryReport(packs))
}

