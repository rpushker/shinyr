res <- dataPartition(iris, 80)

test_that("Test dataPartition : Class of return object is list?", {
  res <- dataPartition(iris, 80)
  expect_true(is.list(res))
})

test_that("Test dataPartition : length of return object", {
  expect_length(res, 2)
})


test_that("Test dataPartition : Shape of test and train set", {
  expect_equal(length(res$Test), 5)
  expect_equal(length(res$Train), 5)
  expect_equal(names(res), c("Test", "Train"))
})
