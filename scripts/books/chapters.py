#!/usr/bin/python3

import os
from datetime import datetime
from pathlib import Path
import locale
import re
import subprocess
from config import get_week, DATE_FORMAT, CURRENT_BOOK_ROOT

EDITOR = os.environ.get('EDITOR', 'vim')

# TODO
locale.setlocale(locale.LC_TIME, "en_US.utf8")

def number2filename(n):
    return 'chapter_{0:02d}.tex'.format(n)

def filename2number(s):
    return int(str(s).replace('.tex', '').replace('chapter_', ''))

class Chapter():
    def __init__(self, file_path, book):
        with file_path.open() as f:
            for line in f:
                chapter_match = re.search(r'chapter\{(.*?)\}', line)
                if chapter_match:
                    break

        # number = int(chapter_match.group(1))

        title = chapter_match.group(1)

        self.file_path = file_path
        self.number = filename2number(file_path.stem)
        self.title = title
        self.book = book

    def edit(self):
        subprocess.run([
            "gnome-terminal",
            "--",
            "zsh", "-i", "-c",
            f"\\nvim {str(self.file_path)}"
        ])

    def __str__(self):
        return f'<Chapter {self.book.info["short"]} {self.number} "{self.title}">'


class Chapters(list):
    def __init__(self, book):
        self.book = book
        self.root = book.path
        self.master_file = self.root / 'master.tex'
        list.__init__(self, self.read_files())

    def read_files(self):
        files = self.root.glob('chapter_*.tex')
        return sorted((Chapter(f, self.book) for f in files), key=lambda l: l.number)

    def parse_chapter_spec(self, string):
        if len(self) == 0:
            return 0

        if string.isdigit():
            return int(string)
        elif string == 'last':
            return self[-1].number
        elif string == 'prev':
            return self[-1].number - 1

    def parse_range_string(self, arg):
        all_numbers = [chapter.number for chapter in self]
        if 'all' in arg:
            return all_numbers

        if '-' in arg:
            start, end = [self.parse_chapter_spec(bit) for bit in arg.split('-')]
            return list(set(all_numbers) & set(range(start, end + 1)))

        return [self.parse_chapter_spec(arg)]

    @staticmethod
    def get_header_footer(filepath):
        part = 0
        header = ''
        footer = ''
        with filepath.open() as f:
            for line in f:
                # order of if-statements is important here!
                if 'end chapters' in line:
                    part = 2

                if part == 0:
                    header += line
                if part == 2:
                    footer += line

                if 'start chapters' in line:
                    part = 1
        return (header, footer)

    def update_chapters_in_master(self, r):
        header, footer = self.get_header_footer(self.master_file)
        body = ''.join(
            ' ' * 4 + r'\input{' + number2filename(number) + '}\n' for number in r)
        self.master_file.write_text(header + body + footer)

    def new_chapter(self):
        if len(self) != 0:
            new_chapter_number = self[-1].number + 1
        else:
            new_chapter_number = 1

        new_chapter_path = self.root / number2filename(new_chapter_number)

        today = datetime.today()
        date = today.strftime(DATE_FORMAT)

        new_chapter_path.touch()
        new_chapter_path.write_text(f'\\lecture{{{new_chapter_number}}}{{{date}}}{{}}\n')

        if new_chapter_number == 1:
            self.update_chapters_in_master([1])
        else:
            self.update_chapters_in_master([new_chapter_number - 1, new_chapter_number])

        self.read_files()


        l = Chapter(new_chapter_path, self.book)

        return l

    def compile_master(self):
        result = subprocess.run(
            ['latexmk', '-f', '-interaction=nonstopmode', str(self.master_file)],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            cwd=str(self.root)
        )
        return result.returncode
