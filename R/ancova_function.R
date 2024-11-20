#' Perform ANCOVA to Compare Models
#'
#' @description Performs ANCOVA to compare multiple linear regression models, evaluating the effect of covariates.
#' @param models A list of linear regression models created using \code{run_regression}.
#' @param covariates A vector of strings specifying the covariate variables to be tested.
#' @param data A data frame containing the variables used in the models.
#' @return A data frame summarizing ANCOVA results, including F-values and p-values for each covariate in the models.
#' @export
#' @examples
#' data(mtcars)
#' model1 <- run_regression(mtcars, response = "mpg", predictors = c("wt"))
#' model2 <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))
#' compare_ancova(models = list(model1, model2), covariates = c("wt", "hp"), data = mtcars)
compare_ancova <- function(models, covariates, data) {
  if (length(models) < 2) stop("At least two models must be provided for comparison.")
  if (!is.character(covariates) || !all(covariates %in% names(data))) {
    stop("All covariates must be column names in the data.")
  }

  comparison <- do.call(rbind, lapply(seq_along(models), function(i) {
    model <- models[[i]]
    ss_residual_full <- sum(model$residuals^2)
    df_residual_full <- length(model$residuals) - length(model$coefficients)

    covariate_results <- lapply(covariates, function(covariate) {
      if (covariate %in% names(model$coefficients)) {
        # Create a reduced model excluding the covariate
        reduced_predictors <- setdiff(names(model$coefficients)[-1], covariate)
        reduced_model <- run_regression(data, response = names(data)[1], predictors = reduced_predictors)
        ss_residual_reduced <- sum(reduced_model$residuals^2)

        # Calculate SS_Covariate
        ss_covariate <- ss_residual_reduced - ss_residual_full

        # Calculate F-value and p-value
        df_covariate <- 1
        F_value <- (ss_covariate / df_covariate) / (ss_residual_full / df_residual_full)
        p_value <- pf(F_value, df_covariate, df_residual_full, lower.tail = FALSE)

        data.frame(
          Model = paste0("Model_", i),
          Covariate = covariate,
          SS_Covariate = ss_covariate,
          F_value = F_value,
          p_value = p_value
        )
      } else {
        data.frame(
          Model = paste0("Model_", i),
          Covariate = covariate,
          SS_Covariate = NA,
          F_value = NA,
          p_value = NA
        )
      }
    })

    do.call(rbind, covariate_results)
  }))

  rownames(comparison) <- NULL
  comparison
}
