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

compare_ancova <- function(models, covariates, data) {

  if (length(models) < 2) stop("At least two models must be provided for comparison.")
  if (!is.character(covariates) || !all(covariates %in% names(data))) {
    stop("All covariates must be column names in the data.")
  }

  # Step 2: Run ANCOVA for Each Model
  results <- lapply(models, function(model) {
    aov(formula(model), data = data)  # Run ANCOVA using the model formula
  })

  comparison <- do.call(rbind, lapply(seq_along(results), function(i) {
    # ancova_table <- summary(results[[i]])[[1]] #coefficient
    #
    # ss_covariate <- ancova_table$'Sum Sq'[1]
    # df_covariate <- ancova_table$'Df'[1]
    #
    # ss_residual <- ancova_table$'Sum Sq'[2]
    # df_residual <- ancova_table$'Df'[2]
    # # Calculate F-value and p-value for the covariate
    # F_value <- (ss_covariate / df_covariate) / (ss_residual / df_residual)
    # p_value <- pf(F_value, df_covariate, df_residual, lower.tail = FALSE)
    #
    # data.frame(
    #   Model = paste0("Model_", i),
    #   Covariate = covariate,
    #   F_value = F_value,
    #   p_value = p_value
    # )


    ancova_table <- summary(results[[i]])[[1]]
    rownames(ancova_table) <- trimws(rownames(ancova_table))
    # Extract the sum of squares, degrees of freedom, F-value, and p-value for each covariate
    covariate_results <- lapply(covariates, function(covariate) {
      if (covariate %in% rownames(ancova_table)) {
        ss_covariate <- ancova_table$'Sum Sq'[which(rownames(ancova_table) == covariate)]
        df_covariate <- ancova_table$Df[which(rownames(ancova_table) == covariate)]

        ss_residual <- ancova_table$'Sum Sq'[which(rownames(ancova_table) == "Residuals")]
        df_residual <- ancova_table$Df[which(rownames(ancova_table) == "Residuals")]

        # Calculate F-value and p-value for the covariate
        F_value <- (ss_covariate / df_covariate) / (ss_residual / df_residual)
        p_value <- pf(F_value, df_covariate, df_residual, lower.tail = FALSE)

        # Return results for this covariate in this model
        data.frame(
          Model = paste0("Model_", i),
          Covariate = covariate,
          F_value = F_value,
          p_value = p_value
        )
      } else {
        # If the covariate is not in the model, return NA values
        data.frame(
          Model = paste0("Model_", i),
          Covariate = covariate,
          F_value = NA,
          p_value = NA
        )
      }
    })

    # Combine results for all covariates in this model
    do.call(rbind, covariate_results)

  }))

  rownames(comparison) <- NULL  # Remove row names for clarity
  comparison
}
