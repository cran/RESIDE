## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----get_marginal_distributions-----------------------------------------------
#  library(RESIDE)
#  marginals <- get_marginal_distributions(IST)

## ----get_marginal_distributions_select----------------------------------------
#  library(RESIDE)
#  marginals <- get_marginal_distributions(
#    IST,
#    variables = c(
#      "SEX",
#      "AGE",
#      "ID14",
#      "RSBP",
#      "RATRIAL",
#      "SET14D",
#      "DSIDED"
#    )
#  )

## ----get_marginal_distributions_print-----------------------------------------
#  library(RESIDE)
#  marginals <- get_marginal_distributions(
#    IST,
#    print = TRUE
#  )

## ----marginal_distributions_print---------------------------------------------
#  library(RESIDE)
#  marginals <- get_marginal_distributions(IST)
#  print(marginals)

## ----export_marginal_distributions_folder_path--------------------------------
#  library(RESIDE)
#  marginals <- get_marginal_distributions(IST)
#  export_marginal_distributions(
#    marginals,
#    folder_path = "/Users/ryan/marginals"
#  )

## ----export_marginal_distributions_create_folder------------------------------
#  library(RESIDE)
#  marginals <- get_marginal_distributions(IST)
#  export_marginal_distributions(
#    marginals,
#    folder_path = "/Users/ryan/marginals",
#    create_folder = TRUE
#  )

