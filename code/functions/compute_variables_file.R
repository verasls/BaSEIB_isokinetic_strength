compute_variables_file <- function(file, ROM = FALSE) {
  # Computes some variables based on isokinetic strenght test data from a single
  # file
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #   ROM: a numeric sequence corresponding the desired range of motion
  #
  # Returns:
  #   A matrix with the computed variables and identifying the subject ID
  #   number and repetition
  
  require(stringr)
  source("code/functions/select_ROM.R")
  source("code/functions/work_integration.R")
  source("code/functions/compute_power.R")
  
  D <- select_ROM(file, ROM)
  B <- read.csv("data/raw/body_composition.csv")
  
  # Detect parameters
  ID  <- str_sub(file, str_length(file) - 12, str_length(file) - 10)
  rep <- str_sub(file, str_length(file) - 8, str_length(file) - 4)
  BM  <- B[which(B[, 1] == as.numeric(ID)), 2] # body mass
  LM  <- B[which(B[, 1] == as.numeric(ID)), 4] # lower limb mass
  
  # Compute variables
  peak_torque       <- max(abs(D[, 2]))
  peak_torque_BM    <- peak_torque / BM
  peak_torque_LM    <- peak_torque / LM
  peak_torque_angle <- min(unname(D[which(abs(D[, 2]) == peak_torque), 4]))
  total_work        <- work_integration(D)
  average_power     <- compute_power(D)[2]
  peak_power        <- compute_power(D)[1]
  
  # Assemble data frame
  M <- as.matrix(
    data.frame(
      ID, rep, peak_torque, peak_torque_BM,
      peak_torque_LM, peak_torque_angle,
      total_work, average_power, peak_power
    )
  )
  M[, 1] <- as.numeric(M[, 1])
  
  return(M)
}