# library(factoextra)
# library(FactoMineR)

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
  flag <- grepl("character", res)
  return(list(types = res, column_ischar = flag, valid_set_for_clustering = ifelse(sum(flag) >=1, FALSE, TRUE)))
}

# as_valid_set_for_clustering(iris[1:4])

output$clustering_columns_selection_ui <- renderUI({
  dat <- filtered_data_dyn()
  cls <- as_valid_set_for_clustering(dat)$types
  numeric_col_index <- which(cls %in% c("numeric", 'integer'))
  selectInput(inputId = "input_cols_for_kmeans_clustering", 
                label = "Select Input columns", 
                multiple = TRUE, 
                choices = names(dat)[numeric_col_index], 
                selected = names(dat)[numeric_col_index])
})

isPackageInstalled <- function(package) {
  installed <- system.file(package = package)
  return(installed != "")
}

output$clustering_status <- renderUI({

  if(isPackageInstalled('factoextra')){
    return()
  } else {
    h1("Please install factoextra package to use this feature")
  }

})

output$partition_cluster_analysis_method <- renderUI({
  radioButtons(inputId = 'partition_cluster_method', 
               label = "Select clustering method", 
               choices = c('K-means', 
                           "Hierarchical"), 
               selected = "K-means", inline = TRUE)
})

output$Cluster_analysis_inputs_ui <- renderUI({
  fluidPage(
    box(width = 12, 
        # title = "K-means Clustering",
        uiOutput("clustering_columns_selection_ui"),
        uiOutput("partition_cluster_analysis_method"),
        uiOutput('kmeans_ncluster_input_ui'),
        uiOutput('nclust_method_input'),
        actionButton("submitt_button_clustering", "Perform Cluster analysis")
        )
  )
})


output$kmeans_cluster_plot <- renderPlot({
  p <- kmeans_analysis()$plot
  p
})

output$hierarchical_cluster_plot <- renderPlot({
  p <- hierarchical_clustering_analysis()
  p
})
output$n_optima_clusters_plot <- renderPlot({
  optimal_number_of_clusters()
})

output$cluster_analysis_ui <- renderUI({
  if(length(input$input_cols_for_kmeans_clustering) < 1) {
    h2("Selected columns are not sufficient to cluster the data")
  } else {
    if(input$partition_cluster_method == 'K-means') {
      box(width = 12, title = "K-means clustering",
          box(plotOutput('n_optima_clusters_plot'), width = 12),
          box(plotOutput('kmeans_cluster_plot'), width = 12),
          DT::dataTableOutput('data_with_cluster_id_mapped'),
          downloadBttn("downloadData_with_cluster_id_mapped", 
                       "Download data mapped to cluster ids", 
                       size = "sm", 
                       color = "royal", 
                       style = "stretch", 
                       block = T),
          plotOutput('ggpairs_plot_for_clusters'))
    } else {
      box(width = 12, title = "Hierarchical clustering",
          plotOutput('hierarchical_cluster_plot'))
    }
  }
})

output$kmeans_ncluster_input_ui <- renderUI({
  shiny::textInput(inputId = "kmeans_n_clusters", 
                   label = 'Specify number of clusters', 
                   value = 2, 
                   placeholder = 'Enter a numeric value')
})

clustering_data <- reactive({
  df <- filtered_data_dyn()
  input$submitt_button_clustering
  isolate({
    df <- scale(na.omit(df[,input$input_cols_for_kmeans_clustering]))
  })
  browser
  df
})

kmeans_analysis <- reactive({
  df <- clustering_data()
  # 2. Compute k-means
  set.seed(123)
  input$submitt_button_clustering
  isolate({
    cluster_analysis <- km.res <- kmeans(df, as.numeric(input$kmeans_n_clusters), nstart = 25)
  })
  
  # 3. Visualize
  plot <- fviz_cluster(km.res, data = df,
               palette = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"),
               ggtheme = theme_minimal(),
               main = "K-means Partitioning Clustering Plot"
  )
  
  return(list(plot = plot, 
              cluster_analysis = cluster_analysis))
  
})

clusters_table <- reactive({
  df <- filtered_data_dyn()
  input$submitt_button_clustering
  isolate({
    df <- na.omit(df[,input$input_cols_for_kmeans_clustering])
  })
  res <- kmeans_analysis()$cluster_analysis
  res <- as.numeric(res$cluster)
  df$Cluster_id <-  res
  df
})

output$data_with_cluster_id_mapped <-  DT::renderDataTable({
  res <- clusters_table()
  DT::datatable(res, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE)
  )
  
})

output$downloadData_with_cluster_id_mapped <- downloadHandler(
  filename = function() {
    paste("Data_with_cluster_id_mapped_", 
          Sys.time(),
          ".csv", 
          sep = "")
  },
  
  content = function(file) {
    res <- clusters_table()
    write.csv(res, file, row.names = FALSE)
  }
)

output$nclust_method_input <- renderUI({
  radioButtons(inputId = 'nclust_calc_method', 
               label = 'Method to calculate optimal number of clusters', 
               choices = c('Average of silhouette', 
                           'Total within sum of square', 
                           'Gap statistics'), 
               selected = 'Gap statistics', 
               inline = TRUE)
})

optimal_number_of_clusters <- reactive({
  my_data <- clustering_data()
  if(input$nclust_calc_method == 'Average of silhouette') {
    method = 'silhouette'
  } 
  if(input$nclust_calc_method == 'Total within sum of square') {
    method = 'wss'
  }
  if(input$nclust_calc_method == 'Gap statistics') {
    method = 'gap_stat'
  }
  fviz_nbclust(my_data, kmeans, method = method)
})

hierarchical_clustering_analysis <- reactive({
  # Compute hierarchical clustering and cut into 4 clusters
  res <- hcut(clustering_data(), k = as.numeric(input$kmeans_n_clusters), stand = TRUE)
  
  # Visualize
  fviz_dend(res, rect = TRUE, cex = 0.5,
            k_colors = c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"))
  
})

output$ggpairs_plot_for_clusters <- renderPlot({
  # res <- clusters_table()
  x <- clustering_data()
  data <- scale(x[,input$input_cols_for_kmeans_clustering])
  input$submitt_button_clustering
  isolate({
    final <- kmeans(x, as.numeric(input$kmeans_n_clusters), 25)
  })
  df <- as.data.frame(data)
  df$cluster <- final$cluster
  df$cluster <- as.character(df$cluster)
  ggpairs(df, 1:5, mapping = ggplot2::aes(color = cluster, alpha = 0.5), 
          diag = list(continuous = wrap("densityDiag")), 
          lower=list(continuous = wrap("points", alpha=0.9)))
})


