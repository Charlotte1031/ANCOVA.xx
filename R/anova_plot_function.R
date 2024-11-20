#' Visualize ANOVA Results
#'
#' @description Creates a scatterplot of the response variable against a predictor, with a regression line based on ANOVA results.
#' @param model A linear regression model created using \code{run_regression}.
#' @param data A data frame containing the variables used in the model.
#' @param response A string specifying the response variable.
#' @param predictor A string specifying the predictor variable.
#' @return A scatterplot with a regression line.
#' @export
#' @examples
#' data(mtcars)
#' model <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
#' plot_anova(model, data = mtcars, response = "mpg", predictor = "wt")
#'
plot_anova <- function(model, data, response, predictor) {
  plot(data[[predictor]], data[[response]], main = "ANOVA Plot",
       xlab = predictor, ylab = response)
  abline(model, col = "red")
}
