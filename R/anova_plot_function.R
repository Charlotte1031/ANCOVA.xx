#' Plot ANOVA Results
#'
#' @description Plots data points and predicted values for ANOVA analysis.
#' @param model A linear model object.
#' @param data The original data frame used to fit the model.
#' @param response The response variable as a string.
#' @param predictor The predictor variable as a string.
#' @export
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ wt, data = mtcars)
#' plot_anova(model, data = mtcars, response = "mpg", predictor = "wt")

plot_anova <- function(model, data, response, predictor) {
  plot(data[[predictor]], data[[response]], main = "ANOVA Plot",
       xlab = predictor, ylab = response)
  abline(model, col = "red")
}
