#!/usr/bin/python3
from rofi import rofi
from utils import MAX_LEN

from books import Books

books = Books()
current = books.current

try:
    current_index = books.index(current)
    args = ['-a', current_index]
except ValueError:
    args = []

code, index, selected = rofi('Select book', 
    ["{title: <{fill}} {date}".format(
                             fill = MAX_LEN,
                             title = b.info['title'],
                             date = b.info['authors'][0]) for b in books], 
    [
    '-auto-select',
    '-kb-rows-down', 'Down',
    '-lines', len(books)
] + args)

if index >= 0:
    books.current = books[index]
