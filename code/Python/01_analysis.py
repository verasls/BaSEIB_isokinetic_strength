import glob
import sys
import os
from proiks import *

# Get path to raw files
# Knee 60°/s
knee_raw_60gs_1st = sorted(glob.glob("data/raw/knee/60gs/1st_eval/*.txt"))
knee_raw_60gs_2nd = sorted(glob.glob("data/raw/knee/60gs/2nd_eval/*.txt"))
knee_raw_60gs_3rd = sorted(glob.glob("data/raw/knee/60gs/3rd_eval/*.txt"))
knee_raw_60gs_4th = sorted(glob.glob("data/raw/knee/60gs/4th_eval/*.txt"))
# Knee 180°/s
knee_raw_180gs_1st = sorted(glob.glob("data/raw/knee/180gs/1st_eval/*.txt"))
knee_raw_180gs_2nd = sorted(glob.glob("data/raw/knee/180gs/2nd_eval/*.txt"))
knee_raw_180gs_3rd = sorted(glob.glob("data/raw/knee/180gs/3rd_eval/*.txt"))
knee_raw_180gs_4th = sorted(glob.glob("data/raw/knee/180gs/4th_eval/*.txt"))
# Trunk 60°/s
trunk_raw_60gs_1st = sorted(glob.glob("data/raw/trunk/60gs/1st_eval/*.txt"))
trunk_raw_60gs_2nd = sorted(glob.glob("data/raw/trunk/60gs/2nd_eval/*.txt"))
trunk_raw_60gs_3rd = sorted(glob.glob("data/raw/trunk/60gs/3rd_eval/*.txt"))
trunk_raw_60gs_4th = sorted(glob.glob("data/raw/trunk/60gs/4th_eval/*.txt"))
# Trunk 120°/s
trunk_raw_120gs_1st = sorted(glob.glob("data/raw/trunk/120gs/1st_eval/*.txt"))
trunk_raw_120gs_2nd = sorted(glob.glob("data/raw/trunk/120gs/2nd_eval/*.txt"))
trunk_raw_120gs_3rd = sorted(glob.glob("data/raw/trunk/120gs/3rd_eval/*.txt"))
trunk_raw_120gs_4th = sorted(glob.glob("data/raw/trunk/120gs/4th_eval/*.txt"))

# Start data analysis pipeline
print("\nStarting analysis of isokinetic strength raw data\n")

while True:
    try:
        location = int(input("Select whether do you want to analyse data "
                             "from knee or trunk:\n"
                             "1 - Knee\n"
                             "2 - Trunk\n"))
    except ValueError:
        print("\nInput must be a number! Please try again\n")
    else:
        if location not in (1, 2):
            print("\nNot a valid input! Please try again\n")
        else:
            break


if location == 1:
    while True:
        try:
            velocity = int(input("Select from which isokinetic velocity "
                                 "you want to analyse the data:\n"
                                 "1 - 60°/s\n"
                                 "2 - 180°/s\n"))
        except ValueError:
            print("\nInput must be a number! Please try again\n")
        else:
            if velocity not in (1, 2):
                print("\nNot a valid input! Please try again\n")
            else:
                break
elif location == 2:
    while True:
        try:
            velocity = int(input("Select from which isokinetic velocity "
                                 "you want to analyse the data:\n"
                                 "1 - 60°/s\n"
                                 "2 - 120°/s\n"))
        except ValueError:
            print("\nInput must be a number! Please try again\n")
        else:
            if velocity not in (1, 2):
                print("\nNot a valid input! Please try again\n")
            else:
                break

while True:
    try:
        evaluation = int(input("Select from which evaluation moment you "
                               "want to analyse the data:\n"
                               "1 - 1st\n"
                               "2 - 2nd\n"
                               "3 - 3rd\n"
                               "4 - 4th\n"))
    except ValueError:
       print("\nInput must be a number! Please try again\n")
    else:
        if evaluation not in (1, 2, 3, 4):
            print("\nNot a valid input! Please try again\n")
        else:
            break

# Select the list of files to use for the data analysis
if location == 1 and velocity == 1 and evaluation == 1:
    files = knee_raw_60gs_1st
    plot_path = "data/python/knee/60gs/1st_eval/plots"
elif location == 1 and velocity == 1 and evaluation == 2:
    files = knee_raw_60gs_2nd
    plot_path = "data/python/knee/60gs/2nd_eval/plots"
elif location == 1 and velocity == 1 and evaluation == 3:
    files = knee_raw_60gs_3rd
    plot_path = "data/python/knee/60gs/3rd_eval/plots"
elif location == 1 and velocity == 1 and evaluation == 4:
    files = knee_raw_60gs_4th
    plot_path = "data/python/knee/60gs/4th_eval/plots"
