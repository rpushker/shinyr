res <- getLibraryReport(c('dplyr', 'data.table'))

testthat::test_that("Test getLibraryReport: Shape of report", {
  expect_true(length(res) == 2)
  expect_true(nrow(res) == 2)
  expect_equal(names(res), c("Package", "Status"))
})

testthat::test_that("Test getLibraryReport: Class of report", {
  expect_equal(class(res), 'data.frame')
})
