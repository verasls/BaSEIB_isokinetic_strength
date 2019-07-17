find_divisions <- function(file) {
  
  source("code/functions/read_strength_data.R")
  
  M <- as.matrix(read_strength_data(file))
  
  # Ensure 1st velocity value to be positive
  if (M[1, 5] <= 0) {
    # Find first positive velocity value
    p <- min(which(M[, 5] > 0))
    M <- M[p:nrow(M), ]
  }
  
  # Find zero crossings in velocity signal
  idx <- vector() # Division points indices
  j   <- 1        # Index counter
  for (i in 2:nrow(M)) {
    # If product < 0, it means different signs
    if (M[i - 1, 5] * M[i, 5] < 0) {
      idx[j] <- i
      j <- j + 1
    } else {
      # If product is 0, at least one of the velocity values is 0
      # Mark where velocity is 0 as index
      if (M[i - 1, 5] * M[i, 5] == 0) {
        if (min(which(M[(i - 1):i, 5] == 0)) == 1) {
          idx[j] <- i - 1
          j <- j + 1
        } else {
          if (min(which(M[(i - 1):i, 5] == 0)) == 2) {
            idx[j] <- i
            j <- j + 1
          }
        }
      }
    }
    idx <- unique(idx[!is.na(idx)])
  }
  
  # Keep only first index value where indices are consecutive
  c <- vector() # Vector indicating where idx values are consecutive
  k <- 1        # Index counter
  for (i in 2:length(idx)) {
    if (idx[i] - idx[i - 1] == 1) {
      c[k] <- i
      k <- k + 1
    }
  }
  if (length(c) != 0) {
    idx <- idx[- c]
  }
  
  # Ensure that idx where velocity is 0 are followed by a sign change
  p <- vector()
  l <- 1
  for (i in 1:length(idx)) { 
    # Identify where idx points to velocity 0
    if (M[idx[i], 5] == 0) {
      p[l] <- i
      l <- l + 1
    }
  }
  if (length(p) > 0) {
    for (i in 1:length(p)) {
      # Find first value after 0
      n <- min(which(M[idx[p[i]]:nrow(M), 5] != 0)) + idx[p[i]] - 1 
      # If product > 0, it means no sign change
      if (M[idx[p[i]] - 1, 5] * M[n, 5] > 0) {
        idx[i] <- NA
      }
    }
    idx <- idx[!is.na(idx)]
  }
  
  return(idx)
}