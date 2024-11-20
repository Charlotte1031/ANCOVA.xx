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
  y <- as.matrix(data[[response]])  # Response variable (as a column vector)
  X <- as.matrix(cbind(Intercept = 1, data[predictors]))  # Predictor matrix with intercept

  # QR decomposition
  qr_decomp <- qr(X)  # Perform QR decomposition
  Q <- qr.Q(qr_decomp)  # Extract Q matrix
  R <- qr.R(qr_decomp)  # Extract R matrix

  # Solve for coefficients using back substitution
  beta <- backsolve(R, crossprod(Q, y))  # Coefficients
  names(beta) <- c("(Intercept)", predictors)  # Assign variable names to coefficients

  # Calculate fitted values and residuals
  fitted_values <- as.vector(X %*% beta)
  residuals <- as.vector(y - fitted_values)

  # Calculate R-squared
  ss_total <- sum((y - mean(y))^2)  # Total sum of squares
  ss_residual <- sum(residuals^2)  # Residual sum of squares
  r_squared <- 1 - (ss_residual / ss_total)

  # Return results as a list similar to lm
  list(
    coefficients = beta,
    fitted_values = fitted_values,
    residuals = residuals,
    r_squared = r_squared
  )
}

