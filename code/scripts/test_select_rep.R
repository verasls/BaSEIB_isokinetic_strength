# Load packages and functions ---------------------------------------------

library(tidyverse)
source("code/functions/read_strength_data.R")

# Read data ---------------------------------------------------------------

test <- read_strength_data("data/raw/knee/60gs/1st_eval/1st_strength_knee_raw_60g_003.txt")

M <- as.matrix(test)

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
  if (M[i - 1, 5] * M[i, 5] < 0) { # If product < 0, it means different signs
    idx[j] <- i
    j <- j + 1
  } else {
    if (M[i - 1, 5] * M[i, 5] == 0) { # If product is 0, at least one of the velocity values is 0
                                      # Mark where velocity is 0 as index
      if (M[(i - 1), 5] == 0 & M[i, 5] == 0) { # If both values are 0, mark the first
        idx[j] <- i - 1
        j <- j + 1
      } else { # If only one value is 0, mark it
        if (which(M[(i - 1):i, 5] == 0) == 1) {
          idx[j] <- i - 1
          j <- j + 1
        } else {
          if (which(M[(i - 1):i, 5] == 0) == 2) {
            idx[j] <- i
            j <- j + 1
          }
        }
      }
    }
  }
  idx <- na.omit(unique(idx))
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
for (i in 1:length(idx)) { # identify where idx points to velocity 0
  if (M[idx[i], 5] == 0) {
    p[l] <- i
    l <- l + 1
  }
}
for (i in 1:length(p)) {
  n <- min(which(M[idx[p[i]]:nrow(M), 5] != 0)) + idx[p[i]] - 1 # Find first value after 0
  if (M[idx[p[i]] - 1, 5] * M[n, 5] > 0) { # If product > 0, it means no sign change
    idx[i] <- NA 
  } 
}
idx <- idx[!is.na(idx)]


# Find time points of velocity zero crossings
t <- vector()
for (i in 1:length(idx)) {
  t[i] <- M[idx[i], 1]
}

# Torque x time plot with half-repetition divisions
ggplot(data = as_tibble(M)) +
  geom_line(mapping = aes(x = time, y = torque), colour = "blue") +
  geom_vline(xintercept = t) +
  labs(
    x = "Time (ms)",
    y = expression(Torque~(N*"\U00B7"*m))
  ) # put ID and eval as plot title