import numpy as np
import glob
import matplotlib.pyplot as plt

files_raw_60gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
data = np.loadtxt(files_raw_60gs_1st[0], skiprows=6)


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


def plot_divisions(file):
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
    plt.plot(data[:, 0], data[:, 1])
    plt.xlabel("Time (ms)")
    plt.ylabel("Torque (Nm)")
    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        plt.axvline(x=idx_time[i], color="k")
    plt.show()
