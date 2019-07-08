# Load packages and functions ---------------------------------------------

library(tidyverse)
source("code/functions/read_strength_data.R")


# Knee extension ---------------------------------------------------------- 
# Obs: in knee extension, torque and velocity should be a positive value and
# anat_position values should start at 90 (or the closest possible) and decrease
# until 0 (or the closest possible)

# Read data
test_df <- read_strength_data("data/raw/knee/60gs/1st_eval/1st_strength_knee_raw_60g_001.txt")

# Plot time x torque
torque_plot <- ggplot(data = test_df) +
  geom_line(mapping = aes(x = time, y = abs_torque)) +
  scale_x_continuous(breaks = seq(0, 13000, 1000))
  # 1 rep is around 1500 to 2000 msec

# Establish peak torque rep area for knee extension (3000 msec to assure to get the whole rep)
ext_peak_torque_row <- which(test_df$torque == max(test_df$torque))

ext_peak_torque_rep_i <- ext_peak_torque_row - 100 # initial point 1/3 the time period before peak torque
ext_peak_torque_rep_f <- ext_peak_torque_row + 200 # final point 2/3 the time period after peak torque

ext_peak_torque_area <- test_df[ext_peak_torque_rep_i:ext_peak_torque_rep_f, ]

ext_peak_torque_area_plot <- ggplot(data = ext_peak_torque_area) +
  geom_line(mapping = aes(x = time, y = torque)) +
  geom_hline(yintercept = 0, colour = "red")

# Exclude region where flexion is occurring
ext_peak_torque_rep <- ext_peak_torque_area %>% 
  filter(torque >= 0) %>% 
  print(n = Inf)

ext_peak_torque_rep_plot <- ggplot(data = ext_peak_torque_rep) +
  geom_line(mapping = aes(x = time, y = torque)) +
  geom_hline(yintercept = 0, colour = "red")

# 1st row must contain:
#   either anat_position == 90, or the highest anat_position value
#   if there are more than 1 row where anat_position == 90, only the last must be kept

ext_peak_torque_rep$anat_position[1] <- 89

if (any(ext_peak_torque_rep$anat_position == 90) == TRUE) {
  ext_peak_torque_rep <- 
    ext_peak_torque_rep[max(which(ext_peak_torque_rep$anat_position == 90)):nrow(ext_peak_torque_rep), ]
} else {
  highest_anat_position <- max(ext_peak_torque_rep$anat_position)
  
  ext_peak_torque_rep <- 
    ext_peak_torque_rep[min(which(ext_peak_torque_rep$anat_position == highest_anat_position)):nrow(ext_peak_torque_rep), ]
}

# Last row must contain:
#   either anat_position == 0, or the lowest anat_position value
#   if there are more than 1 row where anat_position == 0, only the first must be kept