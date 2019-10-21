import numpy as np
import matplotlib.pyplot as plt


def find_divisions(file):
    data = np.loadtxt(file, skiprows=6)

    # Ensure 1st velocity value to be positive
    if data[0, 4] <= 0:
        first_positive = np.min(np.where(data[:, 4] > 0))
        data = data[first_positive:, :]

    # Find zero crossings in velocity signal
    idx = []  # Division points indices
    for i in range(1, data.shape[0] - 1):
        # If product < 0, it means different signs
        if data[i - 1, 4] * data[i, 4] < 0:
            idx.append(i)

    return(idx)


def plot_divisions(file, hline=None):
    data = np.loadtxt(file, skiprows=6)

    # Ensure 1st velocity value to be positive
    if data[0, 4] <= 0:
        first_positive = np.min(np.where(data[:, 4] > 0))
        data = data[first_positive:, :]

    idx = find_divisions(file)

    # Exclude region after the last idx
    data = data[0:idx[len(idx) - 1] + 1, :]

    # Find time points of velocity zero crossings
    idx_time = []
    for i in range(0, len(idx)):
        idx_time.append(data[idx[i], 0])

    # Plot
    time = data[:, 0]
    torque = data[:, 1]
    velocity = data[:, 4]

    fig, ax1 = plt.subplots()
    ax2 = ax1.twinx()

    ax1.plot(time, torque, "b-")
    ax2.plot(time, velocity, "r-")

    ax1.set_xlabel("Time (ms)")
    ax1.set_ylabel("Torque (Nm)", color="b")
    ax2.set_ylabel("Velocity (m/s)", color="r")
    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        ax1.axvline(x=idx_time[i], color="k")
    if hline is True:
        # Add a horizontal line in velocity = 0
        ax2.axhline(y=0, color="r")
    plt.show()
