read_strength_data <- function(file) {
  # Read a txt file containing the isokinetic strength test data into a tibble,
  # skipping the file header and renaming the columns
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #
  # Returns:
  #   A tibble containing the isokinetic strength test data
  
  library(tidyverse)
  
  df <- read_table(file, skip = 6, col_names = FALSE, col_types = cols()) %>% 
    select(
      time = X1,
      torque = X2,
      position = X3,
      anat_position = X4,
      velocity = X5
    )
}