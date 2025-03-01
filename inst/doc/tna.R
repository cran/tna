## ----include = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 6,
  fig.height = 4,
  dev = "svg",
  fig.ext = "svg",
  dpi = 50,
  out.width = "100%",
  dpi = 100,
  comment = "#>"
)
suppressPackageStartupMessages({
  library("tna")
  library("tibble")
  library("dplyr")
  library("gt")
})

## ----eval = FALSE----------------------------------------------------------------
# library("tna")
# library("tibble")
# library("dplyr")
# library("gt")

## --------------------------------------------------------------------------------
data("group_regulation", package = "tna")

## --------------------------------------------------------------------------------
tna_model <- tna(group_regulation)

## ----fig.width=5, fig.height=5---------------------------------------------------
plot(tna_model, cut = 0.2, minimum = 0.05, 
     edge.label.position= 0.8, edge.label.cex = 0.7)

## --------------------------------------------------------------------------------
data.frame(`Initial prob.` = tna_model$inits, check.names = FALSE) |>
  rownames_to_column("Action") |>
  arrange(desc(`Initial prob.`)) |>
  gt() |>
  fmt_percent()

## --------------------------------------------------------------------------------
tna_model$weights |>
  data.frame() |>
  rownames_to_column("From\\To") |>
  gt() |>
  fmt_percent()

## --------------------------------------------------------------------------------
centrality_measures <- c("BetweennessRSP", "Closeness", "InStrength", "OutStrength")
cents_withoutloops <- centralities(
  tna_model,
  measures = centrality_measures,
  loops = FALSE,
  normalize = TRUE
)
plot(cents_withoutloops, ncol = 2, model = tna_model)

