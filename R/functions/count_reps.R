count_reps <- function(path, n = FALSE) {
  # Counts the number of isokinetic strength test repetitions of each ID from a
  # file list
  #
  # Args:
  #   path: path containing the files to be analysed
  #   reps: a numeric value representing the correct number of repetitions
  #   expected on the isokinetic strength test
  #
  # Returns:
  #   A data frame containing the number of isokinetic strength test repetitions
  #   for each ID. If the argument reps is utilized, the function prints which 
  #   IDs have a different number of repetitions than the selected reps
  
  library(stringr)
  
  l <- list.files(path)
  
  # Create sequence of IDs
  IDs <- 1:91
  IDs <- as.character(IDs)
  for (i in 1:length(IDs)) {
    if (str_length(IDs[i]) == 1) {
      IDs[i] <- str_c("00", IDs[i])
    } else {
      if (str_length(IDs[i]) == 2) {
        IDs[i] <- str_c("0", IDs[i])
      }
    }
  }
  
  # Create a matrix (IDs x n of reps)
  reps <- vector()
  for (i in 1:length(IDs)) {
    reps[i] <- length(which(str_detect(l, IDs[i]) == TRUE))
  }
  
  d <- data.frame(IDs, reps) 
  
  if (is.numeric(n)) {
    x <- d[which(d[, 2] != n & d[, 2] != 0), ]
    
    if (nrow(x) == 0) {
      print("None of the IDs have a different number of reps than expected")
    } else {
      print("The following IDs have a different number of reps than expected")
      print(x) 
    }
  }
}