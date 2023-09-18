#!/usr/bin/python3

import os
import re
import subprocess
from datetime import datetime

# Set up the required paths and variables
CURR = os.path.expanduser("~/book/")
num = 0
max = 0
next_chapter = 0
next_file = 0

def chapter_file_exists(num):
    file_path = os.path.join(CURR, f"chapter_{num:02d}.tex")
    return os.path.isfile(file_path)

if not chapter_file_exists(1):
    today_date = datetime.today().strftime("%a, %b %d, %Y")
    with open(os.path.join(CURR, "chapter_01.tex"), "w") as f:
        f.write(f"\\chapter{{Title of the lecture}}\n")

    # Open lecture 00 with nvim in a new terminal (GNOME Terminal).
    try:
        subprocess.run([
            "gnome-terminal",
            "--",
            "nvim", os.path.join(CURR, "chapter_01.tex")
        ])
    except FileNotFoundError:
        print("Error: 'gnome-terminal' or 'nvim' command not found. Make sure you are on a Linux system and both are installed.")
    except Exception as e:
        print(f"Error opening the file: {e}")
else:
    chapter_files = [f for f in os.listdir(CURR) if re.match(r"chapter_\d+\.tex", f)]
    for tf in chapter_files:
        num = int(tf[8:-4])
        max = num if num > max else max

    next_chapter = max + 1
    next_file = f"0{next_chapter}" if next_chapter < 10 else str(next_chapter)

    today_date = datetime.today().strftime("%a, %b %d, %Y")
    with open(os.path.join(CURR, f"chapter_{next_file}.tex"), "w") as f:
        f.write(f"\\chapter{{Title of the lecture}}\n")

    # Open the newly created file with nvim in a new terminal (GNOME Terminal).
    try:
        subprocess.run([
            "gnome-terminal",
            "--",
            "nvim", os.path.join(CURR, f"chapter_{next_file}.tex")
        ])
    except FileNotFoundError:
        print("Error: 'gnome-terminal' or 'nvim' command not found. Make sure you are on a Linux system and both are installed.")
    except Exception as e:
        print(f"Error opening the file: {e}")
