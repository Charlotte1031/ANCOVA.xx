#' ANCOVA Function for Multiple Model Comparison
#'
#' @description This function performs ANCOVA to compare multiple linear models
#' on the same dataset, including covariates.
#' @param formula A formula describing the model to be fitted.
#' @param data A data frame containing the variables in the model.
#' @param covariate A string specifying the covariate variable.
#' @param models A list of linear models to be compared.
#' @return A summary table of ANCOVA results comparing the models.
#' @export
#' @examples
#' data(mtcars)
#' model1 <- lm(mpg ~ wt + hp, data = mtcars)
#' model2 <- lm(mpg ~ wt + hp + cyl, data = mtcars)
#' compare_ancova(models = list(model1, model2), covariate = "hp", data = mtcars)

compare_ancova <- function(models, covariate, data) {
  # Check inputs
  if (length(models) < 2) stop("At least two models must be provided for comparison.")
  if (!is.character(covariate) || !(covariate %in% names(data))) {
    stop("Covariate must be a column name in the data.")
  }

  # Prepare comparison
  results <- lapply(models, function(model) {
    # Fit the ANCOVA model
    aov_model <- aov(model)
    summary(aov_model)
  })

  # Extract and summarize comparison
  comparison <- do.call(rbind, lapply(results, function(res) {
    summary_table <- summary(res)[[1]]
    data.frame(F_value = summary_table["Pr(>F)", covariate], p_value = summary_table["Pr(>F)"])
  }))

  rownames(comparison) <- paste0("Model_", seq_along(models))
  comparison
}
