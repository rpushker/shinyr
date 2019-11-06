#' getFeqTable
#' @author Jayachandra N
#' @param text plain text or a paragraph
#'
#' @return data frame of word and it's frequency.
#' @export
#' @importFrom tm tm_map Corpus content_transformer VectorSource TermDocumentMatrix stopwords removeNumbers removeWords removePunctuation stripWhitespace
#' @examples
#' \dontrun{
#' getFeqTable("India is Incredible!")
#' }
getFeqTable <- function(text) {
  docs <- Corpus(VectorSource(text))
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  docs <- tm_map(docs, toSpace, "/")
  docs <- tm_map(docs, toSpace, "@")
  docs <- tm_map(docs, toSpace, "\\|")

  docs <- tm_map(docs, content_transformer(tolower))
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  # Remove english common stopwords
  docs <- tm_map(docs, removeWords, stopwords("english"))
  # Remove your own stop word
  # specify your stopwords as a character vector
  docs <- tm_map(docs, removeWords, c("blabla1", "blabla2"))
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  # Text stemming

  dtm <- TermDocumentMatrix(docs)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  d
}

