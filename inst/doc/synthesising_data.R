## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----synthesise data----------------------------------------------------------
#  library(RESIDE)
#  marginals <- import_marginal_distributions()
#  simulated_data <- synthesise_data(marginals)

## ----export_cor_matrix--------------------------------------------------------
#  library(RESIDE)
#  marginals <- import_marginal_distributions()
#  export_empty_cor_matrix(marginals, folder_path = tempdir())

## ----print_cor_matrix, eval = TRUE, echo = FALSE------------------------------
.cor_matrix <- utils::read.csv("correlation_matrix.csv")
.cor_matrix <- tibble::column_to_rownames(.cor_matrix, names(.cor_matrix)[1])
DT::datatable(
  .cor_matrix,
  options = list(
    pageLength=10, scrollX='400px'
  )
)

## ----import_cor_matrix--------------------------------------------------------
#  library(RESIDE)
#  correlation_matrix <- import_cor_matrix()

## ----synthesise_data_with_correlations----------------------------------------
#  library(RESIDE)
#  marginals <- import_marginal_distributions()
#  export_empty_cor_matrix(marginals)
#  correlation_matrix <- import_cor_matrix()
#  simulated_data <- synthesise_data(
#    marginals,
#    correlation_matrix
#  )

