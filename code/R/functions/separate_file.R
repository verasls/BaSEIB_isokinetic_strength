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
  source("R/functions/read_strength_data.R")
  source("R/functions/find_divisions.R")
  
  print(
    str_c(
      "File: ",
      if (str_detect(file, "knee")) {
        str_c(
          if (str_detect(file, "60g")) {
            str_sub(file, 29, str_length(file))
          } else {
            if (str_detect(file, "180g")) {
              str_sub(file, 30, str_length(file))
            }
          }
        ) 
      } else {
        if (str_detect(file, "trunk")) {
          str_c(
            if (str_detect(file, "60g")) {
              str_sub(file, 30, str_length(file))
            } else {
              if (str_detect(file, "120g")) {
                str_sub(file, 31, str_length(file))
              }
            }
          )
        }
      }
    ) 
  ) 
  
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
        "data/processed/",
        if (str_detect(file, "knee")) {
          "knee/"
        } else {
          if (str_detect(file, "trunk")) {
            "trunk/"
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
        "separate_reps/"
      ),
      if (str_detect(file, "knee")) {
        str_replace(
          if (str_detect(file, "60g")) {
            str_sub(file, 29, str_length(file) - 4)
          } else {
            if (str_detect(file, "180g")) {
              str_sub(file, 30, str_length(file) - 4)
            }
          },
          "raw_", ""
        )
      } else {
        if (str_detect(file, "trunk")) {
          str_replace(
            if (str_detect(file, "60g")) {
              str_sub(file, 30, str_length(file) - 4)
            } else {
              if (str_detect(file, "120g")) {
                str_sub(file, 31, str_length(file) - 4)
              }
            },
            "raw_", ""
          )  
        }
      },
      if (str_detect(file, "knee")) {
        if (i %% 2 != 0) {
          str_c("_ext_", (i + 1) / 2, ".txt")
        } else {
          if (i %% 2 == 0) {
            str_c("_fle_", i / 2, ".txt")
          }
        }
      } else {
        if (str_detect(file, "trunk")) {
          if (i %% 2 != 0) {
            str_c("_fle_", (i + 1) / 2, ".txt")
          } else {
            if (i %% 2 == 0) {
              str_c("_ext_", i / 2, ".txt")
            }
          }
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