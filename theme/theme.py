# from rofi import rofi
#
# code, index, selected = rofi('Select book', 
#     ["{title: <{fill}} {date}".format(
#                              fill = MAX_LEN,
#                              title = b.info['title'],
#                              date = b.info['authors'][0]) for b in books], 
#     [
#     '-auto-select',
#     '-kb-rows-down', 'Down',
#     '-lines', len(books)
# ] + args)

import os
from rofi import rofi


themes = [filename.replace('-', ' ').title() for filename in os.listdir('/home/volinm/.config/theme/') if (os.path.isdir(filename) and filename != '__pycache__')]
code, index, selected = rofi('Select theme', sorted(themes),
                             ['-auto-select',
                              '-kb-rows-down', 'Down',
                              '-lines', len(themes)])

selected = selected.lower().replace(' ', '-')

os.system('cat /home/volinm/.config/theme/{theme}/zathura > /home/volinm/.config/zathura/zathurarc'.format(theme = selected))
os.system('dconf load /org/gnome/terminal/legacy/profiles:/ < /home/volinm/.config/theme/{theme}/terminal.dconf'.format(theme = selected))
os.system('sed -i "s/colorscheme = .*,/colorscheme = {theme},/g" /home/volinm/.config/nvim/lua/plugins/theme.lua'.format(theme = "'"+selected+"'"))
