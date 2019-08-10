source("code/functions/select_ROM.R")
source("code/functions/work_integration.R")
source("code/functions/compute_power.R")

# read body_composition file
B <- read.csv("data/raw/body_composition.csv")

# read isokinetic strength test file
file <- "data/processed/knee/60gs/1st_eval/separate_reps/1st_strength_knee_60g_001_ext_1.txt"

M <- select_ROM(file, 10:80)

# desired variables

peak_torque <- max(abs(M[, 2]))
peak_torque_BW <- peak_torque / B[1, 2]
peak_torque_LW <- peak_torque / B[1, 4]
peak_torque_angle <- unname(M[which(M[, 2] == peak_torque), 4])
total_work <- work_integration(M)
average_power <- compute_power(M)[2]
peak_power <- compute_power(M)[1]

# the following variables need to be computed after all reps are done

max_peak_torque_rep
max_peak_torque_BW_rep
max_peak_torque_LW_rep
max_peak_torque_angle_rep
max_total_work_rep
max_average_power_rep
max_peak_power_rep