test_that("Test getDataInsights", {
  res <- getDataInsight(iris)
  testthat::expect_true(is.list(res))
  testthat::expect_equal( length(res), 4)
  testthat::expect_true(is.numeric(res$Rows))
  testthat::expect_equal(res$Rows, 150)
  testthat::expect_equal(res$Columns, 5)
  testthat::expect_true(is.matrix(res$Types))
})