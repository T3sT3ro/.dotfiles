#!/bin/bash
# this script dumps all user changed gsettings

DUMP_DUMP_FILE=~/.config/custom/dconf-dump.conf

# handle "dump" and "load" commands. If nothing is given or -h or --help, print help
case $1 in
  dump)
    dconf dump / > $DUMP_DUMP_FILE
    echo "Dumped to $DUMP_DUMP_FILE"
    ;;
  load)
    dconf load / < $DUMP_DUMP_FILE
    echo "Loaded from $DUMP_DUMP_FILE"
    ;;
  *)
    echo "Usage: $0 <dump|load>"
    ;;
esac

