# Load packages and functions ---------------------------------------------

library(tidyverse)
source("R/functions/plot_divisions.R")
source("R/functions/separate_file.R")
source("R/functions/quality_control.R")
source("R/functions/count_reps.R")
source("R/functions/detect_ROM.R")
source("R/functions/correct_ROM.R")
source("R/functions/compute_variables.R")

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

evals <- c("1st_eval", "2nd_eval", "3rd_eval", "4th_eval")

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

# Problematic IDs ---------------------------------------------------------

# KNEE 60º/s
# 1st
# - anat_position: 003, 004, 008, 045 (only ext_5), 070, 072
# - count_reps: 012, 037, 045
# 2nd
# - anat_position: 004 (only ext_1 and fle_1), 021
# - count_reps: 044, 052, 073
# 3rd
# - anat_position: 002, 039
# 4th
# - anat_position: 007
# - count_reps: 007
# 
# KNEE 180º/s
# 1st
# - anat_position: 003, 004, 008, 070, 072
# - count_reps: 012, 064
# 2nd
# - anat_position: 021
# 3rd
# - anat_position: 002, 039, 044 (only ext_5)
# - count_reps: 044
# obs: due to the wrong number of reps, after ext_5 the nomenclature (ext or fle) of all files  is wrong
# 4th
# - anat_position: 007

# Correct errors ----------------------------------------------------------

# 60º/s
# 1st
detect_ROM("60", "1st", "003")
correct_ROM("60", "1st", "003", - 83)

detect_ROM("60", "1st", "004")
correct_ROM("60", "1st", "004", - 90)

detect_ROM("60", "1st", "008")
correct_ROM("60", "1st", "008", - 89)

detect_ROM("60", "1st", "010")
correct_ROM("60", "1st", "010", - 75)

detect_ROM("60", "1st", "045")
file.remove(
  "data/processed/knee/60gs/1st_eval/separate_reps/1st_strength_knee_60g_045_ext_5.txt"
)

detect_ROM("60", "1st", "070")
correct_ROM("60", "1st", "070", - 86)

detect_ROM("60", "1st", "072")
correct_ROM("60", "1st", "072", - 90)

# 2nd
detect_ROM("60", "2nd", "004")
correct_ROM("60", "2nd", "004", - 79)

detect_ROM("60", "2nd", "021")
correct_ROM("60", "2nd", "021", - 81)

# 3rd
detect_ROM("60", "3rd", "002")
correct_ROM("60", "3rd", "002", + 86)

detect_ROM("60", "3rd", "039")
correct_ROM("60", "3rd", "039", - 82)

# 4th
detect_ROM("60", "4th", "007")
correct_ROM("60", "4th", "007", - 90)

# 180º/s
# 1st
detect_ROM("180", "1st", "003")
correct_ROM("180", "1st", "003", - 83)

detect_ROM("180", "1st", "004")
correct_ROM("180", "1st", "004", - 90)

detect_ROM("180", "1st", "008")
correct_ROM("180", "1st", "008", - 88)

detect_ROM("180", "1st", "070")
correct_ROM("180", "1st", "070", - 83)

detect_ROM("180", "1st", "072")
correct_ROM("180", "1st", "072", - 90)

# 2nd
detect_ROM("180", "2nd", "021")
correct_ROM("180", "2nd", "021", - 81)

# 3rd
detect_ROM("180", "3rd", "002")
correct_ROM("180", "3rd", "002", + 89)

detect_ROM("180", "3rd", "039")
correct_ROM("180", "3rd", "039", - 82)

detect_ROM("180", "3rd", "044")
path_44 <- "data/processed/knee/180gs/3rd_eval/separate_reps/3rd_strength_knee_180g_044_"
file.remove(str_c(path_44, "ext_5.txt"))
file.rename(str_c(path_44, "fle_5.txt"), str_c(path_44, "ext_5.txt"))
file.rename(str_c(path_44, "ext_6.txt"), str_c(path_44, "fle_5.txt"))
file.rename(str_c(path_44, "fle_6.txt"), str_c(path_44, "ext_6.txt"))
file.rename(str_c(path_44, "ext_7.txt"), str_c(path_44, "fle_6.txt"))
file.rename(str_c(path_44, "fle_7.txt"), str_c(path_44, "ext_7.txt"))
file.rename(str_c(path_44, "ext_8.txt"), str_c(path_44, "fle_7.txt"))
file.rename(str_c(path_44, "fle_8.txt"), str_c(path_44, "ext_8.txt"))
file.rename(str_c(path_44, "ext_9.txt"), str_c(path_44, "fle_8.txt"))

# 4th
detect_ROM("180", "4th", "007")
correct_ROM("180", "4th", "007", - 90)

# Build data bases --------------------------------------------------------

# 60º/s
# 1st
data_60gs_1st <- compute_variables(
  "data/processed/knee/60gs/1st_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_60gs_1st), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_60gs_1st.csv"
)

# 2nd
data_60gs_2nd <- compute_variables(
  "data/processed/knee/60gs/2nd_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_60gs_2nd), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_60gs_2nd.csv"
)

# 3rd
data_60gs_3rd <- compute_variables(
  "data/processed/knee/60gs/3rd_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_60gs_3rd), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_60gs_3rd.csv"
)

# 4th
data_60gs_4th <- compute_variables(
  "data/processed/knee/60gs/4th_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_60gs_4th), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_60gs_4th.csv"
)

# 180º/s
# 1st
data_180gs_1st <- compute_variables(
  "data/processed/knee/180gs/1st_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_180gs_1st), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_180gs_1st.csv"
)

# 2nd
data_180gs_2nd <- compute_variables(
  "data/processed/knee/180gs/2nd_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_180gs_2nd), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_180gs_2nd.csv"
)

# 3rd
data_180gs_3rd <- compute_variables(
  "data/processed/knee/180gs/3rd_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_180gs_3rd), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_180gs_3rd.csv"
)

# 4th
data_180gs_4th <- compute_variables(
  "data/processed/knee/180gs/4th_eval/separate_reps",
  1:91, 10:80
)
write_csv(
  as.data.frame(data_180gs_4th), 
  "data/data_bases/BaSEIB_isokinetic_strength_knee_180gs_4th.csv"
)