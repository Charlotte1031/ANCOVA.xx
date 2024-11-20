test_that("compare_ancova returns correct structure and numeric results", {
  data(mtcars)

  # Fit models
  model1 <- lm(mpg ~ wt, data = mtcars)
  model2 <- lm(mpg ~ wt + hp, data = mtcars)

  # Run ANCOVA
  results <- compare_ancova(models = list(model1, model2), covariates = c("wt", "hp"), data = mtcars)

  # Verify structure
  expect_s3_class(results, "data.frame")  # Output should be a data frame
  expect_true(all(c("Model", "Covariate", "SS_Covariate", "F_value", "p_value") %in% names(results)))

  # Check specific values
  expect_true(nrow(results) == 4)  # Two models, two covariates
  expect_true(all(results$F_value[!is.na(results$F_value)] > 0))  # F-values should be positive
  expect_true(all(results$p_value[!is.na(results$p_value)] < 1))  # p-values should be valid
})
test_that("compare_ancova returns expected F_value and p_value for nested models", {
  data(mtcars)

  # Fit models
  model1 <- lm(mpg ~ wt, data = mtcars)
  model2 <- lm(mpg ~ wt + hp, data = mtcars)

  # Run ANCOVA
  results <- compare_ancova(models = list(model1, model2), covariates = c("wt", "hp"), data = mtcars)

  # Debugging output to check results
  print(results)

  # Check specific F_value and p_value for hp in Model 2
  expect_true(results$F_value[3] > 0)  # F_value for hp in Model 2
  expect_true(results$p_value[3] < 0.05)  # p_value for hp in Model 2
})
