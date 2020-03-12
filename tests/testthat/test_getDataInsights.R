test_that("Test getDataInsights : Class of return type is list?", {
  res <- getDataInsight(iris)
  testthat::expect_true(is.list(res))
})

test_that("Test getDataInsights : Shape of return type", {
  res <- getDataInsight(iris)
  testthat::expect_equal( length(res), 4)
  testthat::expect_equal(res$Rows, 150)
  testthat::expect_equal(res$Columns, 5)
  testthat::expect_true(is.matrix(res$Types))
})
