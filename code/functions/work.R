Work_Integration <- function(filename) 
{
  # File reading
  M <- as.matrix(read.csv(filename)) # Reads file as matrix	
  n <- dim(M)[1] - 1 # Gets the number of intervals in the matrix
  # Numerical integration
  sum <- 0.0 # Initializes sum variable to zero
  for (i in 1:n) # For each of the n integration intervals	
  {				
    sum = sum - M[i,2]*M[i,3] - M[i+1,2]*M[i,3] + M[i,2]*M[i+1,3] + M[i+1,2]*M[i+1,3];			
  }
  sum = pi*sum/360.0 # Correcting value
  # Returning calculated value without a name
  return(unname(sum))	
}