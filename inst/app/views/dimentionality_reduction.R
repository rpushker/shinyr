
res.pca <- reactive({
  df <- filtered_data_dyn()
  input$do_pca
  isolate({
    df <- df[,input$input_cols_for_dim_reduction]
  })
  return(PCA(df, graph = FALSE))
})

# Extract eigenvalues/variances
eigen_values <- reactive({
  var <- get_eig(res.pca())
  x <- as.data.frame(var)
  # row.names(x) <- NULL
  x$Dim <- row.names(var)
  x
})

# Visualize eigenvalues/variances
viz_eigenvalues <- reactive({
  fviz_screeplot(res.pca(), addlabels = TRUE, ylim = c(0, 50))
})


results_for_variables <- reactive({
  # Extract the results for variables
  var <- get_pca_var(res.pca())
  x <- as.data.frame(var$coord)
  y <- as.data.frame(x)
  # row.names(y) <- NULL
  y$Varaible <- row.names(x)
  y
})

# Control variable colors using their contributions
plot_varables <- reactive({
  fviz_pca_var(res.pca(), col.var="contrib",
               gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
               repel = TRUE # Avoid text overlapping
  )
})

contribution_to_principal_axis <- reactive({
  # Contributions of variables to PC1
  x <- fviz_contrib(res.pca(), choice = "var", axes = 1, top = 10)
  # Contributions of variables to PC2
  y <- fviz_contrib(res.pca(), choice = "var", axes = 2, top = 10)
  
  list(axis1 = x, axis2= y)
})

pca_results_for_induviduals <- reactive({
  # Extract the results for individuals
  ind <- get_pca_ind(res.pca())
  ind
})



### -------- Ui --->
output$dimention_reduction_input_columns <- renderUI({
  dat <- filtered_data_dyn()
  column_names <- names(dat)
  selectInput(inputId = "input_cols_for_dim_reduction", 
              label = "Select Input columns", 
              multiple = TRUE, 
              choices = column_names, 
              selected = column_names)
  
})

output$eigenvalues_table <- DT::renderDataTable({
  x <- eigen_values()
  DT::datatable(x, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

output$eigenvalues_plot <- renderPlot({
  viz_eigenvalues()
})



output$results_for_variables_table <- DT::renderDataTable({
  x <- results_for_variables()
  DT::datatable(x, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

output$results_for_induviduals <- DT::renderDataTable({
  ind <- pca_results_for_induviduals()
  res <- ind$coord
  x <- as.data.frame(res)
  x$Induviduals <- row.names(res)
  # row.names(x) <- NULL
  DT::datatable(x, class = 'cell-border stripe',
                selection=list(mode="multiple", target="row"),
                rownames=TRUE,
                options = list(scrollX = TRUE,
                               autoWidth = FALSE))
})

output$variable_contribution_plot <- renderPlot({
  plot_varables()
})


output$contribution_to_principle_axis_1_table <- renderPlot({
  contribution_to_principal_axis()$axis1
})

output$contribution_to_principle_axis_2_table <- renderPlot({
  contribution_to_principal_axis()$axis2
})

output$induviduals_plot <- renderPlot({
  fviz_pca_ind(res.pca(), col.ind = "cos2",
               gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
               repel = TRUE # Avoid text overlapping (slow if many points)
  )
})
output$biplot <- renderPlot({
  fviz_pca_biplot(res.pca(), repel = TRUE)
})

output$pca_output_view <- renderUI({
  # dat <- filtered_data_dyn()
  # # cls <- as_valid_set_for_clustering(dat)$types
  # dat <- iris
  # 
  # lapply()
  # character_col_index <- which(cls %in% "character")
  character_col_index <- 0
  if(character_col_index >=1) {
    h2('Please select only numeric columns, shinyR currently cannot handle character features, MCA and CA are under development!')
  } else {
    fluidPage(
      uiOutput('dimention_reduction_input_columns'),
      actionButton('do_pca','Perform Principle component analysis'),
      box(DT::dataTableOutput('eigenvalues_table'), width = 12, title = 'Eigen values'),
      box(plotOutput('eigenvalues_plot'), width = 12, title = 'Eigen values'),
      box(DT::dataTableOutput('results_for_variables_table'),width =12),
      box(plotOutput('variable_contribution_plot'), width = 12),
      box(plotOutput('contribution_to_principle_axis_1_table'),width = 12),
      box(plotOutput('contribution_to_principle_axis_2_table'),width =12),
      box(DT::dataTableOutput('results_for_induviduals'), width = 12),
      box(plotOutput('induviduals_plot'), width =12),
      box(plotOutput('biplot'),width = 12)
    )
  }
})

