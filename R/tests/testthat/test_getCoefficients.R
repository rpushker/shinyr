test_that("Test getCoefficients", {
  x <- lm(Sepal.Length ~ ., iris)
  res <- getCoefficients(x)
  testthat::expect_true(is.data.frame(res))
  testthat::expect_true(length(res) == 5)
})