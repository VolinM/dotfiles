#!/usr/bin/python3
from books import Books
from rofi import rofi
from utils import generate_short_title, MAX_LEN

chapters = Books().current.chapters

sorted_chapters = sorted(chapters, key=lambda b: -b.number)

options = [
    "{number: >2}. <b>{title: <{fill}}</b>".format(
        fill=MAX_LEN,
        number=chapter.number,
        title=generate_short_title(chapter.title),
    )
    for chapter in sorted_chapters
]

key, index, selected = rofi('Select Chapter', options, [
    '-lines', 5,
    '-markup-rows',
    '-kb-row-down', 'Down',
    '-kb-custom-1', 'Ctrl+n'
])

if key == 0:
    sorted_chapters[index].edit()
elif key == 1:
    new_chapter = chapters.new_chapter()
    new_chapter.edit()
