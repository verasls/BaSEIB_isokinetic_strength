find_divisions <- function(file) {
  # Find division points between half repetitions by zero crossings on the
  # velocity signal
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #
  # Returns:
  #   A vector containing the row numbers of the division points
  
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
  s <- vector()
  l <- 1
  for (i in 1:length(idx)) { 
    # Identify where idx points to velocity 0
    if (M[idx[i], 5] == 0) {
      s[l] <- i
      l <- l + 1
    }
  }
  if (length(s) > 0) {
    for (i in 1:length(s)) {
      # Find first value after 0
      n <- min(which(M[idx[s[i]]:nrow(M), 5] != 0)) + idx[s[i]] - 1 
      # If product > 0, it means no sign change
      if (M[idx[s[i]] - 1, 5] * M[n, 5] > 0) {
        idx[s[i]] <- NA
      }
    }
    idx <- idx[!is.na(idx)]
  }
  
  # Only keep idx value where distance between divisions is at least half a
  # repetition
  dist <- round(nrow(M) / (length(idx) * 2))
  x <- vector()
  y <- 1
  for (i in 2:length(idx)) {
    if (idx[i] - idx[i - 1] < dist) {
      x[y] <- i
      y <- y + 1
    }
  }
  if (length(x) == 1) {
    idx[x] <- NA
    idx <- idx[!is.na(idx)]
  } else {
    if (length(x) > 1) {
      for (i in 2:length(x)) {
        if (x[i] - x[i - 1] == 1) {
          x[i - 1] == NA
          x <- x[!is.na(x)]
        }
      }
      idx[x] <- NA
      idx <- idx[!is.na(idx)]
    }
  }
  
  return(idx)
}