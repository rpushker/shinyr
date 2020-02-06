# library(wordcloud)
# library("tm")
# library("SnowballC")
# library("RColorBrewer")
# library(tidyr)
# library(tidytext)
# library(ggplot2)
# library(dplyr)

output$cols <-  renderUI({
  selectInput("column", label = "select Columns", choices = names(filtered_data_dyn()), multiple = T)
})

getFrequencyWordTable <- reactive({
  getFeqTable(filtered_data_dyn()[,input$column] %>% as.character())
})

# output$exclude_items <- renderUI({
#   d <- getFrequencyWordTable()
#   d <- d[order(d[,2], decreasing = TRUE), ]
#   selectInput("exclude", label = "Exclude words", choices = d[,1], multiple = T)
# })

output$plot <- renderPlot({
  req(input$column)
  # getWordCloud(getFrequencyWordTable(), min.freq = input$freq, max.words=input$max)
  set.seed(1234)
  d <- getFrequencyWordTable()
  # if(!is.null(input$exclude)) {
  #   k <- which(input$exclude == d$word)
  #   d <- d[-rows, ]
  # }
  wordcloud(words = d$word, freq = d$freq, min.freq = input$freq, max.words=input$max,
            random.order=FALSE, rot.per=0.35,
            colors=brewer.pal(8, "Dark2"))

})

