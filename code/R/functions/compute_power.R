compute_power <- function(df) {
  # Compute peak and average power (in Watt)
  #
  # Args:
  #   df: a data frame containing isokinetic strength test data
  #
  # Returns:
  #   A vector containing the peak and average power values, respectively
  
  M <- as.matrix(df)
	n <- dim(M)[1] - 1 
	
	# Maximum value gets initialized with first power value
	max <- abs(M[1, 2] * M[1, 5]) 
	# Avarage starts as a summation of all values
	avg <- max
	# For each of the n integration intervals minus the first, which was already computed	
	for (i in 2:n) {	
		value <- abs(M[i, 2] * M[i, 5])		
		avg   <- avg + value
		if (value > max) {
			max <- value
		}
	}
	
	# Averaging and changing from degrees to radians
	avg <- pi * (avg / n) / 180 
	# Changing from degrees to radians
	max <- pi * max / 180
	
	# Returning max and avarega
	vec <- c(max, avg)
	
	return(unname(vec))	
}