#' getLibraryReport
#'
#' @param packages Vector of package names
#'
#' @return data.frame, status of required packages and their installation status
#' @export
#'
#' @examples
#' check_and_install(c('dplyr', 'data.table'))
getLibraryReport <- function(packages) {
  report <- list()
  for(i in 1:length(packages)){
    if(packages[i] %in% row.names(installed.packages())) {
      report[[i]] <- c(packages[i], "Installed")
    } else {
      report[[i]] <- c(packages[i], "Not installed")
    }
  }
  report <- as.data.frame(do.call('rbind', report))
  names(report) <- c('Package', "Status")
  return(report)
}


#' check_and_install
#'
#' @param packs Vector of package names
#' @description Tries to install and load the packages which are not installed and returns the status
#' @return data.frame, status of required packages and their installation status
#' @export 
#'
#' @examples
#' check_and_install(c('dplyr', 'data.table'))
check_and_install <- function(packs) {
  for(i in 1:length(packs)) {
    if(packs[i] %in% row.names(installed.packages())) {
      library(packs[i], character.only = TRUE)
    } else {
      x <- packs[i]
      status[i] <- c(packs[i],install.packages(x))
    }
  }
  return(getLibraryReport(packs))
}

