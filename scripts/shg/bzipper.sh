#!/bin/bash

##########################################
# bzipper v1.1
# Simple bash script to pack Source assets into bz2 files, for use in FastDL servers
# Requires: bzip2
# Changelog:
#  - 1.0: initial version
#  - 1.1: Pack all source asset file types (that are worth using in fastdl)
#         Removed packfile function export (its not needed anymore)
#         Loop through subdirectories as well
##########################################

packfile() {
	echo "Packing file: $1"
	bzip2 -z9 $1
}

# check current directory for filetypes:
# maps: bsp
# sound: mp3, wav, ogg
# misc: spr, mdl, vmt
find . -type f \( -iname "*.bsp" -o -iname "*.mp3" -o -iname "*.wav" -o -iname "*.ogg" -o -iname "*.spr" -o -iname "*.mdl" -o -iname "*.vmt" \) -print0 | while IFS= read -r -d '' file; do
	packfile $file
done
