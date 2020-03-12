
testthat::test_that("Test regressionModelMetrics", {
  set.seed(111)
  mod <- lm(formula = wt ~ ., data = mtcars)
  predictions <- predict(mod, mtcars[,-6])
  actials <- mtcars[,6]
  res <- regressionModelMetrics(actuals = actials, predictions = predictions, model = mod)
  expect_type(res, 'list')
  expect_named(res)
  expect_equal(names(res), c("AIC", "BIC", "MAE", "MSE", "RMSE", "MAPE", "Corelation", "r.squared", 'adj.r.squared'))
})
