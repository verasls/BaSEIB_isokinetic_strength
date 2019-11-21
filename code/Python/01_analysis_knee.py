import glob
from proiks import *

# Get path to raw files
# Knee 60°/s
knee_raw_60gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
knee_raw_60gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
knee_raw_60gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
knee_raw_60gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))
# Knee 180°/s
knee_raw_180gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
knee_raw_180gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
knee_raw_180gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
knee_raw_180gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))
# Trunk 60°/s
trunk_raw_60gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
trunk_raw_60gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
trunk_raw_60gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
trunk_raw_60gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))
# Trunk 120°/s
trunk_raw_120gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
trunk_raw_120gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
trunk_raw_120gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
trunk_raw_120gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))

idx = find_divisions(files_knee_raw_60gs_1st[2])
idx = plot_divisions(files_knee_raw_60gs_1st[2], idx)
