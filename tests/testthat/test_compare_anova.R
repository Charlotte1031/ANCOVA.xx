library(testthat)

test_that("compare_anova compares models and returns a data frame", {
  data(mtcars)
  model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
  model2 <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

  results <- compare_anova(models = list(model1, model2))

  expect_s3_class(results, "data.frame")  # Output should be a data frame
  expect_true(all(c("Model", "F_value", "p_value") %in% names(results)))  # Check column names
})

test_that("compare_anova throws an error if fewer than two models are provided", {
  data(mtcars)
  model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))

  expect_error(compare_anova(models = list(model1)))  # Should throw an error
})
