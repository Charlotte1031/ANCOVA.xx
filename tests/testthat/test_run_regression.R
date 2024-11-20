
test_that("run_regression handles missing predictors gracefully", {
  data(mtcars)
  expect_error(run_regression(mtcars, response = "mpg", predictors = c("missing_var")))
})

test_that("run_regression creates a correct output list", {
  data(mtcars)
  model <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

  # Check that the output is a list
  expect_type(model, "list")

  # Check that the output contains the expected components
  expect_named(model, c("coefficients", "fitted_values", "residuals", "r_squared"))

  # Check that coefficients are numeric
  expect_type(model$coefficients, "double")

  # Check R-squared is a single numeric value
  expect_length(model$r_squared, 1)
  expect_type(model$r_squared, "double")
})
