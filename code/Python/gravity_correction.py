import glob
import numpy as np
import math
from process import *

files = sorted(glob.glob("../../data/raw/trunk/60gs/4th_eval/*.txt"))
path = files[1]

data = np.loadtxt(path, skiprows=6)
time = data[:, 0]
torque = abs(data[:, 1])
velocity = data[:, 4]
angle = abs(data[:, 3])

# Gravity torque vars
mass = 38.8226699999999
g = 9.81
distance = 0.36
angle_c = abs(data[:, 3]) + 10
angle_c = 90 - angle_c
angle_c = angle_c * (math.pi / 180)

a = np.zeros(torque.shape)

Tg = mass * g * distance * np.sin(angle_c)


Tc = np.empty(shape=torque.shape, dtype='object')
Tc = torque + Tg
for i in range(0, len(torque)):
    if velocity[i] > 0:
        Tc[i] = torque[i] + Tg[i]
    elif velocity[i] < 0:
        Tc[i] = torque[i] - Tg[i]
    elif velocity[i] == 0:
        Tc[i] = torque[i]
Tc = abs(Tc)

# Plot
fig1 = plt.figure(figsize=(18, 9))
ax1 = fig1.add_subplot(2, 1, 1)
ax2 = fig1.add_subplot(2, 1, 2)
# Add a multicursor to all subplotsg
multi = MultiCursor(fig1.canvas, (ax1, ax2), color="k", linewidth=1)
multi

ax1.plot(time, torque, color="tab:blue", label="Torque (Nm)")
ax1.plot(time, velocity, color="tab:orange", label="Velocity (°/s)")
ax1.plot(time, Tg, color="tab:red", label="Torque corrected")
ax2.plot(time, angle, color="tab:green", label="Anatomical position (°)")

ax1.legend(loc="upper right")
ax2.legend(loc="upper right")

# Add a horizontal line at torque and velocity = 0
ax1.axhline(y=0, color="tab:blue", linestyle="dotted")
# Add horizontal lines at the selected isokinetic velocity
ax1.axhline(y=60, color="tab:orange", linestyle="dotted")
ax1.axhline(y=-60, color="tab:orange", linestyle="dotted")

title = set_plot_title(path)

ax1.set_title(title)
plt.tight_layout()
plt.show()
