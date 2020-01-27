#' getLibraryReport
#' @title Get Library Report
#' @description Get report on whether the given packages are installed on not 
#' @param packages Vector of package names
#' @return data.frame, status of required packages and their installation status
#' @author Jayachandra N
#' @export
#' @examples
#' getLibraryReport(c('dplyr', 'data.table'))
getLibraryReport <- function(packages) {
  report <- list()
    for(i in 1:length(packages)) {
      flag <- system.file(package = packages[i])!= ""
      if(flag) {
        report[[i]] <- c(packages[i], "Installed")
      } else {
        report[[i]] <- c(packages[i], "Not installed")
      }
    }
    report <- as.data.frame(do.call('rbind', report))
    names(report) <- c('Package', "Status")
  return(report)
}
