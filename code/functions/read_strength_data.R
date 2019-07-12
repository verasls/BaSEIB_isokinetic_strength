read_strength_data <- function(file) {
  
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