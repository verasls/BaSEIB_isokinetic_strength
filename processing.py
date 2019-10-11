import numpy as np
import glob

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
    j = 1.    # Index counter
    for i in range(1, data.shape[0] - 1):
        # If product < 0, it means different signs
        if data[i - 1, 4] * data[i, 4] < 0:
            idx[j] = i
            j = j + 1
        elif data[i - 1, 4] * data[i, 4] == 0:
            idx[j] = i
            j = j + 1
