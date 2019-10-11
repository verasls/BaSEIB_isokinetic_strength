import glob
import numpy as np
import matplotlib.pyplot as plt

files_raw_60gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
files_raw_60gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
files_raw_60gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
files_raw_60gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))

data = np.loadtxt(files_raw_60gs_1st[0], skiprows=6)
time = data[:, 0]
torque = data[:, 1]

fig = plt.figure()
f1 = fig.add_subplot(1, 1, 1)
f1.plot(time, torque)
f1.set_xlabel("Time (ms)")
f1.set_ylabel("Torque (Nm)")
plt.show()
