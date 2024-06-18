#!/bin/bash

# Backup script
# Deps: restic sops

set -e

RESTIC_PASSPHRASE_COMMAND="sops -d --extract '[\"restic_passphrase\"]' $HOME/.dotfiles/backups/backblaze.age.json"
BUCKET=$(sops -d --extract '["b2_bucket_name"]' "$HOME/.dotfiles/backups/backblaze.age.json")
ID=$(sops -d --extract '["b2_account_id"]' "$HOME/.dotfiles/backups/backblaze.age.json")
KEY=$(sops -d --extract '["b2_application_key"]' "$HOME/.dotfiles/backups/backblaze.age.json")

# construct the b2 URL from secrets & the hostname
destination_url() {
  SUBDIR="/restic/$(whoami)"

  printf "b2:${BUCKET}:${SUBDIR}\n"
}

run_restic() {

  B2_ACCOUNT_ID="$ID" B2_ACCOUNT_KEY="$KEY" restic \
    --repo $(destination_url) \
    --password-command "$RESTIC_PASSPHRASE_COMMAND" \
    "$@"
}

init_repository() {
  run_restic init
}

# The approach of "backup the whole home directory but here are some weird
# exclusions" is a bit of patchwork approach. I'm trying to make sure I don't
# forget anything important (and accept I'll end up backing up more than I
# probably really need to), but exclude obviously redundant stuff and
# useless stuff that's big.  For example: my .config/Slack dir is 676M - mostly
# split between cache and service workers. Seems a little excessive. And while
# ~/.cache overall is an obvious "not needed" case, I'm genuinely curious what
# Spotify's cache eviction strategy is, because its cache is currently 11G.
run_backup() {
  run_restic backup \
    --one-file-system \
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
  $HOME
}

trim_old_snapshots() {
  run_restic forget \
    --keep-last=10 \
    --keep-within=1m \
    --prune
}

case "$1" in
  help)
    cat <<-EOF
		backup.sh - manage laptop backups

		Usage: backup.sh <sub-command>

		Sub-commands:

		    help: Print this help message.
		    dest: Print the B2 destination URL for backups.
		    restic: Stub for restic with repo url & auth passed.
		    init: Initialize remote repository. Must be run before first backup.
		    backup: Run a backup.
		    trim: Trim older snapshots & prune data.
		    backup-and-trim: Run a backup, then trim older snapshots.
		EOF
    ;;
  dest)
    destination_url
    ;;
  restic)
    shift
    run_restic "$@"
    ;;
  init)
    init_repository
    ;;
  backup)
    run_backup
    ;;
  trim)
    trim_old_snapshots
    ;;
  backup-and-trim)
    run_backup
    trim_old_snapshots
    ;;
  '')
    printf "Sub-command required.\n"
    printf "Run '%s help' for available commands.\n" "$0"
    exit 1
    ;;
  *)
    printf "'%s' is not a recognized sub-command.\n" "$1"
    printf "Run '%s help' for available commands.\n" "$0"
    exit 1
    ;;
esac
