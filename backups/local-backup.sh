#!/bin/bash

cd $HOME

AGE_TXT="$HOME/.age/personal.txt"
AGE_YCT="$HOME/.age/yubikey_c.txt"
AGE_YBT="$HOME/.age/yubikey_b.txt"
AGE_PUB="$(cat $AGE_TXT | rg public | sed -e 's/# public key: \(age\w*\)/\1/')"
AGE_YC="$(cat $AGE_YCT | rg  Recipient | sed -e 's/#    Recipient: \(age\w*\)/\1/')"
AGE_YB="$(cat $AGE_YBT | rg Recipient | sed -e 's/#    Recipient: \(age\w*\)/\1/')"

REMOTE="/Volumes/Backup"

# List the directories you want to backup
dirs=("Calibre Library" "Desktop" "Documents" "Downloads" "Movies" "Music" "Pictures" "Projects")

# Iterate the directories and backup the files
for d in "${dirs[@]}"; do
	echo "Backing up $d ..."
	/opt/homebrew/bin/rsync --exclude ".venv" \
		--exclude "node_modules" \
		--exclude "$HOME/.*" \
		--exclude "$HOME/bin*" \
		--exclude "$HOME/Desktop" \
		--exclude "$HOME/Downloads" \
		--exclude "$HOME/Library" \
		--exclude "$HOME/Movies/TV" \
		--exclude "$HOME/Music/Audio Music Apps" \
		--exclude "$HOME/Music/GarageBand" \
		--exclude "$HOME/Movies/TV" \
		--exclude "$HOME/Pictures/Photos Library.photoslibrary/" \
		--exclude "$HOME/Projects" \
		--exclude "$HOME/Public" \
		--exclude "$HOME/Documents/MochiDiffusion" \
		-rah --info=progress2 \
		--update \
		"$HOME/$d/" "$REMOTE/$d/"
done

echo "Backing up Private"
tar -cvzf - Private | age -r $AGE_PUB -r $AGE_YC -r $AGE_YB > Private.tar.gz.age

/opt/homebrew/bin/rsync -ah --info=progress2 "$HOME/Private.tar.gz.age" "$REMOTE/"
rm "$HOME/Private.tar.gz.age"
