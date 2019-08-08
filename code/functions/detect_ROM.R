detect_ROM <- function(speed, eval, ID, select_rep = FALSE) {
  # Detects the range of motion (ROM) of all repetitions or a selected
  # repetition of an ID
  #
  # Args:
  #   speed: a character string with the isokinetic strength test speed
  #   eval: a character string with the isokinetic strength test evaluation number
  #   ID: a character string with the ID number (3 digits format)
  #   select_rep: if not FALSE, a character string with the isokinetic strength
  #   test repetition (either ext or fle, and the number. e.g.: ext_1)
  #
  # Returns:
  #   A data frame with the selected isokinetic strength test repetitions and
  #   the ROM
  
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
  
  rep   <- rep(NA, length(s))
  from  <- rep(NA, length(s))
  to    <- rep(NA, length(s))
  range <- rep(NA, length(s))
  for (i in 1:length(s)) {
    M <- as.matrix(read.delim(s[i], sep = " "))
    
    rep[i]   <- str_sub(
      s[i],
      str_length(s[i]) - 8,
      str_length(s[i]) - 4
    )
    from[i]  <- range(M[, 4])[1]
    to[i]    <- range(M[, 4])[2]
    range[i] <- abs(range(M[, 4])[1] - range(M[, 4])[2])
  }
  return(data.frame(rep, from, to, range))
}