## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 6,
  fig.height = 4,
  out.width = "100%",
  dev = "jpeg",
  dpi = 100,
  comment = "#>"
)
suppressPackageStartupMessages({
  library("tna")
  library("gt")
})

## ----eval = FALSE-------------------------------------------------------------
# library("tna")
# library("gt")

## ----message = FALSE----------------------------------------------------------
data("group_regulation_long", package = "tna")
prepared <- prepare_data(group_regulation_long,
                         actor = "Actor",
                         action = "Action",
                         time = "Time")

## ----fig.width=9, fig.height=4------------------------------------------------
layout(t(1:2))
achievers <- group_tna(prepared, group = "Achiever")
plot(achievers)

## -----------------------------------------------------------------------------
plot_compare(achievers)

## -----------------------------------------------------------------------------
permutation_test_results <- permutation_test(achievers)
plot(permutation_test_results)

## -----------------------------------------------------------------------------
subsequence_comparison  <- compare_sequences(achievers,
                                                  sub = 3:5,
                                                  min_freq = 5,
                                                  adjust = "fdr")
plot(subsequence_comparison, cells = TRUE)

## -----------------------------------------------------------------------------
clustering_results <- cluster_sequences(prepared, k = 3)

## -----------------------------------------------------------------------------
lapply(2:4, \(k) cluster_sequences(prepared, k = k))

## -----------------------------------------------------------------------------
tna_model_clus <- group_tna(clustering_results)

## ----fig.width=9, fig.height=9------------------------------------------------
layout(matrix(1:4, byrow = TRUE, ncol = 2))
plot(tna_model_clus)

## -----------------------------------------------------------------------------
summary(tna_model_clus) |>
  gt() |>
  fmt_number(decimals = 2)

## -----------------------------------------------------------------------------
print(tna_model_clus, digits = 2)

## -----------------------------------------------------------------------------
cluster_boot <- bootstrap(tna_model_clus)

## ----fig.width=9, fig.height=9, message = FALSE-------------------------------
layout(matrix(1:4, byrow = TRUE, ncol = 2))
plot(cluster_boot)

## ----fig.width=9, fig.height=4------------------------------------------------
centrality_measures <- c(
  "BetweennessRSP",
  "Closeness",
  "InStrength",
  "OutStrength"
)
centralities_per_cluster <- centralities(
  tna_model_clus,
  measures = centrality_measures
)
plot(
  centralities_per_cluster, ncol = 4,
  colors = c("purple", "orange", "pink")
)

## -----------------------------------------------------------------------------
subsequence_comparison  <- compare_sequences(tna_model_clus, sub = 3:5, min_freq = 5, adjust = "fdr")
plot(subsequence_comparison, cells = TRUE)

