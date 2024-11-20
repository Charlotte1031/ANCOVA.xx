#' Compare Models Using ANOVA
#'
#' @description Performs ANOVA to compare multiple linear regression models.
#' @param models A list of linear regression models created using \code{run_regression}.
#' @return A data frame containing the ANOVA comparison results, including F-values and p-values for each model.
#' @export
#' @examples
#' data(mtcars)
#' model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
#' model2 <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))
#' compare_anova(models = list(model1, model2))
#'

compare_anova <- function(models) {
  if (length(models) < 2) stop("At least two models must be provided for comparison.")

  # Extract residuals and compute the sums of squares
  results <- lapply(models, function(model) {
    residuals <- model$residuals
    fitted_values <- model$fitted_values
    ss_residual <- sum(residuals^2)
    ss_total <- sum((fitted_values + residuals - mean(fitted_values + residuals))^2)
    df_residual <- length(residuals) - length(model$coefficients)
    data.frame(
      SS_Residual = ss_residual,
      SS_Total = ss_total,
      DF_Residual = df_residual
    )
  })

  # Combine results into a data frame
  anova_table <- do.call(rbind, results)
  anova_table$Model <- paste0("Model_", seq_along(models))

  # Optionally, calculate F-statistics and p-values for comparison (for nested models)
  if (length(models) > 1) {
    for (i in 2:length(models)) {
      delta_ss <- anova_table$SS_Residual[i - 1] - anova_table$SS_Residual[i]
      delta_df <- anova_table$DF_Residual[i - 1] - anova_table$DF_Residual[i]
      F_value <- (delta_ss / delta_df) / (anova_table$SS_Residual[i] / anova_table$DF_Residual[i])
      p_value <- pf(F_value, delta_df, anova_table$DF_Residual[i], lower.tail = FALSE)
      anova_table$F_value[i] <- F_value
      anova_table$p_value[i] <- p_value
    }
  }

  rownames(anova_table) <- NULL
  anova_table
}
