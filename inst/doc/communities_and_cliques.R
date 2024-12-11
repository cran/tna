## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 10,
  fig.height = 6,
  out.width = "100%",
  dpi = 300,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library("tna")
data("engagement", package = "tna")

## -----------------------------------------------------------------------------
tna_model <- tna(engagement)
print(tna_model)
plot(tna_model)

## ----warning = FALSE----------------------------------------------------------
cd <- communities(tna_model)
plot(cd, method = "leading_eigen")

## ----figures-side, fig.show="hold", out.width="30%", fig.height=8, fig.width=4----
dyads <- cliques(tna_model, size = 2)
triads <- cliques(tna_model, size = 3)
plot(dyads)
plot(triads)

