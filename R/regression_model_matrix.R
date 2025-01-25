#' regressionModelMetrics
#' @title Regression Model Metrics
#' @description Generate regression model metrics such as R-squared and MAPE.
#' @author Jayachandra N
#' @param actuals numeric vector of actual values
#' @param predictions numeric vector of predictions
#' @param model lm model object
#' @importFrom stats AIC BIC na.omit cor
#' @return list
#' @export
#' @examples
#' mod <- lm(formula = wt ~ ., data = mtcars)
#' predictions <- predict(mod, mtcars[,-6])
#' actuals <- mtcars[,6]
#' regressionModelMetrics(actuals = actuals,
#' predictions = predictions, model = mod)
regressionModelMetrics <- function(actuals, predictions, model) {
  x <- summary(model)
  aic <- round(AIC(model), digits = 2)
  bic <- round(BIC(model), digits = 2)
  r.squared <- x$r.squared
  adj.r.squared <- x$adj.r.squared

  mse <- mean((actuals - predictions)^2)
  mae <- mean(abs(actuals - predictions))
  rmse <- sqrt(mse)
  mape <- mean(abs(actuals - predictions) / abs(actuals))

  list(AIC = aic, BIC = bic, MAE = round(mae, digits = 2),
       MSE = round(mse, digits = 2), RMSE = round(rmse, digits = 2),
       MAPE = round(mape, digits = 2),
       Corelation = round(cor(predictions, actuals), digits = 2),
       r.squared = round(r.squared, digits = 2),
       adj.r.squared = round(adj.r.squared, digits = 2))
}
