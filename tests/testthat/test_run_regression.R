library(testthat)

test_that("run_regression creates a linear model", {
  data(mtcars)
  model <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

  expect_s3_class(model, "lm")  # Check if the output is a linear model object
  expect_named(coefficients(model), c("(Intercept)", "wt", "hp"))  # Check if model has correct terms
})

test_that("run_regression handles missing predictors gracefully", {
  data(mtcars)
  expect_error(run_regression(mtcars, response = "mpg", predictors = c("missing_var")))
})
