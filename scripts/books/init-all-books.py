#!/bin/python3
from books import Books

for book in Books():
        chapters = book.chapters
        book_title = chapters.book.info["title"]
        lines = [
                r'\makeatletter',
                r'\def\input@path{{~/book/figures/}{~/.config/latex/}}',
                r'\documentclass{book-preamble}',
                fr'\title{{{book_title}}}',
                r'\begin{document}',
                r'\maketitle',
                r'\tableofcontents',
                fr'% start chapters',
                fr'% end chapters',
                r'\end{document}',
                ]
        chapters.master_file.touch()
        chapters.master_file.write_text('\n'.join(lines))
        (chapters.root / 'master.tex.latexmain').touch()
        (chapters.root / 'figures').mkdir(exist_ok=True)
