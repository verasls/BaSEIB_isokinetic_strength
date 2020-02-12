import glob
import numpy as np
import matplotlib.pyplot as plt

# Get path to raw files
# Knee 60°/s
knee_60_1st = sorted(glob.glob("../../data/raw/knee/60gs/1st_eval/*.txt"))
knee_60_2nd = sorted(glob.glob("../../data/raw/knee/60gs/2nd_eval/*.txt"))
knee_60_3rd = sorted(glob.glob("../../data/raw/knee/60gs/3rd_eval/*.txt"))
knee_60_4th = sorted(glob.glob("../../data/raw/knee/60gs/4th_eval/*.txt"))
# Knee 180°/s
knee_180_1st = sorted(glob.glob("../../data/raw/knee/180gs/1st_eval/*.txt"))
knee_180_2nd = sorted(glob.glob("../../data/raw/knee/180gs/2nd_eval/*.txt"))
knee_180_3rd = sorted(glob.glob("../../data/raw/knee/180gs/3rd_eval/*.txt"))
knee_180_4th = sorted(glob.glob("../../data/raw/knee/180gs/4th_eval/*.txt"))
# Trunk 60°/s
trunk_60_1st = sorted(glob.glob("../../data/raw/trunk/60gs/1st_eval/*.txt"))
trunk_60_2nd = sorted(glob.glob("../../data/raw/trunk/60gs/2nd_eval/*.txt"))
trunk_60_3rd = sorted(glob.glob("../../data/raw/trunk/60gs/3rd_eval/*.txt"))
trunk_60_4th = sorted(glob.glob("../../data/raw/trunk/60gs/4th_eval/*.txt"))
# Trunk 120°/s
trunk_120_1st = sorted(glob.glob("../../data/raw/trunk/120gs/1st_eval/*.txt"))
trunk_120_2nd = sorted(glob.glob("../../data/raw/trunk/120gs/2nd_eval/*.txt"))
trunk_120_3rd = sorted(glob.glob("../../data/raw/trunk/120gs/3rd_eval/*.txt"))
trunk_120_4th = sorted(glob.glob("../../data/raw/trunk/120gs/4th_eval/*.txt"))

# Read data
filename = trunk_60_1st[0]
data = np.loadtxt(filename, skiprows=6)
time = data[:, 0]
angle = data[:, 3]

# Plot
fig1 = plt.figure(figsize=(12, 6))
ax = fig1.add_subplot(1, 1, 1)
ax.plot(time, angle)
plt.title(filename[35:])
plt.show()
