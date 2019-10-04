find_best_values <- function(file_path, output_path) {
  # Find the best value for each variable in a data frame with all IDs for both
  # extension and flexion repetitions, and append it into a new data frame
  #
  # Args:
  #   file_path: path to the input file
  #   output_path: path to the output file
  #
  # Returns:
  #   Writes a data frame with the best values of each variable for all IDs into
  #   a csv file
  
  
  require(tidyverse)
  
  data <- read_csv(file_path)
  all_IDs <- unique(data$ID)
  
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
  
  for (i in 1:length(all_IDs)) {
    select_ID <- filter(data, ID == all_IDs[i])
    ext_reps <- select_ID %>% 
      filter(str_detect(select_ID$rep, "ext") == TRUE)
    fle_reps <- select_ID %>% 
      filter(str_detect(select_ID$rep, "fle") == TRUE)
    
    ID <- which(final_df$ID == IDs[i])
    
    # Select the best values for the variables
    final_df[ID, 2] <- max(ext_reps$peak_torque)
    final_df[ID, 3] <- max(ext_reps$peak_torque_BM)
    final_df[ID, 4] <- max(ext_reps$peak_torque_LM)
    final_df[ID, 5] <- max(ext_reps$peak_torque_angle)
    final_df[ID, 6] <- max(ext_reps$total_work)
    final_df[ID, 7] <- max(ext_reps$average_power)
    final_df[ID, 8] <- max(ext_reps$peak_power)
    
    final_df[ID, 9]  <- max(fle_reps$peak_torque)
    final_df[ID, 10] <- max(fle_reps$peak_torque_BM)
    final_df[ID, 11] <- max(fle_reps$peak_torque_LM)
    final_df[ID, 12] <- max(fle_reps$peak_torque_angle)
    final_df[ID, 13] <- max(fle_reps$total_work)
    final_df[ID, 14] <- max(fle_reps$average_power)
    final_df[ID, 15] <- max(fle_reps$peak_power)
  }
 
  write_csv(final_df, output_path) 
}