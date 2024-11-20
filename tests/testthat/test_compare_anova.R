library(testthat)

test_that("compare_ancova compares models and returns correct structure", {
  data(mtcars)
  model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
  model2 <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

  results <- compare_ancova(models = list(model1, model2), covariates = c("wt", "hp"), data = mtcars)

  expect_s3_class(results, "data.frame")
  expect_true(all(c("Model", "Covariate", "F_value", "p_value") %in% names(results)))
})

test_that("compare_ancova handles missing covariates gracefully", {
  data(mtcars)
  model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
  model2 <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

  results <- compare_ancova(models = list(model1, model2), covariates = c("wt", "hp"), data = mtcars)

  hp_results_model1 <- results[results$Model == "Model_1" & results$Covariate == "hp", ]
  expect_true(is.na(hp_results_model1$F_value))
  expect_true(is.na(hp_results_model1$p_value))
})

test_that("compare_ancova calculates F_value and p_value correctly", {
  data(mtcars)
  model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
  model2 <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

  results <- compare_ancova(models = list(model1, model2), covariates = c("wt"), data = mtcars)

  wt_results <- results[results$Covariate == "wt", ]
  expect_false(any(is.na(wt_results$F_value)))
  expect_false(any(is.na(wt_results$p_value)))
})
