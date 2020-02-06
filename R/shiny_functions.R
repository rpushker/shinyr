#' #' getPickerInput
#' #' @title Get Picker Input
#' #' @param id InputID for the component
#' #' @param label 
#' #' @param choices 
#' #' @param selected 
#' #' @param multiple 
#' #' @import shinyWidgets
#' #' @return
#' #' @export
#' #' @example 
#' #' \donttest {
#' #' getPickerInput("id1", "Test label", 1:3, 1, TRUE)
#' #' }
#' getPickerInput <- function(id,label, choices, selected, multiple) {
#'   shinyWidgets::pickerInput(inputId = id, 
#'                             label = label, 
#'                             choices = choices, 
#'                             selected = selected, 
#'                             multiple = multiple)
#' }
#' 
