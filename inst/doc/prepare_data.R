## ----include = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  fig.width = 6,
  fig.height = 4,
  out.width = "100%",
  message = FALSE,
  fig.show = TRUE,
  dev = "jpeg",
  dpi = 100,
  results = "hide",  
  comment = "#>"
)
suppressPackageStartupMessages({
  library("tna")
  library("tibble")
  library("dplyr")
})

## --------------------------------------------------------------------------------
df <- tribble(
  ~user, ~timestamp, ~event, ~achievement, ~order,
  2, "2025-02-27 18:01:32", "Plan",           "High", 1,
  2, "2025-02-27 18:03:32", "Goals",          "High", 2,
  1, "2025-02-27 18:08:32", "Goals",          "High", 1,
  3, "2025-02-27 18:15:32", "Plan",           "High", 1,
  5, "2025-02-27 18:16:32", "Help",           "Low",  1,
  3, "2025-02-27 18:19:32", "Goals",          "High", 2,
  5, "2025-02-27 18:19:32", "Plan",           "Low",  2,
  2, "2025-02-27 18:20:32", "Environment",    "High", 3,
  1, "2025-02-27 18:25:32", "Task",           "High", 2,
  4, "2025-02-27 18:25:32", "Help",           "Low",  1,
  5, "2025-02-27 18:26:32", "Task",           "Low",  3,
  3, "2025-02-27 18:32:32", "Metacognition",  "High", 3,
  4, "2025-02-27 18:33:32", "Goals",          "Low",  2,
  1, "2025-02-27 18:36:32", "Environment",    "High", 3,
  1, "2025-02-27 18:44:32", "Task",           "High", 4,
  1, "2025-02-27 18:45:32", "Task",           "High", 5,
  5, "2025-02-27 18:46:32", "Help",           "Low",  4,
  1, "2025-02-27 19:01:32", "Plan",           "High", 6,
  2, "2025-02-27 19:06:32", "Environment",    "High", 4,
  4, "2025-02-27 19:06:32", "Plan",           "Low",  3,
  1, "2025-02-27 19:13:32", "Metacognition",  "High", 7,
  3, "2025-02-27 19:13:32", "Metacognition",  "High", 4,
  4, "2025-02-27 19:15:32", "Goals",          "Low",  4,
  4, "2025-02-27 19:20:32", "Metacognition",  "Low",  5,
  4, "2025-02-27 19:20:32", "Environment",    "Low",  6,
  5, "2025-02-27 19:23:32", "Metacognition",  "Low",  5,
  3, "2025-02-27 19:25:32", "Help",           "High", 5,
  2, "2025-02-27 19:27:32", "Metacognition",  "High", 5,
  2, "2025-02-27 19:33:32", "Environment",    "High", 6,
  4, "2025-02-27 19:46:32", "Environment",    "Low",  7,
  5, "2025-02-27 19:49:32", "Plan",           "Low",  6,
  2, "2025-02-27 19:55:32", "Goals",          "High", 7
)


## --------------------------------------------------------------------------------
by_classroom <- prepare_data(df, action = "event")
tna_by_classroom <- tna(by_classroom)
plot(tna_by_classroom)

## --------------------------------------------------------------------------------
by_user <- prepare_data(df, actor = "user", action = "event", order = "order")
tna_by_user <- tna(by_user)
plot(tna_by_user)

## --------------------------------------------------------------------------------
by_session <- prepare_data(df, actor = "user", time = "timestamp", action = "event")
tna_by_session <- tna(by_session)
plot(tna_by_session)

## --------------------------------------------------------------------------------
by_session_custom <- prepare_data(
  df, actor = "user", time = "timestamp", 
  action = "event", time_threshold = 10 * 60 # 10 minutes
)
tna_by_session_custom <- tna(by_session_custom)
plot(tna_by_session_custom)

## ----fig.width=8,fig.height=3, echo=2:3------------------------------------------
layout(t(1:2))
gtna <- group_tna(by_user, group = "achievement")
plot(gtna)

