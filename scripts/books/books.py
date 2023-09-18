#!/usr/bin/python3
from pathlib import Path
import yaml

from chapters import Chapters
from config import ROOT, CURRENT_BOOK_ROOT, CURRENT_BOOK_SYMLINK, CURRENT_BOOK_WATCH_FILE

class Book():
    def __init__(self, path):
        self.path = path
        self.name = path.stem

        self.info = yaml.safe_load((path / 'info.yaml').open())
        self._chapters = None

    @property
    def chapters(self):
        if not self._chapters:
            self._chapters = Chapters(self)
        return self._chapters

    def __eq__(self, other):
        if other == None:
            return False
        return self.path == other.path

class Books(list):
    def __init__(self):
        list.__init__(self, self.read_files())

    def read_files(self):
        books_directories = [x for x in ROOT.iterdir() if x.is_dir()]
        _books = [Book(path) for path in books_directories]
        return sorted(_books, key=lambda b: b.name)

    @property
    def current(self):
        return Book(CURRENT_BOOK_ROOT.resolve())

    @current.setter
    def current(self, book):
        CURRENT_BOOK_SYMLINK.unlink()
        CURRENT_BOOK_SYMLINK.symlink_to(book.path)
        CURRENT_BOOK_WATCH_FILE.write_text('{}\n'.format(book.info['short']))
