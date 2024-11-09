#' Plot ANCOVA Results
#'
#' @description Plots ANCOVA results, showing data points and predicted values adjusted for the covariate.
#' @param model A linear model object.
#' @param data The original data frame used to fit the model.
#' @param response The response variable as a string.
#' @param predictor The predictor variable as a string.
#' @param covariate The covariate variable as a string.
#' @export
#' @examples
#' data(mtcars)
#' model <- lm(mpg ~ wt + hp, data = mtcars)
#' plot_ancova(model, data = mtcars, response = "mpg", predictor = "wt", covariate = "hp")

plot_ancova <- function(model, data, response, predictor, covariate) {
  plot(data[[predictor]], data[[response]], main = "ANCOVA Plot",
       xlab = predictor, ylab = response)
  adjusted <- predict(model, newdata = data)
  lines(data[[predictor]], adjusted, col = "blue")
}

# TODO
