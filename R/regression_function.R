#' Run Linear Regression
#'
#' @description Runs a linear regression on the input dataset with specified predictor and response variables.
#' @param data A data frame containing the variables in the model.
#' @param response A string specifying the response variable.
#' @param predictors A vector of strings specifying the predictor variables.
#' @return A linear model object.
#' @export
#' @examples
#' data(mtcars)
#' run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))

run_regression <- function(data, response, predictors) {
  formula <- as.formula(paste(response, "~", paste(predictors, collapse = " + ")))
  lm(formula, data = data)
}
