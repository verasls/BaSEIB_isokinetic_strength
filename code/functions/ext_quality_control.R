ext_quality_control <- function(file) {
  # Run a quality control test on extention repetition files to assess whether
  # torque signs, velocity signs and anatomic position angles are correct and
  # apply write_log() function to write this information on a txt file
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data for an
  #   extension repetition
  #
  # Returns:
  #   A txt file containing the information of in which rows the quality control
  #   fails
  
  source("code/functions/write_log.R")
  
  print(
    str_c(
      "Reading file: ",
      if (str_detect(file, "60g")) {
        str_sub(file, 49, str_length(file))
      } else {
        if (str_detect(file, "180g")) {
          str_sub(file, 50, str_length(file) - 4)
        }
      },
      "_plot.pdf"
    )
  ) 
  
  M <- as.matrix(read.delim(file, sep = " "))
  
  # Detect negative torque and velocity values during knee extension
  t <- vector()
  a <- 1
  v <- vector()
  b <- 1
  for (i in 1:nrow(M)) {
    # Torque
    if (M[i, 2] < 0) {
      t[a] <- i
      a <- a + 1
    }
    # Velocity
    if (M[i, 5] < 0) {
      v[b] <- i
      b <- b + 1
    }
  }
  
  # Check wheter anatomic position angles increase
  p <- vector()
  c <- 1
  for (i in 2:nrow(M)) {
    if (M[i, 4] > M[i - 1, 4]) {
      p[c] <- i
      c <- c + 1
    }
  }
  
  write_log(file, t, v, p)
}