#!/bin/bash
cd $HOME

REMOTE="/run/media/mike/mike_backup/mike"

dirs=("Desktop" "Documents" "Downloads" "Pictures" "Projects" "Movies")

for d in "${dirs[@]}"; do
	rsync -av $REMOTE/$d/ $HOME/$d/
done

age --decrypt -i $1 Private.tar.gz.age | tar -xvzf -
