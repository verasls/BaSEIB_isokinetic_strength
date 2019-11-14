import glob
from proikd import read_strength_data, plot_divisions

files_raw_60gs_1st = sorted(glob.glob("../../data/raw/knee/60gs/1st_eval/*.txt"))
files_raw_60gs_2nd = sorted(glob.glob("../../data/raw/knee/60gs/2nd_eval/*.txt"))
files_raw_60gs_3rd = sorted(glob.glob("../../data/raw/knee/60gs/3rd_eval/*.txt"))
files_raw_60gs_4th = sorted(glob.glob("../../data/raw/knee/60gs/4th_eval/*.txt"))

data = read_strength_data(files_raw_60gs_1st[2])
idx = plot_divisions(data)
print(idx)
