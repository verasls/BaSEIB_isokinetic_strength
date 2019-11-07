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
  source("R/functions/select_ROM.R")
  source("R/functions/work_integration.R")
  source("R/functions/compute_power.R")
  
  if (str_detect(file, "60gs")) {
    if (str_length(file) == 84) {
      print(
        str_c(
          "Reading file: ",
          str_sub(file, str_length(file) - 35, str_length(file))
        )
      )
    } else {
      print(
        str_c(
          "Reading file: ",
          str_sub(file, str_length(file) - 34, str_length(file))
        )
      )
    }
  } else {
    if (str_detect(file, "180gs")) {
      if (str_length(file) == 86) {
        print(
          str_c(
            "Reading file: ",
            str_sub(file, str_length(file) - 36, str_length(file))
          )
        )
      } else {
        print(
          str_c(
            "Reading file: ",
            str_sub(file, str_length(file) - 35, str_length(file))
          )
        )
      }
    }
  }
  
  D <- select_ROM(file, ROM)
  B <- read.csv("data/raw/body_composition.csv")
  
  # Detect parameters
    # For ID and rep, the chunk of the string to be subset depends on the length
    # of the string
  if (str_detect(file, "180gs")) {
    if (str_length(file) == 86) {
      ID  <- str_sub(file, str_length(file) - 13, str_length(file) - 11)  
      rep <- str_sub(file, str_length(file) - 9, str_length(file) - 4)
    } else {
      ID  <- str_sub(file, str_length(file) - 12, str_length(file) - 10) 
      rep <- str_sub(file, str_length(file) - 8, str_length(file) - 4)
    }
  } else {
    ID  <- str_sub(file, str_length(file) - 12, str_length(file) - 10)
    rep <- str_sub(file, str_length(file) - 8, str_length(file) - 4)
    
  }
  BM  <- B[which(B[, 1] == as.numeric(ID)), 2] # body mass
  LM  <- B[which(B[, 1] == as.numeric(ID)), 4] # lower limb mass
  
  # Compute variables
  peak_torque       <- max(abs(D[, 2]))
  peak_torque_BM    <- peak_torque / BM
  peak_torque_LM    <- peak_torque / LM
  peak_torque_angle <- min(unname(D[which(abs(D[, 2]) == peak_torque), 4]))
  total_work        <- work_integration(D)
  total_work_BM     <- total_work / BM
  total_work_LM     <- total_work / LM
  average_power     <- compute_power(D)[2]
  average_power_BM  <- average_power / BM
  average_power_LM  <- average_power / LM
  peak_power        <- compute_power(D)[1]
  peak_power_BM     <- peak_power / BM 
  peak_power_LM     <- peak_power / LM
  
  # Assemble data frame
  M <- as.matrix(
    data.frame(
      ID, rep, peak_torque, peak_torque_BM,
      peak_torque_LM, peak_torque_angle,
      total_work, total_work_BM, total_work_LM,
      average_power, average_power_BM, average_power_LM,
      peak_power, peak_power_BM, peak_power_LM
    )
  )
  M[, 1] <- as.numeric(M[, 1])
  
  return(M)
}