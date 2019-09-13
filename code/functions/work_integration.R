work_integration <- function(df) {
  # Computes total work (in Nm) from a isokinetic strength test data
  #
  # Args:
  #   df: a data frame containing isokinetic strength test data
  #
  # Returns:
  #   The absolute value of total work done
  
  M <- as.matrix(df)
  n <- dim(M)[1] - 1 # Gets the number of intervals in the matrix
  
  # Numerical integration
  work <- 0
  for (i in 1:n) {				
    work <- work + (M[i, 2] * M[i + 1, 3]) + (M[i + 1, 2] * M[i + 1, 3]) - (M[i, 2] * M[i, 3]) - (M[i + 1, 2] * M[i, 3])
  }
  # Change from degrees to radians
  work <- (pi * work) / (180 * 2)

  return(unname(abs(work)))
}