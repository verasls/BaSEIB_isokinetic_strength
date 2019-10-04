compute_variables_ID <- function(path, ID, ROM = FALSE) {
  # Applies compute_variables_file() function to all the files related to an ID
  # in the selected path
  #
  # Args:
  #   path: a character string with the path which contains isokinetic strenght
  #   test data
  #   ID: a character string with the ID number (3 digits format)
  #   ROM: a numeric sequence corresponding the desired range of motion
  #
  # Returns:
  #   A matrix with the computed variables and identifying the subject ID number
  #   and repetition for all the files related to an ID in the selected path
  
  require(stringr)
  source("R/functions/compute_variables_file.R")
  
  l <- list.files(path, full.names = TRUE)
  
  m <- which(str_detect(l, ID) == TRUE)
  
  M <- matrix(NA, length(m), 9)
  for (i in 1:length(m)) {
    M[i, ] <- compute_variables_file(l[m[i]], ROM)
  }
  colnames(M) <- c(
    "ID", "rep", "peak_torque", "peak_torque_BM",
    "peak_torque_LM", "peak_torque_angle",
    "total_work", "average_power", "peak_power"
  )
  
  return(M)
}