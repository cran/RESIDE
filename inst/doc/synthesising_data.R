## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----synthesise data----------------------------------------------------------
# library(RESIDE)
# marginals <- import_marginal_distributions()
# simulated_data <- synthesise_data(marginals)

## ----synthesise_data_with_correlations----------------------------------------
# library(RESIDE)
# marginals <- import_marginal_distributions()
# simulated_data <- synthesise_data(
#   marginals,
#   correlations = list(
#     correlation("AGE", "RSBP", 0.3)
#   )
# )

## ----categorical_correlations-------------------------------------------------
# simulated_data <- synthesise_data(
#   marginals,
#   correlations = list(
#     correlation("SEX", "AGE", -0.2, factor_name.x = "M"),
#     correlation("RATRIAL", "RSBP", 0.1, factor_name.x = "Y")
#   )
# )

## ----multi_table_correlations-------------------------------------------------
# simulated_data <- synthesise_data(
#   marginals,
#   correlations = list(
#     # Both variables in the same data frame
#     correlation("DOMAIN", "AESTDY", 0.2, df_name = "ae", factor_name.x = "AE"),
#     # Variables in different data frames
#     correlation(
#       "SEX",
#       "AESEV",
#       0.3,
#       df_name.x = "dm",
#       df_name.y = "ae",
#       factor_name.x = "M",
#       factor_name.y = "SEVERE"
#     )
#   )
# )

