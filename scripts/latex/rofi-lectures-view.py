#!/usr/bin/python3
from courses import Courses
from rofi import rofi

lectures = Courses().current.lectures

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

lecture_range = lectures.parse_range_string(command)
lectures.update_lectures_in_master(lecture_range)
lectures.compile_master()
