import numpy as np
import matplotlib.pyplot as plt

def read_strength_data(file):
    """Reads isokinetic strength test data

    Args:
        file: Path to isokinetic strength test file

    Returns:
        The isokinetic strength data as a numpy array.
        Col 0: time (ms)
        Col 1: torque (Nm)
        Col 2: position (°)
        Col 3: anatomic position (°)
        Col 4: velocity (°s-1)
    """

    data = np.loadtxt(file, skiprows=6)
    return(data)


def find_divisions(data):
    # Ensure 1st velocity value to be positive
    velocity = data[:, 4]
    if velocity[0] <= 0:
        first_positive = np.min(np.where(velocity > 0))
        velocity = velocity[first_positive:]

    # Find zero crossings in velocity signal
    idx = []  # Division points indices
    for i in range(1, len(velocity)):
        # If product < 0, it means different signs
        if velocity[i - 1] * velocity[i] < 0:
            idx.append(i)

    return(idx)


def plot_divisions(data, hline=True):
    # Ensure 1st velocity value to be positive
    velocity = data[:, 4]
    if velocity[0] <= 0:
        first_positive = np.min(np.where(velocity > 0))
        velocity = velocity[first_positive:]

    idx = find_divisions(data)

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

    fig = plt.figure(figsize=(15, 7))
    ax1 = fig.add_subplot(1, 1, 1)
    ax2 = ax1.twinx()

    ax1.plot(time, torque, "tab:blue")
    ax2.plot(time, velocity, "tab:orange")

    ax1.set_xlabel("Time (ms)")
    ax1.set_ylabel("Torque (Nm)", color="tab:blue")
    ax2.set_ylabel("Velocity (m/s)", color="tab:orange")
    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        ax1.axvline(x=idx_time[i], color="k", linestyle="dotted")
    if hline is True:
        # Add a horizontal line in velocity = 0
        ax2.axhline(y=0, color="k", linestyle="dotted")
    elif hline is False:
        pass
    else:
        raise ValueError("hline parameter can only be True or False")

    plt.show(block=False)
