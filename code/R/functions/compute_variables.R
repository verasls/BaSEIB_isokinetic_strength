compute_variables <- function(path, ID, ROM) {
  # Applies compute_variables_ID() function to more than one ID in the selected
  # path
  #
  # Args:
  #   path: a character string with the path which contains isokinetic strenght
  #   test data
  #   ID: a vector with the desired IDs to computation
  #   ROM: a numeric sequence corresponding the desired range of motion
  #
  # Returns:
  #   A matrix with the computed variables and identifying the subject ID number
  #   and repetition for all the specified IDs in the selected path
  
  require(stringr)
  source("R/functions/compute_variables_ID.R")
  
  l <- list.files(path, full.names = TRUE)
  
  # Put IDs in a character string with 3 digits
  ID <- as.character(ID)
  for (i in 1:length(ID)) {
    if (str_length(ID[i]) == 1) {
      ID[i] <- str_c("00", ID[i])
    } else {
      if (str_length(ID[i]) == 2) {
        ID[i] <- str_c("0", ID[i])
      }
    }
  }
  
  v <- vector()
  w <- 1
  for (i in 1:length(ID)) {
    if (any(str_detect(l, ID[i]) == TRUE)) {
      v[w] <- ID[i]
      w <- w + 1
    }
  }
  
  for (i in 1:length(v)) {
    if (i == 1) {
      M <- compute_variables_ID(path, v[i], ROM)
    } else {
      m <- compute_variables_ID(path, v[i], ROM)
      M <- rbind(M, m)
    }
  }
  
  return(M)
}