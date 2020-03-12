testthat::test_that("Test Multinomial", {
  set.seed(111)
  res <- multinomial( Species ~ .,  iris)
  expect_equal(c('multinom', 'nnet'), class(res)) 
  expect_type(res, 'list')
})