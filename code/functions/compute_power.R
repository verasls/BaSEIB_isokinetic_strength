compute_power <- function(df) {
	
  M <- as.matrix(df)
	n <- dim(M)[1] - 1 
	
	max <- M[1, 2] * M[1, 5] # Maximum value gets initialized with first power value
	avg <- max # Avarage starts as a summation of all values
	for (i in 2:n) # For each of the n integration intervals minus the first, which was already computed	
	{	
		value <- M[i, 2] * M[i, 5] # Power value for this iteration			
		avg = avg + value # Add value to avarage calculation 
		if (value > max) # If this power value is larger than the stored maximum, it becomes the new maximum
		{
			max = value
		}

	}
	avg = pi * (avg / n) / 180 # Averaging and changing from degrees to radians
	max = pi * max / 1800.0 # Changing from degrees to radians
	# Returning max and avarega
	vec <- c(max, avg)
	return(unname(vec))	
}