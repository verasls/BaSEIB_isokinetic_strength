quality_control <- function(file, ROM = FALSE) {
  # Detect whether a file is for extension or flextion and apply the correct
  # quality control function to it
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #
  # Returns:
  #   A txt file containing the information of in which rows the quality control
  #   fails
  
  require(stringr)
  source("code/functions/ext_quality_control.R")
  source("code/functions/fle_quality_control.R")
  
  if (str_detect(file, "ext")) {
    ext_quality_control(file, ROM)
  } else {
    if (str_detect(file, "fle")) {
      fle_quality_control(file, ROM)
    }
  }
}