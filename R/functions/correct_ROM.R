correct_ROM <- function(speed, eval, ID, operation, select_rep = FALSE) {
  # Corrects the range of motion (ROM) of all repetitions or a selected
  # repetition of an ID
  #
  # Args:
  #   speed: a character string with the isokinetic strength test speed
  #   eval: a character string with the isokinetic strength test evaluation number
  #   ID: a character string with the ID number (3 digits format)
  #   operation: the mathematic operation needed to correct the ROM
  #   select_rep: if not FALSE, a character string with the isokinetic strength
  #   test repetition (either ext or fle, and the number. e.g.: ext_1)
  #
  # Returns:
  #   Saves the corrected isokinetic strength repetition data into a txt file
  #   with the same name of the original file
  
  require(stringr)
  
  path <- str_c(
    "data/processed/knee/",
    speed,
    "gs/",
    eval,
    "_eval/separate_reps"
  )
  
  l <- list.files(path, full.names = TRUE)
  if (select_rep != FALSE) {
    s <- str_c(
      path,
      "/",
      eval,
      "_strength_knee_",
      speed,
      "g_",
      ID,
      "_",
      select_rep,
      ".txt"
    ) 
  } else {
    s <- l[which(str_detect(l, ID))] 
  }
  
  for (n in 1:length(s)) {
    M <- as.matrix(read.delim(s[n], sep = " "))
    for (i in 1:nrow(M)) {
      M[i, 4] <- M[i, 4] + operation
    }
    write.table(M, s[n], row.names = FALSE)
  }
}