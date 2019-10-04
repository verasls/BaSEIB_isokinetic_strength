# Load packages and functions ---------------------------------------------

library(tidyverse)
source("code/functions/plot_divisions.R")
source("code/functions/separate_file.R")
source("code/functions/quality_control.R")
source("code/functions/count_reps.R")

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

# Run quality control -----------------------------------------------------

# 60º/s
files_sep_reps_60gs <- c(
  list.files("data/processed/trunk/60gs/1st_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/trunk/60gs/2nd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/trunk/60gs/3rd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/trunk/60gs/4th_eval/separate_reps", full.names = TRUE)
)
for (i in 1:length(files_sep_reps_60gs)) {
  quality_control(files_sep_reps_60gs[i], ROM = 10:50)
}

# 120º/s
files_sep_reps_120gs <- c(
  list.files("data/processed/trunk/120gs/1st_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/trunk/120gs/2nd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/trunk/120gs/3rd_eval/separate_reps", full.names = TRUE),
  list.files("data/processed/trunk/120gs/4th_eval/separate_reps", full.names = TRUE)
)
for (i in 1:length(files_sep_reps_120gs)) {
  quality_control(files_sep_reps_120gs[i], ROM = 10:50)
}

# Count reps --------------------------------------------------------------

# 60º/s
count_reps("data/processed/trunk/60gs/1st_eval/separate_reps/", 8)
count_reps("data/processed/trunk/60gs/2nd_eval/separate_reps/", 8)
count_reps("data/processed/trunk/60gs/3rd_eval/separate_reps/", 8)
count_reps("data/processed/trunk/60gs/4th_eval/separate_reps/", 8)

# 120º/s
count_reps("data/processed/trunk/120gs/1st_eval/separate_reps/", 12)
count_reps("data/processed/trunk/120gs/2nd_eval/separate_reps/", 12)
count_reps("data/processed/trunk/120gs/3rd_eval/separate_reps/", 12)
count_reps("data/processed/trunk/120gs/4th_eval/separate_reps/", 12)

# Problematic IDs ---------------------------------------------------------

# TRUNK 60º/s
# 1st
# - anat_position: 
# - count_reps: 018, 022, 023, 026, 030, 047, 049, 055, 060, 063, 065, 066, 069,
# 070, 071, 075
# 2nd
# - anat_position:
# - count_reps: 002, 012, 017, 021, 023, 026, 027, 028, 037, 040, 046, 050, 055,
# 072, 083
# 3rd
# - anat_position:
# - count_reps: 001, 004, 006, 007, 014, 017, 039, 049, 055, 061, 080, 087
# 4th
# - anat_position:
# - count_reps: 003, 004, 006, 007, 014, 017, 024, 030, 049, 061, 062, 073
#
# TRUNK 120º/s
# 1st
# - anat_position: 
# - count_reps: 016, 018, 020, 021, 023, 024, 026, 029, 030, 031, 034, 036, 037,
# 038, 039, 041, 042, 045, 046, 048, 049, 050, 052, 053, 054, 055, 056, 057,
# 059, 062, 063, 064, 067, 068, 071, 073, 075, 078, 083, 084
# 2nd
# - anat_position:
# - count_reps: 001, 002, 004, 007, 008, 012, 014, 017, 020, 021, 024, 026, 027,
# 028, 029, 030, 031, 034, 035, 037, 046, 049, 050, 051, 052, 062, 063, 072,
# 078, 083, 085, 091
# 3rd
# - anat_position: 
# - count_reps: 001, 003, 004, 005, 007, 010, 011, 014, 016, 017, 021, 022, 024,
# 026, 027, 028, 029, 030, 034, 043, 044, 046, 049, 050, 054, 055, 058, 060,
# 061, 067, 068, 070, 071, 072, 073, 078, 080, 083
# 4th
# - anat_position:
# - count_reps: 004, 006, 007, 008, 009, 012, 014, 022, 026, 028, 030, 039, 049,
# 051, 061, 062, 063, 068, 072, 073, 083