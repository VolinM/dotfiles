from datetime import datetime
from pathlib import Path

def get_week(d=datetime.today()):
    return (int(d.strftime("%W")) + 52 - 5) % 52

# default is 'primary', if you are using a separate calendar for your course schedule,
# your calendarId (which you can find by going to your Google Calendar settings, selecting
# the relevant calendar and scrolling down to Calendar ID) probably looks like
# xxxxxxxxxxxxxxxxxxxxxxxxxg@group.calendar.google.com
# example:
# USERCALENDARID = 'xxxxxxxxxxxxxxxxxxxxxxxxxg@group.calendar.google.com'
USERCALENDARID = 'primary'
CURRENT_BOOK_SYMLINK = Path('~/book').expanduser()
CURRENT_BOOK_ROOT = CURRENT_BOOK_SYMLINK.resolve()
CURRENT_BOOK_WATCH_FILE = Path('/tmp/books').resolve()
ROOT = Path('~/Documents/notes/books/current/').expanduser()
DATE_FORMAT = '%a, %b %d, %Y'
