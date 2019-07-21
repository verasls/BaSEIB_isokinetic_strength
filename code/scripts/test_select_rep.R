# Load packages and functions ---------------------------------------------

library(tidyverse)
source("code/functions/plot_divisions.R")


# Plot divisions for all evals --------------------------------------------

evals <- c("1st_eval", "2nd_eval", "3rd_eval", "4th_eval")

# 60º/s
for (i in evals) {
  files_60gs <- list.files(str_c("data/raw/knee/60gs/", i), full.names = TRUE)
  for (i in 1:length(files_60gs)) {
    plot_divisions(files_60gs[i], show = FALSE)
  }
}

# 180º/s
for (i in evals) {
  files_180gs <- list.files(str_c("data/raw/knee/180gs/", i), full.names = TRUE)
  for (i in 1:length(files_180gs)) {
    plot_divisions(files_180gs[i], show = FALSE)
  }
}