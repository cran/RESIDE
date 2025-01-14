% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print.RESIDE.R
\name{print.RESIDE}
\alias{print.RESIDE}
\title{print.RESIDE}
\usage{
\method{print}{RESIDE}(x, ...)
}
\arguments{
\item{x}{an object of class RESIDE}

\item{...}{Other parameters currently none are used}
}
\value{
No return value, called to print to the terminal.
}
\description{
S3 override for print RESIDE
}
\details{
S3 Override for RESIDE Class
}
\examples{
print(
  marginal_distributions <- get_marginal_distributions(
    IST,
    variables <- c(
      "SEX",
      "AGE",
      "ID14",
      "RSBP",
      "RATRIAL"
    )
  )
)
}
