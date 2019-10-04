# Load packages and functions ---------------------------------------------

library(tidyverse)

# Arguments ---------------------------------------------------------------

filename <- "data/dbs/BaSEIB_isokinetic_strength_knee_60gs_1st.csv"

# Build final data frame template -----------------------------------------

data <- read_csv(filename)
IDs <- unique(data$ID)

final_df <- tibble(
  ID = IDs,
  peak_torque_ext = NA,
  peak_torque_BM_ext = NA,
  peak_torque_LM_ext = NA,
  peak_torque_angle_ext = NA,
  total_work_ext = NA,
  average_power_ext = NA,
  peak_power_ext = NA,
  peak_torque_fle = NA,
  peak_torque_BM_fle = NA,
  peak_torque_LM_fle = NA,
  peak_torque_angle_fle = NA,
  total_work_fle = NA,
  average_power_fle = NA,
  peak_power_fle = NA
)

for (i in 1:length(IDs)) {
  select_ID <- filter(data, ID == IDs[i])
  ext_reps <- select_ID %>% 
    filter(str_detect(select_ID$rep, "ext") == TRUE)
  fle_reps <- select_ID %>% 
    filter(str_detect(select_ID$rep, "fle") == TRUE)
  
  # Select the best values for the variables
  final_df[which(final_df$ID == IDs[i]), 2] <- max(ext_reps$peak_torque)
  final_df[which(final_df$ID == IDs[i]), 3] <- max(ext_reps$peak_torque_BM)
  final_df[which(final_df$ID == IDs[i]), 4] <- max(ext_reps$peak_torque_LM)
  final_df[which(final_df$ID == IDs[i]), 5] <- max(ext_reps$peak_torque_angle)
  final_df[which(final_df$ID == IDs[i]), 6] <- max(ext_reps$total_work)
  final_df[which(final_df$ID == IDs[i]), 7] <- max(ext_reps$average_power)
  final_df[which(final_df$ID == IDs[i]), 8] <- max(ext_reps$peak_power)
  
  final_df[which(final_df$ID == IDs[i]), 9]  <- max(fle_reps$peak_torque)
  final_df[which(final_df$ID == IDs[i]), 10] <- max(fle_reps$peak_torque_BM)
  final_df[which(final_df$ID == IDs[i]), 11] <- max(fle_reps$peak_torque_LM)
  final_df[which(final_df$ID == IDs[i]), 12] <- max(fle_reps$peak_torque_angle)
  final_df[which(final_df$ID == IDs[i]), 13] <- max(fle_reps$total_work)
  final_df[which(final_df$ID == IDs[i]), 14] <- max(fle_reps$average_power)
  final_df[which(final_df$ID == IDs[i]), 15] <- max(fle_reps$peak_power)
}