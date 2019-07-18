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
	
	max <- abs(M[1, 2] * M[1, 5]) # Maximum value gets initialized with first power value
	avg <- max # Avarage starts as a summation of all values
	for (i in 2:n) # For each of the n integration intervals minus the first, which was already computed	
	{	
		value <- abs(M[i, 2] * M[i, 5]) # Power value for this iteration			
		avg = avg + value # Add value to avarage calculation 
		if (value > max) # If this power value is larger than the stored maximum, it becomes the new maximum
		{
			max = value
		}

	}
	avg = pi * (avg / n) / 180 # Averaging and changing from degrees to radians
	max = pi * max / 180 # Changing from degrees to radians
	# Returning max and avarega
	vec <- c(max, avg)
	return(unname(vec))	
}