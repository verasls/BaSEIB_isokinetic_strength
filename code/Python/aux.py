import numpy as np
import os
import csv
from datetime import date


def set_plot_title(path):
    # Set plot title
    if ("1st" in path) is True:
        evaluation = "1st eval"
    elif ("2nd" in path) is True:
        evaluation = "2nd eval"
    elif ("3rd" in path) is True:
        evaluation = "3rd eval"
    elif ("4th" in path) is True:
        evaluation = "4th eval"

    if "corrected" in path:
        subject = " ID " + path[-17:-14]
    else:
        subject = " ID " + path[-7:-4]

    if ("knee" in path) is True:
        location = " - knee "
    elif ("trunk" in path) is True:
        location = " - trunk "

    if ("60gs" in path) is True:
        speed = "60°/s"
    elif ("120gs" in path) is True:
        speed = "120°/s"
    elif ("180gs" in path) is True:
        speed = "180°/s"

    title = evaluation + subject + location + speed

    return(title)


def set_path_to_save(path):
    # Set path to save plot
    if ("knee" in path) is True:
        path_to_save = "output/knee/"
    elif ("trunk" in path) is True:
        path_to_save = "output/trunk/"
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

    return(path_to_save)


def remove_ID(filelist, ID_num):
    """
    Remove an ID from the files list

    Args:
        filelist: a list of paths to the files
        ID_num: a character string indicating the subject ID to be removed
        (3 digits format)

    Returns:
        The filelist without the path to the file of the removed ID
    """
    remove = filelist[0]
    remove = remove[:-7]
    remove = remove + ID_num + ".txt"

    filelist.remove(remove)

    return(filelist)


def correct_angle(filelist, ID_num, operation):
    """
    Correct the anatomical position angle

    Args:
        filelist: a list of paths to the files
        ID_num: a character string indicating the subject ID to be removed
        (3 digits format)
        operation: mathematical operation needed to correct the angle

    Returns:
        Saves the corrected data into a file ending with "_corrected.txt"
        The filelist with the corrected file instead of the old file
    """
    # Get path to file
    ID_idx = []
    for i in range(0, len(filelist)):
        if (ID_num in filelist[i]) is True:
            ID_idx = i
    path = filelist[ID_idx]

    if ("_corrected" in path) is False:
        # Read data
        data = np.loadtxt(path, skiprows=6)
        angle = abs(data[:, 3])

        # Correct POS (ANAT) values and substitute in the ndarray
        angle = abs(angle + operation)
        data[:, 3] = angle

        # Save corrected file
        path = path[:-4] + "_corrected.txt"
        np.savetxt(path, data, delimiter=" ", fmt="%f")

        # Substitute the old file for the corrected file in the filelist
        filelist[ID_idx] = path

    return(filelist)


def save_idx(path, idx, manual_selection):
    """
    Save the division point indices in a csv file, along with other
    informations, as the subject ID, date of analysis, type of analysis
    (whether automatic or manual), and number of indices.

    Args:
        path: A character string with the path to the file containing
            isokinetic strength test data.
        idx: A list of intergers with the division points indices, preferably
            from the find_divisions() of add_divisions() functions.
        manual_selection: A character string, either "y" or "n", from an input
            to the plot_divisions() function.

    Returns:
        Save the division point indices along with other informations in a csv
        file.
    """
    # Set path to save the indices
    if ("knee" in path) is True:
        path_to_save = "output/knee/"
    elif ("trunk" in path) is True:
        path_to_save = "output/trunk/"

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
