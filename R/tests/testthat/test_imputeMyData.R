test_that("Testing imputeMyData", {
  x <- head(iris)
  x$Sepal.Length[1] <- NA
  res <- imputeMyData(x, "Sepal.Length", "mean")
  expect_true(is.na(x$Sepal.Length[1]))
  expect_true(res$Sepal.Length[1] == 4.92)
  expect_true(is.data.frame(res))
  expect_equal(length(res), length(x))
  expect_equal(nrow(res), nrow(x))
})
