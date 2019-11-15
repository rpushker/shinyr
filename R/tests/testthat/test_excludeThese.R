test_that("Test excludeThese", {
  res <- excludeThese(1:10, 1)
  expect_equal(length(excludeThese(1:10, 1)), 9)
  # expect_false(1 %in% res)
})
