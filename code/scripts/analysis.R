# Load packages and functions ---------------------------------------------

library(tidyverse)
source("code/functions/plot_divisions.R")
source("code/functions/separate_file.R")
source("code/functions/quality_control.R")
source("code/functions/count_reps.R")

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

# Write files for all half reps -------------------------------------------

# 60º/s
for (i in evals) {
  files_60gs <- list.files(str_c("data/raw/knee/60gs/", i), full.names = TRUE)
  for (i in 1:length(files_60gs)) {
    separate_file(files_60gs[i])
  }
}

# 180º/s
for (i in evals) {
  files_180gs <- list.files(str_c("data/raw/knee/180gs/", i), full.names = TRUE)
  for (i in 1:length(files_180gs)) {
    separate_file(files_180gs[i])
  }
}

# Run quality control -----------------------------------------------------

# 60º/s
files_sep_reps_60gs <- c(
  list.files("data/processed/knee/60gs/1st_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/knee/60gs/2nd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/knee/60gs/3rd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/knee/60gs/4th_eval/separate_reps", full.names = TRUE)
)
for (i in 1:length(files_sep_reps_60gs)) {
  quality_control(files_sep_reps_60gs[i], ROM = 10:80)
}

# 180º/s
files_sep_reps_180gs <- c(
  list.files("data/processed/knee/180gs/1st_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/knee/180gs/2nd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/knee/180gs/3rd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/knee/180gs/4th_eval/separate_reps", full.names = TRUE)
)
for (i in 1:length(files_sep_reps_180gs)) {
  quality_control(files_sep_reps_180gs[i], ROM = 10:80)
}

# Count reps --------------------------------------------------------------

# 60º/s
count_reps("data/processed/knee/60gs/1st_eval/separate_reps/", 8)
count_reps("data/processed/knee/60gs/2nd_eval/separate_reps/", 8)
count_reps("data/processed/knee/60gs/3rd_eval/separate_reps/", 8)
count_reps("data/processed/knee/60gs/4th_eval/separate_reps/", 8)

# 180º/s
count_reps("data/processed/knee/180gs/1st_eval/separate_reps/", 16)
count_reps("data/processed/knee/180gs/2nd_eval/separate_reps/", 16)
count_reps("data/processed/knee/180gs/3rd_eval/separate_reps/", 16)
count_reps("data/processed/knee/180gs/4th_eval/separate_reps/", 16)