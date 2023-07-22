#!/usr/bin/python3

import os
import subprocess

# Set up the required paths and variables
CURR = os.path.expanduser("~/current_course/")
MASTER_FILE = os.path.join(CURR, "master.tex")

def master_file_exists():
    return os.path.isfile(MASTER_FILE)

if master_file_exists():
    try:
        # Open the master file with nvim in a new terminal (GNOME Terminal).
        subprocess.run([
            "gnome-terminal",
            "--",
            "nvim", MASTER_FILE
        ])
    except FileNotFoundError:
        print("Error: 'gnome-terminal' or 'nvim' command not found. Make sure you are on a Linux system and both are installed.")
    except Exception as e:
        print(f"Error opening the file: {e}")
else:
    print("Master file not found. Please create the master.tex file first.")
