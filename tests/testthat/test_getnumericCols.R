
test_that("test getnumericCols", {
  res <- getnumericCols(iris)
  expect_true(class(res) == "character")
  expect_equal(length(res), 4)
  expect_equal(res, names(iris)[1:4])
})

test_that("test getcharacterCols", {
  res <- getcharacterCols(iris)
  expect_true(class(res) == "character")
})

