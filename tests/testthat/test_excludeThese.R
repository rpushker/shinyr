test_that("Test excludeThese: for exlusion!", {
  res <- excludeThese(1:10, 1)
  expect_equal(length(excludeThese(1:10, 1)), 9)
  expect_equal(setdiff(1, res), 1)
})

test_that("Test excludeThese: for exlusion!", {
  res <- excludeThese(1:10, 1)
  expect_equal(setdiff(res, 1), 2:10)
})

