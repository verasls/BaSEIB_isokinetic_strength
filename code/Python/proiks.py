import numpy as np
import matplotlib
matplotlib.use('MacOSX')
import matplotlib.pyplot as plt
from matplotlib.widgets import Cursor
import os
import csv
from datetime import date


def find_divisions(path):
    """
    Find division points between half repetitions by zero crossings on the 
    velocity signal

    Args:
        path: a character string with the path to the file containing 
            isokinetic strength test data

    Returns:
        A list of intergers with the division points indices
    """
    # Read data
    data = np.loadtxt(path, skiprows=6)
    
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
        # If product is 0, at least one of the velocity values is 0
        # Mark where velocity is 0 as index
        elif velocity[i - 1] * velocity[i] == 0:
            if velocity[i - 1] == 0:
                idx.append(i - 1)
            elif velocity[i] == 0:
                idx.append(i)

    # Keep only first index value where indices are consecutive
    c = []  # Vector indicating the indices to be removed
    for i in range(1, len(idx)):
        if idx[i] - idx[i - 1] == 1:
            c.append(idx[i])
    if len(c) != 0:
        for i in range(0, len(c)):
            idx.remove(c[i])

    # Ensure that idx where velocity is 0 are followed by a sign change
    s = []  # Vector indicating the indices where velocity == 0
    for i in range(0, len(idx)):
        if velocity[idx[i]] == 0:
            s.append(idx[i])
    if len(s) != 0:
        for i in range(0, len(s)):
            f = np.amin(np.where(velocity[s[i]:len(velocity)] != 0)) + s[i]
            if velocity[s[i]] * velocity[f] > 0:
                idx.remove(s[i])

    # Removes duplicates
    idx = sorted(list(set(idx)))
    
    # Keep only idx values where distance between divisions is at least
    # a quarter repetition
    if ("knee" in path and "60gs" in path) is True:
        dist = round(len(velocity) / 16)  # 4 * 4 reps
    if ("knee" in path and "180gs" in path) is True:
        dist = round(len(velocity) / 32)  # 4 * 8 reps
    if ("trunk" in path and "60gs" in path) is True:
        dist = round(len(velocity) / 16)  # 4 * 4 reps
    if ("trunk" in path and "120gs" in path) is True:
        dist = round(len(velocity) / 24)  # 4 * 6 reps

    r = []  # Vector indicating the indices to be removed by the
            # distance criterion
    for i in range(1, len(idx)):
        if idx[i] - idx[i - 1] < dist:
            r.append(idx[i])
    if len(r) != 0:
        for i in range(0, len(r)):
            idx.remove(r[i])

    return(idx)


