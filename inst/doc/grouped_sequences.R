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
  library("seqHMM")
})

## ----eval = FALSE----------------------------------------------------------------
# library("tna")
# library("tibble")
# library("dplyr")
# library("gt")
# library("seqHMM")
# data("engagement", package = "tna")

## ----eval = FALSE----------------------------------------------------------------
# set.seed(265)
# tna_model <- tna(engagement)
# n_var <- length(tna_model$labels)
# n_clusters <- 3
# trans_probs <- simulate_transition_probs(n_var, n_clusters)
# init_probs <- list(
#   c(0.70, 0.20, 0.10),
#   c(0.15, 0.70, 0.15),
#   c(0.10, 0.20, 0.70)
# )

## ----eval = FALSE----------------------------------------------------------------
# mmm <- build_mmm(
#   engagement,
#   transition_probs = trans_probs,
#   initial_probs = init_probs
# )
# fit_mmm <- fit_model(
#   modelTrans,
#   global_step = TRUE,
#   control_global = list(algorithm = "NLOPT_GD_STOGO_RAND"),
#   local_step = TRUE,
#   threads = 60,
#   control_em = list(restart = list(times = 100, n_optimum = 101))
# )

## ----eval = TRUE, echo = FALSE---------------------------------------------------
tna_model_clus <- group_model(engagement_mmm)

## ----eval = FALSE----------------------------------------------------------------
# tna_model_clus <- group_model(fit_mmm$model)

## --------------------------------------------------------------------------------
summary(tna_model_clus) |>
  gt() |>
  fmt_number(decimals = 2)

## --------------------------------------------------------------------------------
bind_rows(lapply(tna_model_clus, \(x) x$inits), .id = "Cluster") |>
  gt() |>
  fmt_percent()

## --------------------------------------------------------------------------------
transitions <- lapply(
  tna_model_clus,
  function(x) {
    x$weights |>
      data.frame() |>
      rownames_to_column("From\\To") |>
      gt() |>
      tab_header(title = names(tna_model_clus)[1]) |>
      fmt_percent()
  }
)
transitions[[1]]
transitions[[2]]
transitions[[3]]

## ----fig.width=6, fig.height=2---------------------------------------------------
layout(t(1:3))
plot(tna_model_clus, vsize = 20, edge.label.cex = 2)

## --------------------------------------------------------------------------------
pruned_clus <- prune(tna_model_clus, threshold = 0.1)

## ----fig.width=6, fig.height=2, message = FALSE----------------------------------
layout(t(1:3))
plot(pruned_clus, vsize = 20, edge.label.cex = 2)

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

