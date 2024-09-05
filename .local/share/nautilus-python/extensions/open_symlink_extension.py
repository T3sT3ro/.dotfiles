#!/usr/bin/env python3

import os
import subprocess
import gi
gi.require_version('Gtk', '4.0')
from gi.repository import Nautilus, GObject, Gtk

class GoToLinkLocationExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        GObject.Object.__init__(self)

    def get_file_items(self, files):
        # Check if exactly one file is selected
        if len(files) != 1:
            return

        file = files[0]

        # Check if the selected file is a symbolic link
        if not file.get_uri_scheme() == 'file' or not os.path.islink(file.get_location().get_path()):
            return

        # Create a menu item
        item = Nautilus.MenuItem(
            name="GoToLinkLocationExtension::GoToLinkLocation",
            label="Go to Link Location",
            tip="Opens the directory containing the link target"
        )
        item.connect('activate', self.go_to_link_location, file)

        return [item]

    def go_to_link_location(self, menu, file):
        link_path = file.get_location().get_path()
        target_path = os.readlink(link_path)
        target_dir = os.path.dirname(target_path)

        # Ensure the target directory is an absolute path
        if not os.path.isabs(target_dir):
            target_dir = os.path.abspath(os.path.join(os.path.dirname(link_path), target_dir))

        # Open the directory containing the target
        subprocess.Popen(['xdg-open', target_dir])
