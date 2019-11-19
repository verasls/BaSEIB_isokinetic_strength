import tkinter as tk
from tkinter import messagebox
import numpy as np

def make_changes():
    root = tk.Tk()
    root.withdraw()

    answer = tk.messagebox.askyesno(title=None, 
                                    message="Do you want to make any "
                                            "changes to the division points?")
    return(answer)
