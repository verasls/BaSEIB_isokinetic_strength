write_log <- function(file, t, v, p, M = FALSE, ROM = FALSE) {
  # Function to run inside ext_quality_control() and fle_quality_control()
  # functions
  #
  # Writes the results of the xxx_quality_control() function in a txt file
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data for an
  #   extension or flexion repetition
  #   t, v, p: vectors containing the row numbers in which the torque sign,
  #   velocity sign or anatomic position angles are incorrect for the repetition
  #
  # Returns:
  #   A txt file containing the information of in which rows the quality control
  #   fails
  
  require(stringr)
  
  qc_file <- str_c(
    if (str_detect(file, "60g")) {
      str_sub(file, 1, 34)
    } else {
      if (str_detect(file, "180g")) {
        str_sub(file, 1, 35)
      }
    },
    "quality_control_log.txt"
  )
  
  # Create quality_control_log.txt file if it does not exist
  if (file.exists(qc_file) == FALSE) {
    file.create(qc_file) 
  }
  
  # Name the file being read
  if (str_detect(file, "60g")) {
    file_name <- str_sub(file, str_length(file) - 34, str_length(file))
  } else {
    if (str_detect(file, "180g")) {
      file_name <- str_sub(file, str_length(file) - 35, str_length(file))
    }
  }
  
  # Write quality_control_log.txt file header
  if (length(t) > 0 | length(v) > 0 | length(p) > 0 | nrow(M) == 0) {
    cat(
      "****************************************", 
      file = qc_file, sep =  "\n", append = TRUE
    )
    cat("File: ", file = qc_file, sep = " ", append = TRUE)
    cat(file_name, file = qc_file, sep = "\n", append = TRUE)
    cat(as.character(Sys.Date()), file = qc_file, sep = "\n", append = TRUE)
  }
  
  if (nrow(M) == 0) {
    cat(" ", file = qc_file, sep = "\n", append = TRUE)
    cat(
      "Selected ROM does not correspond to the anat_position values on the file",
      file = qc_file, sep = "\n", append = TRUE
    )
    cat(
      str_c("Selected ROM: ", range(ROM)[1], "-", range(ROM)[2]),
      file = qc_file, sep = "\n", append = TRUE
    )
    M <- as.matrix(read.delim(file, sep = " "))
    cat(
      str_c("anat_position range:", range(M[, 4])[1], "-", range(M[, 4])[2]),
      file = qc_file, sep = "\n", append = TRUE
    )
  }
  if (length(t) > 0) {
    cat(" ", file = qc_file, sep = "\n", append = TRUE)
    cat(
      "The following row numbers contain torque values with the wrong sign:",
      file = qc_file, sep = "\n", append = TRUE
    )
    cat(as.character(t), file = qc_file, sep = "\n", append = TRUE)
  }
  if (length(v) > 0) {
    cat(" ", file = qc_file, sep = "\n", append = TRUE)
    cat(
      "The following row numbers contain velocity values with the wrong sign:",
      file = qc_file, sep = "\n", append = TRUE
    )
    cat(as.character(v), file = qc_file, sep = "\n", append = TRUE) 
  }
  if (length(p) > 0) {
    cat(" ", file = qc_file, sep = "\n", append = TRUE)
    cat(
      "The following row numbers contain a sequence of anatomic 
    position angles that does not match the repetition:",
      file = qc_file, sep = "\n", append = TRUE
    )
    cat(as.character(p), file = qc_file, sep = "\n", append = TRUE) 
  } 
}