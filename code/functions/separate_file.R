separate_file <- function(file) {
  # Separate a isokinetic strength test data file into the half repetitions
  # found by find_divisions() and write it in different files
  #
  # Args:
  #   file: name of the file containing isokinetic strength test data
  #
  # Returns:
  #   Writes the half repetitions into separate files

  require(stringr)
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
  
  for (i in 1:length(idx)) {
    
    path <- str_c(
      str_c(
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
        "separate_reps/"
      ),
      str_replace(
        if (str_detect(file, "60g")) {
          str_sub(file, 29, str_length(file) - 4)
        } else {
          if (str_detect(file, "180g")) {
            str_sub(file, 30, str_length(file) - 4)
          }
        },
        "raw_", ""
      ),
      if (i %% 2 != 0) {
        str_c("_ext_", (i + 1) / 2, ".txt")
      } else {
        if (i %% 2 == 0) {
          str_c("_fle_", i / 2, ".txt")
        }
      }
    )
      
    if (i == 1) {
      write.table(M[i:idx[i], ], path, row.names = FALSE)
    } else {
      write.table(M[(idx[i - 1] + 1):idx[i], ], path, row.names = FALSE)
    }
  }
}