#!/bin/bash

# fix for "tar: unable to record current working directory: No such file or directory"
untar() {
  DIR="$@"
  cd "$DIR" && sudo tar xpo -C $DIR 
}

csrutil status

DIRS="/System/Library/Extensions/ /Library/Extensions/"

for DIR in $DIRS; do
  sudo rm -rf "$DIR/HoRNDIS.kext" || exit 1
done

DIR="/Library/Extensions/"

tar c -C "./build/Release/" HoRNDIS.kext/ | untar "$DIR" || exit 1
sudo kextload "$DIR/HoRNDIS.kext" || exit 1

kextstat | grep HoR
