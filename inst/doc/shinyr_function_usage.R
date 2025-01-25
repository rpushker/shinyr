## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("shinyr")
# library(shinyr)

## ----eval = FALSE, warnings = FALSE-------------------------------------------
# library(shinyr)
# shinyr::shineMe()

## ----warning=FALSE, message=FALSE---------------------------------------------
library(shinyr)
dsets <- shinyr::valid_sets()
knitr::kable(dsets)

## ----warning=FALSE, message=FALSE---------------------------------------------
dsets$Item <- as.character(dsets$Item)
mtcars <- get(dsets$Item[dsets$Item == "mtcars"])
knitr::kable(head(mtcars))

## -----------------------------------------------------------------------------
getnumericCols(mtcars)

## ----warning=FALSE, echo=FALSE------------------------------------------------
splitAndGet("**shinyr** is developed to build dynamic shiny based dashboards to analyze the data of your choice.  It provides simple yet genius dashboard design to subset the data, perform exploratory analysis and predictive analysis by means of")

## ----warning=FALSE, echo=FALSE------------------------------------------------
x <- getFeqTable("shinyr is developed to build dynamic shiny based dashboards to analyze the data of your choice.  It provides simple yet genius dashboard design to subset the data, perform exploratory analysis and predictive analysis by means of")
knitr::kable(x)

## ----warning=FALSE------------------------------------------------------------
getWordCloud(x)

## ----echo=FALSE, warning=FALSE------------------------------------------------
res <- getDataInsight(mtcars)
knitr::kable(res$Types)

## -----------------------------------------------------------------------------
knitr::kable(res$cor_matrix)

## -----------------------------------------------------------------------------
corrplot::corrplot(as.matrix(res$cor_matrix),method = "number")

## -----------------------------------------------------------------------------
excludeThese(mtcars$mpg, c(21.0))

## -----------------------------------------------------------------------------
getMostRepeatedValue(c(1,1,1,2,2,3,4,5))

## -----------------------------------------------------------------------------
x <- head(mtcars)
x$mpg[1:2] <- NA

## -----------------------------------------------------------------------------
missing_count(x$mpg)

## -----------------------------------------------------------------------------
 imputeMyData(df = x, col = "mpg", FUN = "mean")

## -----------------------------------------------------------------------------
knitr::kable(groupByandSumarize(mtcars, grp_col = c("am"), summarise_col = "hp", FUN = "mean"))

## -----------------------------------------------------------------------------
partition <- dataPartition(mtcars, 85)

## -----------------------------------------------------------------------------
knitr::kable(head(partition$Train))

## -----------------------------------------------------------------------------
knitr::kable(head(partition$Test))

## -----------------------------------------------------------------------------
mod <- lm(formula = wt ~ ., data = mtcars)
mod

## -----------------------------------------------------------------------------
predictions <- predict(mod, mtcars[,-6])

## -----------------------------------------------------------------------------
 actials <- mtcars[,6]
 x <- regressionModelMetrics(actuals = actials, predictions = predictions, model = mod)
 y <- as.data.frame(x)
 row.names(y) <- NULL
 knitr::kable(y)