def plot_divisions(path, idx, saveplot=True, saveidx=True):
    # Read data
    data = np.loadtxt(path, skiprows=6)

    # Ensure 1st velocity value to be positive
    velocity = data[:, 4]
    if velocity[0] <= 0:
        first_positive = np.min(np.where(velocity > 0))
        velocity = velocity[first_positive:]

    # Find time points of velocity zero crossings
    idx_time = []
    for i in range(0, len(idx)):
        idx_time.append(data[idx[i], 0])

    # Plot
    time = data[:, 0]
    torque = data[:, 1]
    velocity = data[:, 4]

    fig1 = plt.figure(figsize=(12, 6))
    ax11 = fig1.add_subplot(1, 1, 1)
    ax21 = ax11.twinx()

    ax11.plot(time, torque, "tab:blue")
    ax21.plot(time, velocity, "tab:orange")

    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        ax11.axvline(x=idx_time[i], color="k", linestyle="dotted")
    
    # Add a horizontal line at torque and velocity = 0
    ax11.axhline(y=0, color="tab:blue", linestyle="dotted")
    ax21.axhline(y=0, color="tab:orange", linestyle="dotted")
    
    ax11.set_xlabel("Time (ms)")
    ax11.set_ylabel("Torque (Nm)", color="tab:blue")
    ax21.set_ylabel("Velocity (°/s)", color="tab:orange")
    
    # Set plot title
    if ("1st" in path) is True:
        evaluation = "1st eval"
    elif ("2nd" in path) is True:
        evaluation = "2nd eval"
    elif ("3rd" in path) is True:
        evaluation = "3rd eval"
    elif ("4th" in path) is True:
        evaluation = "4th eval"
    
    subject = " ID " + path[-7:-4]
    
    if ("knee" in path) is True:
        location = " - knee "
    elif ("trunk" in path) is True:
        location = " - trunk"
    
    if ("60gs" in path) is True:
        speed = "60°/s"
    elif ("120gs" in path) is True:
        speed = "120°/s"
    elif ("180gs" in path) is True:
        speed = "180°/s"

    title = evaluation + subject + location + speed

    plt.title(title + "\n" +
              "Close the plot when done inspecting \n"
              "Division points are marked as vertical black dotted lines")
    fig1.show()

    manual_selection = input("\nDo you want to manually select the "
                             "division points? (y/n)\n")
    while manual_selection not in ("y", "n"):
        print("\nNot a valid input! Please try again\n")
        manual_selection = input("\nDo you want to manually select the "
                                 "division points? (y/n)\n")
    if manual_selection == "y":
        while True:
            try:
                ndivisions = int(input("\nHow many division points "
                                       "do you want to add?\n"))
            except ValueError:
                print("\nInput must be a number! Please try again\n")
            else:
                idx = add_divisions(path, idx, ndivisions, saveplot)
                break
    elif manual_selection == "n":
        print("\nThe division points will not be altered\n")
        
        if saveplot is True:
            # Set path to save plot
            if ("knee" in path) is True:
                path_to_save = "data/python/knee/"
            elif ("trunk" in path) is True:
                path_to_save = "data/python/trunk/"
            
            if ("60gs" in path) is True:
                path_to_save = path_to_save + "60gs/"
            elif ("120gs" in path) is True:
                path_to_save = path_to_save + "120gs/"
            elif ("180gs" in path) is True:
                path_to_save = path_to_save + "180gs/"
            
            if ("1st" in path) is True:
                path_to_save = path_to_save + "1st_eval/plots/"
            elif ("2nd" in path) is True:
                path_to_save = path_to_save + "2nd_eval/plots/"
            elif ("3rd" in path) is True:
                path_to_save = path_to_save + "3rd_eval/plots/"
            elif ("4th" in path) is True:
                path_to_save = path_to_save + "4th_eval/plots/"
            
            if ("knee" in path) is True:
                if ("60gs" in path) is True:
                    path_to_save = path_to_save + path[28:-4] + "_plot.pdf"
                elif ("180gs" in path) is True:
                    path_to_save = path_to_save + path[29:-4] + "_plot.pdf"
            elif ("trunk" in path) is True:
                if ("60gs" in path) is True:
                    path_to_save = path_to_save + path[29:-4] + "_plot.pdf"
                elif ("120gs" in path) is True:
                    path_to_save = path_to_save + path[30:-4] + "_plot.pdf"

            fig2 = plt.figure(figsize=(12, 6))
            ax21 = fig2.add_subplot(1, 1, 1)
            ax22 = ax21.twinx()
            ax21.plot(time, torque, "tab:blue")
            ax22.plot(time, velocity, "tab:orange")
            for i in range(0, len(idx_time)):
                ax21.axvline(x=idx_time[i], color="k", linestyle="dotted")
            ax21.axhline(y=0, color="tab:blue", linestyle="dotted")
            ax22.axhline(y=0, color="tab:orange", linestyle="dotted")
            ax21.set_xlabel("Time (ms)")
            ax21.set_ylabel("Torque (Nm)", color="tab:blue")
            ax22.set_ylabel("Velocity (°/s)", color="tab:orange")
            plt.title(title + "\n" + "Code-defined division points")
            plt.savefig(path_to_save)
            print("\nPlot saved")

    if saveidx is True:
        save_idx(path, idx, manual_selection)
        print("\nDivision points indices saved")
    
    plt.close("all")
    return(idx)


