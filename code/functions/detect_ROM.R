detect_ROM <- function(speed, eval, ID, select_rep = FALSE) {
  
  
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