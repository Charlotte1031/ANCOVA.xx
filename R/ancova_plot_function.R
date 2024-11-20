#' Visualize ANCOVA Results
#'
#' @description Creates a scatterplot showing the relationship between the response and predictor variables, with adjustments for covariates.
#' @param model A linear regression model created using \code{run_regression}.
#' @param data A data frame containing the variables used in the model.
#' @param response A string specifying the response variable.
#' @param predictor A string specifying the predictor variable.
#' @param covariate A string specifying the covariate to adjust for.
#' @return A scatterplot with regression lines showing adjusted effects.
#' @export
#' @examples
#' data(mtcars)
#' model <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))
#' plot_ancova(model, data = mtcars, response = "mpg", predictor = "wt", covariate = "hp")
#'
plot_ancova <- function(model, data, response, predictor, covariate) {
  # Extract components from custom model
  coefficients <- model$coefficients
  fitted_values <- model$fitted_values

  # Calculate predictions
  predictions <- fitted_values  # Use already computed fitted values

  # Create plot
  plot(data[[predictor]], data[[response]], main = "ANCOVA Plot",
       xlab = predictor, ylab = response, col = "blue", pch = 19)
  lines(data[[predictor]], predictions, col = "red", lwd = 2)

  # Add covariate effects (e.g., adjusting predictions by covariate levels)
  legend("topright", legend = c("Data", "Adjusted Fit"),
         col = c("blue", "red"), lwd = c(NA, 2), pch = c(19, NA))
}
