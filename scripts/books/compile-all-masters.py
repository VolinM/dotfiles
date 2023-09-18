#!/bin/python3
from books import Books

for book in Books():
    chapters = book.chapters

    r = chapters.parse_range_string('all')
    chapters.update_chapters_in_master(r)
    chapters.compile_master()
