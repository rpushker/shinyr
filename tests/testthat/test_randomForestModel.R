test_that("Testing RandomForestModel", {
  res <- randomForestModel(Species ~ ., iris)
  expect_true(is.factor(res$predicted))
})
