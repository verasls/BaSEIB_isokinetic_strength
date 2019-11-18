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


def exclude_divisions():
    root = tk.Tk()
    root.withdraw()

    answer = tk.messagebox.askyesno(title=None, 
                                    message="Do you want to exclude "
                                            "any division points?")
    return(answer)


def which_divisions():
    master = tk.Tk()
    
    tk.Label(master, text="Division points to exclude").grid(row=0)
    
    idx_0 = tk.IntVar()
    idx_1 = tk.IntVar()
    idx_2 = tk.IntVar()
    idx_3 = tk.IntVar()
    idx_4 = tk.IntVar()
    idx_5 = tk.IntVar()
    idx_6 = tk.IntVar()
    idx_7 = tk.IntVar()
    
    tk.Checkbutton(master, text=1, variable=idx_0).grid(column=0, row=1, sticky="w")
    tk.Checkbutton(master, text=2, variable=idx_1).grid(column=0, row=2, sticky="w")
    tk.Checkbutton(master, text=3, variable=idx_2).grid(column=0, row=3, sticky="w")
    tk.Checkbutton(master, text=4, variable=idx_3).grid(column=0, row=4, sticky="w")
    tk.Checkbutton(master, text=5, variable=idx_4).grid(column=1, row=1, sticky="w")
    tk.Checkbutton(master, text=6, variable=idx_5).grid(column=1, row=2, sticky="w")
    tk.Checkbutton(master, text=7, variable=idx_6).grid(column=1, row=3, sticky="w")
    tk.Checkbutton(master, text=8, variable=idx_7).grid(column=1, row=4, sticky="w")
    
    def get_excluded():
        excluded = [idx_0.get(), idx_1.get(), idx_2.get(), idx_3.get(),
                   idx_4.get(), idx_5.get(), idx_6.get(), idx_7.get()]
        excluded = np.asarray(excluded)
        excluded = np.where(excluded == 1)
        master.quit()
        
    tk.Button(master, text='Cancel', command=master.quit).grid(column=0, row=5, sticky="w", pady=4)
    tk.Button(master, text='Ok', command=var_states).grid(column=1, row=5, sticky="w", pady=4)
    
    tk.mainloop()
