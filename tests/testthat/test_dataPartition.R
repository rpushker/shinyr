
test_that("Test dataPartition", {
  res <- dataPartition(iris, 80)
  expect_true(is.list(res))
  expect_length(res, 2)
  expect_equal(length(res$Test), 5)
  expect_equal(length(res$Train), 5)
  expect_equal(names(res), c("Test", "Train"))
})
