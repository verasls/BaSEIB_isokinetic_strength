plot_divisions <- function(file, show = TRUE, save = TRUE) {
  # Make a torque x time plot with vertical lines representing the half
  # repetitions division points found by find_divisions() function
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #   show: whether or not to return the ggplot object (default is TRUE)
  #   save: whether or not to save the plot
  #
  # Returns:
  #   Saves the plot as a pdf file
  #   Return the ggplot object (optional)
  
  require(readr)
  require(stringr)
  require(ggplot2)
  source("code/functions/read_strength_data.R")
  source("code/functions/find_divisions.R")
  
  M <- as.matrix(read_strength_data(file))
  
  # Ensure 1st velocity value to be positive
  if (M[1, 5] <= 0) {
    # Find first positive velocity value
    p <- min(which(M[, 5] > 0))
    M <- M[p:nrow(M), ]
  }
  
  idx <- find_divisions(file)
  
  # Exclude region after the last idx
  M <- M[1:idx[length(idx)], ]
  
  # Find time points of velocity zero crossings
  t <- vector()
  for (i in 1:length(idx)) {
    t[i] <- M[idx[i], 1]
  }
  
  # Torque x time plot with half-repetition divisions
  
  title <- str_c(
    if (str_detect(file, "1st")) {
      "1st eval"
    } else {
      if (str_detect(file, "2nd")) {
        "2nd eval"
      } else {
        if (str_detect(file, "3rd")) {
          "3rd eval"
        } else {
          if (str_detect(file, "4th")) {
            "4th eval"
          }
        }
      }
    },
    " ID ",
    str_sub(file, str_length(file) - 6, str_length(file) - 4),
    if (str_detect(file, "knee")) {
      " - knee "
    } else {
      if (str_detect(file, "trunk")) {
        " - trunk "
      }
    }, 
    if (str_detect(file, "60gs")) {
      "60º" 
    } else {
      if (str_detect(file, "120gs")) {
        "120º"
      } else {
        if (str_detect(file, "180g")) {
          "180º"
        }
      }
    },
    "/s" 
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
  
  

  if (save == TRUE) {
    path <- str_c(
      if (str_detect(file, "knee")) {
        "data/processed/knee/"
      } else {
        if (str_detect(file, "trunk")) {
          "data/processed/trunk/"
        }
      },
      if (str_detect(file, "60gs")) {
        "60gs/"
      } else {
        if (str_detect(file, "120gs")) {
          "120gs/"
        } else {
          if (str_detect(file, "180gs")) {
            "180gs/"
          }
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
      if (str_detect(file, "knee")) {
        if (str_detect(file, "60g")) {
          str_sub(file, 29, str_length(file) - 4)
        } else {
          if (str_detect(file, "180g")) {
            str_sub(file, 30, str_length(file) - 4)
          }
        }
      } else {
        if (str_detect(file, "trunk")) {
          if (str_detect(file, "60g")) {
            str_sub(file, 30, str_length(file) - 4)
          } else {
            if (str_detect(file, "120g")) {
              str_sub(file, 31, str_length(file) - 4)
            }
          }
        }
      },
      "_plot.pdf"
    )
    
    ggsave(path, plot, width = 9, height = 4)
    
    print(
      if (str_detect(file, "knee")) {
        str_c(
          "Saving file: ",
          if (str_detect(file, "60g")) {
            str_sub(file, 29, str_length(file) - 4)
          } else {
            if (str_detect(file, "180g")) {
              str_sub(file, 30, str_length(file) - 4)
            }
          },
          "_plot.pdf"
        )
      } else {
        if (str_detect(file, "trunk")) {
          str_c(
            "Saving file: ",
            if (str_detect(file, "60g")) {
              str_sub(file, 30, str_length(file) - 4)
            } else {
              if (str_detect(file, "120g")) {
                str_sub(file, 31, str_length(file) - 4)
              }
            },
            "_plot.pdf"
          )
        }
      }
    )
  }
  
  if (show == TRUE) {
    return(plot)
  }
}