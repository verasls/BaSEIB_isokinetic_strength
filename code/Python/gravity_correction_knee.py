import numpy as np
import math
from process import *

path = "../../data/tests/biodex/"

# Get data (NO FORCE APPLIED)
filename = "knee_isokinetic_60ds_without_gravitational_correction_lucas.txt"
file = path + filename

data = np.loadtxt(file, skiprows=6)
time = data[:, 0]
torque = data[:, 1]
velocity = data[:, 4]
angle = abs(data[:, 3])

# Set torque  and velocity to show only the knee flexion as positive values
# Invert signal
torque = torque * -1
velocity = velocity * -1
# Set to 0 every negative torque
for i in range(0, len(torque)):
    if torque[i] < 0:
        torque[i] = 0
    if velocity[i] < 0:
        velocity[i] = 0

# Gravity torque vars (needs input)
torque_limb = 20
angle_limb = 7

angle_c = 90 - angle
angle_c = angle_c * (math.pi / 180)
angle_limb = (90 - angle_limb) * (math.pi / 180)
torque_limb = torque_limb / np.sin(angle_limb)

Tg = torque_limb * np.sin(angle_c)

Tc = np.empty(shape=torque.shape, dtype='object')
Tc = torque - Tg

# Plot
fig1 = plt.figure(figsize=(18, 9))
ax11 = fig1.add_subplot(2, 1, 1)
ax12 = fig1.add_subplot(2, 1, 2)
# Add a multicursor to all subplotsg
multi = MultiCursor(fig1.canvas, (ax11, ax12), color="k", linewidth=1)
multi

ax11.plot(time, torque, color="tab:blue", label="Torque (Nm)")
ax11.plot(time, velocity, color="tab:orange", label="Velocity (°/s)")
ax11.plot(time, Tc, color="tab:red", label="Torque corrected (Nm)")
ax12.plot(time, angle, color="tab:green", label="Anatomical position (°)")

ax11.legend(loc="upper right")
ax12.legend(loc="upper right")

# Add a horizontal line at torque and velocity = 0
ax11.axhline(y=0, color="tab:blue", linestyle="dotted")
# Add horizontal lines at the selected isokinetic velocity
ax11.axhline(y=60, color="tab:orange", linestyle="dotted")

ax11.set_title("Knee flexion - No force applied")
plt.tight_layout()

# Get data (FORCE APPLIED)
filename_2 = "Lucas_Knee_Isocinetic_without graviatational correction.txt"
file_2 = path + filename_2

data_2 = np.loadtxt(file_2, skiprows=6)
time_2 = data_2[:, 0]
torque_2 = data_2[:, 1]
velocity_2 = data_2[:, 4]
angle_2 = abs(data_2[:, 3])

# Set torque  and velocity to show only the knee flexion as positive values
# Invert signal
torque_2 = torque_2 * -1
velocity_2 = velocity_2 * -1
# Set to 0 every negative torque
for i in range(0, len(torque_2)):
    if torque_2[i] < 0:
        torque_2[i] = 0
    if velocity_2[i] < 0:
        velocity_2[i] = 0

# Gravity torque vars
angle_c_2 = 90 - angle_2
angle_c_2 = angle_c_2 * (math.pi / 180)

Tg_2 = torque_limb * np.sin(angle_c_2)

Tc_2 = np.empty(shape=torque_2.shape, dtype='object')
Tc_2 = torque_2 - Tg_2

# Plot
fig2 = plt.figure(figsize=(18, 9))
ax21 = fig2.add_subplot(2, 1, 1)
ax22 = fig2.add_subplot(2, 1, 2)
# Add a multicursor to all subplotsg
multi = MultiCursor(fig2.canvas, (ax21, ax22), color="k", linewidth=1)
multi

ax21.plot(time_2, torque_2, color="tab:blue", label="Torque (Nm)")
ax21.plot(time_2, velocity_2, color="tab:orange", label="Velocity (°/s)")
ax21.plot(time_2, Tc_2, color="tab:red", label="Torque corrected (Nm)")
ax22.plot(time_2, angle_2, color="tab:green", label="Anatomical position (°)")

ax21.legend(loc="upper right")
ax22.legend(loc="upper right")

# Add a horizontal line at torque and velocity = 0
ax21.axhline(y=0, color="tab:blue", linestyle="dotted")
# Add horizontal lines at the selected isokinetic velocity
ax21.axhline(y=60, color="tab:orange", linestyle="dotted")

ax21.set_title("Knee flexion - Force applied")
plt.tight_layout()
plt.show()
