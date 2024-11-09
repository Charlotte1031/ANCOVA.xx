#' ANOVA Function for Multiple Model Comparison
#'
#' @description This function performs ANOVA to compare multiple linear models
#' on the same dataset.
#' @param models A list of linear models to be compared.
#' @return A summary table of ANOVA results comparing the models.
#' @export
#' @examples
#' data(mtcars)
#' model1 <- lm(mpg ~ wt, data = mtcars)
#' model2 <- lm(mpg ~ wt + hp, data = mtcars)
#' compare_anova(models = list(model1, model2))

compare_anova <- function(models) {
  # Check inputs
  if (length(models) < 2) stop("At least two models must be provided for comparison.")

  # Run ANOVA for each model and extract results
  results <- lapply(models, anova)

  # Prepare a summary table for comparison
  comparison <- do.call(rbind, lapply(seq_along(results), function(i) {
    anova_table <- results[[i]]
    # Extract F value and p value from the ANOVA table
    data.frame(
      Model = paste0("Model_", i),
      F_value = anova_table$'F value'[1],
      p_value = anova_table$'Pr(>F)'[1]
    )
  }))

  rownames(comparison) <- NULL  # Remove row names for clarity
  comparison
}
