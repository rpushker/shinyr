res <- confmatrix(c(1,1,1,0), c(1,1,0,0))

test_that("Test confMtrix dimention!", {
  # res <- confmatrix(c(1,1,1,0), c(1,1,0,0))
  expect_equal(dim(res$table), c(2,2))
})


test_that("Test confMtrix right value?", {
  # res <- confmatrix(c(1,1,1,0), c(1,1,0,0))
  expect_true(res$table[4] == 2)
})

test_that("Test confMtrix class", {
  # res <- confmatrix(c(1,1,1,0), c(1,1,0,0))
  expect_equal(class(res), "confusionMatrix")
})
