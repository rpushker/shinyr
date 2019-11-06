context("groupByandSumarize success test")
test_that("Group_by_and_Summarize test", {
  data("mtcars")
  res <- groupByandSumarize(mtcars, grp_col = "vs", summarise_col = "hp", FUN = "mean")
  expect_true(is.data.frame(res))
  expect_true(unique(unique(res$vs) == c(0,1)))

})





