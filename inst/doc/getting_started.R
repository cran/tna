## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 10,
  fig.height = 6,
  out.width = "100%",
  dpi = 300,
  comment = "#>"
)
suppressPackageStartupMessages({
  library("tna")
  library("tibble")
  library("dplyr")
  library("gt")
})

## ----eval = FALSE-------------------------------------------------------------
#  library("tna")
#  library("tibble")
#  library("dplyr")
#  library("gt")

## -----------------------------------------------------------------------------
data("engagement", package = "tna")

## -----------------------------------------------------------------------------
tna_model <- tna(engagement)

## -----------------------------------------------------------------------------
plot(tna_model)

## -----------------------------------------------------------------------------
data.frame(`Initial prob.` = tna_model$inits, check.names = FALSE) |>
  rownames_to_column("Engagement state") |>
  arrange(desc(`Initial prob.`)) |>
  gt() |>
  fmt_percent()

## -----------------------------------------------------------------------------
tna_model$weights |>
  data.frame() |>
  rownames_to_column("From\\To") |>
  gt() |>
  fmt_percent()

## -----------------------------------------------------------------------------
centrality_measures <- c("BetweennessRSP", "Closeness", "InStrength", "OutStrength")
cents_withoutloops <- centralities(
  tna_model,
  measures = centrality_measures,
  loops = FALSE,
  normalize = TRUE
)
plot(cents_withoutloops, ncol = 2, model = tna_model)

