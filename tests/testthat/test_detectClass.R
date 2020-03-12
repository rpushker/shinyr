test_that("Test DetectClass : Return value", {
  expect_true(detectClass(c("a","b"))=="character")
  expect_equal(detectClass(c(1,2,3)), "numeric")
  expect_equal(detectClass(iris$Species), "factor")
})
