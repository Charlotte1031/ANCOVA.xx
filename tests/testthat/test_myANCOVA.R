### 5. Testing (`tests/testthat/test_ancova_function.R`)

library(testthat)

test_that("compare_ancova returns a data frame", {
  data(mtcars)
  model1 <- lm(mpg ~ wt + hp, data = mtcars)
  model2 <- lm(mpg ~ wt + hp + cyl, data = mtcars)

  result <- compare_ancova(models = list(model1, model2), covariate = "hp", data = mtcars)
  expect_s3_class(result, "data.frame")
})
