test_that("test splitAndGet", {
  
  x <- splitAndGet("R programming is awesome!")
  expect_equal(length(x), 1)
  expect_true(is.list(x))
  expect_equal(length(x[[1]]), 4)
  y <- x[[1]][4]
  expect_true(y == "awesome!")
  
})
