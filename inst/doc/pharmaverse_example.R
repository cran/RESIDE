## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  # pharmaversesdtm is suggested, only evaluate if it is installed
  eval = requireNamespace("pharmaversesdtm", quietly = TRUE)
)

## ----load-library, message = FALSE--------------------------------------------
# Load the Library
library(RESIDE)
# Load dplyr for data manipulation
library(dplyr)
# Set the seed
set.seed(1234)
# Store the folder path used for import / export
folder_path <- tempdir()

## ----original-data------------------------------------------------------------
# Store the tables in a named list
dfs <- list(
  dm = pharmaversesdtm::dm,
  ae = pharmaversesdtm::ae
)

# Number of rows in each table
sapply(dfs, nrow)

# Number of subjects in each table
sapply(dfs, function(df) length(unique(df$USUBJID)))

# Treatment arms of the subjects
table(dfs$dm$ARM)

# Severity of the adverse events
table(dfs$ae$AESEV)

## ----original-model-----------------------------------------------------------
# Join the adverse events to the demographics of each subject
prepare_ae_data <- function(dm, ae) {
  ae |>
    select(USUBJID, AESEV) |>
    inner_join(select(dm, USUBJID, AGE, SEX, ARM), by = "USUBJID") |>
    # Remove screen failures and adverse events without a severity
    filter(ARM != "Screen Failure", AESEV != "") |>
    mutate(
      MOD_SEV = AESEV %in% c("MODERATE", "SEVERE"),
      ARM = relevel(factor(ARM), "Placebo")
    )
}

ae_original <- prepare_ae_data(dfs$dm, dfs$ae)

# Proportion of moderate or severe adverse events by treatment arm
prop.table(table(ae_original$ARM, ae_original$MOD_SEV), 1)

# Fit a logistic regression model
glm.original <- glm(
  MOD_SEV ~ AGE + SEX + ARM,
  data = ae_original,
  family = binomial
)

# Output the coefficients of the model
summary(glm.original)$coefficients

## ----get-marginals------------------------------------------------------------
# Get the Marginal Distributions of both tables
marginals <- get_marginal_distributions(
  dfs,
  subject_identifier = "USUBJID"
)

# Summarise the Marginal Distributions
summary(marginals)

## ----export-marginals---------------------------------------------------------
# Export the Marginal Distributions
export_marginal_distributions(marginals,
                              folder_path = folder_path,
                              force = TRUE)

## ----import-marginals---------------------------------------------------------
# Import the Marginal Distributions
imported_marginals <- import_marginal_distributions(folder_path = folder_path)

## ----synthesis-data-----------------------------------------------------------
# Synthesise the tables from the imported Marginal Distributions (without correlations)
sim_dfs <- synthesise_data(imported_marginals)

# Number of rows in each table
sapply(sim_dfs, nrow)

# Number of subjects in each table
sapply(sim_dfs, function(df) length(unique(df$USUBJID)))

## ----sim-data-model-----------------------------------------------------------
ae_sim <- prepare_ae_data(sim_dfs$dm, sim_dfs$ae)

# Proportion of moderate or severe adverse events by treatment arm
prop.table(table(ae_sim$ARM, ae_sim$MOD_SEV), 1)

# Fit a logistic regression model on the synthesised data
glm.sim <- glm(
  MOD_SEV ~ AGE + SEX + ARM,
  data = ae_sim,
  family = binomial
)

# Output the coefficients of the model
summary(glm.sim)$coefficients

## ----synthesis-data-cor-------------------------------------------------------
# Synthesise the tables specifying assumed correlations
sim_dfs_cor <- synthesise_data(
  imported_marginals,
  correlations = list(
    # Subjects on placebo are more likely to have mild adverse events
    correlation(
      "ARM",
      "AESEV",
      0.2,
      df_name.x = "dm",
      df_name.y = "ae",
      factor_name.x = "Placebo",
      factor_name.y = "MILD"
    ),
    # Male subjects are younger
    correlation("AGE", "SEX", -0.2, factor_name.y = "M")
  )
)

## ----sim-data-model-cor-------------------------------------------------------
ae_sim_cor <- prepare_ae_data(sim_dfs_cor$dm, sim_dfs_cor$ae)

# Proportion of moderate or severe adverse events by treatment arm
prop.table(table(ae_sim_cor$ARM, ae_sim_cor$MOD_SEV), 1)

# Fit a logistic regression model on the synthesised data (with correlations)
glm.sim.cor <- glm(
  MOD_SEV ~ AGE + SEX + ARM,
  data = ae_sim_cor,
  family = binomial
)

# Output the coefficients of the model
summary(glm.sim.cor)$coefficients

