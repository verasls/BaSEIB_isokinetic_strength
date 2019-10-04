select_ROM <- function(file, ROM) {
  # Select a range of motion on the isokinetic strength test data
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #   ROM: a numeric sequence corresponding the desired range of motion
  #
  # Returns:
  #   The isokinetic strength test data on the selected range of motion as a
  #   matrix
  
  M <- as.matrix(read.delim(file, sep = " "))
  
  M <- M[which(abs(M[, 4]) %in% ROM), ]
  
  return(M)
}