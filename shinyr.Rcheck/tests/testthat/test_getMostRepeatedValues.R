test_that("TEsting getMostRepeatedValue", {
  res <- getMostRepeatedValue(c(1:10,1))
  expect_true(res == 1)
  expect_equal(length(res), 1)
  res <- getMostRepeatedValue(c("a", "a", "3", 1))
  expect_true(is.factor(res))
  expect_true(res == "a")
})
