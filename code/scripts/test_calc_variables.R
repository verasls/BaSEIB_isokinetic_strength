# Load packages
library(tidyverse)
source("code/functions/work.R")

# Read data
ext <- read_csv("data/4th_055_knee_60gs_ext.csv")
flx <- read_csv("data/4th_055_knee_60gs_flx.csv")

# Compute variables
peak_torque <- max(ext$abs.Torque_NM)
peak_torque_BW <- peak_torque / 59.5 # subject body weight (kg)
time_peak_torque <- ext$Time_mSec[which(ext$abs.Torque_NM == peak_torque)] - ext$Time_mSec[1]
angle_peak_torque <- ext$POS_Anat_Degrees[which(ext$abs.Torque_NM == peak_torque)]
torque_0.18seg <- ext$Torque_NM[which(ext$Time_mSec == (ext$Time_mSec[1] + 180))] # needs some adjustment 
work <- work(ext)