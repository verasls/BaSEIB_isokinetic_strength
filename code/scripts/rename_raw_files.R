# This script renames the isokinetic strength raw files from they original name
# to a name more suitable for the analysis

library(stringr)

# Knee --------------------------------------------------------------------
# ** For 60gs -------------------------------------------------------------
knee_filenames_60_1 <- list.files(path = "data/raw/knee/60gs/1st_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_60_1)) {
  new_filename <- knee_filenames_60_1[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 57) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_60_1[i], new_filename)
}

knee_filenames_60_2 <- list.files(path = "data/raw/knee/60gs/2nd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_60_2)) {
  new_filename <- knee_filenames_60_2[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 57) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_60_2[i], new_filename)
}

knee_filenames_60_3 <- list.files(path = "data/raw/knee/60gs/3rd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_60_3)) {
  new_filename <- knee_filenames_60_3[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 57) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_60_3[i], new_filename)
}

knee_filenames_60_4 <- list.files(path = "data/raw/knee/60gs/4th_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_60_4)) {
  new_filename <- knee_filenames_60_4[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 57) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_60_4[i], new_filename)
}

# ** For 180gs ------------------------------------------------------------
knee_filenames_180_1 <- list.files(path = "data/raw/knee/180gs/1st_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_180_1)) {
  new_filename <- knee_filenames_180_1[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_180_1[i], new_filename)
}

knee_filenames_180_2 <- list.files(path = "data/raw/knee/180gs/2nd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_180_2)) {
  new_filename <- knee_filenames_180_2[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_180_2[i], new_filename)
}

knee_filenames_180_3 <- list.files(path = "data/raw/knee/180gs/3rd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_180_3)) {
  new_filename <- knee_filenames_180_3[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_180_3[i], new_filename)
}

knee_filenames_180_4 <- list.files(path = "data/raw/knee/180gs/4th_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(knee_filenames_180_4)) {
  new_filename <- knee_filenames_180_4[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(knee_filenames_180_4[i], new_filename)
}

# Trunk -------------------------------------------------------------------
# ** For 60gs -------------------------------------------------------------
trunk_filenames_60_1 <- list.files(path = "data/raw/trunk/60gs/1st_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_60_1)) {
  new_filename <- trunk_filenames_60_1[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_60_1[i], new_filename)
}

trunk_filenames_60_2 <- list.files(path = "data/raw/trunk/60gs/2nd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_60_2)) {
  new_filename <- trunk_filenames_60_2[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_60_2[i], new_filename)
}

trunk_filenames_60_3 <- list.files(path = "data/raw/trunk/60gs/3rd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_60_3)) {
  new_filename <- trunk_filenames_60_3[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_60_3[i], new_filename)
}

trunk_filenames_60_4 <- list.files(path = "data/raw/trunk/60gs/4th_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_60_4)) {
  new_filename <- trunk_filenames_60_4[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 59) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_60_4[i], new_filename)
}

# ** For 120gs ------------------------------------------------------------
trunk_filenames_120_1 <- list.files(path = "data/raw/trunk/120gs/1st_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_120_1)) {
  new_filename <- trunk_filenames_120_1[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 61) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_120_1[i], new_filename)
}

trunk_filenames_120_2 <- list.files(path = "data/raw/trunk/120gs/2nd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_120_2)) {
  new_filename <- trunk_filenames_120_2[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 61) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_120_2[i], new_filename)
}

trunk_filenames_120_3 <- list.files(path = "data/raw/trunk/120gs/3rd_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_120_3)) {
  new_filename <- trunk_filenames_120_3[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 61) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_120_3[i], new_filename)
}

trunk_filenames_120_4 <- list.files(path = "data/raw/trunk/120gs/4th_eval", pattern = ".txt", full.names = TRUE)
for (i in 1:length(trunk_filenames_120_4)) {
  new_filename <- trunk_filenames_120_4[i] %>% 
    str_to_lower() %>%
    str_replace_all("__", "_") %>% 
    str_sub(1, 61) %>% 
    str_c(".txt")
  
  file.rename(trunk_filenames_120_4[i], new_filename)
}