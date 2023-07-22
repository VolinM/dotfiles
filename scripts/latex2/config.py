from pathlib import Path

CURRENT_COURSE_SYMLINK = Path('~/current_course/').expanduser()
CURRENT_COURSE_ROOT = CURRENT_COURSE_SYMLINK.resolve()
CURRENT_COURSE_WATCH_FILE = Path('/tmp/current_course')
ROOT = Path('~/Documents/notes/bachelor/semester_6/').expanduser()
DATE_FORMAT = '%a, %b %d, %Y'
