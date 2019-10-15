import glob
from processing import find_divisions, plot_divisions

files_raw_60gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
files_raw_60gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
files_raw_60gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
files_raw_60gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))

idx = find_divisions(files_raw_60gs_1st[0])
print("Indexes are:", idx)
print("The idx vector length is:", len(idx))
print("The last index is:", idx[len(idx) - 1])

plot_divisions(files_raw_60gs_1st[0])
