import tkinter as tk
from tkinter import messagebox

def make_changes():
    root = tk.Tk()
    root.withdraw()

    answer = tk.messagebox.askyesno(title=None, 
                                    message="Do you want to make any "
                                            "changes to the division points?")
    return(answer)


def exclude_divisions():
    root = tk.Tk()
    root.withdraw()

    answer = tk.messagebox.askyesno(title=None, 
                                    message="Do you want to exclude "
                                            "any division points?")
    return(answer)    