elif location == 1 and velocity == 2 and evaluation == 1:
    files = knee_raw_180gs_1st
    plot_path = "data/python/knee/180gs/1st_eval/plots"
elif location == 1 and velocity == 2 and evaluation == 2:
    files = knee_raw_180gs_2nd
    plot_path = "data/python/knee/180gs/2nd_eval/plots"
elif location == 1 and velocity == 2 and evaluation == 3:
    files = knee_raw_180gs_3rd
    plot_path = "data/python/knee/180gs/3rd_eval/plots"
elif location == 1 and velocity == 2 and evaluation == 4:
    files = knee_raw_180gs_4th
    plot_path = "data/python/knee/180gs/4th_eval/plots"
elif location == 2 and velocity == 1 and evaluation == 1:
    files = trunk_raw_60gs_1st
    plot_path = "data/python/trunk/60gs/1st_eval/plots"
elif location == 2 and velocity == 1 and evaluation == 2:
    files = trunk_raw_60gs_2nd
    plot_path = "data/python/trunk/60gs/2nd_eval/plots"
elif location == 2 and velocity == 1 and evaluation == 3:
    files = trunk_raw_60gs_3rd
    plot_path = "data/python/trunk/60gs/3rd_eval/plots"
elif location == 2 and velocity == 1 and evaluation == 4:
    files = trunk_raw_60gs_4th
    plot_path = "data/python/trunk/60gs/4th_eval/plots"
elif location == 2 and velocity == 2 and evaluation == 1:
    files = trunk_raw_120gs_1st
    plot_path = "data/python/trunk/120gs/1st_eval/plots"
elif location == 2 and velocity == 2 and evaluation == 2:
    files = trunk_raw_120gs_2nd
    plot_path = "data/python/trunk/120gs/2nd_eval/plots"
elif location == 2 and velocity == 2 and evaluation == 3:
    files = trunk_raw_120gs_3rd
    plot_path = "data/python/trunk/120gs/3rd_eval/plots"
elif location == 2 and velocity == 2 and evaluation == 4:
    files = trunk_raw_120gs_4th
    plot_path = "data/python/trunk/120gs/4th_eval/plots"

# Create directory structure to save the plots
if not os.path.exists(plot_path):
    os.makedirs(plot_path)

# Get the first file to analyse
while True:
    try:
        first_ID = int(input("From which ID do you want to start the "
                             "data analysis?\n"))
    except ValueError:
        print("\nInput must be a number! Please try again\n")
    else:
        break

# Change first_ID from int to str and format as a three-digit number
first_ID = str(first_ID)
if len(first_ID) == 1:
    first_ID = "00" + first_ID
elif len(first_ID) == 2:
    first_ID = "0" + first_ID

# Get the index in the list of files corresponding to the selected first_ID
first_ID_number = []
for i in range(0, len(files)):
    if (first_ID in files[i]) is True:
        first_ID_number = i

# Preventing program to crash if the selected ID is not in the directory
if isinstance(first_ID_number, list) is True:
    print("\nThere is no ID", first_ID, "in this directory\n")
    first_ID_directory = files[0]
    first_ID_directory = first_ID_directory[-7:-4]
    message1 = "\nThe first ID found is "
    message2 = first_ID_directory
    message3 = "\nDo you want to start analysing it? (y/n)\n"
    message = message1 + message2 + message3
    analyse_first = input(message)
    while analyse_first not in ("y", "n"):
        print("\nNot a valid input! Please try again\n")
        analyse_first = input("\nThe first ID found is", first_ID_directory,
                              "\nDo you want to start analysing it? (y/n)\n")
    if analyse_first == "y":
        first_ID_number = 0
    elif analyse_first == "n":
        raise SystemExit("\nPlease, go to the desired directory, check which "
                         "IDs are in it and try again")

print("\nStarting data analysis...")

for i in range(first_ID_number, len(files)):
    print("\nReading file", i + 1, "out of", len(files), ":", files[i])

    idx = find_divisions(files[i])
    print("\n", len(idx), " division points identified\n", sep="")
    idx = plot_divisions(files[i], idx, saveplot=True, saveidx=True)

    if i + 1 == len(files):
        print("\nThis was the last file in this directory\n")
        break

    continues = input("\nDo you want to continue analysing the other "
                      "files in this directory? (y/n)\n")
    while continues not in ("y", "n"):
        print("\nNot a valid input! Please try again\n")
        continues = input("\nDo you want to continue analysing the other "
                          "files in this directory? (y/n)\n")
    if continues == "y":
        print("\nContinuing analysis...\n")
    elif continues == "n":
        print("\nEnding analysis...\n")
        break
