import numpy as np
import matplotlib
matplotlib.use('Tkagg')
import matplotlib.pyplot as plt
from matplotlib.widgets import Cursor
import plotgui

def read_strength_data(file):
    """Reads isokinetic strength test data

    Args:
        file: Path to isokinetic strength test file

    Returns:
        The isokinetic strength data as a numpy array.
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

    # Find time points of velocity zero crossings
    idx_time = []
    for i in range(0, len(idx)):
        idx_time.append(data[idx[i], 0])

    # Plot
    time = data[:, 0]
    torque = data[:, 1]
    velocity = data[:, 4]

    fig1 = plt.figure(figsize=(15, 7))
    ax11 = fig1.add_subplot(1, 1, 1)
    ax21 = ax11.twinx()

    ax11.plot(time, torque, "tab:blue")
    ax21.plot(time, velocity, "tab:orange")

    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        ax11.axvline(x=idx_time[i], color="k", linestyle="dotted")
    
    # Add a horizontal line at velocity == 0
    if hline is True:
        ax21.axhline(y=0, color="k", linestyle="dotted")
    elif hline is False:
        pass
    else:
        raise ValueError("hline parameter can only be True or False")

    ax11.set_xlabel("Time (ms)")
    ax11.set_ylabel("Torque (Nm)", color="tab:blue")
    ax21.set_ylabel("Velocity (m/s)", color="tab:orange")
    plt.title("Click on the plot to select the half-repetitions division poins")
    plt.show()

    answer = plotgui.make_changes()
    if answer is True:
        select_divisions(data)


def select_divisions(data, hline=True):
    # Ensure 1st velocity value to be positive
    velocity = data[:, 4]
    if velocity[0] <= 0:
        first_positive = np.min(np.where(velocity > 0))
        velocity = velocity[first_positive:]

    idx = find_divisions(data)

    # Find time points of velocity zero crossings
    idx_time = []
    for i in range(0, len(idx)):
        idx_time.append(data[idx[i], 0])

    # Plot
    time = data[:, 0]
    torque = data[:, 1]
    velocity = data[:, 4]

    fig1 = plt.figure(figsize=(15, 7))
    ax11 = fig1.add_subplot(1, 1, 1)
    ax21 = ax11.twinx()

    ax11.plot(time, torque, "tab:blue")
    ax21.plot(time, velocity, "tab:orange")

    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        ax11.axvline(x=idx_time[i], color="k", linestyle="dotted")
    
    # Add a horizontal line at velocity == 0
    if hline is True:
        ax21.axhline(y=0, color="k", linestyle="dotted")
    elif hline is False:
        pass
    else:
        raise ValueError("hline parameter can only be True or False")

    ax11.set_xlabel("Time (ms)")
    ax11.set_ylabel("Torque (Nm)", color="tab:blue")
    ax21.set_ylabel("Velocity (m/s)", color="tab:orange")
    plt.title("Click on the plot to select the half-repetitions division poins")
    
    # Use the cursor to manually select the division points
    cursor = Cursor(ax21, useblit=True, color="k", linewidth=1)

    new_idx = []
    for i in range(0, 8):
        coords = plt.ginput(n=1, timeout=0, show_clicks=False)
        x, y = coords[0]
        ax21.axvline(x=x, color="r")
        new_idx.append(x)
    new_idx = np.array(new_idx, dtype=int)
    # new_idx is an array with the time values of the division points. The
    # column in the data array is formated to have only multiples of 10.
    # new_idx must, then, be formatted to attend this criterion.
    for i in range(0, len(new_idx)):
        last_digit = new_idx[i] % 10
        if last_digit < 5:
            new_idx[i] = new_idx[i] - last_digit
        elif last_digit >= 5:
            new_idx[i] = new_idx[i] + (10 - last_digit)
    new_idx = new_idx.tolist()

    # Plot the manually selected division points
    fig2 = plt.figure(figsize=(15, 7))
    ax12 = fig2.add_subplot(1, 1, 1)
    ax22 = ax12.twinx()

    ax12.plot(time, torque, "tab:blue")
    ax22.plot(time, velocity, "tab:orange")

    # Add vertical black lines in the manually selected division points
    for i in range(0, len(new_idx)):
        ax12.axvline(x=new_idx[i], color="k", linestyle="dotted")

    # Add a horizontal line at velocity == 0
    if hline is True:
        ax22.axhline(y=0, color="k", linestyle="dotted")
    elif hline is False:
        pass
    else:
        raise ValueError("hline parameter can only be True or False")

    ax12.set_xlabel("Time (ms)")
    ax12.set_ylabel("Torque (Nm)", color="tab:blue")
    ax22.set_ylabel("Velocity (m/s)", color="tab:orange")
    plt.title("User-defined division points")

    plt.show()

    # new_idx is an array with the time values of the division points, while
    # idx is contains the array indices. Thus, new_idx needs to be transformed
    # to contain the array indices as well.
    time_list = time.tolist()
    for i in range(0, len(new_idx)):
        new_idx[i] = time_list.index(new_idx[i])

    return(new_idx)