def add_divisions(path, idx, ndivisions, saveplot=True):
    # Read data
    data = np.loadtxt(path, skiprows=6)

    # Ensure 1st velocity value to be positive
    velocity = data[:, 4]
    if velocity[0] <= 0:
        first_positive = np.min(np.where(velocity > 0))
        velocity = velocity[first_positive:]

    # Find time points of velocity zero crossings
    idx_time = []
    for i in range(0, len(idx)):
        idx_time.append(data[idx[i], 0])

    # Plot
    time = data[:, 0]
    torque = data[:, 1]
    velocity = data[:, 4]

    fig1 = plt.figure(figsize=(12, 6))
    ax11 = fig1.add_subplot(1, 1, 1)
    ax21 = ax11.twinx()

    ax11.plot(time, torque, "tab:blue")
    ax21.plot(time, velocity, "tab:orange")

    # Add vertical black lines in the division points
    for i in range(0, len(idx_time)):
        ax11.axvline(x=idx_time[i], color="k", linestyle="dotted")
    
    # Add a horizontal line at torque and velocity = 0
    ax11.axhline(y=0, color="tab:blue", linestyle="dotted")
    ax21.axhline(y=0, color="tab:orange", linestyle="dotted")
    
    ax11.set_xlabel("Time (ms)")
    ax11.set_ylabel("Torque (Nm)", color="tab:blue")
    ax21.set_ylabel("Velocity (°/s)", color="tab:orange")

    # Set plot title
    if ("1st" in path) is True:
        evaluation = "1st eval"
    elif ("2nd" in path) is True:
        evaluation = "2nd eval"
    elif ("3rd" in path) is True:
        evaluation = "3rd eval"
    elif ("4th" in path) is True:
        evaluation = "4th eval"
    
    subject = " ID " + path[-7:-4]
    
    if ("knee" in path) is True:
        location = " - knee "
    elif ("trunk" in path) is True:
        location = " - trunk"
    
    if ("60gs" in path) is True:
        speed = "60°/s"
    elif ("120gs" in path) is True:
        speed = "120°/s"
    elif ("180gs" in path) is True:
        speed = "180°/s"

    title = evaluation + subject + location + speed

    plt.title(title + "\n" + "Click on the plot to select the "
              "half-repetitions division poins")
    
    # Use the cursor to manually select the division points
    cursor = Cursor(ax21, useblit=True, color="k", linewidth=1)

    new_idx = []
    for i in range(0, ndivisions):
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
    fig2 = plt.figure(figsize=(12, 6))
    ax12 = fig2.add_subplot(1, 1, 1)
    ax22 = ax12.twinx()

    ax12.plot(time, torque, "tab:blue")
    ax22.plot(time, velocity, "tab:orange")

    # Add vertical black lines in the manually selected division points
    for i in range(0, len(new_idx)):
        ax12.axvline(x=new_idx[i], color="k", linestyle="dotted")

    # Add a horizontal line at torque and velocity = 0
    ax12.axhline(y=0, color="tab:blue", linestyle="dotted")
    ax22.axhline(y=0, color="tab:orange", linestyle="dotted")
    
    ax12.set_xlabel("Time (ms)")
    ax12.set_ylabel("Torque (Nm)", color="tab:blue")
    ax22.set_ylabel("Velocity (°/s)", color="tab:orange")
    plt.title(title + "\n" + "User-defined division points")
    
    if saveplot is True:
        if saveplot is True:
            # Set path to save plot
            if ("knee" in path) is True:
                path_to_save = "data/python/knee/"
            elif ("trunk" in path) is True:
                path_to_save = "data/python/trunk/"
            
            if ("60gs" in path) is True:
                path_to_save = path_to_save + "60gs/"
            elif ("120gs" in path) is True:
                path_to_save = path_to_save + "120gs/"
            elif ("180gs" in path) is True:
                path_to_save = path_to_save + "180gs/"
            
            if ("1st" in path) is True:
                path_to_save = path_to_save + "1st_eval/plots/"
            elif ("2nd" in path) is True:
                path_to_save = path_to_save + "2nd_eval/plots/"
            elif ("3rd" in path) is True:
                path_to_save = path_to_save + "3rd_eval/plots/"
            elif ("4th" in path) is True:
                path_to_save = path_to_save + "4th_eval/plots/"
            
            if ("knee" in path) is True:
                if ("60gs" in path) is True:
                    path_to_save = path_to_save + path[28:-4] + "_plot.pdf"
                elif ("180gs" in path) is True:
                    path_to_save = path_to_save + path[29:-4] + "_plot.pdf"
            elif ("trunk" in path) is True:
                if ("60gs" in path) is True:
                    path_to_save = path_to_save + path[29:-4] + "_plot.pdf"
                elif ("120gs" in path) is True:
                    path_to_save = path_to_save + path[30:-4] + "_plot.pdf"

        plt.savefig(path_to_save)
        print("\nPlot saved\n")
    
    plt.show()


    # new_idx is an array with the time values of the division points, while
    # idx is contains the array indices. Thus, new_idx needs to be transformed
    # to contain the array indices as well.
    time_list = time.tolist()
    for i in range(0, len(new_idx)):
        new_idx[i] = time_list.index(new_idx[i])

    return(new_idx)


def save_idx(path, idx, manual_selection):
    # Set path to save the indices
    if ("knee" in path) is True:
        path_to_save = "data/python/knee/"
    elif ("trunk" in path) is True:
        path_to_save = "data/python/trunk/"
    
    if ("60gs" in path) is True:
        path_to_save = path_to_save + "60gs/"
    elif ("120gs" in path) is True:
        path_to_save = path_to_save + "120gs/"
    elif ("180gs" in path) is True:
        path_to_save = path_to_save + "180gs/"
    
    if ("1st" in path) is True:
        path_to_save = path_to_save + "1st_eval/"
    elif ("2nd" in path) is True:
        path_to_save = path_to_save + "2nd_eval/"
    elif ("3rd" in path) is True:
        path_to_save = path_to_save + "3rd_eval/"
    elif ("4th" in path) is True:
        path_to_save = path_to_save + "4th_eval/"
    
    path_to_save = path_to_save + "division_points_idx.csv"

    # Get variables to write the file
    ID_num = path[-7:-4]
    today = date.today()
    idx_type = []
    if manual_selection == "y":
        idx_type = "manual"
    elif manual_selection == "n":
        idx_type = "automatic"
    idx = idx

    # Write the csv file
    file_exists = os.path.isfile(path_to_save)
    if file_exists is False:
        # Create file heading
        heading = [["ID", "date", "selection_type", "n_idx", "idx"]]
        idx_file = open(path_to_save, "w")
        with idx_file:
            writer = csv.writer(idx_file)
            writer.writerows(heading)

        # Write data
        idx_data = [[ID_num, today, idx_type, len(idx), idx]]
        idx_file = open(path_to_save, "a")
        with idx_file:
            writer = csv.writer(idx_file)
            writer.writerows(idx_data)
    elif file_exists is True:   
        # Write data
        idx_data = [[ID_num, today, idx_type, len(idx), idx]]
        idx_file = open(path_to_save, "a")
        with idx_file:
            writer = csv.writer(idx_file)
            writer.writerows(idx_data)
