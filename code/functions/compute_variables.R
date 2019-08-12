compute_variables <- function(path, ID, ROM = FALSE) {
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
  source("code/functions/compute_variables_file.R")
  
  l <- list.files(path, full.names = TRUE)
  
  m <- which(str_detect(l, ID) == TRUE)
  
  M <- matrix(NA, length(m), 9)
  for (i in 1:length(m)) {
    M[i, ] <- compute_variables_file(l[m[i]], ROM)
  }
  colnames(M) <- colnames(compute_variables_file(l[m[1]]))
  
  return(M)
}