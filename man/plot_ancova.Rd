% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ancova_plot_function.R
\name{plot_ancova}
\alias{plot_ancova}
\title{Visualize ANCOVA Results}
\usage{
plot_ancova(model, data, response, predictor, covariate)
}
\arguments{
\item{model}{A linear regression model created using \code{run_regression}.}

\item{data}{A data frame containing the variables used in the model.}

\item{response}{A string specifying the response variable.}

\item{predictor}{A string specifying the predictor variable.}

\item{covariate}{A string specifying the covariate to adjust for.}
}
\value{
A scatterplot with regression lines showing adjusted effects.
}
\description{
Creates a scatterplot showing the relationship between the response and predictor variables, with adjustments for covariates.
}
\examples{
data(mtcars)
model <- run_regression(mtcars, response = "mpg", predictors = c("wt", "hp"))
plot_ancova(model, data = mtcars, response = "mpg", predictor = "wt", covariate = "hp")

}
