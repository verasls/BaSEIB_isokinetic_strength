plot_divisions <- function(file, show = TRUE) {
 
  require(readr)
  require(stringr)
  require(ggplot2)
  source("code/functions/read_strength_data.R")
  source("code/functions/find_divisions.R")
  
  d <- read_strength_data(file)
  M <- as.matrix(d)
  
  # Ensure 1st velocity value to be positive
  if (M[1, 5] <= 0) {
    # Find first positive velocity value
    p <- min(which(M[, 5] > 0))
    M <- M[p:nrow(M), ]
  }
  
  idx <- find_divisions(file)
  
  # Find time points of velocity zero crossings
  t <- vector()
  for (i in 1:length(idx)) {
    t[i] <- M[idx[i], 1]
  }
  
  # Torque x time plot with half-repetition divisions
  
  title <- str_c(
    "ID ",
    str_sub(file, str_length(file) - 6, str_length(file) - 4),
    " - knee ", 
    if (str_detect(file, "60g")) {
      "60 g"
    } else {
      if (str_detect(file, "180g")) {
        "180 g"
      }
    },
    "\U00B7",
    "s" 
  )
  
  plot <- ggplot(data = as_tibble(M)) +
    geom_line(mapping = aes(x = time, y = torque), colour = "blue") +
    geom_vline(xintercept = t) +
    labs(
      x = "Time (ms)",
      y = expression(Torque~(N*"\U00B7"*m)),
      title = title
    ) + 
    theme(plot.title = element_text(hjust = 0.5))
  
  path <- str_c(
    "data/processed/knee/",
    if (str_detect(file, "60g")) {
      "60gs/"
    } else {
      if (str_detect(file, "180g")) {
        "180gs/"
      }
    },
    if (str_detect(file, "1st")) {
      "1st_eval/"
    } else {
      if (str_detect(file, "2nd")) {
        "2nd_eval/"
      } else {
        if (str_detect(file, "3rd")) {
          "3rd_eval/"
        } else {
          if (str_detect(file, "4th")) {
            "4th_eval/"
          }
        }
      }
    },
    "plots/",
    str_sub(file, 29, str_length(file) - 4),
    "_plot.pdf"
  )

  ggsave(path, plot, width = 9, height = 4)
  
  if (show == TRUE) {
    return(plot)
  }
}