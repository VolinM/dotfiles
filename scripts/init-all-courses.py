#!/bin/python3
from courses import Courses

for course in Courses():
        lectures = course.lectures
        course_title = lectures.course.info["title"]
        lines = [r'\makeatletter',
                 r'\def\input@path{{~/.config/latex/}}',
                 r'\documentclass{lecture-preamble}',
                 r'\input{../preamble.tex}',
                 fr'\title{{{course_title}}}',
                 r'\begin{document}',
                 r'    \maketitle',
                 r'    \tableofcontents',
                 fr'    % start lectures',
                 fr'    % end lectures',
                 r'\end{document}'
                ]
        lectures.master_file.touch()
        lectures.master_file.write_text('\n'.join(lines))
        (lectures.root / 'master.tex.latexmain').touch()
        (lectures.root / 'figures').mkdir(exist_ok=True)
