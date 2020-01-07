test_that("testing valid_sets", {
  res <- valid_sets()
  testthat::expect_true("data.frame" == class(res))
})


