# Load packages and functions ---------------------------------------------

library(tidyverse)
source("code/functions/plot_divisions.R")
source("code/functions/separate_file.R")

# Plot divisions for all evals --------------------------------------------

# Delete files due to error during eval
d <- c(
  "data/raw/trunk/60gs/3rd_eval/3rd_strength_trunk_raw_60g_036.txt",
  "data/raw/trunk/120gs/1st_eval/1st_strength_trunk_raw_120g_069.txt"
)
for (i in 1:length(d)) {
  if (file.exists(d[i])) {
    file.remove(d[i])
  }
}

evals <- c("1st_eval", "2nd_eval", "3rd_eval", "4th_eval")

# 60º/s
for (i in evals) {
  files_60gs <- list.files(str_c("data/raw/trunk/60gs/", i), full.names = TRUE)
  for (i in 1:length(files_60gs)) {
    plot_divisions(files_60gs[i], show = FALSE)
  }
}

# 180º/s
for (i in evals) {
  files_120gs <- list.files(str_c("data/raw/trunk/120gs/", i), full.names = TRUE)
  for (i in 1:length(files_120gs)) {
    plot_divisions(files_120gs[i], show = FALSE)
  }
}

# Write files for all half reps -------------------------------------------

evals <- c("1st_eval", "2nd_eval", "3rd_eval", "4th_eval")

# 60º/s
for (i in evals) {
  files_60gs <- list.files(str_c("data/raw/trunk/60gs/", i), full.names = TRUE)
  for (i in 1:length(files_60gs)) {
    separate_file(files_60gs[i])
  }
}

# 120º/s
for (i in evals) {
  files_120gs <- list.files(str_c("data/raw/trunk/120gs/", i), full.names = TRUE)
  for (i in 1:length(files_120gs)) {
    separate_file(files_120gs[i])
  }
}
