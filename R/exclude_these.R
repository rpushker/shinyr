#' excludeThese
#' @title Exclude These
#' @description Exclude an item from a set of items
#' @author Jayachandra N
#' @param set vector
#' @param items_to_exclude vector to exclude from the whole set
#' @return vector
#' @export
#' @examples
#' excludeThese(1:10, 1)

excludeThese <- function(set, items_to_exclude) {

  set[!(set %in% items_to_exclude )]

}
