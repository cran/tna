## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 6,
  fig.height = 4,
  dev = "jpeg",
  dpi = 100,
  out.width = "100%",
  comment = "#>"
)
suppressPackageStartupMessages({
  library("tna")
})

## ----eval = FALSE-------------------------------------------------------------
# library("tna")

## -----------------------------------------------------------------------------
data("group_regulation", package = "tna")

## -----------------------------------------------------------------------------
tna_model <- tna(group_regulation)

## ----fig.width=5, fig.height=5------------------------------------------------
plot(tna_model)

## -----------------------------------------------------------------------------
print(tna_model, digits = 2)

## -----------------------------------------------------------------------------
summary(tna_model)

## -----------------------------------------------------------------------------
centrality_measures <- c("BetweennessRSP", "Closeness", "InStrength", "OutStrength")
cents_withoutloops <- centralities(
  tna_model,
  measures = centrality_measures,
  loops = FALSE,
  normalize = TRUE
)
plot(cents_withoutloops, ncol = 2)

