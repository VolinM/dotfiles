#!/usr/bin/python3

import os
from datetime import datetime
import locale
import re
import subprocess
import sys, tempfile, os

from config import DATE_FORMAT, CURRENT_COURSE_ROOT

EDITOR = os.environ.get('EDITOR', 'vim')

# TODO
locale.setlocale(locale.LC_TIME, "en_US.utf8")

def filename2number(n):
    return 'lec_{0:02d}.tex'.format(n)

class Lecture():
    def __init__(self, file_path, course):
        with file_path.open() as f:
            for line in f:
                lecture_match = re.search(r'lecture\{(.*?)\}\{(.*?)\{(.*)\}', line)
                if lecture_match:
                    break;

        date_str = lecture_match.group(2)
        date = datetime.strptime(date_str, DATE_FORMAT)

        title = lecture_match.group(3)

        self.file_path = file_path
        self.date = date
        self.number = filename2number(file_path.stem)
        self.title = title
        self.course = course

    def edit(self):
        with tempfile.NamedTemporaryFile(suffix=".tmp") as tf:
            tf.write(self.file_path)
            tf.flush()
            subprocess.call([EDITOR, tf.name])

            # do the parsing with `tf` using regular File operations.
            # for instance:
            tf.seek(0)
            edited_message = tf.read()


