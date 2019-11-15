test_that("Test getFeqTable", {
  x <- getFeqTable("shinyr is an easy way to do initial analysis of data")
  expect_true(is.data.frame(x))
  expect_equal(length(x), 2)
  expect_equal(nrow(x), 6)
})
