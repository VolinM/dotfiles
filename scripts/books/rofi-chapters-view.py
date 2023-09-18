#!/usr/bin/python3
from books import Books
from rofi import rofi

chapters = Books().current.chapters

commands = ['last', 'prev-last', 'all', 'prev']
options = ['Current chapter', 'Last two chapters', 'All chaters', 'Previous chapters']

key, index, selected = rofi('Select view', options, [
    '-lines', 4,
    '-auto-select'
])

if index >= 0:
    command = commands[index]
else:
    command = selected

chapter_range = chapters.parse_range_string(command)
chapters.update_chapters_in_master(chapter_range)
chapters.compile_master()
