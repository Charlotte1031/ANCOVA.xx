
# Statistical Analysis Functions and Demo

This repository contains a suite of R functions designed to perform essential statistical analyses, including ANOVA, ANCOVA, and regression analyses, along with accompanying visualization functions. A detailed demo vignette is also provided to illustrate the application of these functions in various scenarios.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Functions](#functions)
  - [ANOVA Functions](#anova-functions)
  - [ANCOVA Functions](#ancova-functions)
  - [Regression Functions](#regression-functions)
- [Demo](#demo)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

The repository offers statistical analysis functions with plotting capabilities for each model type. The available functions allow users to perform and visualize:
- Analysis of Variance (ANOVA)
- Analysis of Covariance (ANCOVA)
- Simple and multiple linear regression analyses

Each function includes a plotting feature to facilitate the visualization of results, aiding in the interpretation of statistical findings.

## Installation

1. Clone the repository:
   ```bash
   https://github.com/Charlotte1031/ANCOVA.git
   ```
2.	Load the functions in your R environment:

  ```bash
  source("path/to/ancova_function.R")
  source("path/to/ancova_plot_function.R")
  source("path/to/anova_function.R")
  source("path/to/anova_plot_function.R")
  source("path/to/regression_function.R")
  ```


## Functions

### ANOVA Functions

- anova_function.R: Performs ANOVA analysis on a given dataset, testing for significant differences across group means.
- anova_plot_function.R: Visualizes the ANOVA results with options for displaying mean differences and confidence intervals across groups.

### ANCOVA Functions

- ancova_function.R: Executes an ANCOVA analysis, adjusting for covariates while comparing group means.
- ancova_plot_function.R: Provides a plot of ANCOVA results, illustrating adjusted group means and highlighting covariate effects.

### Regression Functions

- regression_function.R: Conducts linear regression analysis, supporting both simple and multiple regression models. It outputs model coefficients, residuals, and other relevant statistics.

## Demo

The repository includes a vignette file Demo.Rmd to walk users through:

1.	Loading datasets.
2.	Executing each of the statistical functions.
3.	Generating and interpreting visualizations.

Run the vignette file in R to follow along with the examples, which highlight real-world applications and provide practical insights.

## Testing

This package includes tests to validate the correctness of all functions. Comparisons are made against results from R’s built-in functions (e.g., aov(), lm()) using all.equal() for accuracy and bench::mark() for efficiency. Detailed test results and vignettes are available within the package.

### Example usage:

```r
# ANOVA example
result_anova <- anova_function(data)
anova_plot_function(result_anova)

# ANCOVA example
result_ancova <- ancova_function(data, covariate)
ancova_plot_function(result_ancova)

# Regression example
result_reg <- regression_function(data)
```

#### Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have any improvements or bug fixes.

	1.	Fork the repository.
	2.	Create pull requests for new features or bug fixes.
	3.	Submit feedback or feature requests via GitHub issues.

#### License

This project is licensed under the MIT License. See the LICENSE file for more details.

