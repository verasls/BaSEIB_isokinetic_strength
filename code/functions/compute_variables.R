compute_variables <- function(file, ROM = FALSE) {
  # Computes some variables based on isokinetic strenght test data
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #   ROM: a numeric sequence corresponding the desired range of motion
  #
  # Returns:
  #   A data frame with the computed variables and identifying the subject ID
  #   number and repetition
  
  require(stringr)
  source("code/functions/select_ROM.R")
  source("code/functions/work_integration.R")
  source("code/functions/compute_power.R")
  
  M <- select_ROM(file, ROM)
  B <- read.csv("data/raw/body_composition.csv")
  
  # Detect parameters
  ID  <- str_sub(file, str_length(file) - 12, str_length(file) - 10)
  rep <- str_sub(file, str_length(file) - 8, str_length(file) - 4)
  BW  <- B[which(B[, 1] == as.numeric(ID)), 2] # body weight
  LW  <- B[which(B[, 1] == as.numeric(ID)), 4] # lower limb weight
  
  # Compute variables
  peak_torque       <- max(abs(M[, 2]))
  peak_torque_BW    <- peak_torque / BW
  peak_torque_LW    <- peak_torque / LW
  peak_torque_angle <- unname(M[which(M[, 2] == peak_torque), 4])
  total_work        <- work_integration(M)
  average_power     <- compute_power(M)[2]
  peak_power        <- compute_power(M)[1]
  
  # Assemble data frame
  df <- data.frame(
    ID, rep, peak_torque, peak_torque_BW,
    peak_torque_LW, peak_torque_angle,
    total_work, average_power, peak_power
  )
  df[, 1] <- as.numeric(df[, 1])
  
  return(df)
}