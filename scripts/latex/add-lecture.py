#!/usr/bin/python3

import os
import re
import subprocess
from datetime import datetime

# Set up the required paths and variables
CURR = os.path.expanduser("~/notebook/")
num = 0
max = 0
next_lecture = 0
next_file = 0

def lecture_file_exists(num):
    file_path = os.path.join(CURR, f"lec_{num:02d}.tex")
    return os.path.isfile(file_path)

if not lecture_file_exists(0):
    today_date = datetime.today().strftime("%a, %b %d, %Y")
    with open(os.path.join(CURR, "lec_00.tex"), "w") as f:
        f.write(f"\\lecture{{00}}{{{today_date}}}{{Title of the lecture}}\n")

    # Open lecture 00 with nvim in a new terminal (GNOME Terminal).
    try:
        subprocess.run([
            "gnome-terminal",
            "--",
            "nvim", os.path.join(CURR, "lec_00.tex")
        ])
    except FileNotFoundError:
        print("Error: 'gnome-terminal' or 'nvim' command not found. Make sure you are on a Linux system and both are installed.")
    except Exception as e:
        print(f"Error opening the file: {e}")
else:
    lecture_files = [f for f in os.listdir(CURR) if re.match(r"lec_\d+\.tex", f)]
    for tf in lecture_files:
        num = int(tf[4:-4])
        max = num if num > max else max

    next_lecture = max + 1
    next_file = f"0{next_lecture}" if next_lecture < 10 else str(next_lecture)

    today_date = datetime.today().strftime("%a, %b %d, %Y")
    with open(os.path.join(CURR, f"lec_{next_file}.tex"), "w") as f:
        f.write(f"\\lecture{{{next_file}}}{{{today_date}}}{{Title of the lecture}}\n")

    # Open the newly created file with nvim in a new terminal (GNOME Terminal).
    try:
        subprocess.run([
            "gnome-terminal",
            "--",
            "nvim", os.path.join(CURR, f"lec_{next_file}.tex")
        ])
    except FileNotFoundError:
        print("Error: 'gnome-terminal' or 'nvim' command not found. Make sure you are on a Linux system and both are installed.")
    except Exception as e:
        print(f"Error opening the file: {e}")
