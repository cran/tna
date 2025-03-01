## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 6,
  fig.height = 4,
  dev = "svg",
  fig.ext="svg",
  out.width = "100%",
  dpi = 60,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library("tna")
data("group_regulation", package = "tna")

## -----------------------------------------------------------------------------
tna_model <- tna(group_regulation)
print(tna_model)
plot(tna_model)

## ----warning = FALSE----------------------------------------------------------
cd <- communities(tna_model)
plot(cd, method = "leading_eigen")

## ----figures-side, fig.show="hold", fig.height=6, fig.width=8-----------------
layout(matrix(1:4, ncol = 2, byrow = T))
dyads <- cliques(tna_model, size = 2, threshold = 0.2)
triads <- cliques(tna_model, size = 3, threshold = 0.05)
plot(dyads, ask = F)
plot(triads, ask = F)

