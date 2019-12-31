#' getLibraryReport
#' @title Get Library Report
#' @description Get report on whether the given packages are installed on not 
#' @param packages Vector of package names
#' @return data.frame, status of required packages and their installation status
#' @author Jayachandra N
#' @export
#' @importFrom utils installed.packages
#' @examples
#' check_and_install(c('dplyr', 'data.table'))
getLibraryReport <- function(packages) {
  report <- list()
  # if(method != 'requireNamespace') {
  #   for(i in 1:length(packages)){
  #     if(packages[i] %in% row.names(utils::installed.packages())) {
  #       report[[i]] <- c(packages[i], "Installed")
  #     } else {
  #       report[[i]] <- c(packages[i], "Not installed")
  #     }
  #   }
  #   report <- as.data.frame(do.call('rbind', report))
  #   names(report) <- c('Package', "Status")
  # }
  # else{
    for(i in 1:length(packages)) {
      flag <- requireNamespace(packages[i], quietly = TRUE)
      if(flag) {
        report[[i]] <- c(packages[i], "Installed")
      } else {
        report[[i]] <- c(packages[i], "Not installed")
      }
    }
    report <- as.data.frame(do.call('rbind', report))
    names(report) <- c('Package', "Status")
  # }
  return(report)
}


#' check_and_install
#' @title Check and Install
#' @description Check whether given packages are installed or not and if not installed install them
#' @param packs Vector of package names
#' @return data.frame, status of required packages and their installation status
#' @export 
#' @importFrom utils install.packages installed.packages
#' @examples
#' check_and_install(c('dplyr', 'data.table'))
check_and_install <- function(packs) {
  for(i in 1:length(packs)) {
    flag <- requireNamespace(packs[i], quietly = TRUE)
    if(flag) {
      library(packs[i], character.only = TRUE)
    } else {
      x <- packs[i]
      status[i] <- c(packs[i], utils::install.packages(x))
    }
  }
  return(getLibraryReport(packs))
}

