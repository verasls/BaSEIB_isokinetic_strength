import Tkinter as tk
import tkMessageBox

def make_changes():
    root = tk.Tk()
    root.withdraw()

    answer = tkMessageBox.askyesno(title=None, 
                                         message="Do you want to make any "
                                         "changes to the division points?")
    return(answer)


def exclude_divisions():
    root = tk.Tk()
    root.withdraw()

    answer = tkMessageBox.askyesno(title=None, 
                                         message="Do you want to exclude "
                                         "any division points?")
    return(answer)    
