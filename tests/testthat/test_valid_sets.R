test_that("testing valid_sets: class of return type", {
  res <- valid_sets()
  testthat::expect_true("data.frame" == class(res))
})

test_that("testing valid_sets: column names", {
  res <- valid_sets()
  testthat::expect_equal(names(res), c("Package", "LibPath", "Item", "Title"))
})


