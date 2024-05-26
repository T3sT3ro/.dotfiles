# This extension adds "Open with AVFS" context action to archive files in nautilus.
# It allows browsing archives as if they were directories
# It depends on avfs as a fuse virtual file system.
# 
# version: 1.0
# author: tooster, 2024
# license: Apache 2.0, full text: https://www.apache.org/licenses/LICENSE-2.0
#   
# useful docs this was based on:
# - https://gnome.pages.gitlab.gnome.org/nautilus/
# - https://gnome.pages.gitlab.gnome.org/nautilus-python/index.html
# - https://github.com/glycerine/avfs/blob/b0e86e1f9380fa0a7dadd0ea57c8147e77386054/avfs-1.0.3/README
# - https://mimetype.io/all-types
# - https://magic.github.io/mime-types/
# - find out mimetypes for various archives with `mimetype --all <paths to archives...>`
#
# TODO:
# - [ ] add mimetype conditionals to handlers
# - [ ] test if handlers work on example archives

import os
import subprocess
from gi.repository import Nautilus, GObject

class AVFSNautilusExtension(GObject.GObject, Nautilus.MenuProvider):

    def __init__(self):
        GObject.Object.__init__(self)
        
        # Mapping of MIME types to AVFS handlers
        self.mime_handlers = {
            
            # specializations from avfs modules
            'application/x-bzip-compressed-tar':    '#',            #.tar.bz2
            'application/x-compressed-tar':         '#ugz#utar',    #.tar.gz
            'application/x-xz-compressed-tar':      '#uxz#utar',    #.tar.xz
            
            'application/x-cd-image':               '#iso9660',     #.iso
            'application/java-archive':             '#uzip',        #.jar
            'application/vnd.rar':                  '#urar',        #.rar
            'application/x-archive':                '#uar',         #.ar
            
            # extra modules defined in defined in /usr/share/avfs/extfs/

            'application/x-7z-compressed':          '#u7z',         #.7z
            'application/vnd.debian.binary-package':'#deb',         #.deb
            'application/x-redhat-package-manager': '#rpm',         #.rpm
            'application/vnd.ms-cab-compressed':    '#ucab',        #.cab
            'application/x-cpio':                   '#ucpio',       #.cpio
            'application/x-lha':                    '#ulha',        #.lha <-- for some reason not working in avfs
            'application/x-zoo':                    '#uzoo',        #.zoo
            'application/vnd.comicbook-rar':        '#urar',        #.cbr

            # catch-alls

            'application/x-tar':                    '#utar',        #.tar / catch all tar
            'application/zip':                      '#uzip',        # catch all zip

            # modules present in avfs that have been omitted:
            # apt ,audio ,bpp ,extfs.ini ,ftplist ,hp48 ,lslR ,mailfs ,patchfs ,uace ,uadf ,uar ,uarc ,uarj ,uc1541 ,udar ,uextrar ,uha ,uimg ,upp ,uxdms ,uxpk
        }

    def mount_and_open_with_avfs(self, menu, file):
        file_path = file.get_location().get_path()
        avfs_mount_point = os.path.expanduser('~/.avfs')

        # Ensure AVFS is mounted
        if not os.path.ismount(avfs_mount_point):
            subprocess.call(['mountavfs'])

        # Determine the appropriate handler based on the file's MIME type
        handler = self.get_avfs_handler(file)

        if handler:
            # Construct the virtual path
            virtual_path = os.path.join(avfs_mount_point, file_path.lstrip('/') + handler)

            # Open the virtual directory with Nautilus
            subprocess.Popen(['nautilus', virtual_path])

    def get_avfs_handler(self, file):
        for mime_type, handler in self.mime_handlers.items():
            if file.is_mime_type(mime_type):
                return handler
        return '#'

    def get_file_items(self, window, files):
        # Only add the menu item if one file is selected
        if len(files) != 1:
            return

        file = files[0]

        # Check if the file is an archive
        if any(file.is_mime_type(mime) for mime in self.mime_handlers):
            item = Nautilus.MenuItem(
                name='AVFSNautilusExtension::OpenWithAVFS',
                label='_Open with AVFS as virtual directory',  # Add the mnemonic "O"
                tip='Mount and open the archive with AVFS',
                icon='archive-mount'  # This can be any icon you prefer
            )
            item.connect('activate', self.mount_and_open_with_avfs, file)
            return [item]

        return []
