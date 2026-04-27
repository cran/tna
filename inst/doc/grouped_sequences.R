## ----include = FALSE-------------------------------------------------------------
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
  library("tibble")
  library("dplyr")
  library("gt")
})

## ----eval = FALSE----------------------------------------------------------------
# library("tna")
# library("tibble")
# library("dplyr")
# library("gt")

## ----message = F-----------------------------------------------------------------
data("group_regulation_long", package = "tna")
prepared <- prepare_data(group_regulation_long,
                         actor = "Actor",
                         action = "Action",
                         time = "Time")

## ----fig.width=9, fig.height=4---------------------------------------------------
layout(t(1:2))
achievers <- group_tna(prepared, group = "Achiever")
plot(achievers)

## --------------------------------------------------------------------------------
plot_compare(achievers)

## --------------------------------------------------------------------------------
permutation_test_results <- permutation_test(achievers)
plot(permutation_test_results)

## --------------------------------------------------------------------------------
subsequence_comparison  <- compare_sequences(achievers,
                                                  sub = 3:5,
                                                  min_freq = 5,
                                                  correction = "fdr")
plot(subsequence_comparison, cells = TRUE)

## --------------------------------------------------------------------------------
clustering_results <- cluster_sequences(prepared, k = 3)

## --------------------------------------------------------------------------------
plot(
  2:8,
  sapply(2:8, \(k) cluster_sequences(prepared, k = k)$silhouette),
  type = "b",
  xlab = "Number of clusters (k)",
  ylab = "Silhouette",
  xaxt = "n"
)

## --------------------------------------------------------------------------------
tna_model_clus <- group_tna(prepared, group = clustering_results$assignments)

## ----fig.width=9, fig.height=9---------------------------------------------------
layout(matrix(1:4, byrow = T, ncol = 2))
plot(tna_model_clus)

## --------------------------------------------------------------------------------
summary(tna_model_clus) |>
  gt() |>
  fmt_number(decimals = 2)

## --------------------------------------------------------------------------------
mat <- sapply(
  tna_model_clus,
  \(x) setNames(x$inits, x$labels)
)

df <- data.frame(label = rownames(mat), mat, row.names = NULL)

gt(df, rowname_col = "label") |> fmt_percent(columns = -label)

## --------------------------------------------------------------------------------
transitions <- lapply(
  tna_model_clus,
  function(x) {
    x$weights |>
      data.frame() |>
      rownames_to_column("From\\To") |>
      gt() |>
      fmt_percent()
  }
)

transitions[[1]] |> tab_header(title = names(tna_model_clus)[1])
transitions[[2]] |> tab_header(title = names(tna_model_clus)[2])
transitions[[3]] |> tab_header(title = names(tna_model_clus)[3])

## --------------------------------------------------------------------------------
cluster_boot <- bootstrap(tna_model_clus)

## ----fig.width=9, fig.height=9, message = F--------------------------------------
layout(matrix(1:4, byrow = T, ncol = 2))
plot(cluster_boot)

## ----fig.width=9, fig.height=4---------------------------------------------------
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

## --------------------------------------------------------------------------------
subsequence_comparison  <- compare_sequences(tna_model_clus, sub = 3:5, min_freq = 5, correction = "fdr")
plot(subsequence_comparison, cells = TRUE)

